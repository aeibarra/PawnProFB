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
    { Images that could not be READ (locked, permissions, bad media) as opposed
      to images that genuinely differ. Both are re-queued for backup, but they
      mean very different things and must not be reported as one number. }
    ErrorCount: Integer;
    LastImageNo: Integer;
    ErrorMessage: string;
  end;

  { Progress/diagnostic sink. Called from the worker thread only. }
  TAuditLogProc = reference to procedure(const AMessage: string);

procedure RunImageBackupAudit(const AConfig: TImageAuditConfig;
  AStopEvent: TEvent; ALog: TAuditLogProc; out AResult: TImageAuditResult);

implementation

uses
  { System.Hash, NOT IdHashSHA -- see SHA256OfFile. }
  System.SysUtils, System.Hash, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.Stan.Option, uImageMaintenanceGate;

type
  TImageAuditRow = record
    ImageNo: Integer;
    ImageDate: TDateTime;
  end;

{ Single checkpoint for every reason the audit might have to stop: application
  shutdown (the controller's event) or an interactive image operation waiting on
  the gate. Doubles as the throttle -- callers pass the delay they wanted to
  sleep, and a stop cuts it short. }
function StopRequested(AStopEvent: TEvent; ATimeoutMs: Cardinal): Boolean;
begin
  if ImageMaintenanceYieldRequested then
    Exit(True);
  Result := Assigned(AStopEvent) and
            (AStopEvent.WaitFor(ATimeoutMs) = wrSignaled);
  if not Result then
    Result := ImageMaintenanceYieldRequested;
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

{ Uses System.Hash (THashSHA2), NOT Indy's TIdHashSHA256.

  Indy's SHA-256 is routed through IdFIPS and is only available when OpenSSL is
  loaded. In this application it is not: TIdHashSHA256.IsAvailable returns False
  and HashStreamAsHex then returns an EMPTY STRING for every file -- no
  exception, no error. Two empty strings compare equal, so every content
  comparison the audit performed silently reported "identical", and a corrupted
  backup image of the correct size was never detected. Verified 2026-07-26 with
  a byte-flipped test image the audit failed to flag.

  THashSHA2 is part of the RTL, always available, and has no external
  dependency. Reading in chunks also lets cancellation be checked directly,
  which is why the old TCancellableReadStream wrapper is gone. }
function SHA256OfFile(const AFileName: string; AStopEvent: TEvent): string;
const
  ChunkSize = 64 * 1024;
var
  FileStream: TFileStream;
  Hash: THashSHA2;
  Buffer: TBytes;
  BytesRead: Integer;
begin
  Hash := THashSHA2.Create(THashSHA2.TSHA2Version.SHA256);
  SetLength(Buffer, ChunkSize);
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    repeat
      { Hashing is the longest uninterruptible stretch in the audit, so shutdown
        and an interactive yield are both honoured mid-file, per chunk. }
      if StopRequested(AStopEvent, 0) then
        Abort;
      BytesRead := FileStream.Read(Buffer[0], ChunkSize);
      if BytesRead > 0 then
        Hash.Update(Buffer[0], BytesRead);
    until BytesRead <= 0;
  finally
    FileStream.Free;
  end;
  Result := Hash.HashAsString;
end;

{ Reads the whole work list up front so the SELECT's read transaction lives for
  one round trip instead of for the entire audit. A transaction left open for
  the many minutes of a full walk pins Firebird's oldest active transaction and
  blocks garbage collection for the whole store. Two integers per image is cheap
  even at six figures of images. }
function LoadImageList(AQuery: TFDQuery; AStopEvent: TEvent;
  out ARows: TArray<TImageAuditRow>): Boolean;
const
  StopCheckInterval = 500;
var
  Count: Integer;
begin
  Count := 0;
  SetLength(ARows, 0);
  // fmAll: the rowset is fetched in one go, which lets us close the query -- and
  // with it the read transaction -- before the long file-comparison walk starts.
  AQuery.FetchOptions.Mode := fmAll;
  AQuery.Open;
  try
    // Exact after a full fetch, so this is a presize rather than a guess.
    if AQuery.RecordCount > 0 then
      SetLength(ARows, AQuery.RecordCount);
    while not AQuery.Eof do
    begin
      if (Count mod StopCheckInterval = 0) and StopRequested(AStopEvent, 0) then
        Exit(False);
      if Count = Length(ARows) then
        SetLength(ARows, Count + 4096);
      ARows[Count].ImageNo := AQuery.Fields[0].AsInteger;
      ARows[Count].ImageDate := AQuery.Fields[1].AsDateTime;
      Inc(Count);
      AQuery.Next;
    end;
  finally
    SetLength(ARows, Count);
    AQuery.Close;
  end;
  Result := True;
end;

procedure RunImageBackupAudit(const AConfig: TImageAuditConfig;
  AStopEvent: TEvent; ALog: TAuditLogProc; out AResult: TImageAuditResult);
const
  { A full run on a store-sized image set takes ~17 minutes. Without a heartbeat
    the log cannot distinguish "still working" from "died silently", which is
    exactly the question the phase-2 logs have to answer after the fact. }
  ProgressIntervalMs = 60000;
  { Enough to identify a pattern (one bad folder, one bad drive) without letting
    a systemic failure flood the log. }
  MaxLoggedErrors = 20;
var
  Connection: TFDConnection;
  ImageQuery, MarkQuery: TFDQuery;
  Rows: TArray<TImageAuditRow>;
  Row: TImageAuditRow;
  SourcePath, BackupPath: string;
  SourceSize, BackupSize: Int64;
  SourceHash, BackupHash: string;
  NextProgressAt: UInt64;
  LoggedErrors: Integer;

  procedure Note(const AMessage: string);
  begin
    if Assigned(ALog) then
      ALog(AMessage);
  end;

  procedure ReportProgress;
  begin
    if TThread.GetTickCount64 < NextProgressAt then
      Exit;
    NextProgressAt := TThread.GetTickCount64 + ProgressIntervalMs;
    Note(Format('Image audit progress: %d/%d checked, missing=%d different=%d ' +
      'errors=%d last=%d',
      [AResult.CheckedCount, Length(Rows), AResult.MissingCount,
       AResult.DifferentCount, AResult.ErrorCount, AResult.LastImageNo]));
  end;

  procedure MarkForBackup;
  begin
    try
      MarkQuery.Params.ParamByName('IMAGES_DATA_NO').AsInteger := Row.ImageNo;
      MarkQuery.ExecSQL;
    except
      // Best effort: a normal image backup will retry the row.
    end;
  end;

  procedure NoteStopReason;
  begin
    AResult.Canceled := True;
    if ImageMaintenanceYieldRequested then
      AResult.ErrorMessage :=
        'Yielded to an interactive image operation; will retry on the next ' +
        'eligible day because the weekly marker was not advanced.';
  end;

begin
  AResult := Default(TImageAuditResult);
  LoggedErrors := 0;
  NextProgressAt := TThread.GetTickCount64 + ProgressIntervalMs;

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

        if not LoadImageList(ImageQuery, AStopEvent, Rows) then
        begin
          NoteStopReason;
          Exit;
        end;
        Note(Format('Image audit work list loaded: %d images to check.',
          [Length(Rows)]));

        for Row in Rows do
        begin
          if StopRequested(AStopEvent, 0) then
          begin
            NoteStopReason;
            Exit;
          end;

          AResult.LastImageNo := Row.ImageNo;
          Inc(AResult.CheckedCount);
          SourcePath := BuildImagePath(AConfig.SourceRoot, Row.ImageNo, Row.ImageDate);
          BackupPath := BuildImagePath(AConfig.BackupRoot, Row.ImageNo, Row.ImageDate);

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
                  NoteStopReason;
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
                  { An empty hash must never read as "these match". That is
                    exactly how the previous Indy-based implementation failed
                    silently for the life of this feature -- it returned '' for
                    every file and every comparison passed. Treat it as an
                    error, which is both counted and logged. }
                  if (SourceHash = '') or (BackupHash = '') then
                    raise Exception.CreateFmt(
                      'SHA-256 unavailable: empty digest for image %d.',
                      [Row.ImageNo]);
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
              // Raised by TCancellableReadStream mid-hash on stop or yield.
              NoteStopReason;
              Exit;
            end;
            on E: Exception do
            begin
              // Unreadable, not different. Still re-queued for backup, but
              // counted and reported separately -- conflating the two hides
              // a failing drive behind what looks like ordinary drift.
              Inc(AResult.ErrorCount);
              if LoggedErrors < MaxLoggedErrors then
              begin
                Inc(LoggedErrors);
                Note(Format('Image audit could not read image %d (%s): %s: %s',
                  [Row.ImageNo, SourcePath, E.ClassName, E.Message]));
                if LoggedErrors = MaxLoggedErrors then
                  Note('Image audit: further read errors will not be logged ' +
                    'individually; see the errors= total on the finish line.');
              end;
              MarkForBackup;
            end;
          end;

          ReportProgress;

          if StopRequested(AStopEvent, AConfig.ItemThrottleMs) then
          begin
            NoteStopReason;
            Exit;
          end;
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
