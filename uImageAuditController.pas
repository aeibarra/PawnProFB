unit uImageAuditController;

interface

uses
  System.Classes, System.SyncObjs, FireDAC.Comp.Client, uImageBackupAudit;

type
  TImageAuditState = (iasIdle, iasRunning, iasStopping, iasCompleted, iasFailed);

  TImageAuditController = class
  private
    FLock: TCriticalSection;
    FThread: TThread;
    FStopEvent: TEvent;
    FDoneEvent: TEvent;
    FState: TImageAuditState;
    FResult: TImageAuditResult;
    FLogFile: string;
    procedure Log(const AMessage: string);
    procedure SetFinished(const AResult: TImageAuditResult);
    class function ConnectionConfigFrom(AConnection: TFDConnection): TFBConnectionConfig; static;
  public
    constructor Create(const ALogFile: string);
    destructor Destroy; override;
    function TryStartIfDue(AConnection: TFDConnection;
      const ASourceRoot, ABackupRoot, ALastAuditWeek, ACurrentAuditWeek: string;
      AInitialDelayMs: Cardinal = 15000; AItemThrottleMs: Cardinal = 100): Boolean;
    procedure RequestStop;
    function WaitForStop(ATimeoutMs: Cardinal): Boolean;
    function State: TImageAuditState;
    function LastResult: TImageAuditResult;
  end;

implementation

uses
  System.SysUtils, PawnGlobal;

constructor TImageAuditController.Create(const ALogFile: string);
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FStopEvent := TEvent.Create(nil, True, False, '');
  FDoneEvent := TEvent.Create(nil, True, True, '');
  FLogFile := ALogFile;
  FState := iasIdle;
end;

destructor TImageAuditController.Destroy;
begin
  RequestStop;
  // Object ownership cannot safely end while the worker still uses its events.
  // Callers can use WaitForStop with a bounded timeout first for diagnostics.
  if Assigned(FThread) then
  begin
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;
  FDoneEvent.Free;
  FStopEvent.Free;
  FLock.Free;
  inherited;
end;

procedure TImageAuditController.Log(const AMessage: string);
var
  Stream: TFileStream;
  Line: UTF8String;
begin
  if FLogFile = '' then
    Exit;
  try
    ForceDirectories(ExtractFilePath(FLogFile));
    Line := UTF8String(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now) +
      ' [thread ' + IntToStr(TThread.CurrentThread.ThreadID) + '] ' +
      AMessage + sLineBreak);
    if FileExists(FLogFile) then
      Stream := TFileStream.Create(FLogFile, fmOpenReadWrite or fmShareDenyWrite)
    else
      Stream := TFileStream.Create(FLogFile, fmCreate or fmShareDenyWrite);
    try
      Stream.Position := Stream.Size;
      if Length(Line) > 0 then
        Stream.WriteBuffer(Line[1], Length(Line));
    finally
      Stream.Free;
    end;
  except
    // Diagnostics must never take down the application.
  end;
end;

class function TImageAuditController.ConnectionConfigFrom(
  AConnection: TFDConnection): TFBConnectionConfig;
begin
  Result := Default(TFBConnectionConfig);
  Result.Server := AConnection.Params.Values['Server'];
  Result.Database := AConnection.Params.Values['Database'];
  Result.UserName := AConnection.Params.Values['User_Name'];
  Result.Password := AConnection.Params.Values['Password'];
  Result.Port := StrToIntDef(AConnection.Params.Values['Port'], 3050);
  Result.CharacterSet := AConnection.Params.Values['CharacterSet'];
end;

function TImageAuditController.TryStartIfDue(AConnection: TFDConnection;
  const ASourceRoot, ABackupRoot, ALastAuditWeek, ACurrentAuditWeek: string;
  AInitialDelayMs, AItemThrottleMs: Cardinal): Boolean;
var
  Config: TImageAuditConfig;
begin
  Result := False;
  if not Assigned(AConnection) or not AConnection.Connected then
    Exit;
  if (Trim(ASourceRoot) = '') or not DirectoryExists(ASourceRoot) then
    Exit;
  if (Trim(ABackupRoot) = '') or not DirectoryExists(ABackupRoot) then
    Exit;
  if SameText(Trim(ALastAuditWeek), Trim(ACurrentAuditWeek)) then
    Exit;

  FLock.Acquire;
  try
    if Assigned(FThread) then
      Exit;

    Config := Default(TImageAuditConfig);
    Config.SourceRoot := IncludeTrailingPathDelimiter(ASourceRoot);
    Config.BackupRoot := IncludeTrailingPathDelimiter(ABackupRoot);
    Config.AuditWeek := ACurrentAuditWeek;
    Config.Connection := ConnectionConfigFrom(AConnection);
    Config.InitialDelayMs := AInitialDelayMs;
    Config.ItemThrottleMs := AItemThrottleMs;

    FStopEvent.ResetEvent;
    FDoneEvent.ResetEvent;
    FResult := Default(TImageAuditResult);
    FState := iasRunning;
    FThread := TThread.CreateAnonymousThread(
      procedure
      var
        AuditResult: TImageAuditResult;
      begin
        Log('Image audit started.');
        RunImageBackupAudit(Config, FStopEvent, AuditResult);
        if AuditResult.Completed then
        begin
          // These helpers serialize access to PawnPro.ini. A canceled or
          // partial audit deliberately does not advance the weekly marker.
          WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditDate,
            FormatDateTime('yyyy-mm-dd', Date));
          WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditWeek,
            Config.AuditWeek);
        end;
        SetFinished(AuditResult);
      end);
    FThread.FreeOnTerminate := False;
    FThread.Priority := tpLowest;
    FThread.Start;
    Result := True;
  finally
    FLock.Release;
  end;
end;

procedure TImageAuditController.SetFinished(const AResult: TImageAuditResult);
begin
  FLock.Acquire;
  try
    FResult := AResult;
    if AResult.Completed or AResult.Canceled then
      FState := iasCompleted
    else
      FState := iasFailed;
    FDoneEvent.SetEvent;
  finally
    FLock.Release;
  end;
  Log(Format('Image audit finished: completed=%s canceled=%s checked=%d ' +
    'missing=%d different=%d last=%d error="%s"',
    [BoolToStr(AResult.Completed, True), BoolToStr(AResult.Canceled, True),
     AResult.CheckedCount, AResult.MissingCount, AResult.DifferentCount,
     AResult.LastImageNo, AResult.ErrorMessage]));
end;

procedure TImageAuditController.RequestStop;
var
  LogRequest: Boolean;
begin
  LogRequest := False;
  FLock.Acquire;
  try
    if FState = iasRunning then
    begin
      FState := iasStopping;
      LogRequest := True;
    end;
    FStopEvent.SetEvent;
  finally
    FLock.Release;
  end;
  if LogRequest then
    Log('Image audit stop requested.');
end;

function TImageAuditController.WaitForStop(ATimeoutMs: Cardinal): Boolean;
begin
  Result := FDoneEvent.WaitFor(ATimeoutMs) = wrSignaled;
  if not Result then
    Log('Image audit did not stop within ' + IntToStr(ATimeoutMs) + ' ms.');
end;

function TImageAuditController.State: TImageAuditState;
begin
  FLock.Acquire;
  try
    Result := FState;
  finally
    FLock.Release;
  end;
end;

function TImageAuditController.LastResult: TImageAuditResult;
begin
  FLock.Acquire;
  try
    Result := FResult;
  finally
    FLock.Release;
  end;
end;

end.
