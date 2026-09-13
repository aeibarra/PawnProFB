unit CardReader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils, System.DateUtils,
  Buttons, Vcl.Mask, RzEdit, DrvLic_PDF417Parsing;

type
  TfrmDriverLicCardReader = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edFirst: TEdit;
    edLast: TEdit;
    edMiddle: TEdit;
    edAddress: TEdit;
    edCity: TEdit;
    edState: TEdit;
    edSex: TEdit;
    edHeight: TEdit;
    Panel1: TPanel;
    MemoRawData: TMemo;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button1: TButton;
    edDOB: TRzDateTimeEdit;
    edZIP: TRzMaskEdit;
    edDrvLic: TRzMaskEdit;
    edCountry: TEdit;
    Label12: TLabel;
    edExp: TRzDateTimeEdit;
    Label13: TLabel;
    EdIssued: TRzDateTimeEdit;
    Label14: TLabel;
    edDrvLicClass: TEdit;
    Label15: TLabel;
    BitBtn1: TBitBtn;
    TimerForScan: TTimer;
    Memo1: TMemo;
    procedure MemoRawDataChange(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TimerForScanTimer(Sender: TObject);
  private
    LastDataCount: integer;
    ScanIdleChecks: Integer;
    procedure ParseFL_DL_String;
    procedure ShowDrvLicInfo(const DrvLicInfo: TDriverLicenseInfo);
//    procedure GetScanDataBuffer(var S: string);
    procedure ProcessAndShowBarcodeData;
  public
    { Public declarations }
  end;

var
  frmDriverLicCardReader: TfrmDriverLicCardReader;

implementation

{$R *.dfm}

uses PawnGlobal, GLbUtils, uPawnDialogs;

procedure TfrmDriverLicCardReader.ShowDrvLicInfo(const DrvLicInfo: TDriverLicenseInfo);
begin
  edFirst.Text:= DrvLicInfo.FirstName;
  edMiddle.Text := DrvLicInfo.MiddleName;
  edLast.Text := DrvLicInfo.LastName;
  edSex.Text := DrvLicInfo.Sex;     //Wrong
  edHeight.Text := DrvLicInfo.PersonHeight; //Wrong
  edAddress.Text := DrvLicInfo.Address;
  edCity.Text := DrvLicInfo.City;
  edState.Text := DrvLicInfo.State;
  edZIP.Text := DrvLicInfo.ZipCode; //Wrong
  edDOB.Date := DrvLicInfo.DOB;
  edDrvLic.Text := DrvLicInfo.DrivervLicNumber;

  edCountry.Text := DrvLicInfo.Country;
  edExp.Date := DrvLicInfo.Exp;
  EdIssued.Date := DrvLicInfo.IssuedDate;
  edDrvLicClass.Text := DrvLicInfo.VehicleClass;

end;

procedure TfrmDriverLicCardReader.ProcessAndShowBarcodeData;
var
  DrvLicInfo: TDriverLicenseInfo;
  S: string;
begin
  TimerForScan.Enabled := False;
  try
    S := MemoRawData.Text;
    try
      ParsePDF417_US_Driver_License(S, DrvLicInfo);
    except
      on E: EDriverLicenseBarcode do
      begin
        PawnWarn(E.Message, 'Driver license scan', Self);
        MemoRawData.Clear;
        MemoRawData.SetFocus;
        Exit;
      end;
    end;
    ShowDrvLicInfo(DrvLicInfo);
    ModalResult := mrOK;
  finally
    LastDataCount := 0;
    ScanIdleChecks := 0;
    TimerForScan.Enabled := False;
  end;
end;

procedure TfrmDriverLicCardReader.TimerForScanTimer(Sender: TObject);
begin
  if ScanBufferIsIdle(Length(MemoRawData.Text), LastDataCount, ScanIdleChecks) then
    ProcessAndShowBarcodeData;
end;

procedure TfrmDriverLicCardReader.ParseFL_DL_String;
var
  DrvLicInfo: TDriverLicenseInfo;
begin
  if (Length( MemoRawData.Lines.Text) < 50) {and (RawData[1] <> '%')} then
    exit;

  FillChar(DrvLicInfo, SizeOf(DrvLicInfo), #0);

//  WriteTextFile('C:\Temp\SamaraLic.txt', MemoRawData.Lines.Text); //Test

  ParseFL_DL(MemoRawData.Lines.Text, DrvLicInfo);

  ShowDrvLicInfo(DrvLicInfo);

end;
(*
procedure TfrmDriverLicCardReader.ParseFL_DL;
var
  LastName, RawData: string;
  P: integer;
begin
//  if pos(#10, MemoRawData.Lines.Text) <= 0 then
//    exit;

  if (Length( MemoRawData.Lines.Text) < 150) {and (RawData[1] <> '%')} then
    exit;

  RawData := MemoRawData.Lines.Text;

  if RawData[1] <> '%' then
    exit;

  p := pos('^', RawData);
  edState.Text := UpperCase(Copy(RawData, 2, 2));
  edCity.Text := UpperCase(Copy(RawData, 4, p - 4));
  Delete(RawData, 1, P);

  P := Pos('$', RawData);
  LastName := Copy(RawData, 1, P - 1);
  edLast.Text := UpperCase(LastName);
  Delete(RawData, 1, P);

  P := Pos('$', RawData);
  edFirst.Text := UpperCase(Copy(RawData, 1, P - 1));
  Delete(RawData, 1, P);

  P := Pos('^', RawData);
  edMiddle.Text := UpperCase(Copy(RawData, 1, P - 1));
  Delete(RawData, 1, P);

  P := Pos('^', RawData);
  if P = 0 then
    P := Pos('?', RawData);

  edAddress.Text := UpperCase(Copy(RawData, 1, P - 1));

  P := Pos(';', RawData);
  Delete(RawData, 1, P);

  P := Pos('=', RawData);
  edDrvLic.Text := UpperCase(Copy(LastName, 1, 1) + Copy(RawData, 9, 11) + '0');
  Delete(RawData, 1, P);

  edDOB.Text := Copy(RawData, 3, 2) + '/' + Copy(RawData, 11, 2) + '/' + Copy(RawData, 5, 4);

  P := Pos('?#!', RawData);
  if P = 0 then
    P := Pos('?+!', RawData);

  Delete(RawData, 1, P+3);

  RawData := trim(RawData);

  edZIP.Text := Copy(RawData, 1, 5);
  Delete(RawData, 1, 20);

  RawData := trim(RawData);

  if Copy(RawData, 1, 1) = '1' then
    edSex.Text := 'M'
  else
    edSex.Text := 'F';

  edHeight.Text := Copy(RawData, 2, 1) + '.' + Copy(RawData, 3, 2) ;

//  ModalResult := mrOk;

end;  *)

//procedure TfrmDriverLicCardReader.GetScanDataBuffer(var S: string);
//begin
//  S := MemoRawData.Lines.Text;
//end;

procedure TfrmDriverLicCardReader.MemoRawDataChange(Sender: TObject);
begin
  if MemoRawData.Text = '' then
  begin
    TimerForScan.Enabled := False;
    LastDataCount := 0;
    ScanIdleChecks := 0;
    Exit;
  end;
  // PDF417 may have any number of lines. Test its header before magnetic data.
  if BarcodePDF417PatterDetected(MemoRawData.Text) then
  begin
    if not TimerForScan.Enabled then
    begin
      LastDataCount := 0;
      ScanIdleChecks := 0;
      TimerForScan.Enabled := True;
    end;
  end
  else if (MemoRawData.Lines.Count = 3) and
          (Pos('?', MemoRawData.Lines[2]) > 0) then
  begin
    ParseFL_DL_String;
    ModalResult := mrOK;
  end;
end;

procedure TfrmDriverLicCardReader.BitBtn3Click(Sender: TObject);
begin
  TimerForScan.Enabled := False;
  LastDataCount := 0;
  ScanIdleChecks := 0;
  MemoRawData.Lines.Clear;
end;

procedure TfrmDriverLicCardReader.Button1Click(Sender: TObject);
var
  DrvLic: TDriverLicenseInfo;
  S: string;
begin
  S := Memo1.Text;
  try
    ParsePDF417_US_Driver_License(S, DrvLic);
    ShowDrvLicInfo(DrvLic);
  except
    on E: EDriverLicenseBarcode do
      PawnWarn(E.Message, 'Driver license scan', Self);
  end;
end;

procedure TfrmDriverLicCardReader.Button2Click(Sender: TObject);
begin
//  ParseFL_DL_String;
end;

procedure TfrmDriverLicCardReader.FormShow(Sender: TObject);
begin
  edZIP.Text := '';
  edDrvLic.Text := '';
  edHeight.Text := '';
end;

end.
