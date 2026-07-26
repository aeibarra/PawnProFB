unit uImageMaintenanceGate;

{ Mutual exclusion between the three things that touch the image folder:
  the weekly background audit, an image backup, and an interactive camera
  capture.

  Interactive work always wins. The audit can hold the gate for many minutes on
  a store with a large image set, so a plain "first come, first served" lock
  would tell a clerk to come back later for the length of a whole audit. Instead
  the audit is *preemptible*: when an interactive operation asks for the gate it
  raises a yield request, the audit notices at its next checkpoint, abandons the
  run and releases. The abandoned run does not advance the weekly marker, so it
  simply retries on the next eligible day.

  This unit deliberately has no VCL, DB or PawnPro dependencies -- it is the
  only piece of shared state between the background worker and the UI, and it
  stays small enough to reason about in one screen. }

interface

type
  TImageMaintenanceOperation = (imoNone, imoAudit, imoBackup, imoImageCapture);

{ Claims the gate. AWaitMs > 0 makes the caller wait (and preempt a running
  audit) rather than fail immediately; pass 0 for a pure try. Returns False if
  the gate could not be claimed within AWaitMs. Every True result must be
  balanced by EndImageMaintenance. }
function TryBeginImageMaintenance(AOperation: TImageMaintenanceOperation;
  AWaitMs: Cardinal = 0): Boolean;

procedure EndImageMaintenance(AOperation: TImageMaintenanceOperation);
function CurrentImageMaintenanceOperation: TImageMaintenanceOperation;

{ Polled by the audit at its checkpoints. True means an interactive operation is
  waiting and the audit must stop and release the gate promptly. }
function ImageMaintenanceYieldRequested: Boolean;

implementation

uses
  Winapi.Windows, System.SyncObjs;

const
  { How long a caller sleeps between attempts while waiting for the audit to
    notice a yield request and release. The audit checks between every item, so
    in practice it releases well inside one slice. }
  RetrySliceMs = 25;

var
  Gate: TCriticalSection;
  ActiveOperation: TImageMaintenanceOperation;
  YieldRequested: Integer;

function IsPreemptible(AOperation: TImageMaintenanceOperation): Boolean;
begin
  { Only the unattended weekly audit gives way. A backup in progress is either
    user-initiated or part of shutdown; interrupting it would leave a partial
    image set, which is worse than making the caller wait. }
  Result := AOperation = imoAudit;
end;

function IsInteractive(AOperation: TImageMaintenanceOperation): Boolean;
begin
  Result := AOperation in [imoBackup, imoImageCapture];
end;

function ImageMaintenanceYieldRequested: Boolean;
begin
  Result := TInterlocked.CompareExchange(YieldRequested, 0, 0) <> 0;
end;

function TryBeginImageMaintenance(AOperation: TImageMaintenanceOperation;
  AWaitMs: Cardinal): Boolean;
var
  Deadline: UInt64;
  Holder: TImageMaintenanceOperation;
begin
  Deadline := GetTickCount64 + AWaitMs;
  repeat
    Gate.Acquire;
    try
      Result := ActiveOperation = imoNone;
      if Result then
        ActiveOperation := AOperation;
      Holder := ActiveOperation;
    finally
      Gate.Release;
    end;

    if Result then
      Exit;

    { Ask the audit to stand down. Safe to re-assert on every pass: the flag is
      cleared only when the audit actually releases the gate. }
    if IsInteractive(AOperation) and IsPreemptible(Holder) then
      TInterlocked.Exchange(YieldRequested, 1);

    if GetTickCount64 >= Deadline then
      Exit;

    Sleep(RetrySliceMs);
  until False;
end;

procedure EndImageMaintenance(AOperation: TImageMaintenanceOperation);
begin
  Gate.Acquire;
  try
    if ActiveOperation = AOperation then
    begin
      ActiveOperation := imoNone;
      { Cleared here rather than by the waiter: the request belongs to the
        holder that was asked to yield, and clearing it on release is what makes
        a later audit run start with a clean flag. }
      if IsPreemptible(AOperation) then
        TInterlocked.Exchange(YieldRequested, 0);
    end;
  finally
    Gate.Release;
  end;
end;

function CurrentImageMaintenanceOperation: TImageMaintenanceOperation;
begin
  Gate.Acquire;
  try
    Result := ActiveOperation;
  finally
    Gate.Release;
  end;
end;

initialization
  Gate := TCriticalSection.Create;
  ActiveOperation := imoNone;
  YieldRequested := 0;

finalization
  { Deliberately not freed. This unit is used by both the UI and the background
    audit; unit finalization order does not guarantee the worker is gone by the
    time this runs, and a freed critical section would turn an orderly shutdown
    into an access violation. One 40-byte object at process exit is the correct
    trade. }

end.
