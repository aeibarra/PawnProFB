unit uLeadsOnlineClient;

{
  Thin wrapper over the generated LeadsOnlineWS SOAP proxy.

  Responsibilities (per PawnDocs/Private/LEADSONLINE_SOAP_PLAN.md section 4):
    - credential injection (LoginInfo is built once, from the store's API creds)
    - endpoint selection (sandbox | production)
    - errorCode -> readable message
    - timeout / retry
    - exception normalising (WinInet / SOAP faults -> ELeadsOnlineTransport)

  Nothing here knows about the database or the UI. LeadsOnlineWS.pas is WSDL
  importer output and must never be hand-edited; all deviations live here.

  Phase 1 exposes CheckLogin only.
}

interface

uses
  System.SysUtils, System.Classes, Soap.SOAPHTTPClient, LeadsOnlineWS;

const
  /// Sent as the ApiVersion element on every operation. The element is
  /// declared minOccurs="1" nillable="true" xsd:int in the WSDL.
  LeadsOnlineApiVersion = 1;

  LeadsOnlineSandboxURL    = 'https://w3apisandbox.leadsonline.com/ticketWS.asmx';
  LeadsOnlineProductionURL = 'https://w3api.leadsonline.com/ticketWS.asmx';

  /// Default per-call network timeouts, in milliseconds. These are counter-side
  /// calls, so they must fail visibly rather than hang the till.
  LeadsOnlineDefaultTimeout = 30000;

type
  /// Raised when the call never produced a Response: DNS, TLS, HTTP, or a SOAP
  /// fault. A Response with a non-zero errorCode is NOT this -- that is a
  /// successful round trip that the service rejected, and comes back as a
  /// TLeadsOnlineResult.
  ELeadsOnlineTransport = class(Exception)
  private
    FOperation: string;
    FEndpoint: string;
  public
    constructor Create(const AOperation, AEndpoint, AMessage: string);
    property Operation: string read FOperation;
    property Endpoint: string read FEndpoint;
  end;

  /// The service's own answer, flattened off the TRemotable so callers never
  /// have to think about who frees what.
  TLeadsOnlineResult = record
    ErrorCode: Integer;
    ErrorResponse: string;
    function Succeeded: Boolean;
    function Text: string;
  end;

  TLeadsOnlineClient = class
  private
    FStoreId: Integer;
    FUserName: string;
    FPassword: string;
    FUseSandbox: Boolean;
    FApiVersion: Integer;
    FIpAddress: string;
    FIpAddressResolved: Boolean;
    FTimeoutMS: Integer;
    FRetries: Integer;
    FCaptureXML: Boolean;
    FLastRequestXML: string;
    FLastResponseXML: string;
    FRIO: THTTPRIO;
    FService: ticketWSSoap;
    function GetEndpointURL: string;
    function GetService: ticketWSSoap;
    function NewLoginInfo: LoginInfo;
    function ResolveIpAddress: string;
    procedure HTTPRIOBeforeExecute(const MethodName: string; SOAPRequest: TStream);
    procedure HTTPRIOAfterExecute(const MethodName: string; SOAPResponse: TStream);
    /// Runs ACall, retrying only transport failures, and normalises whatever
    /// comes back into a TLeadsOnlineResult. Never retries a call that reached
    /// the service and returned a Response.
    function Execute(const AOperation: string; const ACall: TFunc<Response>): TLeadsOnlineResult;
  public
    constructor Create(AStoreId: Integer; const AUserName, APassword: string;
      AUseSandbox: Boolean = False);
    destructor Destroy; override;

    /// Verifies the store id / user / password against the selected endpoint.
    /// Raises ELeadsOnlineTransport if the service could not be reached.
    function CheckLogin: TLeadsOnlineResult;
    /// Non-raising form, for a "Test Connection" button.
    function TryCheckLogin(out AResult: TLeadsOnlineResult; out AError: string): Boolean;

    property StoreId: Integer read FStoreId;
    property UserName: string read FUserName;
    property UseSandbox: Boolean read FUseSandbox;
    property EndpointURL: string read GetEndpointURL;
    /// Sent as the ApiVersion element. Overridable so the probe tool can
    /// establish what the service actually accepts.
    property ApiVersion: Integer read FApiVersion write FApiVersion;
    /// Sent as the IpAddress element. Left empty resolves the workstation's
    /// own address once, lazily; the element is optional in the schema.
    property IpAddress: string read FIpAddress write FIpAddress;
    property TimeoutMS: Integer read FTimeoutMS write FTimeoutMS;
    /// Transport-failure retries, not counting the first attempt.
    property Retries: Integer read FRetries write FRetries;
    /// Off by default. Turning it on keeps the last envelopes in memory, which
    /// means credentials in memory too -- diagnostics only.
    property CaptureXML: Boolean read FCaptureXML write FCaptureXML;
    property LastRequestXML: string read FLastRequestXML;
    property LastResponseXML: string read FLastResponseXML;
  end;

/// errorCode -> something worth putting in front of a user. The service sends
/// its own text in errorResponse, so that wins when present; the full code
/// table lives in the NDA document under PawnDocs/Private/.
function LeadsOnlineErrorText(AErrorCode: Integer; const AErrorResponse: string): string;

implementation

uses
  IdStack;

function LeadsOnlineErrorText(AErrorCode: Integer; const AErrorResponse: string): string;
begin
  if AErrorCode = 0 then
    Exit('OK');

  if Trim(AErrorResponse) <> '' then
    Exit(Format('%s (code %d)', [Trim(AErrorResponse), AErrorCode]));

  case AErrorCode of
    7: Result := 'Ticket date is out of range (code 7)';
  else
    Result := Format('LeadsOnline returned error code %d', [AErrorCode]);
  end;
end;

{ ELeadsOnlineTransport }

constructor ELeadsOnlineTransport.Create(const AOperation, AEndpoint, AMessage: string);
begin
  inherited CreateFmt('LeadsOnline %s failed at %s: %s', [AOperation, AEndpoint, AMessage]);
  FOperation := AOperation;
  FEndpoint := AEndpoint;
end;

{ TLeadsOnlineResult }

function TLeadsOnlineResult.Succeeded: Boolean;
begin
  Result := ErrorCode = 0;
end;

function TLeadsOnlineResult.Text: string;
begin
  Result := LeadsOnlineErrorText(ErrorCode, ErrorResponse);
end;

{ TLeadsOnlineClient }

constructor TLeadsOnlineClient.Create(AStoreId: Integer; const AUserName, APassword: string;
  AUseSandbox: Boolean);
begin
  inherited Create;
  FStoreId := AStoreId;
  FUserName := AUserName;
  FPassword := APassword;
  FUseSandbox := AUseSandbox;
  FApiVersion := LeadsOnlineApiVersion;
  FTimeoutMS := LeadsOnlineDefaultTimeout;
  FRetries := 1;
end;

destructor TLeadsOnlineClient.Destroy;
begin
  // Do NOT free FRIO. TRIO._Release destroys an ownerless RIO the moment the
  // last interface reference goes, so dropping FService has already disposed
  // of it; freeing it again lands in BeforeDestruction on dead memory
  // (EInvalidPointer). FRIO is a borrowed pointer, never an owned one.
  FService := nil;
  FRIO := nil;
  inherited;
end;

function TLeadsOnlineClient.GetEndpointURL: string;
begin
  if FUseSandbox then
    Result := LeadsOnlineSandboxURL
  else
    Result := LeadsOnlineProductionURL;
end;

function TLeadsOnlineClient.GetService: ticketWSSoap;
var
  RIO: THTTPRIO;
begin
  if FService = nil then
  begin
    RIO := THTTPRIO.Create(nil);
    try
      // Never UseWSDL: the importer baked the sandbox address into the unit,
      // and fetching the WSDL at call time would put a second network round
      // trip in front of every ticket.
      RIO.URL := GetEndpointURL;
      RIO.HTTPWebNode.UseUTF8InHeader := True;
      RIO.HTTPWebNode.ConnectTimeout := FTimeoutMS;
      RIO.HTTPWebNode.SendTimeout := FTimeoutMS;
      RIO.HTTPWebNode.ReceiveTimeout := FTimeoutMS;
      RIO.OnBeforeExecute := HTTPRIOBeforeExecute;
      RIO.OnAfterExecute := HTTPRIOAfterExecute;
      FService := GetticketWSSoap(False, RIO.URL, RIO);
    except
      // Still refcount 0 out here, so an ordinary Free is the right undo.
      RIO.Free;
      raise;
    end;
    // Kept only to reach the component's properties; ownership sits with
    // FService (see Destroy).
    FRIO := RIO;
  end;
  Result := FService;
end;

function TLeadsOnlineClient.NewLoginInfo: LoginInfo;
begin
  Result := LoginInfo.Create;
  Result.storeId := FStoreId;
  Result.userName := FUserName;
  Result.password := FPassword;
end;

function TLeadsOnlineClient.ResolveIpAddress: string;
begin
  if not FIpAddressResolved then
  begin
    FIpAddressResolved := True;
    if FIpAddress = '' then
      try
        TIdStack.IncUsage;
        try
          FIpAddress := GStack.LocalAddress;
        finally
          TIdStack.DecUsage;
        end;
      except
        // The element is optional; an unresolvable address must not stop a ticket.
        FIpAddress := '';
      end;
  end;
  Result := FIpAddress;
end;

procedure TLeadsOnlineClient.HTTPRIOBeforeExecute(const MethodName: string; SOAPRequest: TStream);
var
  Bytes: TBytes;
begin
  if not FCaptureXML then
    Exit;
  SetLength(Bytes, SOAPRequest.Size);
  SOAPRequest.Position := 0;
  SOAPRequest.ReadBuffer(Bytes, Length(Bytes));
  SOAPRequest.Position := 0;
  FLastRequestXML := TEncoding.UTF8.GetString(Bytes);
end;

procedure TLeadsOnlineClient.HTTPRIOAfterExecute(const MethodName: string; SOAPResponse: TStream);
var
  Bytes: TBytes;
begin
  if not FCaptureXML then
    Exit;
  SetLength(Bytes, SOAPResponse.Size);
  SOAPResponse.Position := 0;
  SOAPResponse.ReadBuffer(Bytes, Length(Bytes));
  SOAPResponse.Position := 0;
  FLastResponseXML := TEncoding.UTF8.GetString(Bytes);
end;

function TLeadsOnlineClient.Execute(const AOperation: string;
  const ACall: TFunc<Response>): TLeadsOnlineResult;
var
  Attempt: Integer;
  Reply: Response;
  LastError: string;
begin
  LastError := '';
  for Attempt := 0 to FRetries do
  begin
    try
      Reply := ACall();
    except
      on E: Exception do
      begin
        // Transport, TLS, HTTP status or SOAP fault -- nothing was returned, so
        // retrying cannot duplicate anything the service accepted.
        LastError := E.Message;
        Continue;
      end;
    end;

    try
      if Reply = nil then
        raise ELeadsOnlineTransport.Create(AOperation, GetEndpointURL,
          'the service returned an empty response');
      Result.ErrorCode := Reply.errorCode;
      Result.ErrorResponse := Reply.errorResponse;
    finally
      Reply.Free;
    end;
    Exit;
  end;

  raise ELeadsOnlineTransport.Create(AOperation, GetEndpointURL, LastError);
end;

function TLeadsOnlineClient.CheckLogin: TLeadsOnlineResult;
var
  Login: LoginInfo;
begin
  Login := NewLoginInfo;
  try
    Result := Execute('CheckLogin',
      function: Response
      begin
        Result := GetService.CheckLogin(FApiVersion, ResolveIpAddress, Login);
      end);
  finally
    Login.Free;
  end;
end;

function TLeadsOnlineClient.TryCheckLogin(out AResult: TLeadsOnlineResult;
  out AError: string): Boolean;
begin
  AError := '';
  try
    AResult := CheckLogin;
    Result := AResult.Succeeded;
    if not Result then
      AError := AResult.Text;
  except
    on E: Exception do
    begin
      AResult := Default(TLeadsOnlineResult);
      AError := E.Message;
      Result := False;
    end;
  end;
end;

end.
