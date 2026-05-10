unit ItemPictures;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, PNGImage, JPEG,
  Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, RzButton,
  RzForms, Vcl.ExtCtrls, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TfrmItemPictures = class(TForm)
    gbFooter: TGroupBox;
    btnExit: TBitBtn;
    gbImageList: TGroupBox;
    qryItemImages: TFDQuery;
    qryItemImagesIMAGE_DESC: TWideStringField;
    qryItemImagesCREATED: TSQLTimeStampField;
    dsItemImages: TDataSource;
    DBGrid1: TDBGrid;
    btnTakeNewPic: TRzBitBtn;
    btnReTakePic: TRzBitBtn;
    qryItemImagesIMAGE_TYPE_NO: TIntegerField;
    qryItemImagesIMAG_REF_TO_ROW_NO: TIntegerField;
    FormState: TRzFormState;
    ImageJewelrySet: TImage;
    qryItemImagesIMAGES_DATA_NO: TIntegerField;
    qryItemImagesIMAGE_DATA: TBlobField;
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

    frmCapturePicFromCamera.ImageDesc := qryItemImagesIMAGE_DESC.AsString;
    Screen.Cursor := crHourGlass;
    if frmCapturePicFromCamera.ShowModal = mrOk then
      begin
        qryItemImagesIMAGE_DESC.AsString := frmCapturePicFromCamera.ImageDesc;
        qryItemImagesIMAGE_DATA.LoadFromFile(frmCapturePicFromCamera.SavePicFileName);
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

        SaveImageProc(qryItemImagesIMAGES_DATA_NO.AsInteger, frmCapturePicFromCamera.SavePicFileName, qryItemImagesCREATED.AsDateTime);

        DeleteFile(frmCapturePicFromCamera.SavePicFileName);

        DoNoLoadImage := false;
        GetImageProc(qryItemImagesIMAGES_DATA_NO.AsInteger, ImageJewelrySet);
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
  qryItemImages.Params.ParamByName('INV_ITEM_NO').AsInteger := ImagRefToRowNo;
  qryItemImages.Open;
end;

procedure TfrmItemPictures.qryItemImagesAfterScroll(DataSet: TDataSet);
begin
  if qryItemImagesIMAGES_DATA_NO.AsInteger > 0 then
    GetImageProc(qryItemImagesIMAGES_DATA_NO.AsInteger, ImageJewelrySet);
end;

procedure TfrmItemPictures.qryItemImagesNewRecord(DataSet: TDataSet);
var
  EmptyImageData: TMemoryStream;
begin
  qryItemImagesIMAGE_TYPE_NO.AsInteger := 2;
  qryItemImagesIMAG_REF_TO_ROW_NO.AsInteger := ImagRefToRowNo;
  qryItemImagesIMAGE_DESC.AsString := Format('%s_%.2d_%.2d', [trim(TicketNo), ItemCountInTran, GetRecNo(qryItemImages.RecordCount+1)]);

  EmptyImageData := TMemoryStream.Create;
  try
    qryItemImagesIMAGE_DATA.LoadFromStream(EmptyImageData);
  finally
    EmptyImageData.Free;
  end;
end;

end.
