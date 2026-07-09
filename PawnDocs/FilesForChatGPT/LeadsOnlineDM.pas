unit LeadsOnlineDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Datasnap.DBClient,
  Datasnap.Provider, Vcl.StdCtrls, Forms, StrUtils;

type
  TDM_LeadsOnline = class(TDataModule)
    qryGetDataToExp: TADOQuery;
    qryGetDataToExpticket_type: TSmallintField;
    qryGetDataToExpTransactionNo: TIntegerField;
    qryGetDataToExpTranDate: TDateTimeField;
    qryGetDataToExpClerkName: TStringField;
    qryGetDataToExpTranVoided: TStringField;
    qryGetDataToExpCustLast: TStringField;
    qryGetDataToExpCustFirst: TStringField;
    qryGetDataToExpCustMid: TStringField;
    qryGetDataToExpCustAddr: TStringField;
    qryGetDataToExpCustCity: TStringField;
    qryGetDataToExpCustState: TStringField;
    qryGetDataToExpCustZip: TStringField;
    qryGetDataToExpCustDOB: TDateField;
    qryGetDataToExpCustWeight: TFloatField;
    qryGetDataToExpCustHeight: TStringField;
    qryGetDataToExpCustEyes: TStringField;
    qryGetDataToExpCustHair: TStringField;
    qryGetDataToExpCustRace: TStringField;
    qryGetDataToExpCustGender: TStringField;
    qryGetDataToExpInvItemCount: TIntegerField;
    qryGetDataToExpInvItemBrand: TStringField;
    qryGetDataToExpModelNumber: TStringField;
    qryGetDataToExpSerialNumber: TStringField;
    qryGetDataToExpDescription: TStringField;
    qryGetDataToExpNote: TStringField;
    qryGetDataToExpUnitCost: TBCDField;
    qryGetDataToExpJStyleDesc: TStringField;
    qryGetDataToExpJMetalDesc: TStringField;
    qryGetDataToExpKT: TFloatField;
    qryGetDataToExpWeight: TFloatField;
    qryGetDataToExpSizeLength: TFloatField;
    qryGetDataToExpGender: TStringField;
    clnExpData_: TClientDataSet;
    clnExpData_ticket_type: TSmallintField;
    clnExpData_TransactionNo: TIntegerField;
    clnExpData_ClerkName: TStringField;
    clnExpData_TranVoided: TStringField;
    clnExpData_CustLast: TStringField;
    clnExpData_CustFirst: TStringField;
    clnExpData_CustMid: TStringField;
    clnExpData_CustAddr: TStringField;
    clnExpData_CustCity: TStringField;
    clnExpData_CustState: TStringField;
    clnExpData_CustZip: TStringField;
    clnExpData_CustWeight: TFloatField;
    clnExpData_CustHeight: TStringField;
    clnExpData_CustEyes: TStringField;
    clnExpData_CustHair: TStringField;
    clnExpData_CustRace: TStringField;
    clnExpData_CustGender: TStringField;
    clnExpData_InvItemCount: TIntegerField;
    clnExpData_InvItemBrand: TStringField;
    clnExpData_ModelNumber: TStringField;
    clnExpData_SerialNumber: TStringField;
    clnExpData_Description: TStringField;
    clnExpData_Note: TStringField;
    clnExpData_UnitCost: TBCDField;
    clnExpData_JStyleDesc: TStringField;
    clnExpData_JMetalDesc: TStringField;
    clnExpData_KT: TFloatField;
    clnExpData_Weight: TFloatField;
    clnExpData_SizeLength: TFloatField;
    clnExpData_Gender: TStringField;
    qryGetDataToExpRowNo: TIntegerField;
    qryExportFileFormat: TADOQuery;
    prvExportFileFormat: TDataSetProvider;
    clnExportFileFormat: TClientDataSet;
    clnExportFileFormatID: TIntegerField;
    clnExportFileFormatDataFieldName: TStringField;
    clnExportFileFormatDataFieldType: TSmallintField;
    clnExportFileFormatDataFieldMaxSize: TIntegerField;
    clnExportFileFormatDataFieldCaption: TStringField;
    clnExportFileFormatDataFieldDesc: TStringField;
    clnExpData_TranDate: TStringField;
    clnExpData_CustDOB: TStringField;
    qryGetDataToExpAmountRedeemDefaultDate: TDateTimeField;
    qryGetDataToExpClientPhone: TStringField;
    qryGetDataToExpClientIdType: TStringField;
    qryGetDataToExpClientIdState: TStringField;
    qryGetDataToExpClientIdNumber: TStringField;
    qryGetDataToExpStoneType1: TStringField;
    qryGetDataToExpJStoneDesc1: TStringField;
    qryGetDataToExpJShapeDesc1: TStringField;
    qryGetDataToExpStoneNumber1: TIntegerField;
    qryGetDataToExpCT1: TFloatField;
    qryGetDataToExpStoneType2: TStringField;
    qryGetDataToExpJStoneDesc2: TStringField;
    qryGetDataToExpStoneNumber2: TIntegerField;
    qryGetDataToExpJShapeDesc2: TStringField;
    qryGetDataToExpCT2: TFloatField;
    qryGetDataToExpCustPhHome: TStringField;
    qryGetDataToExpCustPhBussiness: TStringField;
    qryGetDataToExpCustPhBeep: TStringField;
    qryGetDataToExpCustPhCell: TStringField;
    qryGetDataToExpCustFlDrvLic: TStringField;
    qryGetDataToExpCustID: TStringField;
    qryGetDataToExpCustIDType: TStringField;
    qryGetDataToExpCustIDAgencyState: TStringField;
    qryItemStones: TADOQuery;
    qryItemStonesNo: TIntegerField;
    qryItemStonesInvItemNo: TIntegerField;
    qryItemStonesStoneNo: TIntegerField;
    qryItemStonesStoneType: TStringField;
    qryItemStonesJStoneDesc: TStringField;
    qryItemStonesStoneNumber: TIntegerField;
    qryItemStonesJShapeDesc: TStringField;
    qryItemStonesCT: TFloatField;
    qryGetDataToExpInvItemNo: TIntegerField;
    qryGetDataToExpTranTicketNo: TStringField;
    spCreateExpLog: TADOStoredProc;
    qryInsExpLogLine: TADOQuery;
    qryUpdItemCount: TADOQuery;
    qryRegenExportFile: TADOQuery;
    qryRegenExportFileID: TIntegerField;
    qryRegenExportFileExportLogID: TIntegerField;
    qryRegenExportFileTransactionNo: TIntegerField;
    qryRegenExportFileExportLine: TMemoField;
    qryExpImgMarkAsSent: TADOQuery;
    qryGetDataToExpCustPlaceEmply: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryGetDataToExpCalcFields(DataSet: TDataSet);
  private
    LastTransactionNo, ItemSeq: integer;
    SaveExportQry: String;
    function ProcessOneLine: string;
    function GetFileHeader: string;
    procedure InstExpLogLine(ExportLogID, TransactionNo, InvItemNo, ItemSeq: integer; const ExportLine: string);
    function GetExportFileName(Folder: string): string;
  public
    procedure PopulateExportDatatClient(var lbl: TLabel; const ExportFolder: string;
     ExportProcType: integer; FromDate, ToDate: TDateTime; LimitRows: boolean; LimitToRowsNo: integer);
    procedure ExportFileFromHist(var lbl: TLabel; FileName: string; ExportLogID: integer);
    function GetLeadsOnlineFileName(LeadsStoreId, TranType: string; TranDate: TDatetime; TransactionNo, ItemSeq, PictureId: integer): string;
    procedure MarImageAsSent(ImagesDataNo: integer; const UploadFileName: string);
  end;

var
  DM_LeadsOnline: TDM_LeadsOnline;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses PawnDM, GLbUtils, PawnGlobal;

{$R *.dfm}

const
  Str_EOL = ^M^J;

procedure TDM_LeadsOnline.DataModuleCreate(Sender: TObject);
begin
  SaveExportQry := qryGetDataToExp.SQL.Text;
  clnExportFileFormat.Close;
  clnExportFileFormat.Open;
end;

function DoubleQuoteIfComma(const S: string): string;
begin
  Result := ReplaceStr(S, '"', '-');

  if (pos(',', Result) > 0) or (pos(';', Result) > 0) then
    Result := '"' + Result + '"';
end;

function TDM_LeadsOnline.ProcessOneLine: string;
var
  FieldStr: string;
begin
  Result := '';

  if LastTransactionNo <> qryGetDataToExpTransactionNo.AsInteger then
    begin
      LastTransactionNo := qryGetDataToExpTransactionNo.AsInteger;
      ItemSeq := 1;
    end
  else
    begin
      inc(ItemSeq);
    end;

  clnExportFileFormat.First;
  while not clnExportFileFormat.Eof do
    begin
      FieldStr := '';
      if clnExportFileFormatDataFieldName.AsString <> 'NONE' then
        begin
          if clnExportFileFormatDataFieldType.AsInteger = 1 then //1 - Numeric
            begin
              FieldStr := qryGetDataToExp.FieldByName(clnExportFileFormatDataFieldName.AsString).AsString;
            end
          else if clnExportFileFormatDataFieldType.AsInteger = 2 then //2 - String(25)
            begin
              FieldStr := Copy(qryGetDataToExp.FieldByName(clnExportFileFormatDataFieldName.AsString).AsString, 1, clnExportFileFormatDataFieldMaxSize.AsInteger);
            end
          else if clnExportFileFormatDataFieldType.AsInteger = 3 then //Datetime Field mm/dd/yyyy hh:mm:ss
            begin
              FieldStr := FormatDateTime('mm/dd/yyyy hh:nn:ss', qryGetDataToExp.FieldByName(clnExportFileFormatDataFieldName.AsString).AsDateTime);
            end
          else if clnExportFileFormatDataFieldType.AsInteger = 4 then //4 - Date mm/dd/yyyy
            begin
              FieldStr := FormatDateTime('mm/dd/yyyy', qryGetDataToExp.FieldByName(clnExportFileFormatDataFieldName.AsString).AsDateTime);
            end
          else if clnExportFileFormatDataFieldType.AsInteger = 5 then //5 - Data Length f'ii"
            begin
              FieldStr := qryGetDataToExp.FieldByName(clnExportFileFormatDataFieldName.AsString).AsString;
            end
          else if clnExportFileFormatDataFieldType.AsInteger = 6 then //6 - Item Number Counter
            begin
              FieldStr := ItemSeq.ToString();
            end
          else if clnExportFileFormatDataFieldType.AsInteger = 7 then //7 - Constant
            begin
              FieldStr := clnExportFileFormatDataFieldName.AsString;
            end;
        end; //IF NONE

      Result := Result + DoubleQuoteIfComma(FieldStr) + ',';

      clnExportFileFormat.Next;
    end; //while

  if Result <> '' then
    Result := Copy(Result, 1, length(Result) - 1);

end;

procedure TDM_LeadsOnline.qryGetDataToExpCalcFields(DataSet: TDataSet);
var
  ClientPhone: string;
begin
  if trim(qryGetDataToExpCustPhCell.AsString) <> '' then
    ClientPhone := trim(qryGetDataToExpCustPhCell.AsString)
  else if trim(qryGetDataToExpCustPhHome.AsString) <> '' then
    ClientPhone := trim(qryGetDataToExpCustPhHome.AsString)
  else if trim(qryGetDataToExpCustPhBussiness.AsString) <> '' then
    ClientPhone := trim(qryGetDataToExpCustPhBussiness.AsString)
  else if trim(qryGetDataToExpCustPhBeep.AsString) <> '' then
    ClientPhone := trim(qryGetDataToExpCustPhBeep.AsString);

  qryGetDataToExpClientPhone.AsString := ClientPhone;

  if trim(qryGetDataToExpCustFlDrvLic.AsString) <> '' then
    begin
      qryGetDataToExpClientIdType.AsString := 'Driver License';
      qryGetDataToExpClientIdState.AsString := 'Florida';
      qryGetDataToExpClientIdNumber.AsString := trim(qryGetDataToExpCustFlDrvLic.AsString);
    end
  else
    begin
      qryGetDataToExpClientIdType.AsString := qryGetDataToExpCustIDType.AsString;
      qryGetDataToExpClientIdState.AsString := qryGetDataToExpCustIDAgencyState.AsString;
      qryGetDataToExpClientIdNumber.AsString := trim(qryGetDataToExpCustID.AsString);
    end;

  qryGetDataToExpAmountRedeemDefaultDate.AsDateTime := DM.CalcPawnDefaultDate(qryGetDataToExpTranDate.AsDateTime, DM.qryStorePawnDefaultMonths.AsInteger);

  qryItemStones.Close;
  qryItemStones.Parameters.ParamByName('InvItemNo').Value := qryGetDataToExpInvItemNo.AsInteger;
  qryItemStones.Open;

  while not qryItemStones.Eof do
    begin
      if qryItemStonesNo.AsInteger = 1 then
        begin
          qryGetDataToExpStoneType1.AsString := qryItemStonesStoneType.AsString;
          qryGetDataToExpJStoneDesc1.AsString := qryItemStonesJStoneDesc.AsString;
          qryGetDataToExpStoneNumber1.AsInteger := qryItemStonesStoneNumber.AsInteger;
          qryGetDataToExpJShapeDesc1.AsString := qryItemStonesJShapeDesc.AsString;
          qryGetDataToExpCT1.AsFloat := qryItemStonesCT.AsFloat;
        end
      else if qryItemStonesNo.AsInteger = 2 then
        begin
          qryGetDataToExpStoneType2.AsString := qryItemStonesStoneType.AsString;
          qryGetDataToExpJStoneDesc2.AsString := qryItemStonesJStoneDesc.AsString;
          qryGetDataToExpStoneNumber2.AsInteger := qryItemStonesStoneNumber.AsInteger;
          qryGetDataToExpJShapeDesc2.AsString := qryItemStonesJShapeDesc.AsString;
          qryGetDataToExpCT2.AsFloat := qryItemStonesCT.AsFloat;
        end
      else
        Break;

      qryItemStones.Next;
    end;
end;

function TDM_LeadsOnline.GetFileHeader: string;
begin
  Result := '';
  clnExportFileFormat.First;
  while not clnExportFileFormat.Eof do
    begin
      Result := Result + clnExportFileFormatDataFieldCaption.AsString + ',';
      clnExportFileFormat.Next;
    end;

  Result := Copy(Result, 1, Length(Result) - 1);
end;

procedure TDM_LeadsOnline.InstExpLogLine(ExportLogID, TransactionNo, InvItemNo, ItemSeq: integer; const ExportLine: string);
begin
  qryInsExpLogLine.Parameters.ParamByName('ExportLogID').Value := ExportLogID;
  qryInsExpLogLine.Parameters.ParamByName('TransactionNo').Value := TransactionNo;
  qryInsExpLogLine.Parameters.ParamByName('InvItemNo').Value := InvItemNo;
  qryInsExpLogLine.Parameters.ParamByName('ItemSeq').Value := ItemSeq;
  qryInsExpLogLine.Parameters.ParamByName('ExportLine').Value := ExportLine;
  qryInsExpLogLine.ExecSQL;
end;

function TDM_LeadsOnline.GetExportFileName(Folder: string): string;
var
  FCounter: integer;
begin
  FCounter := 1;
  repeat
    Result := 'Export' + FormatDateTime('_yyyy_mm_dd_', Date) + Format('%.2d', [FCounter]) + '.csv';
    inc(FCounter);
  until not FileExists(Folder + Result);
end;

procedure TDM_LeadsOnline.PopulateExportDatatClient(var lbl: TLabel; const ExportFolder: string;
     ExportProcType: integer; FromDate, ToDate: TDateTime; LimitRows: boolean; LimitToRowsNo: integer);
var
  Line: string;
  FileTextData: string;
  i, ExportLogID: integer;
  ExportFileName: string;
  CurrSQLText: string;
begin
  lbl.Caption := '';

  qryGetDataToExp.Close;

  if ExportProcType = 1 then //Export not exported Transactions
    begin
      CurrSQLText := ReplaceStr(SaveExportQry, '--<FILTER>', 'and not Exists(select * from ExportLogFileDetail T01 where T01.TransactionNo = T1.TransactionNo)');

      if LimitRows then
        CurrSQLText := ReplaceStr(CurrSQLText, '--<LIMIT_ROWS>', 'TOP ' + LimitToRowsNo.ToString());

    end
  else if ExportProcType = 2 then //Date Range
    begin
      CurrSQLText := ReplaceStr(SaveExportQry, '--<FILTER>', ' AND T1.TranDate BETWEEN ' + AsaDateToStr(FromDate) + ' AND ' + AsaDateToStr(ToDate) + ' ');
    end
  else
    begin
      exit;
    end;

  qryGetDataToExp.SQL.Text := CurrSQLText;
  qryGetDataToExp.Open;

  if qryGetDataToExp.RecordCount = 0 then
    begin
      MsgInfo('No Data found to export.');
      exit;
    end;

  lbl.Caption := '0 / ' + IntToStr(qryGetDataToExp.RecordCount);
  Application.ProcessMessages;

  ExportFileName := GetExportFileName(ExportFolder);
  spCreateExpLog.Parameters.ParamByName('@FileName').Value := ExportFileName;
  spCreateExpLog.ExecProc;
  ExportLogID := spCreateExpLog.Parameters.ParamByName('@ExportLogID').Value;

  LastTransactionNo := -1;
  i := 0;
  FileTextData := GetFileHeader + Str_EOL;

  while not qryGetDataToExp.Eof do
    begin
      inc(i);
      lbl.Caption := i.ToString() + ' / ' + IntToStr(qryGetDataToExp.RecordCount);
      Application.ProcessMessages;

      Line := ProcessOneLine + Str_EOL;

      FileTextData := FileTextData + Line;

      InstExpLogLine(ExportLogID, qryGetDataToExpTransactionNo.AsInteger, qryGetDataToExpInvItemNo.AsInteger, ItemSeq, Line);

      qryGetDataToExp.Next;
    end;

  qryUpdItemCount.Parameters.ParamByName('ItemCount').Value := i;
  qryUpdItemCount.Parameters.ParamByName('ExportLogID').Value := ExportLogID;
  qryUpdItemCount.ExecSQL;

  WriteTextFile(ExportFolder + ExportFileName, FileTextData);
end;

procedure TDM_LeadsOnline.ExportFileFromHist(var lbl: TLabel; FileName: string; ExportLogID: integer);
var
  F: TextFile;
  RecCountStr, HeaderStr: string;
begin
  qryRegenExportFile.Close;
  qryRegenExportFile.Parameters.ParamByName('ExportLogID').Value := ExportLogID;
  qryRegenExportFile.Open;

  if qryRegenExportFile.RecordCount = 0 then
    begin
      MsgInfo('No Data found in selected export');
      exit;
    end;

 ///MsgInfo(FileName);

  AssignFile(F, FileName);
  Rewrite(F);
  try
    RecCountStr := qryRegenExportFile.RecordCount.ToString();

    clnExportFileFormat.Open;

    HeaderStr := GetFileHeader + Str_EOL;
    Write(F, HeaderStr);

    while not qryRegenExportFile.Eof do
      begin
        lbl.Caption := IntToStr(qryRegenExportFile.RecNo) + ' of ' + RecCountStr;
        Application.ProcessMessages;

        Write(F, qryRegenExportFileExportLine.AsString);

        qryRegenExportFile.Next;
      end;

    clnExportFileFormat.Close;

  finally
    CloseFile(F);
  end;

end;

function TDM_LeadsOnline.GetLeadsOnlineFileName(LeadsStoreId, TranType: string; TranDate: TDatetime; TransactionNo, ItemSeq, PictureId: integer): string;
var
  Tran: string;
begin
  if TranType = 'P' then
    Tran := 'P'
  else if TranType = 'U' then
    Tran := 'B';

  Result := 'IMG_AN' + Tran + '_' + LeadsStoreId + '_' + FormatDateTime('yyyymmdd', TranDate) + '_' + TransactionNo.ToString + '_' +
             Format('%.2d', [ItemSeq]) + '_' + Format('%.3d', [PictureId]) + '.JPG';
end;

procedure TDM_LeadsOnline.MarImageAsSent(ImagesDataNo: integer; const UploadFileName: string);
begin
  qryExpImgMarkAsSent.Parameters.ParamByName('UploadFileName').Value := UploadFileName;
  qryExpImgMarkAsSent.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  qryExpImgMarkAsSent.ExecSQL;
end;

end.
