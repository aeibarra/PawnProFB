unit BackupDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, System.UITypes,
  RzButton, RzCommon, RzShellDialogs, Vcl.Mask, RzEdit, RzLabel;

type
  TfrmBackupDB = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    GroupBox2: TGroupBox;
    edBckPath: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    btnViewBackupLog: TBitBtn;
    chkDiBackupWhenClosingApp: TCheckBox;
    btnBackUp: TBitBtn;
    RzLabel1: TRzLabel;
    edImageDirectory: TRzEdit;
    btnSelectFolder: TRzToolButton;
    lblProgress: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnBackUpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnViewBackupLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectFolderClick(Sender: TObject);
  private
    { Private declarations }
//    procedure LogBackup(BckLocation: string);
  public
    { Public declarations }
  end;

var
  frmBackupDB: TfrmBackupDB;

implementation

uses PawnDM, PawnGlobal, ViewBackupHistory, uPawnDialogs;

{$R *.dfm}

procedure TfrmBackupDB.SpeedButton1Click(Sender: TObject);
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

procedure TfrmBackupDB.btnCloseClick(Sender: TObject);
begin
  Close;
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

//procedure TfrmBackupDB.LogBackup(BckLocation: string);
//begin
//  DM.ConnDB.Execute('INSERT INTO BackupHistory (BckDate, BckPath) VALUES(GetDate(), ' + QuotedStr(BckLocation) + ')');
//end;
//

procedure TfrmBackupDB.btnBackUpClick(Sender: TObject);
var
  CopiedCount, SkippedCount: integer;
  ErrorMessage: string;
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
  try
    btnBackUp.Enabled := false;

    lblProgress.Caption := 'Backing up database...';
    Repaint;
    DM.BackupDatabase(edBckPath.Text);

    if ImageStorageMode = ImageStorageMode_File then
      begin
        lblProgress.Caption := 'Backing up Images...';
        Repaint;
        DM.BackupImagesToFolder(ImagesStoragePath, trim(edImageDirectory.Text), CopiedCount, SkippedCount, ErrorMessage);
        if ErrorMessage <> '' then
          PawnError(ErrorMessage, 'Backup Images', Self);
      end;

  finally
    btnBackUp.Enabled := true;
    lblProgress.Caption := '';
  end;

  if ErrorMessage = '' then
    PawnInfo('Backup done!', 'Pawn Database', Self);

end;

procedure TfrmBackupDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.qryBackupSetings.Close;
  DM.qryBackupSetings.Open;

  if DM.qryBackupSetings.RecordCount = 0 then
    DM.qryBackupSetings.Append
  else
    DM.qryBackupSetings.Edit;

  DM.qryBackupSetingsBackupPath.AsString := trim(edBckPath.Text);
  DM.qryBackupSetingsAutoBackupWhenCloseApp.AsBoolean := chkDiBackupWhenClosingApp.Checked;
  DM.qryBackupSetingsBackupImagesPath.AsString := trim(edImageDirectory.Text);
  DM.qryBackupSetings.Post;

  DM.qryBackupSetings.Close;

end;

procedure TfrmBackupDB.FormShow(Sender: TObject);
begin
  lblProgress.Caption := '';
  DM.qryBackupSetings.Close;
  DM.qryBackupSetings.Open;

  edBckPath.Text := DM.qryBackupSetingsBackupPath.AsString;
  chkDiBackupWhenClosingApp.Checked := DM.qryBackupSetingsAutoBackupWhenCloseApp.AsBoolean;
  edImageDirectory.Text := DM.qryBackupSetingsBackupImagesPath.AsString;

  DM.qryBackupSetings.Close;

  btnBackUp.SetFocus;
end;

end.
