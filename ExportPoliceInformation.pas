unit ExportPoliceInformation;
{$I+}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.FileCtrl,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, RzEdit, RzButton, RzRadChk,
  Vcl.ExtCtrls, RzPanel, RzShellDialogs, RzCommon, RzTabs, Vcl.Menus,
  IdComponent, IdBaseComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmExportPoliceInformation = class(TForm)
    GroupBox2: TGroupBox;
    btnExit: TBitBtn;
    qryHistTranDays: TFDQuery;
    dsHistTranDays: TDataSource;
    SaveDialog: TSaveDialog;
    PropertyStore: TRzPropertyStore;
    qryHistTranDaysExportLogID: TIntegerField;
    qryHistTranDaysExportDate: TSQLTimeStampField;
    qryHistTranDaysFileName: TWideStringField;
    qryHistTranDaysItemCount: TIntegerField;
    PageControlExport: TRzPageControl;
    TabExportData: TRzTabSheet;
    TabSendImages: TRzTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    lblProgress: TLabel;
    btnSelectFolder: TSpeedButton;
    lblRegenProgress: TLabel;
    DBGrid1: TDBGrid;
    gbExportTranSelection: TGroupBox;
    rbExportDateRange: TRzRadioButton;
    rbExportNotExportedTran: TRzRadioButton;
    pnDateRange: TRzPanel;
    Label1: TLabel;
    Label3: TLabel;
    edFDate: TRzDateTimeEdit;
    edTDate: TRzDateTimeEdit;
    chkLimitRows: TRzCheckBox;
    pnRowLimit: TRzPanel;
    edLimitRows: TRzNumericEdit;
    edExportFolder: TLabeledEdit;
    btnGenAndExport: TRzBitBtn;
    GroupBox3: TGroupBox;
    qryImagesNotExp: TFDQuery;
    qryImagesNotExpTransactionNo: TIntegerField;
    qryImagesNotExpInvItemNo: TIntegerField;
    qryImagesNotExpItemSeq: TIntegerField;
    qryImagesNotExpImagesDataNo: TIntegerField;
    qryImagesNotExpImageDesc: TWideStringField;
    lblNotSendPics: TLabel;
    dsImagesNotExp: TDataSource;
    qryImagesNotExpTranTicketNo: TWideStringField;
    popMnu: TPopupMenu;
    ViewImages1: TMenuItem;
    btnSendImages: TRzToolButton;
    qryImagesNotExpTranType: TWideStringField;
    qryImagesNotExpTranDate: TDateField;
    MemoTxResult: TMemo;
    FTP: TIdFTP;
    lblFTPStatus: TLabel;
    lblSendImgProgress: TLabel;
    Label4: TLabel;
    chkShowTxDetail: TCheckBox;
    pgItemPics: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    qrySentImg: TFDQuery;
    qrySentImgImagesDataNo: TIntegerField;
    qrySentImgImageDesc: TWideStringField;
    qrySentImgUploadTime: TSQLTimeStampField;
    qrySentImgUploadFileName: TWideStringField;
    dsSentImg: TDataSource;
    popMnu2: TPopupMenu;
    MenuItem1: TMenuItem;
    TabSheet3: TRzTabSheet;
    Button1: TButton;
    qryExpLogDetail: TFDQuery;
    btnOpen: TButton;
    dsExpLogDetail: TDataSource;
    qryExpLogDetailID: TIntegerField;
    qryExpLogDetailExportLogID: TIntegerField;
    qryExpLogDetailTransactionNo: TIntegerField;
    qryExpLogDetailExportLine: TMemoField;
    qryExpLogDetailInvItemNo: TIntegerField;
    qryExpLogDetailItemSeq: TIntegerField;
    lblItemSeq: TLabel;
    lblItemInvNo: TLabel;
    qryGetItemNo: TFDQuery;
    qryGetItemNoInvItemNo: TIntegerField;
    lblRowProgress: TLabel;
    chkFTPOnlyOne: TCheckBox;
    PopupMenuHistory: TPopupMenu;
    ReGenerateExportFile1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnGenAndExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkLimitRowsClick(Sender: TObject);
    procedure btnSelectFolderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbExportDateRangeClick(Sender: TObject);
    procedure btnExportFromDateSelectedInGridClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControlExportChange(Sender: TObject);
    procedure ViewImages1Click(Sender: TObject);
    procedure btnSendImagesClick(Sender: TObject);
    procedure qryImagesNotExpAfterOpen(DataSet: TDataSet);
    procedure FTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure FTPConnected(Sender: TObject);
    procedure FTPDisconnected(Sender: TObject);
    procedure pgItemPicsChange(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure rbExportNotExportedTranClick(Sender: TObject);
  private
    procedure RefreshHistory;
    function ValidateExpPath(var ExpPath: string): boolean;
    procedure DisableBtns(DisableBtn: boolean);
    procedure ShowItemPics(ImagesDataNo: integer);
    function GetInvItemNo(TransactionNo, ItemSeq: integer): integer;
    procedure UpdateExportLogFileDetail_InvItemNo_ItemSeq(ID, ItemSeq,
      InvItemNo: integer);
    procedure SendCustomerIdImagesForTran(TransactionNo, TicketNo: integer;
      const TranType: string; TranDate: TDateTime; const TempImgPath: string);
  public
    { Public declarations }
  end;

var
  frmExportPoliceInformation: TfrmExportPoliceInformation;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, LeadsOnlineDM, GLbUtils, ViewImage;

procedure TfrmExportPoliceInformation.btnExitClick(Sender: TObject);
begin
  Close;
end;

function TfrmExportPoliceInformation.ValidateExpPath(var ExpPath: string): boolean;
begin
  Result := false;

  if trim(edExportFolder.Text) <> '' then
    begin
      Result := true;
      ExpPath := IncludeTrailingPathDelimiter(trim(edExportFolder.Text));
      edExportFolder.Text := ExpPath;
    end;

end;

procedure TfrmExportPoliceInformation.ShowItemPics(ImagesDataNo: integer);
var
  ImgFileName: string;
begin
  frmViewImage := TfrmViewImage.Create(self);
  try
    ImgFileName := DM_LeadsOnline.GetLeadsOnlineFileName(DM.qryStoreLEADS_STORE_ID.AsString, qryImagesNotExpTranType.AsString,
                                                               qryImagesNotExpTranDate.AsDateTime, qryImagesNotExpTranTicketNo.AsInteger,
                                                               qryImagesNotExpItemSeq.AsInteger, qryImagesNotExpImagesDataNo.AsInteger);
    frmViewImage.FileName := ImgFileName;
    frmViewImage.ImagesDataNo := ImagesDataNo;
    frmViewImage.ShowModal;
  finally
    frmViewImage.Free;
  end;
end;

procedure TfrmExportPoliceInformation.ViewImages1Click(Sender: TObject);
begin
  ShowItemPics(qryImagesNotExpImagesDataNo.AsInteger);
end;

procedure TfrmExportPoliceInformation.btnExportFromDateSelectedInGridClick(Sender: TObject);
var
  ExpPath: string;
//  F: TextFile;
begin
  if qryHistTranDaysExportLogID.AsInteger = 0 then
    exit;


  if not ValidateExpPath(ExpPath) then
    exit;

  DisableBtns(true);
  try

    DM_LeadsOnline.ExportFileFromHist(lblRegenProgress, ExpPath + qryHistTranDaysFileName.AsString, qryHistTranDaysExportLogID.AsInteger);

  finally
    DisableBtns(false);
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmExportPoliceInformation.DisableBtns(DisableBtn: boolean);
begin
  btnGenAndExport.Enabled := not DisableBtn;
//  btnExportFromDateSelectedInGrid.Enabled := not DisableBtn;
end;

procedure TfrmExportPoliceInformation.btnGenAndExportClick(Sender: TObject);
var
  ExportProcType{, LimitToRowsNo}: integer;
  ExpPath: string;
begin
  if not ValidateExpPath(ExpPath) then
    exit;

  try
    DisableBtns(true);
    Screen.Cursor := crHourGlass;

    if rbExportNotExportedTran.Checked then
      ExportProcType := 1
    else if rbExportDateRange.Checked then
      ExportProcType := 2
    else
      ExportProcType := -1;

    edExportFolder.Text := IncludeTrailingPathDelimiter(trim(edExportFolder.Text));

    DM_LeadsOnline.PopulateExportDatatClient(lblProgress, ExpPath, ExportProcType, edFDate.Date, edTDate.Date, chkLimitRows.Checked, trunc(edLimitRows.Value));

    RefreshHistory;

  finally
    DisableBtns(false);
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmExportPoliceInformation.btnOpenClick(Sender: TObject);
begin
  qryExpLogDetail.Close;
  qryExpLogDetail.Open;
end;

{function SelectExportFolder(var FDir: string): boolean;
begin
  Result := false;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
      try
        Title := 'Select Directory';
        Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
        OkButtonLabel := 'Select';
        DefaultFolder := FDir;
        FileName := FDir;
        if Execute then
          begin
            FDir := IncludeTrailingPathDelimiter(FileName);
            Result := true;
          end;
      finally
        Free;
      end
  else
    if SelectDirectory('Select Directory', ExtractFileDrive(FDir), FDir, [sdNewUI, sdNewFolder]) then
      begin
        FDir := IncludeTrailingPathDelimiter(FDir);
        Result := true;
      end;
end;}

procedure TfrmExportPoliceInformation.btnSelectFolderClick(Sender: TObject);
var
  Folder: string;
begin
  if trim(edExportFolder.Text) = '' then
    Folder := 'C:\'
  else
    Folder := trim(edExportFolder.Text);

  if SelectExportFolder(Folder) then
    begin
      edExportFolder.Text := Folder;
    end;
end;

procedure TfrmExportPoliceInformation.SendCustomerIdImagesForTran(TransactionNo, TicketNo: integer;
  const TranType: string; TranDate: TDateTime; const TempImgPath: string);
var
  qryCust: TFDQuery;
  ImgFileName: string;
  ImagesDataNo: integer;
begin
  qryCust := TFDQuery.Create(nil);
  try
    qryCust.Connection := DM.ConnFB;
    // Customer ID photos (IMAGE_TYPE_NO = 1) are keyed to CUST_NO. Send each one
    // that has not yet been logged as sent for THIS transaction.
    qryCust.SQL.Text :=
      'select T3.IMAGES_DATA_NO as "ImagesDataNo" '#13#10 +
      'from TRANSACTIONS T4 '#13#10 +
      '  join IMAGES_DATA T3 on T3.IMAG_REF_TO_ROW_NO = T4.CUST_NO and T3.IMAGE_TYPE_NO = 1 '#13#10 +
      'where T4.TRANSACTION_NO = :TransactionNo '#13#10 +
      '  and not exists (select 1 from EXPORT_IMAGE_SENT S '#13#10 +
      '                  where S.TRANSACTION_NO = T4.TRANSACTION_NO '#13#10 +
      '                    and S.IMAGES_DATA_NO = T3.IMAGES_DATA_NO)';
    qryCust.Params.ParamByName('TransactionNo').AsInteger := TransactionNo;
    qryCust.Open;
    while not qryCust.Eof do
      begin
        ImagesDataNo := qryCust.FieldByName('ImagesDataNo').AsInteger;

        // Transaction-image name: no item-number component, "I" classification.
        ImgFileName := DM_LeadsOnline.GetLeadsOnlineCustIdFileName(DM.qryStoreLEADS_STORE_ID.AsString,
                         TranType, TranDate, TicketNo, ImagesDataNo);
        try
          DM.ExportImageToPath(ImagesDataNo, TempImgPath + ImgFileName);
          FTP.Put(TempImgPath + ImgFileName);
          if chkShowTxDetail.Checked then
            MemoTxResult.Lines.Add(FTP.LastCmdResult.ToString);
          DeleteFile(TempImgPath + ImgFileName);
          DM_LeadsOnline.MarkTranImageAsSent(TransactionNo, ImagesDataNo, ImgFileName);
          MemoTxResult.Lines.Add(ImgFileName + ' Ok');
        except
          on e: exception do
            MemoTxResult.Lines.Add(ImgFileName + ' Error: ' + e.Message);
        end;

        qryCust.Next;
      end;
  finally
    qryCust.Free;
  end;
end;

procedure TfrmExportPoliceInformation.btnSendImagesClick(Sender: TObject);
var
  ImgFileName, TempImgPath: string;
  ImgTxResult: string;
  i, TotalImg: integer;
  ErrorInTx: boolean;
  LastCustTranNo: integer;
begin
  ErrorInTx := false;
  LastCustTranNo := -1;
  MemoTxResult.Lines.Clear;
  TempImgPath := GetWindowsTempDir;

  if qryImagesNotExp.RecordCount = 0 then
    exit;

  btnSendImages.Enabled := false;
  try
    FTP.Host := DM.qryStoreLEADS_ONLINE_FTP_ADDRESS.AsString ;//'ftp.leadsonline.com';
    FTP.Username := DM.qryStoreLEADS_ONLINE_USER_NAME.AsString ;//'perezcash';
    FTP.Password := DM.qryStoreLEADS_ONLINE_PASSWORD.AsString ;//'cashjoyeria2';
//    FTP.Host := 'aeibarra.com';
//    FTP.Username := 'aeibarra' ;
//    FTP.Password := 'SuperKakita1019';
 //   FTP.Passive := true;

    lblFTPStatus.Caption := 'Connecting...'; Application.ProcessMessages;
    FTP.Connect;
    if DM.qryStoreFTP_PASSIVE.AsBoolean then
      begin
        FTP.Passive := true;
      end
    else
      begin
        FTP.Passive := false;
      end;

//    MemoTxResult.Lines.Add(FTP.LastCmdResult.Text.Text);

    try
      qryImagesNotExp.DisableControls;

      TotalImg := qryImagesNotExp.RecordCount;
      i := 0;
      qryImagesNotExp.First;
      while not qryImagesNotExp.Eof do
        begin
          inc(i);
          lblSendImgProgress.Caption := Format('Sending Image %d of %d', [i, TotalImg]);
          Application.ProcessMessages;

          // Once per transaction, send the customer ID photo (if any). Because we
          // drive off the item-image list, this covers only transactions that have
          // item pictures being sent, and sends the photo once per ticket.
          if qryImagesNotExpTransactionNo.AsInteger <> LastCustTranNo then
            begin
              LastCustTranNo := qryImagesNotExpTransactionNo.AsInteger;
              SendCustomerIdImagesForTran(qryImagesNotExpTransactionNo.AsInteger,
                                          qryImagesNotExpTranTicketNo.AsInteger,
                                          qryImagesNotExpTranType.AsString,
                                          qryImagesNotExpTranDate.AsDateTime,
                                          TempImgPath);
            end;

          ImgFileName := DM_LeadsOnline.GetLeadsOnlineFileName(DM.qryStoreLEADS_STORE_ID.AsString, qryImagesNotExpTranType.AsString,
                                                               qryImagesNotExpTranDate.AsDateTime, qryImagesNotExpTranTicketNo.AsInteger,
                                                               qryImagesNotExpItemSeq.AsInteger, qryImagesNotExpImagesDataNo.AsInteger);

          DM.ExportImageToPath(qryImagesNotExpImagesDataNo.AsInteger, TempImgPath + ImgFileName);

          try
            FTP.Put(TempImgPath + ImgFileName);
            MemoTxResult.Lines.Add(FTP.LastCmdResult.ToString);
            ImgTxResult := ' Ok';
            ErrorInTx := false;
          except
            on e: exception do
              begin
                ErrorInTx := true;
                ImgTxResult := ' Error: ' + e.Message;
              end;
          end;

          MemoTxResult.Lines.Add(ImgFileName + ImgTxResult);

          if not ErrorInTx then
            begin
              DeleteFile(TempImgPath + ImgFileName);

              DM_LeadsOnline.MarImageAsSent(qryImagesNotExpImagesDataNo.AsInteger, ImgFileName);
            end;


          qryImagesNotExp.Next;

          if chkFTPOnlyOne.Checked then
            Exit;

        end; //while

      qryImagesNotExp.First;

    finally
      qryImagesNotExp.EnableControls;

      FTP.Disconnect;
    end;

    lblFTPStatus.Caption := 'Finished';
    lblSendImgProgress.Caption := '';
  finally
    btnSendImages.Enabled := true;
  end;

  qryImagesNotExp.Close;
  qryImagesNotExp.Open;
      //LeadsStoreId, TranType: string; TranDate: TDatetime; TransactionNo, ItemSeq, PictureId: integer
end;

function TfrmExportPoliceInformation.GetInvItemNo(TransactionNo, ItemSeq: integer): integer;
var
  p: integer;
begin
  Result := -1;

  qryGetItemNo.Close;
  qryGetItemNo.Params.ParamByName('TransactionNo').AsInteger := TransactionNo;
  qryGetItemNo.Open;

  if (qryGetItemNo.RecordCount = 0) or qryGetItemNoInvItemNo.IsNull then
    Exit;

  p := 0;
  while not qryGetItemNo.Eof do
    begin
      inc(p);
      if p = ItemSeq then
        exit(qryGetItemNoInvItemNo.AsInteger);

      qryGetItemNo.Next;
    end;

end;

procedure TfrmExportPoliceInformation.UpdateExportLogFileDetail_InvItemNo_ItemSeq(ID, ItemSeq, InvItemNo: integer);
begin
  DM.ConnFB.ExecSQL('UPDATE EXPORT_LOG_FILE_DETAIL SET INV_ITEM_NO = :INV_ITEM_NO, ITEM_SEQ = :ITEM_SEQ WHERE ID = :ID',
                    [InvItemNo, ItemSeq, ID]);
end;

procedure TfrmExportPoliceInformation.Button1Click(Sender: TObject);
var
  ItemSeq, InvItemNo: integer;
  FldData: string;
  TotalRows: string;
begin
//  Memo1.Lines.CommaText := qryExpLogDetailExportLine.AsString;
//  ReadCSVString(false, qryExpLogDetailExportLine.AsString, OneFldNamePerLine, OneFldPerLine);
//  Memo1.Lines.Text := OneFldPerLine;
//  Memo2.Lines.Text := OneFldNamePerLine;
  if not qryExpLogDetail.Active then
    qryExpLogDetail.Open;

  TotalRows := qryExpLogDetail.RecordCount.ToString;
  qryExpLogDetail.First;
  while not qryExpLogDetail.Eof do
    begin
      lblRowProgress.Caption := IntToStr(qryExpLogDetail.RecNo) + ' of ' + TotalRows; Update;
      ReadCSVString_GetOneFieldData(false, qryExpLogDetailExportLine.AsString, 45, FldData);
      lblItemSeq.Caption := FldData;

      if TryStrToInt(FldData, ItemSeq) then
       begin
         InvItemNo := GetInvItemNo(qryExpLogDetailTransactionNo.AsInteger, ItemSeq); Update;
         if InvItemNo > 0 then
           begin
             lblItemInvNo.Caption := IntToStr(InvItemNo);
             UpdateExportLogFileDetail_InvItemNo_ItemSeq(qryExpLogDetailID.AsInteger, ItemSeq, InvItemNo);
           end;
       end;


      qryExpLogDetail.Next;
    end;

  lblRowProgress.Caption := lblRowProgress.Caption + ' DONE!!!';
end;

procedure TfrmExportPoliceInformation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // Remember the export folder in the EXE-folder ini (not the per-user temp ini)
  WriteIniFile(IniSecLeadsOnline, IniKeyLeadsOnlinePath, edExportFolder.Text);
end;

procedure TfrmExportPoliceInformation.FormCreate(Sender: TObject);
begin
  lblFTPStatus.Caption := '';
  lblSendImgProgress.Caption := '';
  lblFTPStatus.Caption := '';

  DM_LeadsOnline := TDM_LeadsOnline.Create(nil);

  lblProgress.Caption := '';
  lblRegenProgress.Caption := '';

  // The export folder now lives in the EXE-folder ini (GlobalIniFile)
  edExportFolder.Text := ReadIniFile(IniSecLeadsOnline, IniKeyLeadsOnlinePath);

  // Migration: if it's not there yet, pull the last value from the old
  // PropertyStore location (per-user temp ini) and persist it to the EXE-folder ini
  if trim(edExportFolder.Text) = '' then
    begin
      PropertyStore.Load;
      if trim(edExportFolder.Text) <> '' then
        WriteIniFile(IniSecLeadsOnline, IniKeyLeadsOnlinePath, edExportFolder.Text);
    end;

  PageControlExport.ActivePageIndex := 0;
  pgItemPics.ActivePageIndex := 0;

end;

procedure TfrmExportPoliceInformation.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DM_LeadsOnline);
end;

procedure TfrmExportPoliceInformation.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  btnGenAndExport.Caption := 'Generate && Export';
  edFDate.Date := Date;
  edTDate.Date := Date;

  RefreshHistory;
  PageControlExportChange(nil);
//  qryHistTranDays.Open;
end;

procedure TfrmExportPoliceInformation.FTPConnected(Sender: TObject);
begin
  if chkShowTxDetail.Checked then
    MemoTxResult.Lines.Add('Connected');
end;

procedure TfrmExportPoliceInformation.FTPDisconnected(Sender: TObject);
begin
  if chkShowTxDetail.Checked then
    MemoTxResult.Lines.Add('Disconected');
end;

procedure TfrmExportPoliceInformation.FTPStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
  lblFTPStatus.Caption := AStatusText;
  if chkShowTxDetail.Checked then
    MemoTxResult.Lines.Add(AStatusText);
end;

procedure TfrmExportPoliceInformation.MenuItem1Click(Sender: TObject);
begin
  ShowItemPics(qrySentImgImagesDataNo.AsInteger);
end;

procedure TfrmExportPoliceInformation.rbExportDateRangeClick(Sender: TObject);
begin
  pnDateRange.Enabled := rbExportDateRange.Checked;
end;

procedure TfrmExportPoliceInformation.rbExportNotExportedTranClick(
  Sender: TObject);
begin
  pnDateRange.Enabled := false;

end;

procedure TfrmExportPoliceInformation.RefreshHistory;
begin
  qryHistTranDays.Close;
  qryHistTranDays.Open;
end;

procedure TfrmExportPoliceInformation.PageControlExportChange(Sender: TObject);
begin
  if PageControlExport.ActivePage = TabSendImages then
    begin
      qryImagesNotExp.Close;
      qryImagesNotExp.Open;
    end;
end;

procedure TfrmExportPoliceInformation.pgItemPicsChange(Sender: TObject);
begin
  if pgItemPics.ActivePageIndex = 1 then
    begin
      qrySentImg.Close;
      qrySentImg.Open;
    end;
end;

procedure TfrmExportPoliceInformation.qryImagesNotExpAfterOpen(
  DataSet: TDataSet);
begin
  lblNotSendPics.Caption := 'Item''s Pictures not Sent (' + qryImagesNotExp.RecordCount.ToString + ')';
end;

procedure TfrmExportPoliceInformation.chkLimitRowsClick(Sender: TObject);
begin
  pnRowLimit.Enabled := chkLimitRows.Checked;
end;

end.
