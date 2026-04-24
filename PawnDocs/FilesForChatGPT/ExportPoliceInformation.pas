unit ExportPoliceInformation;
{$I+}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.FileCtrl,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, RzEdit, RzButton, RzRadChk,
  Vcl.ExtCtrls, RzPanel, RzShellDialogs, RzCommon, RzTabs, Vcl.Menus,
  IdComponent, IdBaseComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, Vcl.DBCtrls;

type
  TfrmExportPoliceInformation = class(TForm)
    GroupBox2: TGroupBox;
    btnExit: TBitBtn;
    qryHistTranDays: TADOQuery;
    dsHistTranDays: TDataSource;
    SaveDialog: TSaveDialog;
    PropertyStore: TRzPropertyStore;
    qryHistTranDaysExportLogID: TIntegerField;
    qryHistTranDaysExportDate: TDateTimeField;
    qryHistTranDaysFileName: TStringField;
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
    qryImagesNotExp: TADOQuery;
    qryImagesNotExpTransactionNo: TIntegerField;
    qryImagesNotExpInvItemNo: TIntegerField;
    qryImagesNotExpItemSeq: TIntegerField;
    qryImagesNotExpImagesDataNo: TIntegerField;
    qryImagesNotExpImageDesc: TStringField;
    lblNotSendPics: TLabel;
    dsImagesNotExp: TDataSource;
    qryImagesNotExpTranTicketNo: TStringField;
    popMnu: TPopupMenu;
    ViewImages1: TMenuItem;
    btnSendImages: TRzToolButton;
    qryImagesNotExpTranType: TStringField;
    qryImagesNotExpTranDate: TDateTimeField;
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
    qrySentImg: TADOQuery;
    qrySentImgImagesDataNo: TIntegerField;
    qrySentImgImageDesc: TStringField;
    qrySentImgUploadTime: TDateTimeField;
    qrySentImgUploadFileName: TStringField;
    dsSentImg: TDataSource;
    popMnu2: TPopupMenu;
    MenuItem1: TMenuItem;
    TabSheet3: TRzTabSheet;
    Button1: TButton;
    qryExpLogDetail: TADOQuery;
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
    qryGetItemNo: TADOQuery;
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
  private
    procedure RefreshHistory;
    function ValidateExpPath(var ExpPath: string): boolean;
    procedure DisableBtns(DisableBtn: boolean);
    procedure ShowItemPics(ImagesDataNo: integer);
    function GetInvItemNo(TransactionNo, ItemSeq: integer): integer;
    procedure UpdateExportLogFileDetail_InvItemNo_ItemSeq(ID, ItemSeq,
      InvItemNo: integer);
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
    ImgFileName := DM_LeadsOnline.GetLeadsOnlineFileName(DM.qryStoreLeadsStoreId.AsString, qryImagesNotExpTranType.AsString,
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

procedure TfrmExportPoliceInformation.btnSendImagesClick(Sender: TObject);
var
  ImgFileName, TempImgPath: string;
  ImgTxResult: string;
  i, TotalImg: integer;
  ErrorInTx: boolean;
begin
  ErrorInTx := false;
  MemoTxResult.Lines.Clear;
  TempImgPath := GetWindowsTempDir;

  if qryImagesNotExp.RecordCount = 0 then
    exit;

  btnSendImages.Enabled := false;
  try
    FTP.Host := DM.qryStoreLeadsOnlineFTPAddress.AsString ;//'ftp.leadsonline.com';
    FTP.Username := DM.qryStoreLeadsOnlineUserName.AsString ;//'perezcash';
    FTP.Password := DM.qryStoreLeadsOnlinePassword.AsString ;//'cashjoyeria2';
//    FTP.Host := 'aeibarra.com';
//    FTP.Username := 'aeibarra' ;
//    FTP.Password := 'SuperKakita1019';
 //   FTP.Passive := true;

    lblFTPStatus.Caption := 'Connecting...'; Application.ProcessMessages;
    FTP.Connect;
    if DM.qryStoreFTPPassive.AsBoolean then
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

          ImgFileName := DM_LeadsOnline.GetLeadsOnlineFileName(DM.qryStoreLeadsStoreId.AsString, qryImagesNotExpTranType.AsString,
                                                               qryImagesNotExpTranDate.AsDateTime, qryImagesNotExpTranTicketNo.AsInteger,
                                                               qryImagesNotExpItemSeq.AsInteger, qryImagesNotExpImagesDataNo.AsInteger);

          DM.SaveImageToFile(qryImagesNotExpImagesDataNo.AsInteger, TempImgPath + ImgFileName);

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
  qryGetItemNo.Parameters.ParamByName('TransactionNo').Value := TransactionNo;
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
  DM.ConnDB.Execute(Format('UPDATE ExportLogFileDetail Set InvItemNo = %d, ItemSeq = %d WHERE ID = %d', [InvItemNo, ItemSeq, ID]));
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
             UpdateExportLogFileDetail_InvItemNo_ItemSeq(qryExpLogDetailID.AsInteger, InvItemNo, ItemSeq);
           end;
       end;


      qryExpLogDetail.Next;
    end;

  lblRowProgress.Caption := lblRowProgress.Caption + ' DONE!!!';
end;

procedure TfrmExportPoliceInformation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PropertyStore.Save;
end;

procedure TfrmExportPoliceInformation.FormCreate(Sender: TObject);
begin
  lblFTPStatus.Caption := '';
  lblSendImgProgress.Caption := '';
  lblFTPStatus.Caption := '';

  DM_LeadsOnline := TDM_LeadsOnline.Create(nil);

  lblProgress.Caption := '';
  lblRegenProgress.Caption := '';

  PropertyStore.Load;

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

  btnGenAndExport.Caption := 'Generate && Export' + ' this Date.';   //^M^J
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
