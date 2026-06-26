unit ImagesStorageSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton,
  Vcl.ComCtrls, Vcl.ExtCtrls, RzLabel, Vcl.Mask, RzEdit, RzPanel, Vcl.FileCtrl;

type
  TfrmImagesStorageSettings = class(TForm)
    PageControlImageSettings: TPageControl;
    TabSheet1: TTabSheet;
    TabSheetMigrateImages: TTabSheet;
    RzGroupBox1: TRzGroupBox;
    rbStoreInDB: TRadioButton;
    rbStoreInDir: TRadioButton;
    pnImageFolder: TRzPanel;
    RzLabel1: TRzLabel;
    btnSelectFolder: TRzToolButton;
    edImageDirectory: TRzEdit;
    RzGroupBox2: TRzGroupBox;
    btnSave: TRzBitBtn;
    btnCancel: TBitBtn;
    RzGroupBox3: TRzGroupBox;
    lblFolder: TLabel;
    lblProgress: TLabel;
    btnExportImages: TBitBtn;
    gbSharedImagePath: TRzGroupBox;
    edImageSharedFolder: TRzEdit;
    RzLabel2: TRzLabel;
    procedure rbStoreInDBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PageControlImageSettingsChange(Sender: TObject);
    procedure btnSelectFolderClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImagesStorageSettings: TfrmImagesStorageSettings;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, uPawnDialogs;

procedure TfrmImagesStorageSettings.BitBtn1Click(Sender: TObject);
var
  Count: integer;
  ErrorMsg: string;
begin
  btnExportImages.Enabled := false;
  Screen.Cursor := crHourGlass;
  try
    DM.ExportAllImagesToFolder(Count, ErrorMsg, lblProgress);
    lblProgress.Caption := Format('Total images %d. Msg: %s', [Count, ErrorMsg]);
  finally
    Screen.Cursor := crDefault;
    btnExportImages.Enabled := true;
  end;
end;

procedure TfrmImagesStorageSettings.btnSaveClick(Sender: TObject);
var
  StSelection: string;
  SharedImagePath: string;
  LocalImageDir: string;
begin
  { Hard validation: the directory is now the only home for images, so make
    sure it exists (offer to create it) before we commit the setting. }
  LocalImageDir := Trim(edImageDirectory.Text);
  if LocalImageDir = '' then
  begin
    PawnWarn('Please specify the image storage folder.', 'Image Storage Settings', Self);
    edImageDirectory.SetFocus;
    Exit;
  end;

  if not DirectoryExists(LocalImageDir) then
  begin
    if PawnConfirm('The image storage folder does not exist:' + sLineBreak + sLineBreak +
         LocalImageDir + sLineBreak + sLineBreak + 'Do you want to create it?',
         'Image Storage Settings', Self) then
    begin
      if not ForceDirectories(LocalImageDir) then
      begin
        PawnWarn('PawnPro could not create the folder:' + sLineBreak + sLineBreak +
          LocalImageDir, 'Image Storage Settings', Self);
        edImageDirectory.SetFocus;
        Exit;
      end;
    end
    else
    begin
      edImageDirectory.SetFocus;
      Exit;
    end;
  end;

  { Soft validation: the shared path is a UNC the workstations must reach.
    We cannot reliably verify it from here, so only flag an obvious format
    problem and let the user save anyway. }
  SharedImagePath := Trim(edImageSharedFolder.Text);
  if IsLocalDatabase and (SharedImagePath <> '') and (Copy(SharedImagePath, 1, 2) <> '\\') then
  begin
    if not PawnConfirm('The shared image path does not look like a UNC path ' +
         '(it should start with \\server\share):' + sLineBreak + sLineBreak +
         SharedImagePath + sLineBreak + sLineBreak +
         'Other workstations may not be able to reach it. Save anyway?',
         'Image Storage Settings', Self) then
    begin
      edImageSharedFolder.SetFocus;
      Exit;
    end;
  end;

 if rbStoreInDir.Checked then
   StSelection := ImageStorageMode_File
 else
   StSelection := ImageStorageMode_Database;

 if ImagesStoragePath <> edImageDirectory.Text then
   ImagesStoragePath := edImageDirectory.Text;

  ImageStorageMode := StSelection;
  WriteIniFile(IniSecImageStorage, IniKeyStorageMode, StSelection);
  WriteIniFile(IniSecImageStorage, IniKeyImageDirectory, edImageDirectory.Text);

  { The shared image path is the source of truth for the other workstations,
    so only the computer that hosts the database is allowed to set it. }
  if IsLocalDatabase and (SharedImagePath <> '') then
  begin
    try
      DM.SetAppStateText(AppStateKeyImageSharedPath, SharedImagePath);
    except
      on E: Exception do
        PawnWarn('The image settings were saved locally, but PawnPro could not save the shared image path to the database.' +
          sLineBreak + sLineBreak + E.Message, 'Image Storage Settings', Self);
    end;
  end;

  PawnInfo('Image storage settings have been saved.' + sLineBreak + sLineBreak +
    'PawnPro will now close. Please reopen it for the changes to take effect.',
    'Image Storage Settings', Self);

  Application.Terminate;

  ModalResult := mrOk;
end;

procedure TfrmImagesStorageSettings.btnSelectFolderClick(Sender: TObject);
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Self);
  try
    Dialog.Title := 'Select Image Storage Folder';
    Dialog.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    if ImagesStoragePath <> '' then
      Dialog.DefaultFolder := ImagesStoragePath;

    if Dialog.Execute then
      edImageDirectory.Text := Dialog.FileName;
  finally
    Dialog.Free;
  end;
end;

procedure TfrmImagesStorageSettings.FormCreate(Sender: TObject);
begin
  TabSheetMigrateImages.Enabled := false;
end;

procedure TfrmImagesStorageSettings.FormShow(Sender: TObject);
begin
  lblProgress.Caption := '';
  { Storing images in the database is retired in the Firebird version —
    directory storage is the only supported option. }
  rbStoreInDB.Enabled := False;
  rbStoreInDB.Checked := False;
  rbStoreInDir.Checked := True;

  edImageDirectory.Text := ImagesStoragePath;

  { Only the database-host computer configures the shared path; other
    workstations receive it automatically at startup. }
  gbSharedImagePath.Visible := IsLocalDatabase;
  try
    edImageSharedFolder.Text := DM.GetAppStateText(AppStateKeyImageSharedPath, '');
  except
    edImageSharedFolder.Text := '';
  end;

  rbStoreInDBClick(nil);
end;

procedure TfrmImagesStorageSettings.PageControlImageSettingsChange(Sender: TObject);
begin
  lblFolder.Caption := edImageDirectory.Text;
end;

procedure TfrmImagesStorageSettings.rbStoreInDBClick(Sender: TObject);
begin
  pnImageFolder.Enabled := rbStoreInDir.Checked;
end;

end.
