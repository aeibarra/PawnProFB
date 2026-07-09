unit BackupDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, System.UITypes, System.Threading,
  Vcl.ExtCtrls,
  RzButton, RzCommon, RzShellDialogs, Vcl.Mask, RzEdit, RzLabel;

type
  TfrmBackupDB = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    GroupBox2: TGroupBox;
    edBckPath: TEdit;
    Label1: TLabel;
    btnSelectBackupPath: TSpeedButton;
    btnViewBackupLog: TBitBtn;
    chkDiBackupWhenClosingApp: TCheckBox;
    btnBackUp: TBitBtn;
    RzLabel1: TRzLabel;
    edImageDirectory: TRzEdit;
    btnSelectFolder: TRzToolButton;
    lblProgress: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnBackUpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnViewBackupLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectFolderClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSelectBackupPathClick(Sender: TObject);
  private
    FBackupRunning: Boolean;
    FProgressBaseText: string;
    FProgressTick: Integer;
    FProgressTimer: TTimer;
//    procedure LogBackup(BckLocation: string);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure SetBackupControlsEnabled(AEnabled: Boolean);
    procedure StartBackupProgress(const AMessage: string);
    procedure UpdateBackupProgress(const AMessage: string);
    procedure StopBackupProgress;
    procedure StartBackupWorker(const ABackupPath, AImageTargetPath: string; ADoImageBackup: Boolean);
  public
    { Public declarations }
  end;

var
  frmBackupDB: TfrmBackupDB;

implementation

uses PawnDM, PawnGlobal, ViewBackupHistory, uPawnDialogs;

{$R *.dfm}

procedure TfrmBackupDB.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBackupDB.btnSelectBackupPathClick(Sender: TObject);
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Self);
  try
    Dialog.Title := 'Select Backuo Folder';
    Dialog.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    if trim(edBckPath.Text) <> '' then
      Dialog.DefaultFolder := edBckPath.Text;

  if Dialog.Execute then
    begin
      edBckPath.Text := Dialog.FileName;
    end;

  finally
    Dialog.Free;
  end;
end;

procedure TfrmBackupDB.btnSelectFolderClick(Sender: TObject);
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Self);
  try
    Dialog.Title := 'Select Image Backup Folder';
    Dialog.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    if ImagesStoragePath <> '' then
      Dialog.DefaultFolder := ImagesStoragePath;

    if Dialog.Execute then
      edImageDirectory.Text := Dialog.FileName;
  finally
    Dialog.Free;
  end;

end;

procedure TfrmBackupDB.btnViewBackupLogClick(Sender: TObject);
begin
  frmViewBackupHist := TfrmViewBackupHist.Create(Self);
  try
    frmViewBackupHist.ShowModal;
  finally
    frmViewBackupHist.Free;
  end;
end;

procedure TfrmBackupDB.btnBackUpClick(Sender: TObject);
begin
  if trim(edBckPath.Text) = '' then
    begin
      MessageDlg('Please select Backup path.', mtInformation, [mbOk], 0);
      edBckPath.SetFocus;
      exit;
    end;

  if not DirectoryExists(trim(edBckPath.Text)) then
    begin
      MessageDlg('The specified path does not exist.', mtInformation, [mbOk], 0);
      edBckPath.SetFocus;
      exit;
    end;

  if (ImageStorageMode = ImageStorageMode_File) and (trim(edImageDirectory.Text) = '') then
    begin
      MessageDlg('Please select Image Storage Backup path.', mtInformation, [mbOk], 0);
      edImageDirectory.SetFocus;
      exit;

    end;

  if ImageStorageMode = ImageStorageMode_File then
    begin
      if SameText(IncludeTrailingPathDelimiter(ImagesStoragePath), IncludeTrailingPathDelimiter(trim(edImageDirectory.Text))) then
        begin
          MessageDlg('For Image backup Source and target directories cannot be the same.', mtInformation, [mbOk], 0);
          edImageDirectory.SetFocus;
          exit;
        end;
    end;

  Repaint;
  StartBackupWorker(trim(edBckPath.Text), trim(edImageDirectory.Text), ImageStorageMode = ImageStorageMode_File);

end;

procedure TfrmBackupDB.ProgressTimerTimer(Sender: TObject);
const
  Dots: array[0..3] of string = ('', '.', '..', '...');
begin
  Inc(FProgressTick);
  lblProgress.Caption := FProgressBaseText + Dots[FProgressTick mod 4];
end;

procedure TfrmBackupDB.SetBackupControlsEnabled(AEnabled: Boolean);
begin
  btnBackUp.Enabled := AEnabled;
  btnClose.Enabled := AEnabled;
  btnViewBackupLog.Enabled := AEnabled;
  btnSelectBackupPath.Enabled := AEnabled;
  btnSelectFolder.Enabled := AEnabled;
  edBckPath.Enabled := AEnabled;
  edImageDirectory.Enabled := AEnabled;
  chkDiBackupWhenClosingApp.Enabled := AEnabled;
end;

procedure TfrmBackupDB.StartBackupProgress(const AMessage: string);
begin
  FBackupRunning := True;
  SetBackupControlsEnabled(False);
  Screen.Cursor := crHourGlass;

  FProgressBaseText := AMessage;
  FProgressTick := 0;
  lblProgress.Caption := FProgressBaseText;

  if FProgressTimer = nil then
  begin
    FProgressTimer := TTimer.Create(Self);
    FProgressTimer.Interval := 500;
    FProgressTimer.OnTimer := ProgressTimerTimer;
  end;
  FProgressTimer.Enabled := True;
end;

procedure TfrmBackupDB.UpdateBackupProgress(const AMessage: string);
begin
  FProgressBaseText := AMessage;
  FProgressTick := 0;
  lblProgress.Caption := FProgressBaseText;
end;

procedure TfrmBackupDB.StopBackupProgress;
begin
  if FProgressTimer <> nil then
    FProgressTimer.Enabled := False;

  FBackupRunning := False;
  Screen.Cursor := crDefault;
  SetBackupControlsEnabled(True);
  lblProgress.Caption := '';
end;

procedure TfrmBackupDB.StartBackupWorker(const ABackupPath, AImageTargetPath: string; ADoImageBackup: Boolean);
begin
  StartBackupProgress('Backing up database');

  TTask.Run(
    procedure
    var
      R: TBackupResult;
    begin
      DM.RunBackup(ABackupPath, AImageTargetPath, ADoImageBackup, R,
        procedure(Phase: TBackupPhase)
        begin
          TThread.Queue(nil,
            procedure
            begin
              if not FBackupRunning then
                Exit;
              case Phase of
                bpDatabase: UpdateBackupProgress('Backing up database');
                bpImages:   UpdateBackupProgress('Backing up images');
                bpLogging:  UpdateBackupProgress('Saving backup history');
              end;
            end);
        end);

      TThread.Queue(nil,
        procedure
        begin
          if not FBackupRunning then
            Exit;

          StopBackupProgress;

          if R.BackupError <> '' then
          begin
            PawnError(R.BackupError, 'Backup Database', Self);
            Exit;
          end;

          if R.LogError <> '' then
          begin
            PawnError('Backup file was created, but the backup history could not be saved: ' + R.LogError,
              'Backup Database', Self);
            Exit;
          end;

          if R.ImageError <> '' then
            PawnError(R.ImageError, 'Backup Images', Self)
          else
            PawnInfo('Backup done!', 'Pawn Database', Self);
        end);
    end);
end;

procedure TfrmBackupDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FBackupRunning then
  begin
    Action := caNone;
    Exit;
  end;

  DM.qryBackupSetings.Close;
  DM.qryBackupSetings.Open;

  if DM.qryBackupSetings.RecordCount = 0 then
    DM.qryBackupSetings.Append
  else
    DM.qryBackupSetings.Edit;

  DM.qryBackupSetingsBACKUP_PATH.AsString := trim(edBckPath.Text);
  DM.qryBackupSetingsAUTO_BACKUP_WHEN_CLOSE_APP.AsBoolean := chkDiBackupWhenClosingApp.Checked;
  DM.qryBackupSetingsBACKUP_IMAGES_PATH.AsString := trim(edImageDirectory.Text);
  DM.qryBackupSetings.Post;

  DM.qryBackupSetings.Close;

end;

procedure TfrmBackupDB.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not FBackupRunning;
end;

procedure TfrmBackupDB.FormShow(Sender: TObject);
begin
  lblProgress.Caption := '';
  DM.qryBackupSetings.Close;
  DM.qryBackupSetings.Open;

  edBckPath.Text := DM.qryBackupSetingsBACKUP_PATH.AsString;
  chkDiBackupWhenClosingApp.Checked := DM.qryBackupSetingsAUTO_BACKUP_WHEN_CLOSE_APP.AsBoolean;
  edImageDirectory.Text := DM.qryBackupSetingsBACKUP_IMAGES_PATH.AsString;

  DM.qryBackupSetings.Close;

  btnBackUp.SetFocus;
end;

end.
