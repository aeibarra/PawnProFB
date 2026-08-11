program LeadsOnlineProbe;

// Sandbox smoke test for the LeadsOnline SOAP channel.
//
// Exercises uLeadsOnlineClient against a live endpoint without launching
// PawnPro or touching a database, so a connectivity problem can be told apart
// from an application problem. Phase 1 covers CheckLogin only.
//
//   LeadsOnlineProbe <storeId> <userName> <password>
//                    [--production] [--api N] [--xml] [--timeout MS]
//
// Credentials are arguments on purpose: nothing about a store's API login
// belongs in a file in a public repository.
//
// Exit codes: 0 = errorCode 0, 1 = service rejected the login,
//             2 = the service could not be reached, 3 = bad usage.

{$APPTYPE CONSOLE}

uses
  Winapi.ActiveX,
  System.SysUtils,
  LeadsOnlineWS in '..\LeadsOnlineWS.pas',
  uLeadsOnlineClient in '..\uLeadsOnlineClient.pas';

const
  ExitOK          = 0;
  ExitRejected    = 1;
  ExitUnreachable = 2;
  ExitUsage       = 3;

procedure Usage;
begin
  Writeln('Usage: LeadsOnlineProbe <storeId> <userName> <password>');
  Writeln('                        [--production] [--api N] [--xml] [--timeout MS]');
  Writeln;
  Writeln('  --production  hit the production endpoint (default: sandbox)');
  Writeln('  --api N       override the ApiVersion element (default: ',
          LeadsOnlineApiVersion, ')');
  Writeln('  --xml         print the request and response envelopes');
  Writeln('  --timeout MS  per-call network timeout (default: ',
          LeadsOnlineDefaultTimeout, ')');
end;

function Run: Integer;
var
  I, StoreId, ApiVersion, TimeoutMS: Integer;
  UserName, Password, Arg: string;
  UseSandbox, ShowXML: Boolean;
  Client: TLeadsOnlineClient;
  Res: TLeadsOnlineResult;
begin
  if ParamCount < 3 then
  begin
    Usage;
    Exit(ExitUsage);
  end;

  if not TryStrToInt(ParamStr(1), StoreId) then
  begin
    Writeln('storeId must be numeric: ', ParamStr(1));
    Exit(ExitUsage);
  end;
  UserName := ParamStr(2);
  Password := ParamStr(3);

  UseSandbox := True;
  ShowXML := False;
  ApiVersion := LeadsOnlineApiVersion;
  TimeoutMS := LeadsOnlineDefaultTimeout;

  I := 4;
  while I <= ParamCount do
  begin
    Arg := LowerCase(ParamStr(I));
    if Arg = '--production' then
      UseSandbox := False
    else if Arg = '--sandbox' then
      UseSandbox := True
    else if Arg = '--xml' then
      ShowXML := True
    else if (Arg = '--api') and (I < ParamCount) then
    begin
      Inc(I);
      if not TryStrToInt(ParamStr(I), ApiVersion) then
      begin
        Writeln('--api needs a number');
        Exit(ExitUsage);
      end;
    end
    else if (Arg = '--timeout') and (I < ParamCount) then
    begin
      Inc(I);
      if not TryStrToInt(ParamStr(I), TimeoutMS) then
      begin
        Writeln('--timeout needs a number');
        Exit(ExitUsage);
      end;
    end
    else
    begin
      Writeln('Unknown argument: ', ParamStr(I));
      Usage;
      Exit(ExitUsage);
    end;
    Inc(I);
  end;

  Client := TLeadsOnlineClient.Create(StoreId, UserName, Password, UseSandbox);
  try
    Client.ApiVersion := ApiVersion;
    Client.TimeoutMS := TimeoutMS;
    Client.CaptureXML := ShowXML;

    Writeln('Endpoint   : ', Client.EndpointURL);
    Writeln('Store id   : ', Client.StoreId);
    Writeln('User       : ', Client.UserName);
    Writeln('ApiVersion : ', Client.ApiVersion);
    Writeln;
    Writeln('CheckLogin ...');

    try
      Res := Client.CheckLogin;
    except
      on E: ELeadsOnlineTransport do
      begin
        Writeln('UNREACHABLE: ', E.Message);
        Exit(ExitUnreachable);
      end;
    end;

    if ShowXML then
    begin
      Writeln;
      Writeln('--- request ---');
      Writeln(Client.LastRequestXML);
      Writeln('--- response ---');
      Writeln(Client.LastResponseXML);
      Writeln;
    end;

    Writeln('errorCode     : ', Res.ErrorCode);
    Writeln('errorResponse : ', Res.ErrorResponse);
    Writeln('verdict       : ', Res.Text);

    if Res.Succeeded then
      Result := ExitOK
    else
      Result := ExitRejected;
  finally
    Client.Free;
  end;
end;

begin
  // Delphi's SOAP stack parses through MSXML, which is COM. A VCL host gets
  // COM initialised for free; a console program has to say so itself.
  CoInitialize(nil);
  try
    ExitCode := Run;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := ExitUnreachable;
    end;
  end;
  CoUninitialize;
end.
