unit uImageMaintenanceGate;

interface

type
  TImageMaintenanceOperation = (imoNone, imoAudit, imoBackup, imoImageCapture);

function TryBeginImageMaintenance(AOperation: TImageMaintenanceOperation): Boolean;
procedure EndImageMaintenance(AOperation: TImageMaintenanceOperation);
function CurrentImageMaintenanceOperation: TImageMaintenanceOperation;

implementation

uses
  System.SyncObjs;

var
  Gate: TCriticalSection;
  ActiveOperation: TImageMaintenanceOperation;

function TryBeginImageMaintenance(AOperation: TImageMaintenanceOperation): Boolean;
begin
  Gate.Acquire;
  try
    Result := ActiveOperation = imoNone;
    if Result then
      ActiveOperation := AOperation;
  finally
    Gate.Release;
  end;
end;

procedure EndImageMaintenance(AOperation: TImageMaintenanceOperation);
begin
  Gate.Acquire;
  try
    if ActiveOperation = AOperation then
      ActiveOperation := imoNone;
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

finalization
  Gate.Free;

end.
