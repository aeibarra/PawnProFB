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

uses PawnDM, PawnGlobal;

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
begin
 if rbStoreInDir.Checked then
   StSelection := ImageStorageMode_File
 else
   StSelection := ImageStorageMode_Database;

 if ImagesStoragePath <> edImageDirectory.Text then
   ImagesStoragePath := edImageDirectory.Text;

  ImageStorageMode := StSelection;
  WriteIniFile(IniSecImageStorage, IniKeyStorageMode, StSelection);
  WriteIniFile(IniSecImageStorage, IniKeyImageDirectory, edImageDirectory.Text);

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
  rbStoreInDB.Checked := ImageStorageMode = ImageStorageMode_Database;
  rbStoreInDir.Checked := ImageStorageMode = ImageStorageMode_File;

  if rbStoreInDir.Checked then
    edImageDirectory.Text := ImagesStoragePath;

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
