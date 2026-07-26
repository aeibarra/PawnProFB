unit uImageAuditController;

{ Owns the lifetime of the weekly image-backup audit worker.

  Isolation rules this unit exists to enforce -- the audit runs unattended in a
  live register, so a defect here has to degrade into "the audit did not run",
  never into a crash or a hung shutdown:

  1. The worker never touches TDM, any VCL component, or any global mutable
     state. Everything it needs is copied into a plain value record on the main
     thread before the thread starts (see TryStartIfDue / ConnectionConfigFrom).

  2. The worker closure captures a REF-COUNTED context, not the controller
     object. Freeing the controller therefore can never pull state out from
     under a running worker: whichever of the two dies last releases the shared
     events and log. This is what makes the bounded shutdown below safe.

  3. Shutdown is bounded and never blocks the process. If the worker will not
     exit in time the controller abandons it -- deliberately leaking the thread
     object and its context -- and lets process exit reclaim everything. A leak
     at exit is strictly better than the windowless ghost process an unbounded
     WaitFor produces.

  Because of (1) and (2) this unit is already close to a standalone program: if
  the in-process retest is not conclusive, RunImageBackupAudit plus a snapshot
  of TImageAuditConfig is the whole payload a separate audit EXE would need. }

interface

uses
  System.Classes, System.SyncObjs, FireDAC.Comp.Client, uImageBackupAudit;

type
  TImageAuditState = (iasIdle, iasRunning, iasStopping, iasCompleted, iasFailed);

  { Shared, ref-counted state. Lives as long as EITHER the controller or the
    worker closure still references it. }
  IImageAuditContext = interface
    ['{6F2C8A41-3D5B-4C71-9E0A-7B4D2F1C6E88}']
    function StopEvent: TEvent;
    procedure Log(const AMessage: string);
    procedure BeginRun;
    procedure Finish(const AResult: TImageAuditResult);
    procedure RequestStop;
    function StopWasRequested: Boolean;
    function State: TImageAuditState;
    function LastResult: TImageAuditResult;
  end;

  TImageAuditController = class
  private
    FLock: TCriticalSection;
    FThread: TThread;
    FContext: IImageAuditContext;
    class function ConnectionConfigFrom(AConnection: TFDConnection): TFBConnectionConfig; static;
    function WorkerFinished(ATimeoutMs: Cardinal): Boolean;
  public
    constructor Create(const ALogFile: string);
    destructor Destroy; override;
    function TryStartIfDue(AConnection: TFDConnection;
      const ASourceRoot, ABackupRoot, ALastAuditWeek, ACurrentAuditWeek: string;
      AInitialDelayMs: Cardinal = 15000; AItemThrottleMs: Cardinal = 100): Boolean;
    procedure RequestStop;
    function WaitForStop(ATimeoutMs: Cardinal): Boolean;
    { Writes a line to the audit log without involving the worker. Used to mark
      clean shutdowns so a missing marker is positive evidence of a wedge. }
    procedure Note(const AMessage: string);
    function State: TImageAuditState;
    function LastResult: TImageAuditResult;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, PawnGlobal;

var
  { The worker must not read the global FormatSettings: any form in the app can
    change those at runtime, and a locale-dependent result would corrupt the
    weekly marker written to PawnPro.ini or scramble log timestamps. Note that
    ':' in a Delphi format string is the TimeSeparator *placeholder*, not a
    literal, so timestamps are exposed to this too. Set once at unit
    initialization, read-only thereafter. }
  AuditFormat: TFormatSettings;

type
  TImageAuditContext = class(TInterfacedObject, IImageAuditContext)
  private
    FLock: TCriticalSection;
    FLogLock: TCriticalSection;
    FStopEvent: TEvent;
    FState: TImageAuditState;
    FResult: TImageAuditResult;
    FLogFile: string;
    FStopRequested: Boolean;
  public
    constructor Create(const ALogFile: string);
    destructor Destroy; override;
    function StopEvent: TEvent;
    procedure Log(const AMessage: string);
    procedure BeginRun;
    procedure Finish(const AResult: TImageAuditResult);
    procedure RequestStop;
    function StopWasRequested: Boolean;
    function State: TImageAuditState;
    function LastResult: TImageAuditResult;
  end;

{ TImageAuditContext }

constructor TImageAuditContext.Create(const ALogFile: string);
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FLogLock := TCriticalSection.Create;
  // Manual reset: once shutdown is signalled it stays signalled for every wait
  // the worker performs.
  FStopEvent := TEvent.Create(nil, True, False, '');
  FLogFile := ALogFile;
  FState := iasIdle;
end;

destructor TImageAuditContext.Destroy;
begin
  // Reached only when both the controller and the worker closure are gone, so
  // nothing can still be waiting on these.
  FStopEvent.Free;
  FLogLock.Free;
  FLock.Free;
  inherited;
end;

function TImageAuditContext.StopEvent: TEvent;
begin
  Result := FStopEvent;
end;

procedure TImageAuditContext.Log(const AMessage: string);
var
  Stream: TFileStream;
  Line: UTF8String;
begin
  if FLogFile = '' then
    Exit;
  // Its own lock, not FLock: RequestStop logs while callers may be reading
  // state, and the log must never be a path back into the state lock.
  FLogLock.Acquire;
  try
    try
      ForceDirectories(ExtractFilePath(FLogFile));
      Line := UTF8String(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now, AuditFormat) +
        ' [thread ' + IntToStr(TThread.CurrentThread.ThreadID) + '] ' +
        AMessage + sLineBreak);
      // DenyNone, not DenyWrite: the previous share mode made concurrent writes
      // from the main and worker threads fail, silently dropping exactly the
      // shutdown diagnostics this log exists to capture.
      if FileExists(FLogFile) then
        Stream := TFileStream.Create(FLogFile, fmOpenReadWrite or fmShareDenyNone)
      else
        Stream := TFileStream.Create(FLogFile, fmCreate or fmShareDenyNone);
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
  finally
    FLogLock.Release;
  end;
end;

procedure TImageAuditContext.BeginRun;
begin
  FLock.Acquire;
  try
    FStopEvent.ResetEvent;
    FResult := Default(TImageAuditResult);
    FState := iasRunning;
  finally
    FLock.Release;
  end;
end;

function TImageAuditContext.StopWasRequested: Boolean;
begin
  FLock.Acquire;
  try
    Result := FStopRequested;
  finally
    FLock.Release;
  end;
end;

procedure TImageAuditContext.Finish(const AResult: TImageAuditResult);
begin
  FLock.Acquire;
  try
    FResult := AResult;
    if AResult.Completed or AResult.Canceled then
      FState := iasCompleted
    else
      FState := iasFailed;
  finally
    FLock.Release;
  end;
  Log(Format('Image audit finished: completed=%s canceled=%s checked=%d ' +
    'missing=%d different=%d errors=%d last=%d error="%s"',
    [BoolToStr(AResult.Completed, True), BoolToStr(AResult.Canceled, True),
     AResult.CheckedCount, AResult.MissingCount, AResult.DifferentCount,
     AResult.ErrorCount, AResult.LastImageNo, AResult.ErrorMessage]));
end;

procedure TImageAuditContext.RequestStop;
var
  LogRequest: Boolean;
begin
  LogRequest := False;
  FLock.Acquire;
  try
    // Sticky: BeginRun resets the event, so without this a start racing with
    // shutdown could clear the stop and launch a worker into a dying process.
    FStopRequested := True;
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

function TImageAuditContext.State: TImageAuditState;
begin
  FLock.Acquire;
  try
    Result := FState;
  finally
    FLock.Release;
  end;
end;

function TImageAuditContext.LastResult: TImageAuditResult;
begin
  FLock.Acquire;
  try
    Result := FResult;
  finally
    FLock.Release;
  end;
end;

{ TImageAuditController }

constructor TImageAuditController.Create(const ALogFile: string);
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FContext := TImageAuditContext.Create(ALogFile);
end;

destructor TImageAuditController.Destroy;
const
  { Short: by the time this runs the main window is already gone, so every
    millisecond spent here is a millisecond of windowless process. }
  AbandonAfterMs = 3000;
begin
  RequestStop;
  if Assigned(FThread) then
  begin
    if WorkerFinished(AbandonAfterMs) then
      FreeAndNil(FThread)
    else
    begin
      // Deliberate leak. The thread object and the context it captured stay
      // alive; releasing them here would free the worker's stop event and log
      // lock underneath it. Process exit reclaims both. See note (3) above.
      FContext.Log(Format('Image audit worker did not exit within %d ms -- ' +
        'abandoning it so shutdown can complete. Thread and audit context are ' +
        'leaked on purpose; the process is exiting.', [AbandonAfterMs]));
      FThread := nil;
    end;
  end;
  FContext := nil;
  FLock.Free;
  inherited;
end;

{ True once the OS thread has actually terminated. The context's completion
  state is not a substitute: it is published from inside the thread body, which
  still has to unwind afterwards. }
function TImageAuditController.WorkerFinished(ATimeoutMs: Cardinal): Boolean;
begin
  if not Assigned(FThread) then
    Exit(True);
  Result := WaitForSingleObject(FThread.Handle, ATimeoutMs) = WAIT_OBJECT_0;
end;

class function TImageAuditController.ConnectionConfigFrom(
  AConnection: TFDConnection): TFBConnectionConfig;
begin
  // Snapshot taken on the main thread. The worker gets plain strings and never
  // reaches back into the DM's connection, driver link or password handling.
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
  Context: IImageAuditContext;
begin
  Result := False;
  // Never start once shutdown has begun, however the caller got here.
  if FContext.StopWasRequested then
    Exit;
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
    // A previous run's thread object is reaped here rather than left assigned
    // forever, so a second start in the same session (a manual "run now", a
    // retry after a yield) is possible instead of silently doing nothing.
    if Assigned(FThread) then
    begin
      if not WorkerFinished(0) then
        Exit;
      FreeAndNil(FThread);
    end;

    Config := Default(TImageAuditConfig);
    Config.SourceRoot := IncludeTrailingPathDelimiter(ASourceRoot);
    Config.BackupRoot := IncludeTrailingPathDelimiter(ABackupRoot);
    Config.AuditWeek := ACurrentAuditWeek;
    Config.Connection := ConnectionConfigFrom(AConnection);
    Config.InitialDelayMs := AInitialDelayMs;
    Config.ItemThrottleMs := AItemThrottleMs;

    // Captured by the closure below instead of Self. This local reference is
    // what keeps the shared state alive if the controller is freed first.
    Context := FContext;
    Context.BeginRun;

    FThread := TThread.CreateAnonymousThread(
      procedure
      var
        AuditResult: TImageAuditResult;
      begin
        Context.Log('Image audit started.');
        try
          RunImageBackupAudit(Config, Context.StopEvent,
            procedure(const AMessage: string)
            begin
              Context.Log(AMessage);
            end,
            AuditResult);

          // Serialized against the UI's ini access by PawnGlobal's lock. A
          // canceled or partial audit deliberately does not advance the weekly
          // marker, so it retries on the next eligible day.
          //
          // StopWasRequested is checked as well even though a stopped run can
          // never report Completed: it closes the theoretical window where a
          // worker completes just as shutdown begins and then reaches into
          // PawnGlobal (AppPath, the ini lock) while unit finalization is
          // already running on the main thread. Skipping the marker there costs
          // one deferred audit; touching finalized globals costs a crash log
          // that would send us hunting the wrong bug.
          if AuditResult.Completed and not Context.StopWasRequested then
          begin
            WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditDate,
              FormatDateTime('yyyy-mm-dd', Date, AuditFormat));
            WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditWeek,
              Config.AuditWeek);
          end;
        except
          // The worker must not let anything escape into the RTL's default
          // thread-exception path while the app may be tearing down.
          on E: Exception do
          begin
            AuditResult.Completed := False;
            AuditResult.ErrorMessage := E.ClassName + ': ' + E.Message;
          end;
        end;
        Context.Finish(AuditResult);
      end);
    FThread.FreeOnTerminate := False;
    FThread.Priority := tpLowest;
    FThread.Start;
    Result := True;
  finally
    FLock.Release;
  end;
end;

procedure TImageAuditController.RequestStop;
begin
  FContext.RequestStop;
end;

function TImageAuditController.WaitForStop(ATimeoutMs: Cardinal): Boolean;
begin
  RequestStop;
  Result := WorkerFinished(ATimeoutMs);
  if not Result then
    FContext.Log('Image audit did not stop within ' + IntToStr(ATimeoutMs) + ' ms.');
end;

procedure TImageAuditController.Note(const AMessage: string);
begin
  FContext.Log(AMessage);
end;

function TImageAuditController.State: TImageAuditState;
begin
  Result := FContext.State;
end;

function TImageAuditController.LastResult: TImageAuditResult;
begin
  Result := FContext.LastResult;
end;

initialization
  AuditFormat := TFormatSettings.Invariant;

end.
