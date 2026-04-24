unit ItemPictures;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, PNGImage, JPEG,
  Vcl.DBCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, RzButton,
  RzForms, Vcl.ExtCtrls;

type
  TfrmItemPictures = class(TForm)
    gbFooter: TGroupBox;
    btnExit: TBitBtn;
    gbImageList: TGroupBox;
    qryItemImages: TADOQuery;
    qryItemImagesImageDesc: TStringField;
    qryItemImagesCreated: TDateTimeField;
    dsItemImages: TDataSource;
    DBGrid1: TDBGrid;
    btnTakeNewPic: TRzBitBtn;
    btnReTakePic: TRzBitBtn;
    qryItemImagesImageTypeNo: TIntegerField;
    qryItemImagesImagRefToRowNo: TIntegerField;
    FormState: TRzFormState;
    ImageJewelrySet: TImage;
    qryItemImagesImagesDataNo: TIntegerField;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTakeNewPicClick(Sender: TObject);
    procedure qryItemImagesNewRecord(DataSet: TDataSet);
    procedure btnReTakePicClick(Sender: TObject);
    procedure qryItemImagesAfterScroll(DataSet: TDataSet);
  private
    DoNoLoadImage: boolean;
    procedure AdEditPicture(NewPic: boolean);
  public
    ImagRefToRowNo, ItemCountInTran: integer;
    TicketNo: string;
    PictureTaken: boolean;
  end;

var
  frmItemPictures: TfrmItemPictures;

implementation

{$R *.dfm}

uses PawnDM, CapturePicFromCamera, PawnGlobal;

procedure TfrmItemPictures.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmItemPictures.btnReTakePicClick(Sender: TObject);
begin
  if not DoNoLoadImage and (qryItemImages.RecordCount > 0)  then
    AdEditPicture(false);
end;

procedure TfrmItemPictures.AdEditPicture(NewPic: boolean);
begin
  frmCapturePicFromCamera := TfrmCapturePicFromCamera.Create(Self);
  try
    DoNoLoadImage := true;
    if NewPic then
      qryItemImages.Append
    else
      qryItemImages.Edit;

    frmCapturePicFromCamera.ImageDesc := qryItemImagesImageDesc.AsString;
    Screen.Cursor := crHourGlass;
    if frmCapturePicFromCamera.ShowModal = mrOk then
      begin
        qryItemImagesImageDesc.AsString := frmCapturePicFromCamera.ImageDesc;
       // qryItemImagesImageData.LoadFromFile(frmCapturePicFromCamera.SavePicFileName); Pepito
        qryItemImages.Post;
        PictureTaken := true;

        if NewPic then
          begin
            qryItemImages.DisableControls;
            try
              qryItemImages.Close;
              qryItemImages.Open;
              qryItemImages.Last;
            finally
              qryItemImages.EnableControls;
            end;
          end;

        SaveImageProc(qryItemImagesImagesDataNo.AsInteger, frmCapturePicFromCamera.SavePicFileName, qryItemImagesCreated.AsDateTime);

        DeleteFile(frmCapturePicFromCamera.SavePicFileName);

        DoNoLoadImage := false;
        GetImageProc(qryItemImagesImagesDataNo.AsInteger, ImageJewelrySet);
      end
    else
      begin
        qryItemImages.Cancel;
      end;

  finally
    DoNoLoadImage := false;
    frmCapturePicFromCamera.Free;
  end;
end;

procedure TfrmItemPictures.btnTakeNewPicClick(Sender: TObject);
begin
  AdEditPicture(true);
end;

procedure TfrmItemPictures.FormShow(Sender: TObject);
begin
  qryItemImages.Close;
  qryItemImages.Parameters.ParamByName('InvItemNo').Value := ImagRefToRowNo;
  qryItemImages.Open;
end;

procedure TfrmItemPictures.qryItemImagesAfterScroll(DataSet: TDataSet);
begin
  if qryItemImagesImagesDataNo.AsInteger > 0 then
    GetImageProc(qryItemImagesImagesDataNo.AsInteger, ImageJewelrySet);
end;

procedure TfrmItemPictures.qryItemImagesNewRecord(DataSet: TDataSet);
begin
  qryItemImagesImageTypeNo.AsInteger := 2;
  qryItemImagesImagRefToRowNo.AsInteger := ImagRefToRowNo;
  qryItemImagesImageDesc.AsString := Format('%s_%.2d_%.2d', [trim(TicketNo), ItemCountInTran, GetRecNo(qryItemImages.RecordCount+1)]);
end;

end.
