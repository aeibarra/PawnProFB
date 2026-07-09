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
    ComboBox_Cams: TComboBox;
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    PropCtrl     : ARRAY[TVideoProperty] OF TPropertyControl;
    VideoBMPIndex: integer;
    VideoBMP     : ARRAY[0..1] OF TBitmap;   // double-buffered live frames
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

uses PawnGlobal, GLbUtils, PawnDM, uPawnDialogs;

const
  SaveCameraSec = 'SELECTED_CAMERA';
  SaveCameraItem = 'ACTIVE_CAM';

  SaveCameraResSec = 'SELECTED_CAMERA_RES';
  SaveCameraResItem = 'ACTIVE_CAM_RES';

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

  ComboBox1.Enabled := true;
  // Video already initialized, but paused?
  IF assigned(VideoImage) then
    IF VideoImage.IsPaused then
      begin
        VideoImage.VideoResume;
        btnStop.Enabled := true;
        exit;
      end;

  // Initialize Video
  Screen.Cursor := crHourGlass;
  CleanPaintBoxVideo;
  Application.ProcessMessages;
  // Starting video using index number of device within list of devices.
  // This helps in case two cameras have the same name.
  i := VideoImage.VideoStart('#' + IntToStr(ComboBox_Cams.itemIndex+1));
  Screen.Cursor := crDefault;
  Application.ProcessMessages;

  IF i <> 0 then
    begin
      PawnError('Could not start video (Error ' + IntToStr(i) + ')', 'Capture Picture', Self);
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

  Label_VideoSize.Caption := 'Video size ' + intToStr(VideoImage.VideoWidth) + ' x ' + IntToStr(VideoImage.VideoHeight);
  fFrameCnt := 0;

  btnStop.Enabled := true;
  ComboBox_Cams.Enabled := false;

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

procedure TfrmCapturePicFromCamera.OnNewFrame(Sender: TObject; Width, Height: integer; DataPtr: pointer);
begin
  { Delivered on the main thread (VFrames posts a message), so it is safe to
    touch the VCL here. We just grab the current camera frame and paint it. }
  PaintBox_Video.Width := Width;
  PaintBox_Video.Height := Height;

  Inc(fFrameCnt);
  IF OnNewFrameBusy then
    begin
      Inc(fSkipCnt);
      exit;
    end;

  OnNewFrameBusy := true;
  try
    VideoBMPIndex := 1 - VideoBMPIndex;
    VideoImage.GetBitmap(VideoBMP[VideoBMPIndex]);
    PaintBox_Video.Canvas.Draw(0, 0, VideoBMP[VideoBMPIndex]);
  finally
    OnNewFrameBusy := false;
  end;
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
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  VideoImage.VideoStop;
  Screen.Cursor := crDefault;
  btnStart.Enabled := true;
  btnStop.Enabled := false;
  ComboBox1.Enabled := false;
  ComboBox_Cams.Enabled := true;
  UpdateCamList;
end;

procedure TfrmCapturePicFromCamera.btnTakePicClick(Sender: TObject);
var
  Jpg: TJPEGImage;
  FrameBmp: TBitmap;
  ImageFileName: string;
begin
  { Capture the actual camera frame (full video resolution) rather than
    re-grabbing the on-screen paintbox, which is lower fidelity and can be
    corrupted if the window is occluded. }
  FrameBmp := VideoBMP[VideoBMPIndex];
  if (FrameBmp = nil) or (FrameBmp.Width = 0) or (FrameBmp.Height = 0) then
    begin
      PawnWarn('No video frame is available to capture. Please start the camera first.',
        'Capture Picture', Self);
      exit;
    end;

  Jpg := TJPEGImage.Create;
  try
    Jpg.CompressionQuality := 90;
    Jpg.Assign(FrameBmp);
    ImageFileName := GetWindowsTempDir + GetUniqueID + 'Picture.jpg';
    Jpg.SaveToFile(ImageFileName);
    SavePicFileName := ImageFileName;
  finally
    Jpg.Free;
  end;

  { Release the camera now that we have the shot. }
  if btnStop.Enabled then
    btnStopClick(nil);

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
  VP : TVideoProperty;
begin
  fSkipCnt := 0;
  btnStop.Enabled := false;

  // --- Instantiate TVideoImage
  VideoImage := TVideoImage.Create;
  VideoImage.SetDisplayCanvas(nil);        // we paint the video frames ourselves
  VideoImage.OnNewVideoFrame := OnNewFrame;

  // --- Load ComboBox_Cams with list of available video interfaces (WebCams...)
  UpdateCamList;
  SelectSaveCam;

  VideoBMP[0] := TBitmap.Create;
  VideoBMP[1] := TBitmap.Create;
  VideoBMP[0].PixelFormat := pf24bit;
  VideoBMP[1].PixelFormat := pf24bit;

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
    btnStopClick(nil);
end;

procedure TfrmCapturePicFromCamera.FormCreate(Sender: TObject);
begin
  { Build the capture pipeline once. Teardown happens in FormDestroy. }
  InitFrame;
end;

procedure TfrmCapturePicFromCamera.FormDestroy(Sender: TObject);
begin
  { Stop and release the DirectShow graph and the frame buffers. Without this
    every capture leaked a video graph (COM) plus two bitmaps. }
  if Assigned(VideoImage) then
    begin
      try
        VideoImage.VideoStop;
      except
        // Ignore errors stopping an already-stopped or failed graph.
      end;
      FreeAndNil(VideoImage);
    end;

  FreeAndNil(VideoBMP[0]);
  FreeAndNil(VideoBMP[1]);
end;

procedure TfrmCapturePicFromCamera.FormShow(Sender: TObject);
begin
  edImageDesc.Text := ImageDesc;

  { No usable camera -> leave the preview stopped; the user still sees the form. }
  if not btnStart.Enabled then
    exit;

  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  try
    btnStartClick(nil);
  finally
    Screen.Cursor := crDefault;
  end;
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

  IF ComboBox_Cams.Items.Count > 0 then
    begin
      IF (ComboBox_Cams.ItemIndex < 0) or (ComboBox_Cams.ItemIndex >= ComboBox_Cams.Items.Count) then
        ComboBox_Cams.ItemIndex := 0;
      btnStart.Enabled := true;
    end
    else begin
      ComboBox_Cams.Items.Add('No cameras found.');
      ComboBox_Cams.ItemIndex := 0;
      btnStart.Enabled := false;
    end;
end;

end.
