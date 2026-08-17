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
  System.SysUtils, System.Classes, Soap.SOAPHTTPClient, Soap.InvokeRegistry,
  LeadsOnlineWS;

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
    /// Non-raising form, for a "Test Connection" button. True means the service
    /// was REACHED -- read AResult for its verdict. False means the call never
    /// got there, with AError holding why. A caller that reads False as "wrong
    /// password" will tell an operator to re-type credentials when the real
    /// fault is the network.
    function TryCheckLogin(out AResult: TLeadsOnlineResult; out AError: string): Boolean;

    /// Sends one ticket. The caller owns ATicket and may free it afterwards.
    ///
    /// Retry semantics matter here and are not obvious. Per the vendor spec,
    /// re-sending a ticket whose key already exists is normally an error --
    /// EXCEPT when it matches "the last successful ticket submitted", which is
    /// suppressed so a client can safely resend after a lost response. That
    /// exemption covers only the ticket just sent, so the retry built into
    /// Execute (inline, same ticket, before anything else is submitted) is the
    /// only retry that is safe. Never re-submit an older ticket later and treat
    /// a duplicate error as failure -- see ResultIsAlreadyAccepted.
    function SubmitTransaction(ATicket: Ticket): TLeadsOnlineResult;
    /// Non-raising form: returns False and fills AError on transport failure.
    function TrySubmitTransaction(ATicket: Ticket; out AResult: TLeadsOnlineResult;
      out AError: string): Boolean;

    /// Attaches one image to a ticket. AItemIndex is LeadsOnline's 0-based
    /// position of the item WITHIN THE TICKET AS SENT, and applies only when
    /// ACategory is Item; pass 0 otherwise.
    ///
    /// The ticket need not exist yet -- their spec allows an image to be
    /// uploaded first and the ticket added afterwards.
    ///
    /// On success the server's unique name for the image comes back in
    /// Result.ErrorResponse (not an error, despite the field name). Store it:
    /// it is the only handle DeleteImage accepts.
    function UploadImage(AKey: TicketKey; const ABytes: TBytes;
      ACategory: ImageCategory; AItemIndex: Integer): TLeadsOnlineResult;
    /// Non-raising form: returns False and fills AError on transport failure.
    function TryUploadImage(AKey: TicketKey; const ABytes: TBytes;
      ACategory: ImageCategory; AItemIndex: Integer;
      out AResult: TLeadsOnlineResult; out AError: string): Boolean;

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

/// Works out WHY the endpoint could not be reached, in words an operator can
/// act on, separating three failures that look identical from inside a SOAP
/// exception: no connectivity, something intercepting the connection, and
/// LeadsOnline itself being slow or down.
///
/// Deliberately does NOT treat successful name resolution as evidence of
/// connectivity. Plenty of ISPs answer every lookup with a redirect page, so a
/// name that resolves and a socket that opens can both be true while the real
/// host is unreachable -- confirmed here with a nonexistent hostname, which
/// resolved and accepted a connection on 443. Only completing an HTTPS exchange
/// with the endpoint proves we are talking to LeadsOnline.
///
/// Diagnostic only -- never called on the success path, so its cost does not
/// matter and a wrong guess cannot break a submission.
function DiagnoseEndpoint(const AURL: string): string;

/// True when the service rejected a submit only because it already holds the
/// ticket. Codes 6 and 13 both mean "this ticket key exists"; for a resend of
/// something we believe we sent, that is confirmation it landed, not a failure.
/// Reporting it as an error would leave a row looking permanently unsent.
function ResultIsAlreadyAccepted(const AResult: TLeadsOnlineResult): Boolean;

/// errorCode -> something worth putting in front of a user. The service sends
/// its own text in errorResponse, so that wins when present; the full code
/// table lives in the NDA document under PawnDocs/Private/.
function LeadsOnlineErrorText(AErrorCode: Integer; const AErrorResponse: string): string;

implementation

uses
  System.StrUtils, System.Net.HttpClient, IdStack, IdTCPClient;

function DiagnoseEndpoint(const AURL: string): string;
var
  Host, IP: string;
  P: Integer;
  Client: TIdTCPClient;
  Http: THTTPClient;
  Body: string;
begin
  Host := AURL;
  P := Pos('://', Host);
  if P > 0 then
    Delete(Host, 1, P + 2);
  P := Pos('/', Host);
  if P > 0 then
    Host := Copy(Host, 1, P - 1);
  P := Pos(':', Host);
  if P > 0 then
    Host := Copy(Host, 1, P - 1);

  // Name resolution is recorded as a FACT, never used as evidence that the
  // internet works. Many ISPs hijack unknown names and answer every lookup with
  // a search-page address, so "it resolved" can be true with no connectivity to
  // the real host at all -- verified here against a deliberately bogus name,
  // which resolved happily and accepted a socket on 443.
  IP := '';
  try
    TIdStack.IncUsage;
    try
      IP := GStack.ResolveHost(Host);
    finally
      TIdStack.DecUsage;
    end;
  except
    IP := '';
  end;

  // 1. Is there a listening socket at all?
  Client := TIdTCPClient.Create(nil);
  try
    Client.Host := Host;
    Client.Port := 443;
    Client.ConnectTimeout := 8000;
    try
      Client.Connect;
      Client.Disconnect;
    except
      on E: Exception do
        Exit(Format(
          'This PC cannot reach %s.' + sLineBreak + sLineBreak +
          'Either the store has no internet connection at the moment, or ' +
          'something here (a firewall or security product) is blocking ' +
          'outgoing secure traffic.' + sLineBreak + sLineBreak +
          'Technical detail: %s%s',
          [Host, E.Message,
           IfThen(IP = '', '', ' (name resolved to ' + IP + ')')]));
    end;
  finally
    Client.Free;
  end;

  // 2. A socket opened -- but to WHAT? "Something answered" is not the same as
  // "LeadsOnline answered": a captive portal or an ISP redirect will happily
  // accept the connection. Fetching the service's own WSDL and looking for its
  // contract is the cheap proof, because only the real endpoint can produce it.
  Body := '';
  try
    Http := THTTPClient.Create;
    try
      Http.ConnectionTimeout := 8000;
      Http.ResponseTimeout := 8000;
      Body := Http.Get(AURL + '?wsdl').ContentAsString;
    finally
      Http.Free;
    end;
  except
    on E: Exception do
      Exit(Format(
        'Something answered at %s, but the connection to LeadsOnline could not ' +
        'be completed.' + sLineBreak + sLineBreak +
        'This usually means the connection is being intercepted -- a captive ' +
        'wifi login page, a proxy, or an internet provider redirecting the ' +
        'address -- or that LeadsOnline''s certificate has a problem.' +
        sLineBreak + sLineBreak + 'Technical detail: %s', [Host, E.Message]));
  end;

  if not ContainsText(Body, 'ticketWSSoap') then
    Exit(Format(
      'Something answered at %s, but it is not LeadsOnline.' + sLineBreak + sLineBreak +
      'The address is being redirected somewhere else -- most often a captive ' +
      'wifi login page, a company proxy, or an internet provider that answers ' +
      'unknown addresses with its own search page. The store may look like it ' +
      'has internet when it does not.' + sLineBreak + sLineBreak +
      'Ask whoever manages the network here to allow %s.' + sLineBreak + sLineBreak +
      // The probed address is printed because this verdict is stated
      // confidently and is the one most likely to send someone hunting a
      // firewall that is not the problem. Handed a URL without the service
      // path, the site answers 403 and this branch fires on a perfectly
      // healthy connection -- seeing the address makes that obvious.
      'Address checked: %s', [Host, Host, AURL + '?wsdl']));

  Result := Format(
    'The connection to %s is working normally%s, so this is not a network ' +
    'problem at the store.' + sLineBreak + sLineBreak +
    'LeadsOnline accepted the connection but did not complete the request in ' +
    'time. Their service is most likely busy or having problems. Try again later.',
    [Host, IfThen(IP = '', '', ' (' + IP + ')')]);
end;

function ResultIsAlreadyAccepted(const AResult: TLeadsOnlineResult): Boolean;
begin
  //  6 - conflicts with a ticket created through another source
  // 13 - ticket already exists and cannot be modified by a submit
  Result := (AResult.ErrorCode = 6) or (AResult.ErrorCode = 13);
end;

function LeadsOnlineErrorText(AErrorCode: Integer; const AErrorResponse: string): string;
var
  Known: string;
begin
  if AErrorCode = 0 then
    Exit('OK');

  // Transcribed from the vendor spec's Error Codes section. The service also
  // sends its own prose in errorResponse, which is usually more specific (it
  // names the offending store id or username), so that wins when present and
  // this table fills in when it is empty.
  case AErrorCode of
    -1: Known := 'An internal error occurred at LeadsOnline. Contact their Business Support.';
     1: Known := 'A date was sent in a format LeadsOnline did not recognise.';
     2: Known := 'No ticket number was supplied.';
     3: Known := 'The store ID is not valid.';
     4: Known := 'The API username or password is not correct.';
     5: Known := 'LeadsOnline has no ticket with that ticket key.';
     6: Known := 'This ticket conflicts with one already created by another source ' +
                 '(not this web service).';
     7: Known := 'The ticket date is out of range - either in the future, or too old ' +
                 'for LeadsOnline to still hold.';
     8: Known := 'Invalid state abbreviation.';
     9: Known := 'Invalid ID number.';
    10: Known := 'The image upload failed.';
    11: Known := 'The image delete failed.';
    12: Known := 'At least two of name, ID number and date of birth must be supplied.';
    13: Known := 'This ticket already exists and cannot be modified by a submit. ' +
                 'Use UpdateTransaction, or resubmit it immediately after the ' +
                 'attempt that failed.';
  else
    Known := '';
  end;

  if Trim(AErrorResponse) <> '' then
    Exit(Format('%s (code %d)', [Trim(AErrorResponse), AErrorCode]));

  if Known <> '' then
    Result := Format('%s (code %d)', [Known, AErrorCode])
  else
    Result := Format('LeadsOnline returned error code %d', [AErrorCode]);
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

function TLeadsOnlineClient.SubmitTransaction(ATicket: Ticket): TLeadsOnlineResult;
var
  Login: LoginInfo;
begin
  if ATicket = nil then
    raise ELeadsOnlineTransport.Create('SubmitTransaction', GetEndpointURL,
      'no ticket was supplied');

  Login := NewLoginInfo;
  try
    Result := Execute('SubmitTransaction',
      function: Response
      begin
        Result := GetService.SubmitTransaction(FApiVersion, ResolveIpAddress, Login, ATicket);
      end);
  finally
    Login.Free;
  end;
end;

function TLeadsOnlineClient.TrySubmitTransaction(ATicket: Ticket;
  out AResult: TLeadsOnlineResult; out AError: string): Boolean;
begin
  AError := '';
  try
    AResult := SubmitTransaction(ATicket);
    Result := True;             // reached the service; AResult says what it said
  except
    on E: Exception do
    begin
      AResult := Default(TLeadsOnlineResult);
      AError := E.Message;
      Result := False;          // never reached the service
    end;
  end;
end;

function DetectImageType(const ABytes: TBytes): ImageType;
begin
  // Sniffed from the content, never assumed from a file extension. PawnPro
  // names every stored image .jpg regardless of what the camera or the operator
  // actually produced, so a PNG saved through that path would otherwise be
  // announced to LeadsOnline as a JPEG.
  Result := ImageType.Jpeg;
  if Length(ABytes) < 8 then
    Exit;

  if (ABytes[0] = $89) and (ABytes[1] = Ord('P')) and (ABytes[2] = Ord('N')) and
     (ABytes[3] = Ord('G')) then
    Result := ImageType.Png
  else if (ABytes[0] = Ord('G')) and (ABytes[1] = Ord('I')) and (ABytes[2] = Ord('F')) then
    Result := ImageType.Gif
  else if (ABytes[0] = Ord('%')) and (ABytes[1] = Ord('P')) and (ABytes[2] = Ord('D')) and
          (ABytes[3] = Ord('F')) then
    Result := ImageType.Pdf;
end;

function TLeadsOnlineClient.UploadImage(AKey: TicketKey; const ABytes: TBytes;
  ACategory: ImageCategory; AItemIndex: Integer): TLeadsOnlineResult;
var
  Login: LoginInfo;
  Img: Image;
begin
  if AKey = nil then
    raise ELeadsOnlineTransport.Create('UploadImage', GetEndpointURL,
      'no ticket key was supplied');
  if Length(ABytes) = 0 then
    raise ELeadsOnlineTransport.Create('UploadImage', GetEndpointURL,
      'the image is empty');

  Login := NewLoginInfo;
  try
    Img := Image.Create;
    try
      Img.imageCategory := ACategory;
      Img.imageType := DetectImageType(ABytes);
      Img.imageData := TByteSOAPArray(ABytes);

      Result := Execute('UploadImage',
        function: Response
        begin
          Result := GetService.UploadImage(FApiVersion, ResolveIpAddress, Img,
                                           AItemIndex, Login, AKey);
        end);
    finally
      Img.Free;
    end;
  finally
    Login.Free;
  end;
end;

function TLeadsOnlineClient.TryUploadImage(AKey: TicketKey; const ABytes: TBytes;
  ACategory: ImageCategory; AItemIndex: Integer;
  out AResult: TLeadsOnlineResult; out AError: string): Boolean;
begin
  AError := '';
  try
    AResult := UploadImage(AKey, ABytes, ACategory, AItemIndex);
    Result := True;             // reached the service; AResult says what it said
  except
    on E: Exception do
    begin
      AResult := Default(TLeadsOnlineResult);
      AError := E.Message;
      Result := False;          // never reached the service
    end;
  end;
end;

function TLeadsOnlineClient.TryCheckLogin(out AResult: TLeadsOnlineResult;
  out AError: string): Boolean;
begin
  AError := '';
  try
    AResult := CheckLogin;
    // REACHED the service -- whatever it thought of the credentials. AResult
    // carries the verdict. This deliberately matches TrySubmitTransaction and
    // TryUploadImage: True means "we got an answer", never "the answer was
    // yes". Returning False for a rejected login as well as for a dead line
    // made the two indistinguishable to the caller, and the settings screen
    // reported a firewall block as bad credentials.
    Result := True;
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
