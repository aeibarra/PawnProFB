unit LeadsOnlineDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Vcl.StdCtrls, Forms, StrUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM_LeadsOnline = class(TDataModule)
    qryGetDataToExp: TFDQuery;
    qryGetDataToExpticket_type: TSmallintField;
    qryGetDataToExpTransactionNo: TIntegerField;
    qryGetDataToExpTranDate: TDateField;
    qryGetDataToExpClerkName: TWideStringField;
    qryGetDataToExpTranVoided: TWideStringField;
    qryGetDataToExpCustLast: TWideStringField;
    qryGetDataToExpCustFirst: TWideStringField;
    qryGetDataToExpCustMid: TWideStringField;
    qryGetDataToExpCustAddr: TWideStringField;
    qryGetDataToExpCustCity: TWideStringField;
    qryGetDataToExpCustState: TWideStringField;
    qryGetDataToExpCustZip: TWideStringField;
    qryGetDataToExpCustDOB: TDateField;
    qryGetDataToExpCustWeight: TFloatField;
    qryGetDataToExpCustHeight: TWideStringField;
    qryGetDataToExpCustEyes: TWideStringField;
    qryGetDataToExpCustHair: TWideStringField;
    qryGetDataToExpCustRace: TWideStringField;
    qryGetDataToExpCustGender: TWideStringField;
    qryGetDataToExpInvItemCount: TIntegerField;
    qryGetDataToExpInvItemBrand: TWideStringField;
    qryGetDataToExpModelNumber: TWideStringField;
    qryGetDataToExpSerialNumber: TWideStringField;
    qryGetDataToExpDescription: TWideStringField;
    qryGetDataToExpNote: TWideStringField;
    qryGetDataToExpUnitCost: TFMTBCDField;
    qryGetDataToExpJStyleDesc: TWideStringField;
    qryGetDataToExpJMetalDesc: TWideStringField;
    qryGetDataToExpKT: TFloatField;
    qryGetDataToExpWeight: TFloatField;
    qryGetDataToExpSizeLength: TFloatField;
    qryGetDataToExpGender: TWideStringField;
    clnExpData_: TClientDataSet;
    clnExpData_ticket_type: TSmallintField;
    clnExpData_TransactionNo: TIntegerField;
    clnExpData_ClerkName: TWideStringField;
    clnExpData_TranVoided: TWideStringField;
    clnExpData_CustLast: TWideStringField;
    clnExpData_CustFirst: TWideStringField;
    clnExpData_CustMid: TWideStringField;
    clnExpData_CustAddr: TWideStringField;
    clnExpData_CustCity: TWideStringField;
    clnExpData_CustState: TWideStringField;
    clnExpData_CustZip: TWideStringField;
    clnExpData_CustWeight: TFloatField;
    clnExpData_CustHeight: TWideStringField;
    clnExpData_CustEyes: TWideStringField;
    clnExpData_CustHair: TWideStringField;
    clnExpData_CustRace: TWideStringField;
    clnExpData_CustGender: TWideStringField;
    clnExpData_InvItemCount: TIntegerField;
    clnExpData_InvItemBrand: TWideStringField;
    clnExpData_ModelNumber: TWideStringField;
    clnExpData_SerialNumber: TWideStringField;
    clnExpData_Description: TWideStringField;
    clnExpData_Note: TWideStringField;
    clnExpData_UnitCost: TBCDField;
    clnExpData_JStyleDesc: TWideStringField;
    clnExpData_JMetalDesc: TWideStringField;
    clnExpData_KT: TFloatField;
    clnExpData_Weight: TFloatField;
    clnExpData_SizeLength: TFloatField;
    clnExpData_Gender: TWideStringField;
    qryGetDataToExpRowNo: TIntegerField;
    qryExportFileFormat: TFDQuery;
    prvExportFileFormat: TDataSetProvider;
    clnExportFileFormat: TClientDataSet;
    clnExportFileFormatID: TIntegerField;
    clnExportFileFormatDataFieldName: TWideStringField;
    clnExportFileFormatDataFieldType: TSmallintField;
    clnExportFileFormatDataFieldMaxSize: TIntegerField;
    clnExportFileFormatDataFieldCaption: TWideStringField;
    clnExportFileFormatDataFieldDesc: TWideStringField;
    clnExpData_TranDate: TWideStringField;
    clnExpData_CustDOB: TWideStringField;
    qryGetDataToExpAmountRedeemDefaultDate: TDateTimeField;
    qryGetDataToExpClientPhone: TWideStringField;
    qryGetDataToExpClientIdType: TWideStringField;
    qryGetDataToExpClientIdState: TWideStringField;
    qryGetDataToExpClientIdNumber: TWideStringField;
    qryGetDataToExpStoneType1: TWideStringField;
    qryGetDataToExpJStoneDesc1: TWideStringField;
    qryGetDataToExpJShapeDesc1: TWideStringField;
    qryGetDataToExpStoneNumber1: TIntegerField;
    qryGetDataToExpCT1: TFloatField;
    qryGetDataToExpStoneType2: TWideStringField;
    qryGetDataToExpJStoneDesc2: TWideStringField;
    qryGetDataToExpStoneNumber2: TIntegerField;
    qryGetDataToExpJShapeDesc2: TWideStringField;
    qryGetDataToExpCT2: TFloatField;
    qryGetDataToExpCustPhHome: TWideStringField;
    qryGetDataToExpCustPhBussiness: TWideStringField;
    qryGetDataToExpCustPhBeep: TWideStringField;
    qryGetDataToExpCustPhCell: TWideStringField;
    qryGetDataToExpCustFlDrvLic: TWideStringField;
    qryGetDataToExpCustID: TWideStringField;
    qryGetDataToExpCustIDType: TWideStringField;
    qryGetDataToExpCustIDAgencyState: TWideStringField;
    qryItemStones: TFDQuery;
    qryItemStonesNo: TIntegerField;
    qryItemStonesInvItemNo: TIntegerField;
    qryItemStonesStoneNo: TIntegerField;
    qryItemStonesStoneType: TWideStringField;
    qryItemStonesJStoneDesc: TWideStringField;
    qryItemStonesStoneNumber: TIntegerField;
    qryItemStonesJShapeDesc: TWideStringField;
    qryItemStonesCT: TFloatField;
    qryGetDataToExpInvItemNo: TIntegerField;
    qryGetDataToExpTranTicketNo: TWideStringField;
    spCreateExpLog: TFDQuery;
    qryInsExpLogLine: TFDQuery;
    qryUpdItemCount: TFDQuery;
    qryRegenExportFile: TFDQuery;
    qryRegenExportFileID: TIntegerField;
    qryRegenExportFileExportLogID: TIntegerField;
    qryRegenExportFileTransactionNo: TIntegerField;
    qryRegenExportFileExportLine: TMemoField;
    qryExpImgMarkAsSent: TFDQuery;
    qryGetDataToExpCustPlaceEmply: TWideStringField;
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

  qryGetDataToExpAmountRedeemDefaultDate.AsDateTime := DM.CalcPawnDefaultDate(qryGetDataToExpTranDate.AsDateTime, DM.qryStorePAWN_DEFAULT_MONTHS.AsInteger);

  qryItemStones.Close;
  qryItemStones.Params.ParamByName('InvItemNo').AsInteger := qryGetDataToExpInvItemNo.AsInteger;
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
  qryInsExpLogLine.Params.ParamByName('ExportLogID').AsInteger := ExportLogID;
  qryInsExpLogLine.Params.ParamByName('TransactionNo').AsInteger := TransactionNo;
  qryInsExpLogLine.Params.ParamByName('InvItemNo').AsInteger := InvItemNo;
  qryInsExpLogLine.Params.ParamByName('ItemSeq').AsInteger := ItemSeq;
  qryInsExpLogLine.Params.ParamByName('ExportLine').AsString := ExportLine;
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
      CurrSQLText := ReplaceStr(SaveExportQry, '--<FILTER>', 'and not exists(select 1 from EXPORT_LOG_FILE_DETAIL T01 where T01.TRANSACTION_NO = T1.TRANSACTION_NO)');

      if LimitRows then
        CurrSQLText := ReplaceStr(CurrSQLText, '--<LIMIT_ROWS>', 'FIRST ' + LimitToRowsNo.ToString());

    end
  else if ExportProcType = 2 then //Date Range
    begin
      CurrSQLText := ReplaceStr(SaveExportQry, '--<FILTER>', ' AND T1.TRAN_DATE BETWEEN DATE ''' + FormatDateTime('yyyy-mm-dd', FromDate) + ''' AND DATE ''' + FormatDateTime('yyyy-mm-dd', ToDate) + ''' ');
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
  spCreateExpLog.Close;
  spCreateExpLog.Params.ParamByName('FileName').AsString := ExportFileName;
  spCreateExpLog.Open;
  ExportLogID := spCreateExpLog.FieldByName('ExportLogID').AsInteger;

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

  qryUpdItemCount.Params.ParamByName('ItemCount').AsInteger := i;
  qryUpdItemCount.Params.ParamByName('ExportLogID').AsInteger := ExportLogID;
  qryUpdItemCount.ExecSQL;

  WriteTextFile(ExportFolder + ExportFileName, FileTextData);
end;

procedure TDM_LeadsOnline.ExportFileFromHist(var lbl: TLabel; FileName: string; ExportLogID: integer);
var
  F: TextFile;
  RecCountStr, HeaderStr: string;
begin
  qryRegenExportFile.Close;
  qryRegenExportFile.Params.ParamByName('ExportLogID').AsInteger := ExportLogID;
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
  qryExpImgMarkAsSent.Params.ParamByName('UploadFileName').AsString := UploadFileName;
  qryExpImgMarkAsSent.Params.ParamByName('ImagesDataNo').AsInteger := ImagesDataNo;
  qryExpImgMarkAsSent.ExecSQL;
end;

end.
