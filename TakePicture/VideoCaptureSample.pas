unit VideoCaptureSample;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Surfaces, FMX.Utils,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Media,
  {$IFDEF MSWINDOWS}
  Winapi.Windows, FMX.Platform.Win, FMX.Layouts, FMX.ListBox, FMX.Objects
  {$ENDIF}
  ;
type
  TfrmCamera = class(TForm)
    Layout1: TLayout;
    btnClose: TButton;
    Image1: TImage;
    StartButton: TButton;
    ComboBox1: TComboBox;
    btnCapture: TButton;
    cbResolution: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCaptureClick(Sender: TObject);
  private
    FAllowClose: Boolean;
    FLastUiTick: UInt64;
    FUiIntervalMs: UInt64;
    FFrameBmp: FMX.Graphics.TBitmap;
    FCaptureOutFile: string;
    FCaptureSetting: TVideoCaptureSetting;
    FCaptureRequested: Boolean;
    procedure DisableMinimizeAllowMaximize;
    procedure FillResolutionCombo;
    procedure ApplySelectedResolution;
    procedure SelectDefaultResolution;
    function FindSetting(AWidth, AHeight: Integer;
      out ASetting: TVideoCaptureSetting): Boolean;
    procedure SaveBitmapAsJpeg(const ABmp: FMX.Graphics.TBitmap; const AFileName: string; AQuality: Integer);
  public
    VideoCamera: TVideoCaptureDevice;
    procedure SampleBufferSync;
    procedure SampleBufferReady(Sender: TObject; const ATime: TMediaTime);
  end;

var
  frmCamera: TfrmCamera;

implementation

{$R *.fmx}

procedure TfrmCamera.SaveBitmapAsJpeg(const ABmp: FMX.Graphics.TBitmap; const AFileName: string; AQuality: Integer);
var
  Surf: TBitmapSurface;
  Params: TBitmapCodecSaveParams;
begin
  if AQuality < 1 then
    AQuality := 1
  else if AQuality > 100 then
    AQuality := 100;

  Params.Quality := AQuality;

  Surf := TBitmapSurface.Create;
  try
    Surf.Assign(ABmp); // Assign the source bitmap

    if not TBitmapCodecManager.SaveToFile(AFileName, Surf, @Params) then
      raise Exception.Create('Could not save JPEG: ' + AFileName);

  finally
    Surf.Free;
  end;
end;

procedure TfrmCamera.FormDeactivate(Sender: TObject);
begin
  // If you really mean "don't go behind", bring it back.
  // (Comment this out if it feels too aggressive.)
  //BringToFront;
end;

procedure TfrmCamera.FormDestroy(Sender: TObject);
begin
  if VideoCamera <> nil then
    VideoCamera.StopCapture;

  FFrameBmp.Free;
end;

procedure TfrmCamera.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Prevent Alt+F4 or clicking X unless we explicitly allow it
//  CanClose := FAllowClose;
//   // If we didn’t capture, report cancel
//  if not FileExists(FCaptureOutFile) then
//    begin
//      ExitCode := 1;
//      CanClose := true;
//    end;

end;

procedure TfrmCamera.FormCreate(Sender: TObject);
  var
  DeviceList: TCaptureDeviceList;
  i: integer;
begin
  if ParamCount > 0 then
    FCaptureOutFile := ParamStr(1)
  else
    FCaptureOutFile := 'C:\Temp\Pepito.jpg';

  FAllowClose := False;
  FCaptureRequested := False;
  FFrameBmp := FMX.Graphics.TBitmap.Create;

  FormStyle := TFormStyle.StayOnTop;
  BorderStyle := TFmxFormBorderStyle.Sizeable;

  DisableMinimizeAllowMaximize;

  DeviceList := TCaptureDeviceManager.Current.GetDevicesByMediaType
    (TMediaType.Video);
  for i := 0 to DeviceList.Count - 1 do
  begin
    ComboBox1.Items.Add(DeviceList[i].Name);
  end;

  FUiIntervalMs := 50; // 20 FPS. Try 33 for ~30 FPS, 66 for ~15 FPS
  FLastUiTick := 0;
end;

procedure TfrmCamera.SampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
var
  NowTick: UInt64;
begin
  NowTick := TThread.GetTickCount64;
  if (NowTick - FLastUiTick) < FUiIntervalMs then
    Exit;

  FLastUiTick := NowTick;

  TThread.Queue(nil,
    procedure
    begin
      SampleBufferSync;
    end);
end;

procedure TfrmCamera.SampleBufferSync;
begin
   if VideoCamera = nil then
    Exit;

  // Convert current frame to bitmap (use offscreen bitmap if you have it)
  VideoCamera.SampleBufferToBitmap(FFrameBmp, True);

  // 1) CAPTURE path (one-shot)
  if FCaptureRequested then
  begin
    FCaptureRequested := False;

    try

      SaveBitmapAsJpeg(FFrameBmp, FCaptureOutFile, 90);
      ExitCode := 0;           // success
    except
      ExitCode := 2;           // error saving/capturing
    end;

    Close;                     // return to PawnPro
    Exit;
  end;

  // 2) NORMAL preview path
  Image1.Bitmap.Assign(FFrameBmp);
end;

procedure TfrmCamera.StartButtonClick(Sender: TObject);
begin
  if (VideoCamera <> nil) then
  begin
    if (VideoCamera.State = TCaptureDeviceState.Stopped) then
    begin
      ApplySelectedResolution;

      VideoCamera.OnSampleBufferReady := SampleBufferReady;
      VideoCamera.StartCapture;

      StartButton.Text := 'Stop';
    end
    else
    begin
      VideoCamera.StopCapture;

      StartButton.Text := 'Start';
    end;
  end
  else
  begin
    Caption := 'Video capture devices not available.';
  end;
end;

procedure TfrmCamera.SelectDefaultResolution;
var
  i: Integer;
  CS: TVideoCaptureSetting;
begin
  for i := Low(VideoCamera.AvailableCaptureSettings)
           to High(VideoCamera.AvailableCaptureSettings) do
  begin
    CS := VideoCamera.AvailableCaptureSettings[i];
    if (CS.Width = 1280) and (CS.Height = 720) then
    begin
      cbResolution.ItemIndex := i;
      Exit;
    end;
  end;
end;

procedure TfrmCamera.ComboBox1Change(Sender: TObject);
begin
  VideoCamera := TVideoCaptureDevice
    (TCaptureDeviceManager.Current.GetDevicesByName(ComboBox1.Selected.Text));
  if (VideoCamera <> nil) then
  begin
    StartButton.Enabled := true;
  end;

  FillResolutionCombo;
end;

procedure TfrmCamera.FillResolutionCombo;
var
  i: Integer;
  CS: TVideoCaptureSetting;
  S: string;
begin
  cbResolution.Clear;

  if (VideoCamera = nil) then
    Exit;

  for i := Low(VideoCamera.AvailableCaptureSettings)
           to High(VideoCamera.AvailableCaptureSettings) do
  begin
    CS := VideoCamera.AvailableCaptureSettings[i];

    {$IF Declared(TVideoCaptureSetting.FrameRate)}
    S := Format('%dx%d @ %.0f fps', [CS.Width, CS.Height, CS.FrameRate]);
    {$ELSE}
    S := Format('%dx%d', [CS.Width, CS.Height]);
    {$IFEND}

    // store index safely
    cbResolution.Items.AddObject(S, TObject(i));

    SelectDefaultResolution;
  end;

  if cbResolution.Items.Count > 0 then
    cbResolution.ItemIndex := 0;
end;

procedure TfrmCamera.ApplySelectedResolution;
var
  Idx: Integer;
begin
  if (VideoCamera = nil) or (cbResolution.ItemIndex < 0) then
    Exit;

  Idx := Integer(cbResolution.Items.Objects[cbResolution.ItemIndex]);

  VideoCamera.CaptureSetting :=
    VideoCamera.AvailableCaptureSettings[Idx];
end;

function TfrmCamera.FindSetting(AWidth, AHeight: Integer; out ASetting: TVideoCaptureSetting): Boolean;
var
  i: Integer;
  S: TVideoCaptureSetting;
begin
  Result := False;
  if VideoCamera = nil then Exit;

  for i := Low(VideoCamera.AvailableCaptureSettings) to High(VideoCamera.AvailableCaptureSettings) do
  begin
    S := VideoCamera.AvailableCaptureSettings[i];
    if (S.Width = AWidth) and (S.Height = AHeight) then
    begin
      ASetting := S;
      Exit(True);
    end;
  end;
end;

procedure TfrmCamera.btnCaptureClick(Sender: TObject);
begin
  if VideoCamera = nil then
    Exit;

  if VideoCamera = nil then
  begin
    ExitCode := 2;
    Close;
    Exit;
  end;

  FCaptureRequested := True;

  // Switch to high resolution (example: 1920x1080)
  if not FindSetting(1920, 1080, FCaptureSetting) then
    FCaptureSetting := VideoCamera.CaptureSetting;

  VideoCamera.StopCapture;
  VideoCamera.CaptureSetting := FCaptureSetting;
  VideoCamera.StartCapture;
end;

procedure TfrmCamera.btnCloseClick(Sender: TObject);
begin
  FAllowClose := True;
  ExitCode := 1;
  Close;
end;


procedure TfrmCamera.DisableMinimizeAllowMaximize;
{$IFDEF MSWINDOWS}
var
  H: HWND;
  Style: NativeInt;
begin
  H := FmxHandleToHWND(Handle);

  Style := GetWindowLongPtr(H, GWL_STYLE);
  // remove minimize box
  Style := Style and not WS_MINIMIZEBOX;
  // ensure maximize + sizing are present
  Style := Style or WS_MAXIMIZEBOX or WS_THICKFRAME;
  SetWindowLongPtr(H, GWL_STYLE, Style);

  // refresh non-client area
  SetWindowPos(H, 0, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_FRAMECHANGED);
end;
{$ELSE}
begin
end;
{$ENDIF}


end.
