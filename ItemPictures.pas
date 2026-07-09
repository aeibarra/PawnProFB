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
    qryItemImagesIMAGES_DATA_NO: TIntegerField;
    qryItemImagesIMAGE_DATA: TBlobField;
    Panel1: TPanel;
    ImageJewelrySet: TImage;
    pnImgTop: TPanel;
    sbImage: TScrollBox;
    lblZoom: TLabel;
    btnZoomOut: TButton;
    btnZoomIn: TButton;
    btnZoomFit: TButton;
    btnZoom100: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTakeNewPicClick(Sender: TObject);
    procedure qryItemImagesNewRecord(DataSet: TDataSet);
    procedure btnReTakePicClick(Sender: TObject);
    procedure qryItemImagesAfterScroll(DataSet: TDataSet);
    procedure btnZoomInClick(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure btnZoomFitClick(Sender: TObject);
    procedure btnZoom100Click(Sender: TObject);
    procedure ImageJewelrySetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageJewelrySetMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImageJewelrySetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    DoNoLoadImage: boolean;
    FZoomFactor: Double;
    FPanning: boolean;
    FPanMouseStart: TPoint;
    FPanScrollStartX, FPanScrollStartY: integer;
    procedure AdEditPicture(NewPic: boolean);
    procedure DisplayImage(ImagesDataNo: integer);
    procedure ApplyZoom;
    procedure FitToWindow;
    procedure SetZoom(AFactor: Double);
    function CanPan: boolean;
  public
    ImagRefToRowNo, ItemCountInTran: integer;
    ImageTypeNo: integer;     // ImageType_ItemPicture (default) or ImageType_CustomerID
    TicketNo: string;
    PictureTaken: boolean;
  end;

var
  frmItemPictures: TfrmItemPictures;

implementation

{$R *.dfm}

uses PawnDM, CapturePicFromCamera, PawnGlobal;

const
  { Custom cursor slots for the PDF-viewer style pan hand. }
  crPanOpen = 2101;   // open hand: image can be grabbed
  crPanGrab = 2102;   // closed fist: currently dragging

var
  PanCursorsRegistered: Boolean = False;

{ Draws a simple open-hand / closed-fist glyph (white fill, black outline) into
  a 32x32 color bitmap over a magenta key color, derives a transparency mask
  from that key, and turns the pair into a color cursor. No resource files. }
function BuildHandCursor(Grabbing: Boolean): HCURSOR;
const
  BackColor = clFuchsia;
var
  ColorBmp, MaskBmp: TBitmap;
  IconInfo: TIconInfo;
  x, y: Integer;
begin
  ColorBmp := TBitmap.Create;
  MaskBmp := TBitmap.Create;
  try
    ColorBmp.PixelFormat := pf24bit;
    ColorBmp.SetSize(32, 32);
    with ColorBmp.Canvas do
      begin
        Brush.Color := BackColor;
        Brush.Style := bsSolid;
        FillRect(Rect(0, 0, 32, 32));

        Pen.Color := clBlack;
        Pen.Width := 1;
        Brush.Color := clWhite;

        if not Grabbing then
          begin
            RoundRect(9, 13, 24, 27, 6, 6);   // palm
            RoundRect(10, 5, 13, 17, 3, 3);   // four fingers, extended
            RoundRect(13, 3, 16, 17, 3, 3);
            RoundRect(16, 4, 19, 17, 3, 3);
            RoundRect(19, 6, 22, 17, 3, 3);
            RoundRect(6, 14, 11, 23, 3, 3);   // thumb
          end
        else
          begin
            RoundRect(9, 12, 24, 27, 7, 7);   // fist / palm
            RoundRect(10, 9, 13, 15, 2, 2);   // curled-finger knuckles
            RoundRect(13, 8, 16, 15, 2, 2);
            RoundRect(16, 9, 19, 15, 2, 2);
            RoundRect(19, 10, 22, 15, 2, 2);
            RoundRect(7, 15, 12, 21, 2, 2);   // thumb wrapped over
          end;
      end;

    MaskBmp.PixelFormat := pf1bit;
    MaskBmp.SetSize(32, 32);
    for y := 0 to 31 do
      for x := 0 to 31 do
        if ColorBmp.Canvas.Pixels[x, y] = BackColor then
          begin
            MaskBmp.Canvas.Pixels[x, y] := clWhite;   // 1 = transparent
            { For a COLOR cursor, transparent pixels are XORed onto the screen,
              so the key color must become black (screen XOR 0 = unchanged),
              otherwise the whole 32x32 shows as a colored square. }
            ColorBmp.Canvas.Pixels[x, y] := clBlack;
          end
        else
          MaskBmp.Canvas.Pixels[x, y] := clBlack;     // 0 = opaque (draw color)

    FillChar(IconInfo, SizeOf(IconInfo), 0);
    IconInfo.fIcon := False;        // False => build a cursor, not an icon
    IconInfo.xHotspot := 13;
    IconInfo.yHotspot := 13;
    IconInfo.hbmMask := MaskBmp.Handle;
    IconInfo.hbmColor := ColorBmp.Handle;
    Result := CreateIconIndirect(IconInfo);   // copies the bitmaps
  finally
    ColorBmp.Free;
    MaskBmp.Free;
  end;
end;

procedure EnsurePanCursors;
var
  H: HCURSOR;
begin
  if PanCursorsRegistered then
    Exit;

  H := BuildHandCursor(False);
  if H <> 0 then
    Screen.Cursors[crPanOpen] := H;

  H := BuildHandCursor(True);
  if H <> 0 then
    Screen.Cursors[crPanGrab] := H;

  PanCursorsRegistered := True;
end;

procedure TfrmItemPictures.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmItemPictures.FormCreate(Sender: TObject);
begin
  EnsurePanCursors;
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
        DisplayImage(qryItemImagesIMAGES_DATA_NO.AsInteger);
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
  { The form serves both item pictures and customer ID pictures; callers that
    don't set ImageTypeNo get the historical item-picture behavior. }
  if ImageTypeNo = 0 then
    ImageTypeNo := ImageType_ItemPicture;

  if ImageTypeNo = ImageType_CustomerID then
    Caption := 'Customer Pictures'
  else
    Caption := 'Item Pictures';

  FZoomFactor := 1;

  qryItemImages.Close;
  qryItemImages.Params.ParamByName('IMAGE_TYPE_NO').AsInteger := ImageTypeNo;
  qryItemImages.Params.ParamByName('REF_ROW_NO').AsInteger := ImagRefToRowNo;
  qryItemImages.Open;
end;

procedure TfrmItemPictures.qryItemImagesAfterScroll(DataSet: TDataSet);
begin
  DisplayImage(qryItemImagesIMAGES_DATA_NO.AsInteger);
end;

procedure TfrmItemPictures.qryItemImagesNewRecord(DataSet: TDataSet);
var
  EmptyImageData: TMemoryStream;
begin
  qryItemImagesIMAGE_TYPE_NO.AsInteger := ImageTypeNo;
  qryItemImagesIMAG_REF_TO_ROW_NO.AsInteger := ImagRefToRowNo;
  if ImageTypeNo = ImageType_CustomerID then
    qryItemImagesIMAGE_DESC.AsString := Format('CUST_%.6d_%.2d', [ImagRefToRowNo, GetRecNo(qryItemImages.RecordCount+1)])
  else
    qryItemImagesIMAGE_DESC.AsString := Format('%s_%.2d_%.2d', [trim(TicketNo), ItemCountInTran, GetRecNo(qryItemImages.RecordCount+1)]);

  EmptyImageData := TMemoryStream.Create;
  try
    qryItemImagesIMAGE_DATA.LoadFromStream(EmptyImageData);
  finally
    EmptyImageData.Free;
  end;
end;

procedure TfrmItemPictures.DisplayImage(ImagesDataNo: integer);
begin
  { Single entry point for showing an image: clear, load through the pluggable
    storage backend, then size it to the current zoom (fit-to-window on load). }
  ImageJewelrySet.Picture.Assign(nil);

  if ImagesDataNo > 0 then
    GetImageProc(ImagesDataNo, ImageJewelrySet);

  FitToWindow;
end;

procedure TfrmItemPictures.ApplyZoom;
var
  pw, ph, nw, nh: integer;
begin
  pw := ImageJewelrySet.Picture.Width;
  ph := ImageJewelrySet.Picture.Height;

  if (pw = 0) or (ph = 0) then
    begin
      ImageJewelrySet.SetBounds(0, 0, 0, 0);
      ImageJewelrySet.Cursor := crDefault;
      lblZoom.Caption := '--';
      Exit;
    end;

  nw := Round(pw * FZoomFactor);
  nh := Round(ph * FZoomFactor);

  { Reset any prior scroll offset so Fit / 100% land predictably. }
  sbImage.HorzScrollBar.Position := 0;
  sbImage.VertScrollBar.Position := 0;

  ImageJewelrySet.SetBounds(0, 0, nw, nh);

  { Center the image inside the viewport when it is smaller than the view;
    otherwise pin to the top-left and let the scroll box handle panning. }
  if nw < sbImage.ClientWidth then
    ImageJewelrySet.Left := (sbImage.ClientWidth - nw) div 2
  else
    ImageJewelrySet.Left := 0;

  if nh < sbImage.ClientHeight then
    ImageJewelrySet.Top := (sbImage.ClientHeight - nh) div 2
  else
    ImageJewelrySet.Top := 0;

  lblZoom.Caption := Format('%d%%', [Round(FZoomFactor * 100)]);

  { An open hand hints the image can be dragged to pan when it's bigger than
    the view; the drag handlers swap in the closed fist while grabbing. }
  if CanPan then
    ImageJewelrySet.Cursor := crPanOpen
  else
    ImageJewelrySet.Cursor := crDefault;
end;

function TfrmItemPictures.CanPan: boolean;
begin
  Result := (ImageJewelrySet.Width > sbImage.ClientWidth) or
            (ImageJewelrySet.Height > sbImage.ClientHeight);
end;

procedure TfrmItemPictures.ImageJewelrySetMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbLeft) or not CanPan then
    Exit;

  FPanning := true;
  ImageJewelrySet.Cursor := crPanGrab;   // closed fist while dragging
  { Track in screen coordinates: as we scroll, the image shifts under the
    cursor, so client X/Y would feed back on themselves. }
  FPanMouseStart := Mouse.CursorPos;
  FPanScrollStartX := sbImage.HorzScrollBar.Position;
  FPanScrollStartY := sbImage.VertScrollBar.Position;
end;

procedure TfrmItemPictures.ImageJewelrySetMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Cur: TPoint;
begin
  if not FPanning then
    Exit;

  { A TImage can't capture the mouse, so a release outside its bounds can be
    missed -- if the button is no longer down, stop panning. }
  if not (ssLeft in Shift) then
    begin
      FPanning := false;
      ImageJewelrySet.Cursor := crPanOpen;
      Exit;
    end;

  Cur := Mouse.CursorPos;
  { Drag the image with the mouse: moving right reveals content to the left,
    i.e. the scroll position decreases. Positions clamp to range automatically. }
  sbImage.HorzScrollBar.Position := FPanScrollStartX + (FPanMouseStart.X - Cur.X);
  sbImage.VertScrollBar.Position := FPanScrollStartY + (FPanMouseStart.Y - Cur.Y);
end;

procedure TfrmItemPictures.ImageJewelrySetMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not FPanning then
    Exit;

  FPanning := false;
  { Back to the open hand if still zoomed past the viewport, else no hand. }
  if CanPan then
    ImageJewelrySet.Cursor := crPanOpen
  else
    ImageJewelrySet.Cursor := crDefault;
end;

procedure TfrmItemPictures.SetZoom(AFactor: Double);
begin
  if AFactor < 0.05 then
    AFactor := 0.05;
  if AFactor > 10 then
    AFactor := 10;

  FZoomFactor := AFactor;
  ApplyZoom;
end;

procedure TfrmItemPictures.FitToWindow;
var
  fw, fh, factor: Double;
  pw, ph: integer;
begin
  pw := ImageJewelrySet.Picture.Width;
  ph := ImageJewelrySet.Picture.Height;

  if (pw = 0) or (ph = 0) then
    begin
      SetZoom(1);
      Exit;
    end;

  fw := sbImage.ClientWidth / pw;
  fh := sbImage.ClientHeight / ph;

  { Fit-to-window: scale so the whole image fills the viewport, enlarging small
    photos and shrinking large ones. (100% always shows native pixels, so the
    two are now visibly different.) }
  if fw < fh then
    factor := fw
  else
    factor := fh;

  SetZoom(factor);
end;

procedure TfrmItemPictures.btnZoomInClick(Sender: TObject);
begin
  SetZoom(FZoomFactor * 1.25);
end;

procedure TfrmItemPictures.btnZoomOutClick(Sender: TObject);
begin
  SetZoom(FZoomFactor / 1.25);
end;

procedure TfrmItemPictures.btnZoomFitClick(Sender: TObject);
begin
  FitToWindow;
end;

procedure TfrmItemPictures.btnZoom100Click(Sender: TObject);
begin
  SetZoom(1);
end;

end.
