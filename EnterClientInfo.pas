unit EnterClientInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, System.UITypes,
  StdCtrls, Buttons, DBCtrls, Mask, DB, ActnList, RzButton, RzCmboBx, RzEdit, RzDBEdit,
  System.Actions, PawnGlobal, Vcl.ExtCtrls, FireDAC.Comp.Client,
  DrvLic_PDF417Parsing, RzForms, RzLabel, uPawnPhoneEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet;

const
  sx_ProcessCardScanning = wm_User + 100;

type
  TfrmEnterClientInfo = class(TForm)
    gnBottom: TGroupBox;
    btnCancel: TBitBtn;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label20: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label27: TLabel;
    edLast: TDBEdit;
    edFirst: TDBEdit;
    edMid: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBEdit9: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    DBMemo1: TDBMemo;
    ActionListClientInfo: TActionList;
    ActionScanCard: TAction;
    btnSave: TRzBitBtn;
    cbCustDOB: TRzDBDateTimeEdit;
    DBEdit1: TDBEdit;
    TimerScanningTimeOut: TTimer;
    qryCheckClient: TFDQuery;
    qryCheckClientTClients: TIntegerField;
    TimerForScan: TTimer;
    FormState: TRzFormState;
    cbGender: TComboBox;
    cbRace: TComboBox;
    cbEyes: TComboBox;
    cbHair: TComboBox;
    lblCustAge: TRzLabel;
    edFLDriverLicense: TPawnFLDLEdit;
    edCellNumber: TPawnPhoneEdit;
    edHomePhoneNumber: TPawnPhoneEdit;
    edBussinessPhoneNumber: TPawnPhoneEdit;
    edOtherPhoneNumber: TPawnPhoneEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCalcLicClick(Sender: TObject);
    procedure txtFlDrvLicAfterEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionScanCardExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerScanningTimeOutTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerForScanTimer(Sender: TObject);
    procedure RzDBDateTimeEdit1Exit(Sender: TObject);
  private
    LastThreeKeys: TKeyQueue;
    ScanningCard, PreHeaderDetected: boolean;
    ReadingCardBuffer: string;
    CardScanNewLineCounter: integer;
    ScanningPDF417Barcode: boolean;
    ReadChars: string;
    ScanData: TScanDataList;
    LastDataCount: integer;
    function GetGender: string;
    procedure SetGender(const Value: string);
    function GetRace: string;
    procedure SetRace(const Value: string);
    function GetEyesColor: string;
    procedure SetEyesColor(const Value: string);
    function GetHairColor: string;
    procedure SetHairColor(const Value: string);
    procedure PopulateID(const IdNumber: string; State: string);
    function GetCellNumber: string;
    function GetDriverLicense: string;
    function GetHomePhoneNumber: string;
    function GetOtherPhoneNumber: string;
    procedure SetCellNumber(const Value: string);
    procedure SetDriverLicense(const Value: string);
    procedure SetHomePhoneNumber(const Value: string);
    procedure SetOtherPhoneNumber(const Value: string);
    function GetBussinessPhoneNumber: string;
    procedure SetBussinessPhoneNumber(const Value: string);
    property CustomerGender: string read GetGender write SetGender;
    property CustomerRace: string read GetRace write SetRace;
    property CustomerEyesColor: string read GetEyesColor write SetEyesColor;
    property CustomerHairColor: string read GetHairColor write SetHairColor;

    property CustomerDriverLicense: string read GetDriverLicense write SetDriverLicense;
    property CustomerCellNumber: string read GetCellNumber write SetCellNumber;
    property CustomerHomePhoneNumber: string read GetHomePhoneNumber write SetHomePhoneNumber;
    property CustomerBussinessPhoneNumber: string read GetBussinessPhoneNumber write SetBussinessPhoneNumber;
    property CustomerOtherPhoneNumber: string read GetOtherPhoneNumber write SetOtherPhoneNumber;

    procedure AddToKeyQueue(Key: Word);
    function MatchLastKeys(KeyPattern: TKeyQueue): boolean;
    procedure ProcessScannedCard(var Msg: TMessage); Message sx_ProcessCardScanning;
    procedure ProcessKeyForMagneticScan(var Key: Char);
    procedure PopulateFieldsWithDrvLicInfo(const DrvLicInfo: TDriverLicenseInfo);
    procedure ProcessAndShowBarcodeData;
//    procedure ProcessKeyForPDF417barcodeScan(var Key: Char);
//    procedure FinishPDF417BarcodeScanning;
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEnterClientInfo: TfrmEnterClientInfo;

implementation

uses PawnDM, CardReader, GLbUtils, SearchClient;

{$R *.DFM}

procedure TfrmEnterClientInfo.PopulateID(const IdNumber: string; State: string);
begin
  State := trim(UpperCase(State));
  if (State <> '') and (State = 'FL') then
    begin
      DM.qryCustomersCUST_FL_DRV_LIC.AsString := IdNumber;
    end
  else
    begin
      DM.qryCustomersCUST_ID.AsString := IdNumber;
      DM.qryCustomersCUST_ID_AGENCY_STATE.AsString := State;
      DM.qryCustomersCUST_ID_TYPE.AsString := 'DL';
    end;

end;

procedure TfrmEnterClientInfo.PopulateFieldsWithDrvLicInfo(const DrvLicInfo: TDriverLicenseInfo);
begin
  if (trim(DrvLicInfo.FirstName) = '') and (trim(DrvLicInfo.Address) = '') then
    exit;

  DM.qryCustomersCUST_FIRST.AsString := DrvLicInfo.FirstName;
  DM.qryCustomersCUST_MID.AsString := DrvLicInfo.MiddleName;
  DM.qryCustomersCUST_LAST.AsString := DrvLicInfo.LastName;

  DM.qryCustomersCUST_GENDER.AsString := DrvLicInfo.Sex;
  CustomerGender := DrvLicInfo.Sex;;

  DM.qryCustomersCUST_HEIGHT.AsString := DrvLicInfo.PersonHeight;
  DM.qryCustomersCUST_ADDR.AsString := DrvLicInfo.Address;
  DM.qryCustomersCUST_CITY.AsString := DrvLicInfo.City;
  DM.qryCustomersCUST_STATE.AsString := DrvLicInfo.State;
  DM.qryCustomersCUST_ZIP.AsString := DrvLicInfo.ZipCode;
  DM.qryCustomersCUST_DOB.AsDateTime := DrvLicInfo.DOB;

  PopulateID(DrvLicInfo.DrivervLicNumber, DrvLicInfo.State);

//  State := trim(UpperCase(DrvLicInfo.State));
//  if (State <> '') and (State = 'FL') then
//    begin
//      DM.qryCustomersCUST_FL_DRV_LIC.AsString := DrvLicInfo.DrivervLicNumber;
//    end
//  else
//    begin
//      DM.qryCustomersCUST_ID.AsString := DrvLicInfo.DrivervLicNumber;
//      DM.qryCustomersCUST_ID_AGENCY_STATE.AsString := State;
//      DM.qryCustomersCUST_ID_TYPE.AsString := 'DL';
//    end;

  DM.qryCustomersCUST_COMMENT.AsString := '';
end;

procedure TfrmEnterClientInfo.ProcessAndShowBarcodeData;
var
  DrvLicInfo: TDriverLicenseInfo;
begin
  ParseScanBarcodeData(ScanData, DrvLicInfo);

  PopulateFieldsWithDrvLicInfo(DrvLicInfo);

  ScanData.Clear;
end;

procedure TfrmEnterClientInfo.ProcessScannedCard(var Msg: TMessage);
var
  DrvLicInfo: TDriverLicenseInfo;
begin
  TimerScanningTimeOut.Enabled := false;

  if ScanningCard then
    begin
      ScanningCard := false;
      PreHeaderDetected := false;
      ParseFL_DL(ReadingCardBuffer, DrvLicInfo);

      PopulateFieldsWithDrvLicInfo(DrvLicInfo);
    end;


  cbRace.SetFocus;

//  if ScanningPDF417Barcode then
//    begin
//      Screen.Cursor := crDefault;
//
//      ScanningPDF417Barcode := false;
//      ParseScanBarcodeData(ScanData, DrvLicInfo);
//
//      PopulateFieldsWithDrvLicInfo(DrvLicInfo);
//    end;
//
end;

procedure TfrmEnterClientInfo.RzDBDateTimeEdit1Exit(Sender: TObject);
begin
  if DM.qryCustomerscCustAge.AsInteger <= LastMinorAge then
    begin
      lblCustAge.Caption := DM.qryCustomerscCustAge.AsString + ' Years Old';
      lblCustAge.Visible := true;
      lblCustAge.Blinking := true;
    end
  else
    begin
      lblCustAge.Caption := '';
      lblCustAge.Visible := false;
      lblCustAge.Blinking := false;
    end;
end;

procedure TfrmEnterClientInfo.SetGender(const Value: string);
var
 ItmIdx: integer;
begin
  ItmIdx := -1;

  if Value = 'M' then
    ItmIdx := 0
  else if Value = 'F' then
    ItmIdx := 1
  else if Value = 'N' then
    ItmIdx := 2;

  cbGender.ItemIndex := ItmIdx;
end;

function TfrmEnterClientInfo.GetGender: string;
var
 ItmIdx: integer;
begin
  ItmIdx := cbGender.ItemIndex;

  case ItmIdx of
  0: Result := 'M';
  1: Result := 'F';
  2: Result := 'N';
  else
    Result := '';
  end;

end;

procedure TfrmEnterClientInfo.SetRace(const Value: string);
var
 ItmIdx: integer;
begin
  ItmIdx := -1;

  if Value = 'W' then
    ItmIdx := 0
  else if Value = 'B' then
    ItmIdx := 1
  else if Value = 'I' then
    ItmIdx := 2
  else if Value = 'A' then
    ItmIdx := 3
  else if Value = 'H' then
    ItmIdx := 4;

  cbRace.ItemIndex := ItmIdx;
end;

function TfrmEnterClientInfo.GetRace: string;
var
 ItmIdx: integer;
begin
  ItmIdx := cbRace.ItemIndex;

  case ItmIdx of
  0: Result := 'W';
  1: Result := 'B';
  2: Result := 'I';
  3: Result := 'A';
  4: Result := 'H';
  else
    Result := '';
  end; //case
end;

procedure TfrmEnterClientInfo.SetBussinessPhoneNumber(const Value: string);
begin
  edBussinessPhoneNumber.Digits := Value;
end;

procedure TfrmEnterClientInfo.SetCellNumber(const Value: string);
begin
  edCellNumber.Digits := Value;
end;

procedure TfrmEnterClientInfo.SetDriverLicense(const Value: string);
begin
  edFLDriverLicense.Code := Value;
end;

procedure TfrmEnterClientInfo.SetEyesColor(const Value: string);
var
 ItmIdx: integer;
 C: string;
begin
  ItmIdx := -1;
  C := trim(Value);

  if C = 'BLU' then
    ItmIdx := 0
  else if C = 'BLK' then
    ItmIdx := 1
  else if C = 'BRN' then
    ItmIdx := 2
  else if C = 'GRN' then
    ItmIdx := 3
  else if C = 'GRY' then
    ItmIdx := 4
  else if C = 'HZL' then
    ItmIdx := 5;

  cbEyes.ItemIndex := ItmIdx;
end;

function TfrmEnterClientInfo.GetBussinessPhoneNumber: string;
begin
  Result := edBussinessPhoneNumber.Digits;
end;

function TfrmEnterClientInfo.GetCellNumber: string;
begin
  Result := edCellNumber.Digits;
end;

function TfrmEnterClientInfo.GetDriverLicense: string;
begin
  Result := edFLDriverLicense.Code;
end;

function TfrmEnterClientInfo.GetEyesColor: string;
var
 ItmIdx: integer;
begin
  ItmIdx := cbEyes.ItemIndex;

  case ItmIdx of
  0: Result := 'BLU';
  1: Result := 'BLK';
  2: Result := 'BRN';
  3: Result := 'GRN';
  4: Result := 'GRY';
  5: Result := 'HZL';
  else
    Result := '';
  end; //case

end;

procedure TfrmEnterClientInfo.SetHairColor(const Value: string);
var
 ItmIdx: integer;
 C: string;
begin
  ItmIdx := -1;
  C := trim(Value);

  if C = 'BLK' then
    ItmIdx := 0
  else if C = 'BLD' then
    ItmIdx := 1
  else if (C = 'BRW') or (C = 'BRN') then
    ItmIdx := 2
  else if C = 'GRY' then
    ItmIdx := 3
  else if C = 'RED' then
    ItmIdx := 4;

  cbHair.ItemIndex := ItmIdx;
end;

procedure TfrmEnterClientInfo.SetHomePhoneNumber(const Value: string);
begin
  edHomePhoneNumber.Digits := Value;
end;

procedure TfrmEnterClientInfo.SetOtherPhoneNumber(const Value: string);
begin
  edOtherPhoneNumber.Digits := Value;
end;

function TfrmEnterClientInfo.GetHairColor: string;
var
 ItmIdx: integer;
begin
  ItmIdx := cbHair.ItemIndex;

  case ItmIdx of
  0: Result := 'BLK';
  1: Result := 'BLD';
  2: Result := 'BRW';
  3: Result := 'GRY';
  4: Result := 'RED';
  else
    Result := '';
  end; // case

end;

function TfrmEnterClientInfo.GetHomePhoneNumber: string;
begin
  Result := edHomePhoneNumber.Digits;
end;

function TfrmEnterClientInfo.GetOtherPhoneNumber: string;
begin
  Result := edOtherPhoneNumber.Digits;
end;

procedure TfrmEnterClientInfo.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  if NewRow then
    begin
      DM.qryCustomers.Insert;
    end
  else
    begin
      DM.qryCustomers.Edit;

      CustomerGender := DM.qryCustomersCUST_GENDER.AsString;
      CustomerRace := DM.qryCustomersCUST_RACE.AsString;
      CustomerEyesColor := DM.qryCustomersCUST_EYES.AsString;
      CustomerHairColor := DM.qryCustomersCUST_HAIR.AsString;

      CustomerDriverLicense := DM.qryCustomersCUST_FL_DRV_LIC.AsString;
      CustomerCellNumber := DM.qryCustomersCUST_PH_CELL.AsString;
      CustomerHomePhoneNumber := DM.qryCustomerscCustPhHome.AsString;
      CustomerBussinessPhoneNumber := DM.qryCustomersCCustPhBussiness.AsString;
      CustomerOtherPhoneNumber := DM.qryCustomersCCustPhBeep.AsString;
    end;

  edFirst.SetFocus;
end;

procedure TfrmEnterClientInfo.btnCancelClick(Sender: TObject);
begin
  DM.qryCustomers.Cancel;

  ModalResult := mrCancel;
end;

procedure TfrmEnterClientInfo.btnSaveClick(Sender: TObject);
begin
  if ScanningPDF417Barcode then
    exit;

  btnSave.SetFocus;
  Application.ProcessMessages;

  if trim(DM.qryCustomersCUST_FIRST.AsString) = '' then
    begin
      MessageDlg('Please enter the client firt name.', mtInformation, [mbOk], 0);
      edFirst.SetFocus;
      exit;
    end;
  
  if trim(DM.qryCustomersCUST_LAST.AsString) = '' then
    begin
      MessageDlg('Please enter the client last name.', mtInformation, [mbOk], 0);
      edLast.SetFocus;
      exit;
    end;

  if DM.qryCustomersCUST_FL_DRV_LIC.IsNull then
    btnCalcLicClick(nil);

  DM.qryCustomersCUST_LAST.AsString := trim(DM.qryCustomersCUST_LAST.AsString);
  DM.qryCustomersCUST_FIRST.AsString := trim(DM.qryCustomersCUST_FIRST.AsString);
  DM.qryCustomersCUST_GENDER.AsString := GetGender;
  DM.qryCustomersCUST_RACE.AsString := CustomerRace;
  DM.qryCustomersCUST_EYES.AsString := CustomerEyesColor;
  DM.qryCustomersCUST_HAIR.AsString := CustomerHairColor;

  DM.qryCustomersCUST_FL_DRV_LIC.AsString := CustomerDriverLicense;
  DM.qryCustomersCUST_PH_CELL.AsString := CustomerCellNumber;
  DM.qryCustomerscCustPhHome.AsString := CustomerHomePhoneNumber;
  DM.qryCustomersCCustPhBussiness.AsString := CustomerBussinessPhoneNumber;
  DM.qryCustomersCCustPhBeep.AsString := CustomerOtherPhoneNumber;

  if NewRow then
    begin
      qryCheckClient.Close;
      qryCheckClient.Params.ParamByName('CustLast').Value := DM.qryCustomersCUST_LAST.AsString;
      qryCheckClient.Params.ParamByName('CustFirst').Value := DM.qryCustomersCUST_FIRST.AsString;
      qryCheckClient.Params.ParamByName('CustDOB').Value := DM.qryCustomersCUST_DOB.AsDateTime;
      qryCheckClient.Open;

      if qryCheckClientTClients.AsInteger > 0 then
        begin
          MsgInfo('Client already exists. Please select client from search screen.');
          frmClients.edFirst.Text := DM.qryCustomersCUST_FIRST.AsString;
          frmClients.edLast.Text := DM.qryCustomersCUST_LAST.AsString;

          DM.qryCustomers.Cancel;
          frmClients.btnSearchClick(nil);

          Close;
          exit;
        end;
    end;

  DM.qryCustomers.Post;
//  DM.qryCustomers.Refresh;
//  DM.qryCustomers.ApplyUpdates;
//  DM.qryCustomers.Refresh;
  ModalResult := mrOK;
end;

procedure TfrmEnterClientInfo.btnCalcLicClick(Sender: TObject);
begin
//   DM.qryCustomersCUST_FL_DRV_LIC.AsString := FloridaLic(DM.qryCustomersCUST_LAST.AsString,
//                                                     DM.qryCustomersCUST_FIRST.AsString,
//                                                     DM.qryCustomersCUST_MID.AsString,
//                                                     DM.qryCustomersCUST_DOB.AsDateTime,
//                                                     GetGender);
end;

procedure TfrmEnterClientInfo.txtFlDrvLicAfterEnter(Sender: TObject);
begin
  if DM.qryCustomersCUST_FL_DRV_LIC.IsNull then
    btnCalcLicClick(nil);
end;

procedure TfrmEnterClientInfo.TimerForScanTimer(Sender: TObject);
begin
  if (LastDataCount= 0) or (LastDataCount <> ScanData.Count) then
    begin
      LastDataCount := ScanData.Count;
    end
  else
    begin
      Screen.Cursor := crDefault;

      ScanningPDF417Barcode := false;
      TimerForScan.Enabled := false;

      ProcessAndShowBarcodeData;

      cbRace.SetFocus;
    end;
end;

procedure TfrmEnterClientInfo.TimerScanningTimeOutTimer(Sender: TObject);
begin
  PostMessage(Handle, sx_ProcessCardScanning, 0, 0);
end;

procedure TfrmEnterClientInfo.AddToKeyQueue(Key: Word);
begin
  LastThreeKeys[1] := LastThreeKeys[2];
  LastThreeKeys[2] := Key;
end;

function TfrmEnterClientInfo.MatchLastKeys(KeyPattern: TKeyQueue): boolean;
begin
  Result := (LastThreeKeys[1] = KeyPattern[1]) and (LastThreeKeys[2] = KeyPattern[2]);
end;

procedure TfrmEnterClientInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   AddToKeyQueue(Key);
  if not ScanningCard then
    begin
      PreHeaderDetected := MatchLastKeys(CardHeader);  ///Preheader detected
      ReadingCardBuffer := '';
    end
  else if MatchLastKeys(CardNewLine) then
    begin
      inc(CardScanNewLineCounter);

      if CardScanNewLineCounter = 3 then
        begin
          CardScanNewLineCounter := 0;
          PostMessage(Handle, sx_ProcessCardScanning, 0, 0); //End Of Scanning Detected
        end;
    end;
end;

procedure TfrmEnterClientInfo.ProcessKeyForMagneticScan(var Key: Char);
const
  StartCard = '%';
begin
  if PreHeaderDetected and (Key = StartCard) and not ScanningCard then
    begin
      PreHeaderDetected := false; //Reset Start Flag
      ScanningCard := true;
      TimerScanningTimeOut.Enabled := true;
      Key := #0;
    end
  else if ScanningCard then
    begin
      ReadingCardBuffer := ReadingCardBuffer + Key;
      Key := #0;
    end
  else
    begin
      PreHeaderDetected := false;
    end;
end;

{procedure TfrmEnterClientInfo.FinishPDF417BarcodeScanning;
var
  DrvLic: TDriverLicenseInfo;
begin
  Screen.Cursor := crDefault;

  ScanningPDF417Barcode := false;
  ParseScanBarcodeData(ScanData, DrvLic);
  PopulateFieldsWithDrvLicInfo(DrvLic);
end;

procedure TfrmEnterClientInfo.ProcessKeyForPDF417barcodeScan(var Key: Char);
var
  LastChars: String;
  ListLen: integer;
begin
  if ScanningPDF417Barcode then   ///// FINISH //////
    begin
      ScanData.Add(Key);
      Key := #0;
      if ScanData.Count > 2 then
        begin
          ListLen := ScanData.Count;
          if (ScanData[ListLen - 2] = #13) and (ScanData[ListLen - 1] = #13) then
            begin
               FinishPDF417BarcodeScanning;
            end;
        end;
    end
  else
    begin   ///// START ////////
      LastChars := GetLastSevenReadChars(Key, ReadChars);

      if LastChars = USA_DrvLic_Header_PDF417 then
        begin
          Screen.Cursor := crHourGlass;

          TimerScanningTimeOut.Enabled := true;

          ScanningPDF417Barcode := true;

          ScanData.Add(LastChars[1]);
          ScanData.Add(LastChars[2]);
          ScanData.Add(LastChars[3]);
          ScanData.Add(LastChars[4]);
          ScanData.Add(LastChars[5]);
          ScanData.Add(LastChars[6]);

        end;
    end
end;}

procedure TfrmEnterClientInfo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  ProcessKeyForMagneticScan(Key);

//  ProcessKeyForPDF417barcodeScan(Key);

  ProcessKeyForPDF417barcodeScan(Key,
                                 ScanningPDF417Barcode,
                                 ScanData,
                                 ReadChars,
                                 TimerForScan,
                                 LastDataCount);

(*
{ This is the event handler for the FORM's OnKeyPress event! }
{ You should also set the Form's KeyPreview property to True }
  if Key = #13 then   { if it's an enter key }
    begin
      if (ActiveControl is TDBMemo) then
      exit
      else
        begin { if not on a TDBGrid }
          Key := #0;                                 { eat enter key }
          Perform(WM_NEXTDLGCTL, 0, 0);              { move to next control }
        end;
    end;
*)
end;

procedure TfrmEnterClientInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DM.qryCustomers.State in [dsEdit, dsInsert] then
    DM.qryCustomers.Cancel;
end;

procedure TfrmEnterClientInfo.FormCreate(Sender: TObject);
begin
  ScanData := TScanDataList.Create;
  ScanData.Clear;

  ScanningPDF417Barcode := false;
end;

procedure TfrmEnterClientInfo.ActionScanCardExecute(Sender: TObject);
begin
  frmDriverLicCardReader := TfrmDriverLicCardReader.Create(Application);
  try
    if frmDriverLicCardReader.ShowModal = mrOK then
      begin
        DM.qryCustomersCUST_FIRST.AsString := frmDriverLicCardReader.edFirst.Text;
        DM.qryCustomersCUST_LAST.AsString := frmDriverLicCardReader.edLast.Text;
        DM.qryCustomersCUST_MID.AsString := frmDriverLicCardReader.edMiddle.Text;
        try
          DM.qryCustomersCUST_DOB.AsDateTime := StrToDate(frmDriverLicCardReader.edDOB.Text);
        except
        end;
        DM.qryCustomersCUST_ADDR.AsString :=  frmDriverLicCardReader.edAddress.Text;
        DM.qryCustomersCUST_CITY.AsString := frmDriverLicCardReader.edCity.Text;
        DM.qryCustomersCUST_STATE.AsString := frmDriverLicCardReader.edState.Text;
        DM.qryCustomersCUST_ZIP.AsString := frmDriverLicCardReader.edZIP.Text;

        DM.qryCustomersCUST_GENDER.AsString := frmDriverLicCardReader.edSex.Text;
        CustomerGender := frmDriverLicCardReader.edSex.Text;

        DM.qryCustomersCUST_HEIGHT.AsString := frmDriverLicCardReader.edHeight.Text;

        PopulateID(frmDriverLicCardReader.edDrvLic.Text, frmDriverLicCardReader.edState.Text);

//        State := trim(UpperCase(frmDriverLicCardReader.edState.Text));
//        if (State <> '') and (State = 'FL') then
//          begin
//            DM.qryCustomersCUST_FL_DRV_LIC.AsString := frmDriverLicCardReader.edDrvLic.Text;
//          end
//        else
//          begin
//            DM.qryCustomersCUST_ID.AsString := frmDriverLicCardReader.edDrvLic.Text;
//            DM.qryCustomersCUST_ID_AGENCY_STATE.AsString := State;
//            DM.qryCustomersCUST_ID_TYPE.AsString := 'DL';
//          end;

        cbRace.SetFocus;
      end;
  finally
    frmDriverLicCardReader.Free;
  end;
end;

end.
