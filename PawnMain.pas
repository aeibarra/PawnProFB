unit PawnMain;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Vcl.Menus,
  Buttons, ExtCtrls, ImgList, ComCtrls, ToolWin, Data.DB, System.Threading,
  Data.Win.ADODB, System.ImageList, RzCommon, Vcl.ActnList, Vcl.ActnCtrls,
  System.Actions, RzButton, RzPanel, Vcl.StdCtrls,
  // FireDAC (gold-price background task uses thread-local FB connection + proc)
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DApt,
  // Web & Connection
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.URLClient,

  // JSON Parsing
  System.JSON, RzLabel
;

const
  sx_CloseEnterSale   = wm_User + 102;
  sx_RefreshGoldPrice = wm_User + 103;

type
  TfrmPawnMain = class(TForm)
    ImagesNew: TImageList;
    SaveDialog: TSaveDialog;
    qryAllData: TADOQuery;
    qryAllDataCustno: TIntegerField;
    qryAllDataCustTicketNo: TStringField;
    qryAllDataCustLast: TStringField;
    qryAllDataCustFirst: TStringField;
    qryAllDataCustMid: TStringField;
    qryAllDataCustDOB: TDateField;
    qryAllDataCustGender: TStringField;
    qryAllDataCustRace: TStringField;
    qryAllDataCustHair: TStringField;
    qryAllDataCustEyes: TStringField;
    qryAllDataCustMark: TStringField;
    qryAllDataCustWeight: TFloatField;
    qryAllDataCustHeight: TStringField;
    qryAllDataCustAddr: TStringField;
    qryAllDataCustApt: TStringField;
    qryAllDataCustCity: TStringField;
    qryAllDataCustState: TStringField;
    qryAllDataCustZip: TStringField;
    qryAllDataCustPlaceEmply: TStringField;
    qryAllDataCustFlDrvLic: TStringField;
    qryAllDataCustID: TStringField;
    qryAllDataCustIDType: TStringField;
    qryAllDataCustIDAgencyState: TStringField;
    qryAllDataCustPhHome: TStringField;
    qryAllDataCustPhBussiness: TStringField;
    qryAllDataCustPhBeep: TStringField;
    qryAllDataCustPhCell: TStringField;
    qryAllDataCustComment: TMemoField;
    qryAllDataTransactionNo: TIntegerField;
    qryAllDataCustNo_1: TIntegerField;
    qryAllDataTranDate: TDateTimeField;
    qryAllDataTranTicketNo: TStringField;
    qryAllDataTranComment: TMemoField;
    qryAllDataTranMaturity: TDateField;
    qryAllDataTranType: TStringField;
    qryAllDataTranStatus: TStringField;
    qryAllDataTranVoidDate: TDateTimeField;
    qryAllDataTranPawnAmount: TFloatField;
    qryAllDataTranInterest: TFloatField;
    qryAllDataPrincBalance: TFloatField;
    qryAllDataInsterestBalance: TFloatField;
    qryAllDataTranTime: TTimeField;
    qryAllDataInvItemNo: TIntegerField;
    qryAllDataInvItemBarcode: TStringField;
    qryAllDataInvCatNo: TIntegerField;
    qryAllDataJType: TStringField;
    qryAllDataJStyle: TStringField;
    qryAllDataJMetal: TStringField;
    qryAllDataInvItemCount: TIntegerField;
    qryAllDataNote: TStringField;
    qryAllDataSizeLength: TFloatField;
    qryAllDataWeight: TFloatField;
    qryAllDataKT: TFloatField;
    qryAllDataCreated: TDateTimeField;
    qryAllDataUnitCost: TBCDField;
    qryAllDataUnitPrice: TBCDField;
    qryAllDataInvItemStatus: TStringField;
    qryAllDataTransactionNo_1: TIntegerField;
    qryAllDataInvOriginalItemNo: TIntegerField;
    qryAllDataInvItemBrand: TStringField;
    qryAllDataSerialNumber: TStringField;
    qryAllDataOwnerAppNumber: TStringField;
    qryAllDataModelNumber: TStringField;
    qryAllDataGender: TStringField;
    qryAllDataDescription: TStringField;
    ActionListMainForm: TActionList;
    actClientPawnAndPurchase: TAction;
    actInventory: TAction;
    actLeadsOnlineExport: TAction;
    actBackup: TAction;
    pnlTabs: TPanel;
    btnTabHome: TSpeedButton;
    btnTabReports: TSpeedButton;
    btnTabSettings: TSpeedButton;
    pbUnderTabs: TPaintBox;
    btnTabClient: TSpeedButton;
    btnTabAbout: TSpeedButton;
    btnExit: TSpeedButton;
    pnHome: TRzPanel;
    btnClose: TRzToolButton;
    ToolBarHome: TRzToolbar;
    RzToolButton16: TRzToolButton;
    RzToolButton17: TRzToolButton;
    btnBackupDatabase: TRzToolButton;
    RzToolButton19: TRzToolButton;
    RzToolButton5: TRzToolButton;
    pnClients: TRzPanel;
    RzToolButton1: TRzToolButton;
    ToolbarClients: TRzToolbar;
    RzToolButton6: TRzToolButton;
    RzToolButton7: TRzToolButton;
    RzSpacer2: TRzSpacer;
    RzToolButton8: TRzToolButton;
    RzToolButton9: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzToolButton10: TRzToolButton;
    RzToolButton11: TRzToolButton;
    pnReports: TRzPanel;
    RzToolButton2: TRzToolButton;
    ToolbarReports: TRzToolbar;
    RzToolButton12: TRzToolButton;
    RzToolButton13: TRzToolButton;
    RzToolButton14: TRzToolButton;
    btnExportPawnData: TRzToolButton;
    RzSpacer4: TRzSpacer;
    btnQuickExport: TRzToolButton;
    pnSettings: TRzPanel;
    RzToolButton3: TRzToolButton;
    ToolbarSettings: TRzToolbar;
    btnSelectPrinters: TRzToolButton;
    btnLeadsOnlineFTPParams: TRzToolButton;
    btnDefaultMaturityMonth: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton4: TRzToolButton;
    RzToolButton20: TRzToolButton;
    RzToolButton21: TRzToolButton;
    RzToolButton22: TRzToolButton;
    RzToolButton23: TRzToolButton;
    Timer15Min: TTimer;
    RichEditGLdPrice: TRichEdit;
    btnShowGoldPrice: TRzToolButton;
    RzSpacer5: TRzSpacer;
    btnTransactionList: TRzToolButton;
    RzSpacer6: TRzSpacer;
    btnExportImages: TRzToolButton;
    procedure FormShow(Sender: TObject);
    procedure Jewel1Click(Sender: TObject);
    procedure JewelType1Click(Sender: TObject);
    procedure JewelStyle1Click(Sender: TObject);
    procedure JewelStoneShape1Click(Sender: TObject);
    procedure JewelStoneColor1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure BarcodePrinter1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure Report1Click(Sender: TObject);
    procedure ListofnewPawns1Click(Sender: TObject);
    procedure PurchaseTransactions1Click(Sender: TObject);
    procedure ExportTransactionInformation1Click(Sender: TObject);
    procedure actClientPawnAndPurchaseExecute(Sender: TObject);
    procedure actInventoryExecute(Sender: TObject);
    procedure actLeadsOnlineExportExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actBackupExecute(Sender: TObject);
    procedure btnTabHomeMouseEnter(Sender: TObject);
    procedure btnTabHomeMouseLeave(Sender: TObject);
    procedure btnTabHomeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSelectPrintersClick(Sender: TObject);
    procedure btnLeadsOnlineFTPParamsClick(Sender: TObject);
    procedure btnDefaultMaturityMonthClick(Sender: TObject);
    procedure btnQuickExportClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnTabAboutClick(Sender: TObject);
    procedure Timer15MinTimer(Sender: TObject);
    procedure btnShowGoldPriceClick(Sender: TObject);
    procedure btnTransactionListClick(Sender: TObject);
    procedure btnExportImagesClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pbUnderTabsPaint(Sender: TObject);
  private
    SaveOriPaintboxColor: TColor;
    procedure SelectTab(const ATab: string);    { design-time actions }
    procedure RefreshGoldPrice(var Msg: TMessage); Message sx_RefreshGoldPrice;
    procedure InitializeImageStorage;
  public
    { Public declarations }
  end;

var
  frmPawnMain: TfrmPawnMain;

implementation

Uses PawnSplash, PawnDM, SearchClient, PawnGlobal, Inventory,
  MaintenanceJewle, SetupBarcodePrinter,
  MaintenanceJTypes, BackupDB, TransactionList, ExportPoliceInformation,
  Report01, Report02, RepPurchases, GLbUtils, ReportExportTransactions,
  SetDefaultMaturityMonth, LeadsOnlineFTPParams, ImagesStorageSettings,
  BackupInProgress, uPawnDialogs;

{$R *.DFM}

procedure CleanPaintBox(pb: TPaintBox; pColor:  TColor);
begin
  pb.Canvas.Brush.Color := pColor;
  pb.Canvas.FillRect(pb.ClientRect);
end;

procedure PaintUnderLine(pCanvas: TCanvas; pLeft, pTop: integer; pColor:  TColor);
const
  lineW = 56;
  lineH = 2;
begin
  pCanvas.Brush.Color := pColor;
  pCanvas.FillRect(Rect(pLeft, pTop, pLeft + lineW, pTop + lineH));
end;

procedure TfrmPawnMain.SelectTab(const ATab: string);
begin
  // buttons down state
  btnTabHome.Down    := SameText(ATab, 'Home');
  btnTabClient.Down   := SameText(ATab, 'Clients');
  btnTabReports.Down := SameText(ATab, 'Reports');
  btnTabSettings.Down   := SameText(ATab, 'Settings');

  // toolbars visibility
  pnHome.Visible    := SameText(ATab, 'Home');
  pnClients.Visible := SameText(ATab, 'Clients');
  pnReports.Visible := SameText(ATab, 'Reports');
  pnSettings.Visible := SameText(ATab, 'Settings');

end;

procedure TfrmPawnMain.ExportTransactionInformation1Click(Sender: TObject);
begin
  frmReportExportTransactions := TfrmReportExportTransactions.Create(Self);
  try
    frmReportExportTransactions.ShowModal;
  finally
    frmReportExportTransactions.Free;
  end;
end;

procedure TfrmPawnMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  DM.qryBackupSetings.Open;
  if not DM.qryBackupSetingsAutoBackupWhenCloseApp.AsBoolean or not IsLocalDatabase then
    exit;

  CanClose := true;
  try
    frmBackupInProgress := TfrmBackupInProgress.Create(Self);
    try
      frmBackupInProgress.Show;
      frmBackupInProgress.lblProgress.Caption := 'Database backup in Progress...';
      Application.ProcessMessages;

      DM.qryBackupSetings.Close;
      DM.qryBackupSetings.Open;

      if DM.qryBackupSetingsAutoBackupWhenCloseApp.AsBoolean then
        begin
          DM.BackupDatabase(DM.qryBackupSetingsBackupPath.AsString);
        end;

      if (ImageStorageMode = ImageStorageMode_File) and (DM.qryBackupSetingsBackupImagesPath.AsString <> '') and DirectoryExists(DM.qryBackupSetingsBackupImagesPath.AsString) then
        begin
          frmBackupInProgress.lblProgress.Caption := 'Images backup in Progress...';
          frmBackupInProgress.vImage.ImageIndex := 54;
          Application.ProcessMessages;

          var CopiedCount, SkippedCount: integer;
          var ErrorMessage: string;

          DM.BackupImagesToFolder(ImagesStoragePath, DM.qryBackupSetingsBackupImagesPath.AsString, CopiedCount, SkippedCount, ErrorMessage);
          if ErrorMessage <> '' then
            PawnError(ErrorMessage, 'Backup Images', Self);
        end;

    finally
      frmBackupInProgress.Free;
    end;
  except
    CanClose :=  false;
    MsgInfo('Unable to backup');
  end;

end;

procedure TfrmPawnMain.FormCreate(Sender: TObject);
begin
  RichEditGLdPrice.Lines.Clear;
  SaveOriPaintboxColor := pbUnderTabs.Color;
end;

procedure TfrmPawnMain.FormShow(Sender: TObject);
var
  ScaleFactor: Double;
begin
  // Scale toolbar sizing and image list for current DPI
  ScaleFactor := Screen.PixelsPerInch / 96.0;

  // If the SVG virtual image list is available at runtime, assign it to the toolbar
//  if Assigned(DM) and Assigned(DM.vilMain) then
//  begin
//    ToolBar1.Images := DM.vilMain;
//    ToolBar1.HotImages := DM.vilMain;
//  end;
//
  ToolBarHome.ButtonHeight := Round(96 * ScaleFactor);
  ToolBarHome.ButtonWidth := Round(120 * ScaleFactor);

//  // Create a modern action-based toolbar at runtime and hide the old one
//  CreateRuntimeActionToolBar;
//  if Assigned(FActionToolBar) then
//  begin
//    ToolBar1.Visible := False;
//    CoolBar1.Visible := False;
//  end;
//

  Left := Screen.WorkAreaLeft;
  Top := Screen.WorkAreaTop;

  Width := Screen.WorkAreaWidth;

  frmSplash.Free;
//  ClientsMnu.Visible := false;

//  ToolButtonbackUp.Hint := ReadIniFile(IniSecBackup, IniKeyBackupPath);

  Caption := 'Pawn ' + GetVersionInfo(ParamStr(0), '');

  Self.AutoSize := true;
  Application.ProcessMessages;
  Self.AutoSize := false;
  Application.ProcessMessages;

  { Disable backup button if database is not on local machine }
  btnBackupDatabase.Enabled := IsLocalDatabase;

  // Load saved gold price display state
  if ReadIniFile(IniSecSettings, IniKeyShowGoldPrice) = 'N' then
    begin
      btnShowGoldPrice.Down := True;
    end
  else
    begin
      btnShowGoldPrice.Down := False;
      RichEditGLdPrice.Visible := true;
      Timer15MinTimer(nil);
      Timer15Min.Enabled := true;
    end;

  InitializeImageStorage;
end;

{
procedure TfrmPawnMain.CreateRuntimeActionToolBar;
var
  btn: TToolButton;
begin
  exit;
  if Assigned(FActionToolBar) then
    Exit;

  // Ensure actions are available (create at runtime if not streamed)
  EnsureRuntimeActions;
  if not Assigned(actSearchClients) then
    Exit;

  // Create a regular TToolBar (Delphi 13 compatible) and bind actions to TToolButton
  FActionToolBar := TToolBar.Create(Self);
  FActionToolBar.Parent := Self;
  FActionToolBar.Align := alTop;
  FActionToolBar.Height := ToolBar1.Height;
  FActionToolBar.ShowCaptions := True;
  // keep the toolbar sizing in sync with the existing one
  FActionToolBar.ButtonHeight := ToolBar1.ButtonHeight;
  FActionToolBar.ButtonWidth := ToolBar1.ButtonWidth;
  // Assign the SVG virtual image list if available
  if Assigned(DM) and Assigned(DM.vilMain) then
  begin
    FActionToolBar.Images := DM.vilMain;
    // Set action image indices/names to match original toolbar DFM
    if Assigned(actSearchClients) then
    begin
      actSearchClients.ImageIndex := 1;
      actSearchClients.ImageName := 'actSearch';
    end;
    if Assigned(actInventory) then
    begin
      actInventory.ImageIndex := 11;
      actInventory.ImageName := 'actlabels1';
    end;
    if Assigned(actSale) then
    begin
      actSale.ImageIndex := 21;
      actSale.ImageName := 'actItems';
    end;
    if Assigned(actBackup) then
    begin
      actBackup.ImageIndex := 24;
      actBackup.ImageName := 'actBackup01';
    end;
    if Assigned(actExportPolice) then
    begin
      actExportPolice.ImageIndex := 25;
      actExportPolice.ImageName := 'actExportCDV';
    end;
    if Assigned(actExit) then
    begin
      actExit.ImageIndex := 12;
      actExit.ImageName := 'acrExit01';
    end;
  end;

  // Create buttons for the primary actions in order (use TToolButton and assign Action)
  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Action := actSearchClients;

  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Action := actInventory;

  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Action := actSale;

  // separator
  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Style := tbsSeparator;

  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Action := actBackup;

  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Action := actExportPolice;

  // exit button
  btn := TToolButton.Create(FActionToolBar);
  btn.Parent := FActionToolBar;
  btn.Action := actExit;
end;

procedure TfrmPawnMain.EnsureRuntimeActions;
begin
  exit;
  if Assigned(actSearchClients) then
    Exit;

  // Create the actions at runtime (owner = Form) to avoid using the protected AddAction
  actSearchClients := TAction.Create(Self);
  actSearchClients.Name := 'actSearchClients';
  actSearchClients.Caption := 'Search Clients';
  actSearchClients.OnExecute := btn_SearchClientsClick;

  actInventory := TAction.Create(Self);
  actInventory.Name := 'actInventory';
  actInventory.Caption := 'Inventory';
  actInventory.OnExecute := ToolButton1Click;

  actSale := TAction.Create(Self);
  actSale.Name := 'actSale';
  actSale.Caption := 'Sale';
  actSale.OnExecute := ToolButton3Click;

  actBackup := TAction.Create(Self);
  actBackup.Name := 'actBackup';
  actBackup.Caption := 'Backup Database';
  actBackup.OnExecute := ToolButtonbackUpClick;

  actExportPolice := TAction.Create(Self);
  actExportPolice.Name := 'actExportPolice';
  actExportPolice.Caption := 'Export Police';
  actExportPolice.OnExecute := ToolButton5Click;

//  actExit := TAction.Create(Self);
//  actExit.Name := 'actExit';
//  actExit.Caption := 'Exit';
//  actExit.OnExecute := sb_CloseClick;
end;
}
procedure TfrmPawnMain.ListofnewPawns1Click(Sender: TObject);
begin
  frmReport02 := TfrmReport02.Create(Self);
  try
    frmReport02.ShowModal;
  finally
    frmReport02.Free;
  end;
end;

procedure TfrmPawnMain.Jewel1Click(Sender: TObject);
begin
  frmMaintenanceJ := TfrmMaintenanceJ.Create(Self);
  try
    frmMaintenanceJ.Selection := 1;
    frmMaintenanceJ.ShowModal;
  finally
    frmMaintenanceJ.Free;
  end;
end;

procedure TfrmPawnMain.JewelType1Click(Sender: TObject);
begin
  frmMaintenanceJ := TfrmMaintenanceJ.Create(Self);
  try
    frmMaintenanceJ.Selection := 2;
    frmMaintenanceJ.ShowModal;
  finally
    frmMaintenanceJ.Free;
  end;
end;

procedure TfrmPawnMain.JewelStyle1Click(Sender: TObject);
begin
  frmMaintenanceJ := TfrmMaintenanceJ.Create(Self);
  try
    frmMaintenanceJ.Selection := 3;
    frmMaintenanceJ.ShowModal;
  finally
    frmMaintenanceJ.Free;
  end;
end;

procedure TfrmPawnMain.JewelStoneShape1Click(Sender: TObject);
begin
  frmMaintenanceJ := TfrmMaintenanceJ.Create(Self);
  try
    frmMaintenanceJ.Selection := 4;
    frmMaintenanceJ.ShowModal;
  finally
    frmMaintenanceJ.Free;
  end;
end;

procedure TfrmPawnMain.JewelStoneColor1Click(Sender: TObject);
begin
  frmMaintenanceJ := TfrmMaintenanceJ.Create(Self);
  try
    frmMaintenanceJ.Selection := 5;
    frmMaintenanceJ.ShowModal;
  finally
    frmMaintenanceJ.Free;
  end;
end;

procedure TfrmPawnMain.Timer15MinTimer(Sender: TObject);
begin
  PostMessage(frmPawnMain.Handle, sx_RefreshGoldPrice, 0, 0);
end;

procedure TfrmPawnMain.ToolButton2Click(Sender: TObject);
begin
{  if frmEnterSale <> nil then
    begin
      MessageDlg('Please close the sales windows first.', mtInformation, [mbOk], 0);
      frmEnterSale.BringToFront;
      exit;
    end;}

{  frmSaleTransactions := TfrmSaleTransactions.Create(Application);
  try
    frmSaleTransactions.ShowModal;
  finally
    frmSaleTransactions.Free;
  end;}
end;

procedure TfrmPawnMain.actBackupExecute(Sender: TObject);
begin
  frmBackupDB := TfrmBackupDB.Create(Self);
  try
    frmBackupDB.ShowModal;
  finally
    frmBackupDB.Free;
  end;
end;

procedure TfrmPawnMain.actClientPawnAndPurchaseExecute(Sender: TObject);
begin
  if frmClients <> nil then
    begin
     frmClients.BringToFront;
     exit;
    end;

  frmClients := TfrmClients.Create(Self);
  frmClients.Show;
end;

procedure TfrmPawnMain.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPawnMain.actInventoryExecute(Sender: TObject);
begin
  if frmInventory <> nil then
    begin
     frmInventory.BringToFront;
     exit;
    end;

  frmInventory := TfrmInventory.Create(Self);
  frmInventory.chkSale.Checked := true;
  frmInventory.Show;
end;

procedure TfrmPawnMain.actLeadsOnlineExportExecute(Sender: TObject);
begin
  frmExportPoliceInformation := TfrmExportPoliceInformation.Create(Self);
  try
    frmExportPoliceInformation.ShowModal;
  finally
    frmExportPoliceInformation.Free;
  end;
end;

procedure TfrmPawnMain.BarcodePrinter1Click(Sender: TObject);
begin
  frmSetupBarcodePrinter := TfrmSetupBarcodePrinter.Create(Self);
  try
    frmSetupBarcodePrinter.PrinterKey := IniKeyBarcode;
    frmSetupBarcodePrinter.Caption := 'Select Barcode Printer';
    frmSetupBarcodePrinter.ShowModal;
  finally
    frmSetupBarcodePrinter.Free;
  end;
end;

procedure TfrmPawnMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPawnMain.btnDefaultMaturityMonthClick(Sender: TObject);
begin
  frmSetDefaultMaturityMonth := TfrmSetDefaultMaturityMonth.Create(self);
  try
    frmSetDefaultMaturityMonth.ShowModal;
  finally
    frmSetDefaultMaturityMonth.Free;
  end;
end;

procedure TfrmPawnMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPawnMain.btnExportImagesClick(Sender: TObject);
begin
  frmImagesStorageSettings := TfrmImagesStorageSettings.Create(Self);
  try
    frmImagesStorageSettings.ShowModal;
  finally
    frmImagesStorageSettings.Free;
  end;

end;

procedure TfrmPawnMain.btnLeadsOnlineFTPParamsClick(Sender: TObject);
begin
  frmLeadsOnlineFTPParams := TfrmLeadsOnlineFTPParams.Create(Self);
  try
    frmLeadsOnlineFTPParams.ShowModal;
  finally
    frmLeadsOnlineFTPParams.Free;
  end;
end;

procedure TfrmPawnMain.btnQuickExportClick(Sender: TObject);
var
  ExpCount: integer;
begin
  if not SaveDialog.Execute then
    exit;

  Screen.Cursor := crHourGlass;
  try
    CreateCSV(SaveDialog.FileName, qryAllData, true);
    ExpCount := qryAllData.RecordCount;
  finally
    Screen.Cursor := crDefault;
  end;

  MsgInfo(IntToStr(ExpCount) + ' Records exported!');
end;

procedure TfrmPawnMain.btnSelectPrintersClick(Sender: TObject);
begin
  frmSetupBarcodePrinter := TfrmSetupBarcodePrinter.Create(Self);
  try
    frmSetupBarcodePrinter.PrinterKey := IniKeyRepPolPrn;
    frmSetupBarcodePrinter.PrinterPaymentReceiptKey := IniKeyPayReceiptPrn;
    frmSetupBarcodePrinter.Caption := 'Select Printer';
    frmSetupBarcodePrinter.ShowModal;
  finally
    frmSetupBarcodePrinter.Free;
  end;
end;

procedure TfrmPawnMain.btnShowGoldPriceClick(Sender: TObject);
begin

  if not btnShowGoldPrice.Down then
  begin // Show Gold Price
    PostMessage(Handle, sx_RefreshGoldPrice, 0, 0);
    Timer15Min.Enabled := true;
    RichEditGLdPrice.Visible := true;
  end
  else
  begin // Do not Show Gold Price
    RichEditGLdPrice.Clear;
    RichEditGLdPrice.Visible := false;
    Timer15Min.Enabled := false;
  end;

  WriteIniFile(IniSecSettings, IniKeyShowGoldPrice, YesNo[not btnShowGoldPrice.Down]);

end;

procedure TfrmPawnMain.btnTabAboutClick(Sender: TObject);
begin
  frmSplash := TfrmSplash.Create(Self);
  try
    frmSplash.LblPhone.Visible := true;
    frmSplash.LblEMail.Visible := true;
    frmSplash.lblStoreName.Visible := true;
    frmSplash.LblStoreAddr.Visible := true;
    frmSplash.lblStorePhone.Visible := true;
    frmSplash.lblClientsCount.Visible := true;
    frmSplash.lblCaptionClientsCount.Visible := true;
//    frmSplash.StVersionInfo.FileName := ''; //////////ParamStr(0);
//    frmSplash.st_Msg.Caption := 'Version ' + frmSplash.StVersionInfo.FileVersion;
    frmSplash.ShowCustomersCount;
    frmSplash.ShowModal;
  finally
    frmSplash.Free;
  end;
end;

procedure TfrmPawnMain.btnTabHomeClick(Sender: TObject);
begin
  if Sender is TSpeedButton then
    SelectTab((Sender as TSpeedButton).Caption);
  pbUnderTabs.Invalidate;  // Trigger OnPaint to draw the new active button's underline
end;

procedure TfrmPawnMain.btnTabHomeMouseEnter(Sender: TObject);
var
  Btn: TSpeedButton;
begin
  Btn := TSpeedButton(Sender);
  if Btn.Down then
    PaintUnderLine(pbUnderTabs.Canvas, Btn.Left, 1, clNavy)
  else
    PaintUnderLine(pbUnderTabs.Canvas, Btn.Left, 1, clLtGray);
end;

procedure TfrmPawnMain.btnTabHomeMouseLeave(Sender: TObject);
var
  Btn: TSpeedButton;
begin
  Btn := TSpeedButton(Sender);
  if not Btn.Down then
  begin
    PaintUnderLine(pbUnderTabs.Canvas, Btn.Left, 1, clBtnFace);
    pbUnderTabs.Invalidate;  // Trigger repaint to show the Down button's underline
  end;
end;

procedure TfrmPawnMain.btnTransactionListClick(Sender: TObject);
begin
  if frmTransactionList <> nil then
    begin
     frmTransactionList.BringToFront;
     exit;
    end;

  frmTransactionList := TfrmTransactionList.Create(Self);
  frmTransactionList.Show;
end;

procedure TfrmPawnMain.ToolButton3Click(Sender: TObject);
begin
{  if frmEnterSale <> nil then
    begin
     frmEnterSale.BringToFront;
     exit;
    end;

  DM.clnSalesTran.Close;
  DM.clnSalesTran.Params.ParamByName('FDate').AsDateTime := Now;
  DM.clnSalesTran.Params.ParamByName('TDate').AsDateTime := Now;
  DM.clnSalesTran.Open;

  frmEnterSale := TfrmEnterSale.Create(Application);
  frmEnterSale.NewRow := true;
  frmEnterSale.FromSaleList := false;
  frmEnterSale.Show;}
end;

procedure TfrmPawnMain.PurchaseTransactions1Click(Sender: TObject);
begin
   frmRepPurchases := TfrmRepPurchases.Create(Self);
   try
     frmRepPurchases.ShowModal;
   finally
     frmRepPurchases.Free;
   end
end;

procedure DisplayFormattedText(RichEdit: TRichEdit; YellowText: string; ColoredText: string; IsRed: Boolean);
begin
  RichEdit.Clear;

  // Add yellow text
  RichEdit.SelAttributes.Color := RGB(184, 134, 11);
  RichEdit.SelAttributes.Style := [fsBold];
  RichEdit.SelText := YellowText;

  // Add red or green text
  if IsRed then
    RichEdit.SelAttributes.Color := clRed
  else
    RichEdit.SelAttributes.Color := clGreen;
  RichEdit.SelAttributes.Style := [fsBold];
  RichEdit.SelText := ColoredText;

  RichEdit.ReadOnly := True;
end;

procedure TfrmPawnMain.pbUnderTabsPaint(Sender: TObject);
var
  ActiveButton: TSpeedButton;
begin
  // Clear the entire paintbox first
  CleanPaintBox(pbUnderTabs, SaveOriPaintboxColor);
  
  // Find which button is Down and paint its underline
  ActiveButton := nil;
  if btnTabHome.Down then
    ActiveButton := btnTabHome
  else if btnTabClient.Down then
    ActiveButton := btnTabClient
  else if btnTabReports.Down then
    ActiveButton := btnTabReports
  else if btnTabSettings.Down then
    ActiveButton := btnTabSettings;
  
  // Paint the blue underline for the active button
  if Assigned(ActiveButton) then
    PaintUnderLine(pbUnderTabs.Canvas, ActiveButton.Left, 1, clNavy);
end;

procedure TfrmPawnMain.RefreshGoldPrice(var Msg: TMessage);
begin
  RichEditGLdPrice.Clear;
  RichEditGLdPrice.SelAttributes.Color := clGray;
  RichEditGLdPrice.SelText := 'Loading price...';

  Application.ProcessMessages;

  TTask.Run(
    procedure
    var
      LClient: TNetHTTPClient;
      LResponse: IHTTPResponse;
      LJSON: TJSONObject;
      PricePerOunce: Double;
      TitleStatusMessage, StatusMessage: string;
      lblColorRed: boolean;
      LAsyncConn: TFDConnection;
      LSaveProc: TFDStoredProc;
    begin
      // Thread-local FB connection + stored proc, configured from the same
      // [CONNECTION_FB] params as DM.ConnFB. No shared DM components touched.
      LAsyncConn := TFDConnection.Create(nil);
      try
        DM.ConfigureFBConnectionFor(LAsyncConn);
        LAsyncConn.Connected := True;

        LClient := TNetHTTPClient.Create(nil);
        try
          LResponse := LClient.Get('https://min-api.cryptocompare.com/data/price?fsym=PAXG&tsyms=USD');

          if LResponse.StatusCode = 200 then
          begin
            LJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
            try
              PricePerOunce := LJSON.GetValue<Double>('USD');
              TitleStatusMessage := ' 24K Gold Price:';
              StatusMessage := Format(' %m per Ounce. %m per gram. ', [PricePerOunce, (PricePerOunce / 31.1034768)]);

              try
                LSaveProc := TFDStoredProc.Create(nil);
                try
                  LSaveProc.Connection := LAsyncConn;
                  LSaveProc.StoredProcName := 'SPI_GOLD_PRICE';
                  LSaveProc.Prepare;  // populates Params from FB metadata
                  LSaveProc.Params.ParamByName('PRICE_PER_OUNCE').AsCurrency := PricePerOunce;
                  LSaveProc.Params.ParamByName('CURRENCY').AsString := 'USD';
                  LSaveProc.ExecProc;
                  var LastGldPrice := LSaveProc.Params.ParamByName('LAST_G_PRICE').AsCurrency;
                  lblColorRed := LastGldPrice > PricePerOunce;
                finally
                  LSaveProc.Free;
                end;
              except
                on E: Exception do
                  StatusMessage := StatusMessage + ' (DB Save Failed: ' + E.Message + ')';
              end;

            finally
              LJSON.Free;
            end;
          end
          else
            StatusMessage := 'Error: ' + LResponse.StatusText;
        finally
          LClient.Free;
        end;
      except
        on E: Exception do
          StatusMessage := 'Error: ' + E.Message;
      end;

      try
        if LAsyncConn.Connected then
          LAsyncConn.Connected := False;
      finally
        LAsyncConn.Free;
      end;

      TThread.Synchronize(nil, procedure
      begin
       DisplayFormattedText(RichEditGLdPrice, TitleStatusMessage, StatusMessage, lblColorRed);
      end);
    end);
end;

procedure TfrmPawnMain.Report1Click(Sender: TObject);
begin
  frmReport01 := TfrmReport01.Create(Self);
  try
    frmReport01.ShowModal;
  finally
    frmReport01.Free;
  end;
end;

procedure TfrmPawnMain.InitializeImageStorage;
begin
  ImageStorageMode := ReadIniFile(IniSecImageStorage, IniKeyStorageMode);
  if ImageStorageMode = '' then
    ImageStorageMode := ImageStorageMode_Database;

  ImagesStoragePath := ReadIniFile(IniSecImageStorage, IniKeyImageDirectory);

  { Assign the correct procedures }
  if ImageStorageMode = ImageStorageMode_File then
  begin
    GetImageProc := DM.GetImageFromFile;
    SaveImageProc := DM.SaveImageToFile_FromPath;
    DeleteImageProc := DM.DeleteImageFromFile;
  end
  else
  begin
    GetImageProc := DM.GetImageFromDatabase;
    SaveImageProc := DM.SaveImageToDatabase_FromPath;
    DeleteImageProc := DM.DeleteImageFromDatabase;
  end;
end;

end.
