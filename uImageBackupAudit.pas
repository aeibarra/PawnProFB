unit uImageBackupAudit;

interface

uses
  System.Classes, System.SyncObjs;

type
  TFBConnectionConfig = record
    Server: string;
    Database: string;
    UserName: string;
    Password: string;
    Port: Integer;
    CharacterSet: string;
  end;

  TImageAuditConfig = record
    SourceRoot: string;
    BackupRoot: string;
    AuditWeek: string;
    Connection: TFBConnectionConfig;
    InitialDelayMs: Cardinal;
    ItemThrottleMs: Cardinal;
  end;

  TImageAuditResult = record
    Completed: Boolean;
    Canceled: Boolean;
    CheckedCount: Integer;
    MissingCount: Integer;
    DifferentCount: Integer;
    LastImageNo: Integer;
    ErrorMessage: string;
  end;

procedure RunImageBackupAudit(const AConfig: TImageAuditConfig;
  AStopEvent: TEvent; out AResult: TImageAuditResult);

implementation

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, IdHashSHA,
  uImageMaintenanceGate;

type
  TCancellableReadStream = class(TStream)
  private
    FSource: TStream;
    FStopEvent: TEvent;
    procedure CheckCanceled;
  public
    constructor Create(ASource: TStream; AStopEvent: TEvent);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;

constructor TCancellableReadStream.Create(ASource: TStream; AStopEvent: TEvent);
begin
  inherited Create;
  FSource := ASource;
  FStopEvent := AStopEvent;
end;

procedure TCancellableReadStream.CheckCanceled;
begin
  if Assigned(FStopEvent) and (FStopEvent.WaitFor(0) = wrSignaled) then
    Abort;
end;

function TCancellableReadStream.Read(var Buffer; Count: Longint): Longint;
begin
  CheckCanceled;
  Result := FSource.Read(Buffer, Count);
  CheckCanceled;
end;

function TCancellableReadStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise EStreamError.Create('The audit hash stream is read-only.');
end;

function TCancellableReadStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  CheckCanceled;
  Result := FSource.Seek(Offset, Origin);
end;

function StopRequested(AStopEvent: TEvent; ATimeoutMs: Cardinal): Boolean;
begin
  Result := Assigned(AStopEvent) and
            (AStopEvent.WaitFor(ATimeoutMs) = wrSignaled);
end;

procedure ConfigureConnection(AConnection: TFDConnection;
  const AConfig: TFBConnectionConfig);
begin
  AConnection.Connected := False;
  AConnection.Params.Clear;
  AConnection.DriverName := 'FB';
  AConnection.Params.Values['Server'] := AConfig.Server;
  AConnection.Params.Values['Database'] := AConfig.Database;
  AConnection.Params.Values['User_Name'] := AConfig.UserName;
  AConnection.Params.Values['Password'] := AConfig.Password;
  AConnection.Params.Values['Protocol'] := 'TCPIP';
  AConnection.Params.Values['Port'] := IntToStr(AConfig.Port);
  AConnection.Params.Values['CharacterSet'] := AConfig.CharacterSet;
  AConnection.LoginPrompt := False;
  // Bound database commands where FireDAC/Firebird can honor a timeout.
  AConnection.ResourceOptions.CmdExecTimeout := 15000;
end;

function BuildImagePath(const ARoot: string; AImageNo: Integer;
  AImageDate: TDateTime): string;
begin
  Result := IncludeTrailingPathDelimiter(ARoot) +
            FormatDateTime('yyyymm', AImageDate) + PathDelim +
            IntToStr(AImageNo) + '.jpg';
end;

function FileSizeOf(const AFileName: string): Int64;
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    Result := Stream.Size;
  finally
    Stream.Free;
  end;
end;

function SHA256OfFile(const AFileName: string; AStopEvent: TEvent): string;
var
  FileStream: TFileStream;
  CancelStream: TCancellableReadStream;
  Hasher: TIdHashSHA256;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    CancelStream := TCancellableReadStream.Create(FileStream, AStopEvent);
    try
      Hasher := TIdHashSHA256.Create;
      try
        Result := Hasher.HashStreamAsHex(CancelStream);
      finally
        Hasher.Free;
      end;
    finally
      CancelStream.Free;
    end;
  finally
    FileStream.Free;
  end;
end;

procedure RunImageBackupAudit(const AConfig: TImageAuditConfig;
  AStopEvent: TEvent; out AResult: TImageAuditResult);
var
  Connection: TFDConnection;
  ImageQuery, MarkQuery: TFDQuery;
  ImageNo: Integer;
  ImageDate: TDateTime;
  SourcePath, BackupPath: string;
  SourceSize, BackupSize: Int64;
  SourceHash, BackupHash: string;

  procedure MarkForBackup;
  begin
    try
      MarkQuery.Params.ParamByName('IMAGES_DATA_NO').AsInteger := ImageNo;
      MarkQuery.ExecSQL;
    except
      // Best effort: a normal image backup will retry the row.
    end;
  end;

begin
  AResult := Default(TImageAuditResult);

  // Delay before claiming the operation gate so an interactive camera session
  // opened during application startup always gets priority over the audit.
  if StopRequested(AStopEvent, AConfig.InitialDelayMs) then
  begin
    AResult.Canceled := True;
    Exit;
  end;

  if not TryBeginImageMaintenance(imoAudit) then
  begin
    AResult.Canceled := True;
    AResult.ErrorMessage :=
      'Image audit skipped because another image operation is active.';
    Exit;
  end;
  try

    Connection := nil;
    ImageQuery := nil;
    MarkQuery := nil;
    try
      try
        Connection := TFDConnection.Create(nil);
        ConfigureConnection(Connection, AConfig.Connection);
        Connection.Connected := True;

        ImageQuery := TFDQuery.Create(nil);
        MarkQuery := TFDQuery.Create(nil);
        ImageQuery.Connection := Connection;
        MarkQuery.Connection := Connection;
        ImageQuery.ResourceOptions.CmdExecTimeout := 15000;
        MarkQuery.ResourceOptions.CmdExecTimeout := 15000;

        ImageQuery.SQL.Text :=
          'SELECT IMAGES_DATA_NO, CREATED FROM IMAGES_DATA ' +
          'WHERE CREATED IS NOT NULL ORDER BY IMAGES_DATA_NO';
        MarkQuery.SQL.Text :=
          'DELETE FROM IMAGES_DATA_BACKUP ' +
          'WHERE IMAGES_DATA_NO = :IMAGES_DATA_NO';

        ImageQuery.Open;
        while not ImageQuery.Eof do
        begin
          if StopRequested(AStopEvent, 0) then
          begin
            AResult.Canceled := True;
            Exit;
          end;

          ImageNo := ImageQuery.FieldByName('IMAGES_DATA_NO').AsInteger;
          ImageDate := ImageQuery.FieldByName('CREATED').AsDateTime;
          AResult.LastImageNo := ImageNo;
          Inc(AResult.CheckedCount);
          SourcePath := BuildImagePath(AConfig.SourceRoot, ImageNo, ImageDate);
          BackupPath := BuildImagePath(AConfig.BackupRoot, ImageNo, ImageDate);

          try
            if FileExists(SourcePath) then
            begin
              if not FileExists(BackupPath) then
              begin
                Inc(AResult.MissingCount);
                MarkForBackup;
              end
              else
              begin
                SourceSize := FileSizeOf(SourcePath);
                if StopRequested(AStopEvent, 0) then
                begin
                  AResult.Canceled := True;
                  Exit;
                end;
                BackupSize := FileSizeOf(BackupPath);

                if SourceSize <> BackupSize then
                begin
                  Inc(AResult.DifferentCount);
                  MarkForBackup;
                end
                else
                begin
                  SourceHash := SHA256OfFile(SourcePath, AStopEvent);
                  BackupHash := SHA256OfFile(BackupPath, AStopEvent);
                  if not SameText(SourceHash, BackupHash) then
                  begin
                    Inc(AResult.DifferentCount);
                    MarkForBackup;
                  end;
                end;
              end;
            end;
          except
            on E: EAbort do
            begin
              AResult.Canceled := True;
              Exit;
            end;
            on E: Exception do
            begin
              Inc(AResult.DifferentCount);
              MarkForBackup;
            end;
          end;

          if StopRequested(AStopEvent, AConfig.ItemThrottleMs) then
          begin
            AResult.Canceled := True;
            Exit;
          end;
          ImageQuery.Next;
        end;

        AResult.Completed := True;
      except
        on E: Exception do
          AResult.ErrorMessage := E.ClassName + ': ' + E.Message;
      end;
    finally
      MarkQuery.Free;
      ImageQuery.Free;
      Connection.Free;
    end;
  finally
    EndImageMaintenance(imoAudit);
  end;
end;

end.
