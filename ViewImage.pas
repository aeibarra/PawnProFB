unit ViewImage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, FireDAC.Stan.Param,
  Data.DB, RzForms, RzButton;

type
  TfrmViewImage = class(TForm)
    GroupBox2: TGroupBox;
    btnExit: TBitBtn;
    dsImage: TDataSource;
    FormState: TRzFormState;
    DBImage: TDBImage;
    btnSaveImg: TRzBitBtn;
    SaveDialog: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveImgClick(Sender: TObject);
  private
    { Private declarations }
  public
    ImagesDataNo: integer;
    FileName: string;
  end;

var
  frmViewImage: TfrmViewImage;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal;

procedure TfrmViewImage.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewImage.btnSaveImgClick(Sender: TObject);
var
 Folder, ImgFileName: string;
begin
  if SelectExportFolder(Folder) then
    begin
      if DM.qryImageUploadFileName.AsString <> '' then
        ImgFileName := DM.qryImageUploadFileName.AsString
      else
        ImgFileName := FileName;// 'ImgFile_' + ImagesDataNo.ToString + '.jpg';

      DM.qryImageImageData.SaveToFile(Folder + ImgFileName);
    end;
end;


procedure TfrmViewImage.FormShow(Sender: TObject);
begin
  DM.qryImage.Close;
  DM.qryImage.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  DM.qryImage.Open;

  btnSaveImg.Enabled := DM.qryImage.RecordCount > 0;


end;

end.
