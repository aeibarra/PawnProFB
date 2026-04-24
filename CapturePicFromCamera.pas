unit CapturePicFromCamera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, VFrames, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Winapi.MMSystem, Vcl.Imaging.pngimage, System.UITypes,
  RzButton, System.Actions, Vcl.ActnList, Vcl.Mask, Vcl.DBCtrls, RzForms;

type
  TPropertyControl =
    RECORD
      PCLabel    : TLabel;
      PCTrackbar : TTrackBar;
      PCCheckbox : TCheckBox;
    END;

  TfrmCapturePicFromCamera = class(TForm)
    Panel_Top: TPanel;
    Label_Cameras: TLabel;
    Label1: TLabel;
    ComboBox_Cams: TComboBox;
    ComboBox_DisplayMode: TComboBox;
    PaintBox_Video: TPaintBox;
    btnStart: TRzToolButton;
    btnStop: TRzToolButton;
    btnTakePic: TRzToolButton;
    ActionList1: TActionList;
    ActionTakePic: TAction;
    Label_VideoSize: TLabel;
    SpeedButton1: TSpeedButton;
    btnExit: TBitBtn;
    Label2: TLabel;
    edImageDesc: TEdit;
    ComboBox1: TComboBox;
    FormState: TRzFormState;
    Panel1: TPanel;
    btnTakePicBR: TRzToolButton;
    btnTakePicBL: TRzToolButton;
    procedure FormShow(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnTakePicClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox_CamsChange(Sender: TObject);
  private
    VideoImage   : TVideoImage;
    OnNewFrameBusy: boolean;
    fFrameCnt    : integer;
    fSkipCnt     : integer;
    f30FrameTick : integer;
    LocalJPG     : TJPEGImage;
    PropCtrl     : ARRAY[TVideoProperty] OF TPropertyControl;
    VideoBMPIndex: integer;
    VideoBMP     : ARRAY[0..1] OF TBitmap;  // Used below in case we want to paint the image by ourselfs....
    CopyBMP      : TBitmap;
    ModeBMP      : TBitmap;
    DiffRatio    : double;
    SpyIndex     : integer;
    DiffCol      : ARRAY[-255..255] OF byte;
//    procedure CalcDiffImage(BM1, BM2, Diff: TBitmap; var DiffRatio: double);
//    procedure CalcDiffImage2(BM1, BM2, Diff: TBitmap; var DiffRatio: double);
    procedure CalcGrayScaleImage(BM1, Gray: TBitmap);
    procedure CalcInvertedImage(BM1, Inv: TBitmap);
    procedure CleanPaintBoxVideo;
    procedure InitFrame;
    procedure OnNewFrame(Sender: TObject; Width, Height: integer;
      DataPtr: pointer);
    procedure PropertyCheckBoxClick(Sender: TObject);
    procedure PropertyTrackBarChange(Sender: TObject);
    procedure UpdateCamList;
    procedure SelectSaveCam;
    procedure SaveCamSelection;
    procedure SelectSavedCamResolution;
    procedure SaveCamResolution;
  public
    SavePicFileName, ImageDesc: string;
  end;

var
  frmCapturePicFromCamera: TfrmCapturePicFromCamera;

implementation

{$R *.dfm}

uses PawnGlobal, GLbUtils, PawnDM;

const
  SaveCameraSec = 'SELECTED_CAMERA';
  SaveCameraItem = 'ACTIVE_CAM';

  SaveCameraResSec = 'SELECTED_CAMERA_RES';
  SaveCameraResItem = 'ACTIVE_CAM_RES';

procedure TfrmCapturePicFromCamera.CalcInvertedImage(BM1, Inv: TBitmap);
VAR
  X, Y  : integer;
  p1, d : pbytearray;
begin
  Inv.Width := BM1.Width;
  Inv.Height := BM1.Height;
  Inv.PixelFormat := pf24bit;

  FOR Y := BM1.Height-1 DOWNTO 0 DO
    BEGIN
      p1 := BM1.ScanLine[Y];
      d  := Inv.ScanLine[Y];
      FOR X := 0 TO BM1.Width*3-1 DO  // "*3" because we have pf24bit images
        d^[X] := 255-p1^[X];
    END;
end;


procedure TfrmCapturePicFromCamera.CalcGrayScaleImage(BM1, Gray: TBitmap);
VAR
  X, Y, i : integer;
  p1, d   : pbytearray;
  g       : byte;
begin
  Gray.Width := BM1.Width;
  Gray.Height := BM1.Height;
  Gray.PixelFormat := pf24bit; // Not really necessary. pf8bit together with a suitable color palette would be better.

  FOR Y := BM1.Height-1 DOWNTO 0 DO
    BEGIN
      p1 := BM1.ScanLine[Y];
      d  := Gray.ScanLine[Y];
      i  := 0;
      FOR X := 0 TO BM1.Width-1 DO
        begin
          g := ((p1^[i]*100) + (p1^[i+1]*128) + (p1^[i+2]*28)) shr 8;
          d^[i] := g;
          Inc(i);
          d^[i] := g;
          Inc(i);
          d^[i] := g;
          Inc(i);
        end;
    END;
end;

procedure TfrmCapturePicFromCamera.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCapturePicFromCamera.btnStartClick(Sender: TObject);
{ - Start live video }
var
  i         : integer;
  SL        : TStringList;
  VP        : TVideoProperty;
  MinVal,
  MaxVal,
  StepSize,
  Default,
  Actual    : integer;
  AutoMode  : boolean;
begin
  btnStart.Enabled := false;
  btnTakePic.Enabled := true;
  btnTakePicBR.Enabled := true;
  btnTakePicBL.Enabled := true;

  ComboBox_DisplayMode.Enabled := true;
  ComboBox1.Enabled := true;
  // Video already initialized, but paused?
  IF assigned(VideoImage) then
    IF VideoImage.IsPaused then
      begin
        VideoImage.VideoResume;
//        SpeedButton_VidSettings.Enabled   := true;
//        SpeedButton_VidSize.Enabled       := true;
        btnStop.Enabled     := true;
//        SpeedButton_Pause.Enabled    := true;
//        SpeedButton_RunVideo.enabled := false;
        exit;
      end;

  // Initialize Video
  Screen.Cursor := crHourGlass;
  CleanPaintBoxVideo;
  Application.ProcessMessages;
  // Starting video using name of device
  // i := VideoImage.VideoStart(ComboBox_Cams.Items[ComboBox_Cams.itemIndex]);
  // Starting video using index number of device within list of devices.
  // This helps in case two cameras have the same name.
  i := VideoImage.VideoStart('#' + IntToStr(ComboBox_Cams.itemIndex+1));
  Screen.Cursor := crDefault;
  Application.ProcessMessages;

  IF i <> 0 then
    begin
      MessageDlg('Could not start video (Error '+IntToStr(i)+')', mtError, [mbOK], 0);
      btnStart.Enabled := true;
      exit;
    end;

  SL := TStringList.Create;
  try
    VideoImage.GetListOfSupportedVideoSizes(SL);
    ComboBox1.Items.Assign(SL);
  finally
    SL.Free;
  end;
  SelectSavedCamResolution;
//  VideoImage.SetResolutionByIndex(10);

  Label_VideoSize.Caption := 'Video size ' + intToStr(VideoImage.VideoWidth) + ' x ' + IntToStr(VideoImage.VideoHeight);
  fFrameCnt := 0;

//  SpeedButton_VidSettings.Enabled   := true;
//  SpeedButton_VidSize.Enabled       := true;
  btnStop.Enabled     := true;
//  SpeedButton_Pause.Enabled    := true;
//  SpeedButton_RunVideo.enabled := false;
  ComboBox_Cams.Enabled        := false;


  FOR VP := Low(TVideoProperty) TO High(TVideoProperty) DO
    BEGIN
      IF Succeeded(VideoImage.GetVideoPropertySettings(VP, MinVal, MaxVal, StepSize, Default, Actual, AutoMode)) then
        begin
          WITH PropCtrl[VP] DO
            BEGIN
              PCLabel.Enabled     := true;
              PCTrackbar.Enabled  := true;
              PCTrackbar.Min      := MinVal;
              PCTrackbar.Max      := MaxVal;
              PCTrackbar.Frequency:= StepSize;
              PCTrackbar.Position := Actual;
              PCCheckbox.Enabled  := true;
              PCCheckbox.Checked  := AutoMode;
            end;
        end
        else begin
          WITH PropCtrl[VP] DO
            BEGIN
              PCLabel.Enabled := false;
            end;
        end;
    END;


end;


{procedure TfrmCapturePicFromCamera.CalcDiffImage(BM1, BM2, Diff: TBitmap; VAR DiffRatio: double);
VAR
  X, Y      : integer;
  p1, p2, d : pbytearray;
  TotalDiff : integer;
begin
  DiffRatio := 0;
  IF (BM1.width <> BM2.width) or (BM1.Height <> BM2.Height) or
     (BM1.pixelformat <> pf24bit) or (BM2.pixelformat <> pf24bit) then
    begin
      Diff.Width := 1;
      Diff.Height := 1;
      Diff.PixelFormat := pf24bit;
      exit;
    end;

  Diff.Width := BM1.Width;
  Diff.Height := BM1.Height;
  Diff.PixelFormat := pf24bit;  // Not really necessary. pf8bit together with a suitable color palette would be better.

  TotalDiff := 0;
  FOR Y := BM1.Height-1 DOWNTO 0 DO
    BEGIN
      p1 := BM1.ScanLine[Y];
      p2 := BM2.ScanLine[Y];
      d  := Diff.ScanLine[Y];
      FOR X := 0+3 TO BM1.Width*3-1-3 DO  // "*3" because we have pf24bit images
        begin
          //d^[X] := DiffCol[p1^[X]-p2^[X]];  // Without averaging
          d^[X] := DiffCol[((p1^[X-3]+2*p1^[X]+p1^[X+3])-(p2^[X-3]+2*p2^[X]+p2^[X+3])) div 4];
          Inc(TotalDiff, d^[X]);
        end;
    END;
  DiffRatio := TotalDiff / (3*Diff.Width*Diff.Height*255);
end;

procedure TfrmCapturePicFromCamera.CalcDiffImage2(BM1, BM2, Diff: TBitmap; VAR DiffRatio: double);
begin
  CalcDiffImage(BM1, BM2, Diff, DiffRatio);
  IF (Diff.width = BM1.width) then
    begin
      Diff.Canvas.CopyMode := cmSrcPaint;
      Diff.Canvas.Draw(0, 0, BM1);
      Diff.Canvas.CopyMode := cmSrcCopy;
    end;
end;
}

procedure TfrmCapturePicFromCamera.OnNewFrame(Sender : TObject; Width, Height: integer; DataPtr: pointer);
VAR
  i, x, y,
  T1 : integer;
  d  : double;
  s  : string;
  hour, min, sec, msec: word;
begin
  PaintBox_Video.Width := Width;
  PaintBox_Video.Height := Height;

  Inc(fFrameCnt);
  IF OnNewFrameBusy then
    begin
      Inc(fSkipCnt);
      exit;
    end;

  OnNewFrameBusy := true;
  // Calculate "Frames per second"...
  IF fFrameCnt mod 30 = 0 then
    begin
      T1 := TimeGetTime;
      if f30FrameTick > 0 then
//        Label_fps.Caption := 'fps: ' + FloatToStrf(30000 / (T1-f30FrameTick), ffFixed, 16, 1) +
//                             ' [' + FloatToStrf(VideoImage.FramesPerSecond, ffFixed, 16, 1) +
//                             '] (' + IntToStr(fSkipCnt)+' [' + IntToStr(VideoImage.FramesSkipped) + '] skipped)';
      f30FrameTick := T1;
    end;

  // In the following part the actual video frame is retreived from VideoImage and than
  // painted to the Paintbox_Video. This is usefull, if the image is to be modified
  // before painting. Otherwise we could have set "VideoImage.SetDisplayCanvas(PaintBox_Video.Canvas);"
  // in routine InitFrame below, and the painting would have been done by VideoImage.

  VideoBMPIndex := 1-VideoBMPIndex;
  VideoImage.GetBitmap(VideoBMP[VideoBMPIndex]);

  IF ComboBox_DisplayMode.ItemIndex <= 0
    then begin
      PaintBox_Video.Canvas.Draw(0, 0, VideoBMP[VideoBMPIndex]);
    end
    else begin
      DiffRatio := 0;
      CASE ComboBox_DisplayMode.ItemIndex OF
        1    : CalcInvertedImage(VideoBMP[VideoBMPIndex], ModeBMP);
        2    : CalcGrayScaleImage(VideoBMP[VideoBMPIndex], ModeBMP);
//        3    : CalcDiffImage(VideoBMP[VideoBMPIndex], VideoBMP[1-VideoBMPIndex], ModeBMP, DiffRatio);
//        4, 5 : CalcDiffImage2(VideoBMP[VideoBMPIndex], VideoBMP[1-VideoBMPIndex], ModeBMP, DiffRatio);
        else
        ModeBMP.assign(VideoBMP[VideoBMPIndex]);
      END; {case}
      PaintBox_Video.Canvas.Draw(0, 0, ModeBMP);
//      Label2.Caption := 'Diff-Ratio: ' + FloatToStrF(DiffRatio*100, ffFixed, 16, 3) + '%';
      // Surveillance
      IF (DiffRatio > 0.03/100) and (ComboBox_DisplayMode.ItemIndex = 5) THEN
        BEGIN
          CopyBMP.Width := VideoBMP[VideoBMPIndex].Width;
          CopyBMP.Height := VideoBMP[VideoBMPIndex].Height;
          CopyBMP.Canvas.Draw(0, 0, VideoBMP[VideoBMPIndex]);
          WITH CopyBMP DO
            begin
              DecodeTime(Now, hour, min, sec, msec);
              Canvas.Brush.Style := bsClear;
              Canvas.TextOut(4, Height-4-Canvas.TextHeight('W'), DateTimetoStr(Now));
              Canvas.Brush.Style := bsSolid;
              Canvas.ellipse(4, 4, 36, 36);
              Canvas.Pen.Color := clBlack;
              FOR i := 0 TO 11 DO
                BEGIN
                  Canvas.Pen.Color := clGray;
                  Canvas.Brush.Color := clBlack;
                  X := round(20 + 12*Sin(i*30*Pi/180));
                  Y := round(20 - 12*cos(i*30*Pi/180));
                  Canvas.ellipse(X-2, Y-2, X+2, Y+2);
                END;
              Canvas.Pen.Color := clBlack;
              d := (Hour + min/60) *30 *Pi/180;
              X := round(20 + 7*Sin(d));
              Y := round(20 - 7*cos(d));
              Canvas.Pen.Width := 3;
              Canvas.moveto(20, 20);
              Canvas.LineTo(X, Y);
              Canvas.Pen.Width := 1;
              Canvas.Pen.Color := clBlue;
              d := (Min + Sec/60) *6 *Pi/180;
              X := round(20 + 10*Sin(d));
              Y := round(20 - 10*cos(d));
              Canvas.moveto(20, 20);
              Canvas.LineTo(X, Y);
              Canvas.Pen.Color := clRed;
              d := (sec) *6 *Pi/180;
              X := round(20 + 10*Sin(d));
              Y := round(20 - 10*cos(d));
              Canvas.moveto(20, 20);
              Canvas.LineTo(X, Y);
            end;

          ForceDirectories(AppPath + 'Spy\');
          Inc(SpyIndex);
          IF SpyIndex <= 4000 then
           begin
             s := IntToStr(SpyIndex);
             while length(s) < 4 do
               s := '0' + s;
             LocalJPG.Assign(CopyBMP);
             LocalJPG.SaveToFile(AppPath + 'Spy\Spy_'+s+'.jpg');
             //VideoBMP[VideoBMPIndex].SaveToFile(AppPath + 'Spy\Spy_'+s+'.bmp');
           end;
        END;
    end;
  OnNewFrameBusy := false;
end;

procedure TfrmCapturePicFromCamera.PropertyTrackBarChange(Sender: TObject);
VAR
  VP : TVideoProperty;
begin
  WITH Sender as TTrackBar DO
    BEGIN
      VP := TVideoProperty(Tag);
      VideoImage.SetVideoPropertySettings(VP, PropCtrl[VP].PCTrackbar.Position, PropCtrl[VP].PCCheckbox.Checked);
    end;
end;

procedure TfrmCapturePicFromCamera.SpeedButton1Click(Sender: TObject);
begin
  VideoImage.ShowProperty;
  CleanPaintBoxVideo;
end;

procedure TfrmCapturePicFromCamera.btnStopClick(Sender: TObject);
begin
//  SpeedButton_VidSettings.Enabled := false;
//  SpeedButton_VidSize.Enabled := false;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  VideoImage.VideoStop;
  Screen.Cursor := crDefault;
  btnStart.Enabled := true;
  btnStop.Enabled := false;
  ComboBox_DisplayMode.Enabled := false;
  ComboBox1.Enabled := false;
//  SpeedButton_RunVideo.Enabled := true;
//  SpeedButton_Pause.Enabled    := false;
  ComboBox_Cams.Enabled   := true;
  UpdateCamList;
end;

procedure TfrmCapturePicFromCamera.btnTakePicClick(Sender: TObject);
var
  Bitmap: TBitmap;
  Jpg: TJPEGImage; //TPngImage; //
//  Png: TPngImage;
  Source: TRect;
  Dest: TRect;
  ImageFileName: string;
begin
 if btnStop.Enabled then
   begin
     btnStopClick(nil);
     Application.ProcessMessages;
   end;

  Bitmap := TBitmap.Create;
//  Jpg := TJPEGImage.Create;
  Jpg := TJPEGImage.Create;
  try
    with Bitmap do
    begin
      Width := PaintBox_Video.Width;
      Height := PaintBox_Video.Height;
      Dest := Rect(0, 0, Width, Height);
    end;
    with PaintBox_Video do
      Source := Rect(0, 0, Width, Height);

    Bitmap.Canvas.CopyRect(Dest, PaintBox_Video.Canvas, Source);

    Jpg.CompressionQuality := 90;//
//    Jpg.CompressionQuality CompressionLevel := 9;
    Jpg.Assign(Bitmap); // C := Bitmap.Canvas; // SaveToStream(St);
    ImageFileName := GetWindowsTempDir + GetUniqueID + 'Picture.jpg';
//    if not DirectoryExists(ImageFileName) then
//      ForceDirectories(ImageFileName);
//
//    ImageFileName := ImageFileName + '12345.jpg';
    Jpg.SaveToFile(ImageFileName);

    SavePicFileName := ImageFileName;
  finally
    Jpg.Free;
    Bitmap.Free;
  end;

  ImageDesc := edImageDesc.Text;

  ModalResult := mrOk;
end;

procedure TfrmCapturePicFromCamera.PropertyCheckBoxClick(Sender: TObject);
VAR
  VP : TVideoProperty;
begin
  WITH Sender as TCheckBox DO
    BEGIN
      VP := TVideoProperty(Tag);
      VideoImage.SetVideoPropertySettings(VP, PropCtrl[VP].PCTrackbar.Position, PropCtrl[VP].PCCheckbox.Checked);
    end;
end;

procedure TfrmCapturePicFromCamera.SelectSaveCam;
var
  SelCamIndexStr: string;
  Idx: integer;
begin
  SelCamIndexStr := ReadFromIni(GlobalIniFile, SaveCameraSec, SaveCameraItem);
  if TryStrToInt(SelCamIndexStr, Idx) then
    begin
      if (ComboBox_Cams.Items.Count - 1) >= Idx then
        ComboBox_Cams.ItemIndex := Idx;
    end;
end;

procedure TfrmCapturePicFromCamera.SaveCamSelection;
begin
  WriteToIni(GlobalIniFile, SaveCameraSec, SaveCameraItem, ComboBox_Cams.ItemIndex.ToString);
end;

procedure TfrmCapturePicFromCamera.SelectSavedCamResolution;
var
  SelCamIndexStr: string;
  Idx: integer;
begin
  SelCamIndexStr := ReadFromIni(GlobalIniFile, SaveCameraResSec, SaveCameraResItem);
  if TryStrToInt(SelCamIndexStr, Idx) then
    begin
      if (ComboBox1.Items.Count - 1) >= Idx then
        ComboBox1.ItemIndex := Idx;
    end;
end;

procedure TfrmCapturePicFromCamera.SaveCamResolution;
begin
  WriteToIni(GlobalIniFile, SaveCameraResSec, SaveCameraResItem, ComboBox1.ItemIndex.ToString);
end;

procedure TfrmCapturePicFromCamera.InitFrame;
var
  i  : integer;
  VP : TVideoProperty;
begin
  fSkipCnt := 0;
//  Initialized := true;
  LocalJPG := TJPEGImage.create;
  AppPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  btnStop.Enabled := false;

  // --- Instantiate TVideoImage
  VideoImage := TVideoImage.Create;
  //VideoImage.SetDisplayCanvas(PaintBox_Video.Canvas); // For automatically drawing video frames on paintbox
  VideoImage.SetDisplayCanvas(nil); // For drawing video by ourself
  VideoImage.OnNewVideoFrame := OnNewFrame;

  // --- Load ComboBox_Cams with list of available video interfaces (WebCams...)
  UpdateCamList;

  SelectSaveCam;

  VideoBMP[0] := TBitmap.Create;
  VideoBMP[1] := TBitmap.Create;
  ModeBMP     := TBitmap.Create;
  CopyBMP     := TBitmap.Create;
  VideoBMP[0].PixelFormat := pf24bit;
  VideoBMP[1].PixelFormat := pf24bit;

  CopyBMP.PixelFormat := pf24bit;
  CopyBMP.Canvas.Font.Name := 'Arial';
  CopyBMP.Canvas.Font.Size := 10;
  CopyBMP.Canvas.Brush.Style := bsclear;

  FOR i := -255 TO 255 DO
    IF Abs(i) < 48            // Differences between images must be larger than 24 to be displayed
      then DiffCol[i] := 0
      else IF Abs(i) < 48+64
        then DiffCol[i] := (Abs(i)-48)*4
        else DiffCol[i] := 255;

  FOR VP := Low(TVideoProperty) TO High(TVideoProperty) DO
    WITH PropCtrl[VP] DO
      BEGIN
        PCLabel           := TLabel.Create(Panel_Top);
        PCLabel.Parent    := Panel_Top;
        PCLabel.Left      := 8;
        PCLabel.Top       := 112 + Integer(VP)*26;
        PCLabel.Caption   := GetVideoPropertyName(VP);

        PCTrackbar        := TTrackBar.Create(Panel_Top);
        PCTrackbar.Parent := Panel_Top;
        PCTrackbar.Left   := 100;
        PCTrackbar.Top    := PCLabel.Top-8;
        PCTrackbar.Width  := 218;
        PCTrackbar.Tag    := integer(VP);
        PCTrackbar.Enabled:= false;
        PCTrackbar.ThumbLength := 9;
        PCTrackbar.Height := 25;
        PCTrackbar.TickMarks := tmBoth;
        PCTrackBar.OnChange := PropertyTrackBarChange;
        PCTrackBar.Anchors := [akLeft, akTop, akRight];

        PCCheckbox        := TCheckBox.Create(Panel_Top);
        PCCheckbox.Parent := Panel_Top;
        PCCheckbox.Left   := PCTrackbar.Left + PCTrackbar.Width + 8;
        PCCheckbox.Top    := PCLabel.Top-3;
        PCCheckbox.Tag    := integer(VP);
        PCCheckbox.Enabled:= false;
        PCCheckbox.Caption:= '';
        PCCheckbox.Width  := PCCheckbox.Height+4;
        PCCheckbox.OnClick:= PropertyCheckBoxClick;
        PCCheckbox.Anchors := [akTop, akRight];
      END;

  SelectSavedCamResolution;
 // VideoImage.SetResolutionByIndex(Combobox1.itemIndex);
end;

procedure TfrmCapturePicFromCamera.CleanPaintBoxVideo;
begin
  PaintBox_Video.Canvas.Brush.Color := Color;
  PaintBox_Video.Canvas.rectangle(-1, -1, PaintBox_Video.Width+1, PaintBox_Video.Height+1);
end;

procedure TfrmCapturePicFromCamera.ComboBox1Change(Sender: TObject);
begin
  SaveCamResolution;
  VideoImage.SetResolutionByIndex(Combobox1.itemIndex);
  Label_VideoSize.Caption := 'Video size ' + intToStr(VideoImage.VideoWidth) + ' x ' + IntToStr(VideoImage.VideoHeight);
end;

procedure TfrmCapturePicFromCamera.ComboBox_CamsChange(Sender: TObject);
begin
  SaveCamSelection;
end;

procedure TfrmCapturePicFromCamera.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if btnStop.Enabled then
    begin
      btnStopClick(nil);
    end;
end;

procedure TfrmCapturePicFromCamera.FormShow(Sender: TObject);
begin
  InitFrame;
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  try
    btnStartClick(nil);
  finally
    Screen.Cursor := crDefault;
  end;

  edImageDesc.Text := ImageDesc;
end;

procedure TfrmCapturePicFromCamera.UpdateCamList;
var
  SL : TStringList;
begin
  // Load ComboBox_Cams with list of available video interfaces (WebCams...)
  SL := TStringList.Create;
  try
    VideoImage.GetListOfDevices(SL);
    ComboBox_Cams.Items.Assign(SL);
  finally
    SL.Free;
  end;

  // At least one WebCam found: enable "Run video" button
//  SpeedButton_RunVideo.Enabled := false;
  IF ComboBox_Cams.Items.Count > 0 then
    begin
      IF (ComboBox_Cams.ItemIndex < 0) or (ComboBox_Cams.ItemIndex >= ComboBox_Cams.Items.Count) then
        ComboBox_Cams.ItemIndex := 0;
//      SpeedButton_RunVideo.Enabled := true;
    end
    else begin
      ComboBox_Cams.items.add('No cameras found.');
//      SpeedButton_RunVideo.Enabled := false;
    end;
end;


end.
