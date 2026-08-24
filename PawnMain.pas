unit PawnMain;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Vcl.Menus,
  Buttons, ExtCtrls, ImgList, ComCtrls, ToolWin, Data.DB, System.Threading,
  System.ImageList, RzCommon, Vcl.ActnList, Vcl.ActnCtrls, System.Generics.Collections,
  System.Actions, System.DateUtils, RzButton, RzPanel, Vcl.StdCtrls,
  // FireDAC (gold-price background task uses a thread-local FB connection)
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DApt,
  // Web & Connection
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.URLClient,

  // JSON Parsing
  System.JSON, RzLabel, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  uImageAuditController
;

const
  sx_CloseEnterSale   = wm_User + 102;
  sx_RefreshGoldPrice = wm_User + 103;

type
  TfrmPawnMain = class(TForm)
    ImagesNew: TImageList;
    SaveDialog: TSaveDialog;
    qryAllData: TFDQuery;
    qryAllDataCustno: TIntegerField;
    qryAllDataCustTicketNo: TWideStringField;
    qryAllDataCustLast: TWideStringField;
    qryAllDataCustFirst: TWideStringField;
    qryAllDataCustMid: TWideStringField;
    qryAllDataCustDOB: TDateField;
    qryAllDataCustGender: TWideStringField;
    qryAllDataCustRace: TWideStringField;
    qryAllDataCustHair: TWideStringField;
    qryAllDataCustEyes: TWideStringField;
    qryAllDataCustMark: TWideStringField;
    qryAllDataCustWeight: TFloatField;
    qryAllDataCustHeight: TWideStringField;
    qryAllDataCustAddr: TWideStringField;
    qryAllDataCustApt: TWideStringField;
    qryAllDataCustCity: TWideStringField;
    qryAllDataCustState: TWideStringField;
    qryAllDataCustZip: TWideStringField;
    qryAllDataCustPlaceEmply: TWideStringField;
    qryAllDataCustFlDrvLic: TWideStringField;
    qryAllDataCustID: TWideStringField;
    qryAllDataCustIDType: TWideStringField;
    qryAllDataCustIDAgencyState: TWideStringField;
    qryAllDataCustPhHome: TWideStringField;
    qryAllDataCustPhBussiness: TWideStringField;
    qryAllDataCustPhBeep: TWideStringField;
    qryAllDataCustPhCell: TWideStringField;
    qryAllDataCustComment: TMemoField;
    qryAllDataTransactionNo: TIntegerField;
    qryAllDataCustNo_1: TIntegerField;
    qryAllDataTranDate: TDateField;
    qryAllDataTranTicketNo: TWideStringField;
    qryAllDataTranComment: TMemoField;
    qryAllDataTranMaturity: TDateField;
    qryAllDataTranType: TWideStringField;
    qryAllDataTranStatus: TWideStringField;
    qryAllDataTranVoidDate: TSQLTimeStampField;
    qryAllDataTranPawnAmount: TFloatField;
    qryAllDataTranInterest: TFloatField;
    qryAllDataPrincBalance: TFloatField;
    qryAllDataInsterestBalance: TFloatField;
    qryAllDataTranTime: TTimeField;
    qryAllDataInvItemNo: TIntegerField;
    qryAllDataInvItemBarcode: TWideStringField;
    qryAllDataInvCatNo: TIntegerField;
    qryAllDataJType: TWideStringField;
    qryAllDataJStyle: TWideStringField;
    qryAllDataJMetal: TWideStringField;
    qryAllDataInvItemCount: TIntegerField;
    qryAllDataNote: TWideStringField;
    qryAllDataSizeLength: TFloatField;
    qryAllDataWeight: TFloatField;
    qryAllDataKT: TFloatField;
    qryAllDataCreated: TSQLTimeStampField;
    qryAllDataUnitCost: TFMTBCDField;
    qryAllDataUnitPrice: TFMTBCDField;
    qryAllDataInvItemStatus: TWideStringField;
    qryAllDataTransactionNo_1: TIntegerField;
    qryAllDataInvOriginalItemNo: TIntegerField;
    qryAllDataInvItemBrand: TWideStringField;
    qryAllDataSerialNumber: TWideStringField;
    qryAllDataOwnerAppNumber: TWideStringField;
    qryAllDataModelNumber: TWideStringField;
    qryAllDataGender: TWideStringField;
    qryAllDataDescription: TWideStringField;
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
    // Latest fire-and-forget gold-price fetch. Held so shutdown can join it
    // before DM/FireDAC are torn down -- see WaitForGoldPriceTaskShutdown.
    FGoldPriceTask: ITask;
    FImageAuditController: TImageAuditController;
    procedure SelectTab(const ATab: string);    { design-time actions }
    procedure RefreshGoldPrice(var Msg: TMessage); Message sx_RefreshGoldPrice;
    procedure WaitForGoldPriceTaskShutdown;
    procedure WMSettingChange(var Msg: TMessage); Message WM_SETTINGCHANGE;
    procedure InitializeImageStorage;
    /// Shows or hides the LeadsOnline export entry point according to whether
    /// this store reports to LeadsOnline at all. The settings button is not
    /// affected -- it is how the feature gets turned on.
    procedure ApplyLeadsOnlineVisibility;
  protected
    procedure DoClose(var Action: TCloseAction); override;
  public
    destructor Destroy; override;
    procedure StartImageAuditIfDue;
    { Public declarations }
  end;

var
  frmPawnMain: TfrmPawnMain;

implementation

Uses PawnSplash, PawnDM, SearchClient, PawnGlobal, Inventory,
  MaintenanceJewle, SetupBarcodePrinter,
  BackupDB, TransactionList, ExportPoliceInformation,
  Report01, Report02, RepPurchases, GLbUtils, ReportExportTransactions,
  SetDefaultMaturityMonth, LeadsOnlineSettings, ImagesStorageSettings,
  BackupInProgress, uPawnDialogs, LeadsOnlineSoapExport;

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
var
  BackupPath, ImageBackupPath: string;
  DoImageBackup: Boolean;
  BackupDone: Boolean;
  SaveTimerEnabled: Boolean;
  R: TBackupResult;
begin
  CanClose := True;

  // Stop the gold-price timer before anything else. The close-on-exit backup
  // below pumps messages while it waits, so a timer tick here would spawn a
  // fresh gold-price worker at the exact moment we are trying to shut down.
  // Restored on the paths that abort the close.
  SaveTimerEnabled := Timer15Min.Enabled;
  Timer15Min.Enabled := False;

  BackupPath := '';
  ImageBackupPath := '';
  DoImageBackup := False;

  // Close-on-exit backup requires a live local database. If the DB is
  // unreachable there is nothing to back up, so never let a connection
  // failure block the user from exiting the application.
  if not IsLocalDatabase or not Assigned(DM) or not Assigned(DM.ConnFB) or
    not DM.ConnFB.Connected then
    Exit;

  try
    DM.qryBackupSetings.Open;
    try
      if not DM.qryBackupSetingsAUTO_BACKUP_WHEN_CLOSE_APP.AsBoolean then
        Exit;

      BackupPath := DM.qryBackupSetingsBACKUP_PATH.AsString;
      ImageBackupPath := DM.qryBackupSetingsBACKUP_IMAGES_PATH.AsString;
      DoImageBackup := (ImageStorageMode = ImageStorageMode_File) and
        (ImageBackupPath <> '') and DirectoryExists(ImageBackupPath);
    finally
      DM.qryBackupSetings.Close;
    end;
  except
    // Could not read backup settings (e.g. DB dropped after startup) —
    // allow the app to close rather than trapping the user.
    on E: Exception do
    begin
      CanClose := True;
      Exit;
    end;
  end;

  try
    frmBackupInProgress := TfrmBackupInProgress.Create(Self);
    try
      frmBackupInProgress.Show;
      frmBackupInProgress.lblProgress.Caption := 'Database backup in Progress...';
      Application.ProcessMessages;

      BackupDone := False;

      TTask.Run(
        procedure
        begin
          try
            DM.RunBackup(BackupPath, ImageBackupPath, DoImageBackup, R,
              procedure(Phase: TBackupPhase)
              begin
                TThread.Queue(nil,
                  procedure
                  begin
                    if not Assigned(frmBackupInProgress) then
                      Exit;
                    case Phase of
                      bpDatabase:
                        frmBackupInProgress.lblProgress.Caption := 'Database backup in Progress...';
                      bpImages:
                        begin
                          frmBackupInProgress.lblProgress.Caption := 'Images backup in Progress...';
                          frmBackupInProgress.vImage.ImageIndex := 54;
                        end;
                      bpLogging:
                        frmBackupInProgress.lblProgress.Caption := 'Saving backup history...';
                    end;
                  end);
              end);
          finally
            BackupDone := True;
          end;
        end);

      while not BackupDone do
      begin
        Application.ProcessMessages;
        Sleep(50);
      end;

      if R.BackupError <> '' then
        raise Exception.Create(R.BackupError);

      if R.LogError <> '' then
        raise Exception.Create('Backup file was created, but the backup history could not be saved: ' + R.LogError);

      if R.ImageError <> '' then
      begin
        PawnError(R.ImageError, 'Backup Images', Self);
        CanClose := False;
        Timer15Min.Enabled := SaveTimerEnabled;
      end;

    finally
      frmBackupInProgress.Free;
      frmBackupInProgress := nil;
    end;
  except
    on E: Exception do
    begin
      CanClose := false;
      Timer15Min.Enabled := SaveTimerEnabled;
      MsgInfo('Unable to backup: ' + E.Message);
    end;
  end;

end;

// Runs only once OnCloseQuery has approved the close, so this is the point of
// no return. Flag it globally before the main thread leaves its message loop:
// background workers key off AppShuttingDown to know that queued UI updates must
// be dropped rather than applied to controls that are about to be destroyed.
procedure TfrmPawnMain.DoClose(var Action: TCloseAction);
begin
  AppShuttingDown := True;
  Timer15Min.Enabled := False;
  if Assigned(FImageAuditController) then
  begin
    // Bounded on purpose. WaitForStop waits on the OS thread handle, so a True
    // result means the worker is genuinely gone; on timeout the controller's
    // destructor abandons it rather than blocking. Either way shutdown
    // continues -- an audit that outlives the app cannot corrupt anything,
    // because it shares no state with the UI (see uImageAuditController).
    if FImageAuditController.WaitForStop(5000) then
      FImageAuditController.Note('Application closing cleanly; no audit worker ' +
        'is still running.')
    else
      FImageAuditController.Note('Application closing with an audit worker ' +
        'still active; it will be abandoned.');
  end;
  // Join the in-flight gold-price worker here, while DM and FireDAC are still
  // alive. Once this returns the app falls out of its message loop and Forms
  // finalization frees DM; a worker still running then would be a use-after-free
  // and could wedge FireDAC/thread-pool finalization into a windowless ghost.
  WaitForGoldPriceTaskShutdown;
  inherited;
end;

procedure TfrmPawnMain.WaitForGoldPriceTaskShutdown;
const
  // Bounded so closing never stalls indefinitely. AppShuttingDown is already
  // set, so a worker that is between operations or past its HTTP call bails
  // almost immediately; this cap only matters if it is wedged inside the socket
  // call, which is itself capped by the client's connect/response timeouts. The
  // worker touches DM only before its HTTP call, so any worker still alive when
  // this times out is already past the DM-dependent phase.
  GoldPriceShutdownWaitMs = 5000;
begin
  if not Assigned(FGoldPriceTask) then
    Exit;
  try
    FGoldPriceTask.Wait(GoldPriceShutdownWaitMs);
  except
    // Wait re-raises a faulted task's exception; a background price fetch
    // failing as the app closes is irrelevant.
  end;
  FGoldPriceTask := nil;
end;

procedure TfrmPawnMain.FormCreate(Sender: TObject);
begin
  FImageAuditController := TImageAuditController.Create(
    IncludeTrailingPathDelimiter(AppPath) + 'ImageBackupAudit.log');
  RichEditGLdPrice.Lines.Clear;
  SaveOriPaintboxColor := pbUnderTabs.Color;
end;

destructor TfrmPawnMain.Destroy;
begin
  FreeAndNil(FImageAuditController);
  inherited;
end;

procedure TfrmPawnMain.StartImageAuditIfDue;
const
  AuditInitialDelayMs = 15000;
  AuditItemThrottleMs = 100;
var
  SettingsQuery: TFDQuery;
  BackupImagesPath, LastAuditWeek, CurrentAuditWeek: string;
  WeekYear, WeekNo: Word;
  DayNo: Word;
begin
  if not Assigned(FImageAuditController) or
     (ImageStorageMode <> ImageStorageMode_File) then
    Exit;

  DayNo := DayOfWeek(Date);
  if (DayNo <> 3) and (DayNo <> 4) then
    Exit;

  WeekNo := WeekOfTheYear(Date, WeekYear);
  CurrentAuditWeek := Format('%.4d-%.2d', [WeekYear, WeekNo]);
  LastAuditWeek := ReadIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditWeek);

  BackupImagesPath := '';
  SettingsQuery := TFDQuery.Create(nil);
  try
    SettingsQuery.Connection := DM.ConnFB;
    SettingsQuery.SQL.Text :=
      'SELECT BACKUP_IMAGES_PATH FROM BACKUP_SETTINGS';
    SettingsQuery.Open;
    if not SettingsQuery.Eof then
      BackupImagesPath :=
        Trim(SettingsQuery.FieldByName('BACKUP_IMAGES_PATH').AsString);
  finally
    SettingsQuery.Free;
  end;

  FImageAuditController.TryStartIfDue(DM.ConnFB, ImagesStoragePath, BackupImagesPath, LastAuditWeek, CurrentAuditWeek, AuditInitialDelayMs, AuditItemThrottleMs);
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

  ApplyLeadsOnlineVisibility;


  Left := Screen.WorkAreaLeft;
  Top := Screen.WorkAreaTop;

  Width := Screen.WorkAreaWidth;

  frmSplash.Free;

  Caption := 'Pawn FB - ' + GetVersionInfo(ParamStr(0), '');

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
  // PHASE 1 -- DISABLED ON PURPOSE. Do not re-enable without reading this.
  //
  // The weekly image-backup audit is the prime suspect for the intermittent
  // "component already exists" error and the windowless ghost process. It is
  // held off for one week across the two heavy-traffic stores to establish a
  // clean baseline, because the commit that isolated it also fixed three other
  // candidates (the frmClients csDestroying guard, the nil-owner camera form,
  // and the gold-price task re-entrancy guard).
  //
  // PHASE 2: uncomment this line. The audit only runs Tue/Wed, so each store
  // produces one data point per week -- allow two or three weeks before
  // concluding anything. Evidence to collect afterwards:
  //   ImageBackupAudit.log                     did it start, finish, or get abandoned
  //   PawnProFB_MemoryManager_EventLog.txt     FastMM4 catching a bad free
  // Normal manual and close-on-exit image backups are unaffected either way.
   StartImageAuditIfDue;
end;

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
  if Assigned(frmClients) then
    begin
      // caFree is deferred for a modeless form.  While it is closing, leave
      // the existing owner-named component alone and let its release finish.
      if not (csDestroying in frmClients.ComponentState) then
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

procedure TfrmPawnMain.ApplyLeadsOnlineVisibility;
begin
  // Not every store is a LeadsOnline customer. When the store has not opted in,
  // the whole export entry point disappears rather than being offered and then
  // failing -- an unconfigured store must not look like it reports to law
  // enforcement. Hiding the ACTION hides every menu item and toolbar button
  // bound to it, so there is nothing to keep in sync.
  //
  // The SETTINGS button deliberately stays visible: it is the only way to turn
  // LeadsOnline on, so hiding it would make the feature unreachable forever.
  actLeadsOnlineExport.Visible :=
    UsesLeadsOnline(DM.qryStoreLEADS_ONLINE_EXPORT_METHOD.AsString);
end;

procedure TfrmPawnMain.actLeadsOnlineExportExecute(Sender: TObject);
begin
  // One entry point for both LeadsOnline channels, dispatching on the store's
  // configured method, so staff never have to know which protocol their store
  // uses and the wrong screen is unavailable rather than merely discouraged.
  //
  // Anything that is not explicitly 'S' means CSV. The column is nullable by
  // design (see uDBMigrations Step6), so "not configured" has to keep today's
  // behaviour -- it must never silently become "report by web service".
  if LeadsOnlineMethod(DM.qryStoreLEADS_ONLINE_EXPORT_METHOD.AsString) = LeadsExportMethodSoap then
  begin
    frmLeadsOnlineSoapExport := TfrmLeadsOnlineSoapExport.Create(Self);
    try
      frmLeadsOnlineSoapExport.ShowModal;
    finally
      frmLeadsOnlineSoapExport.Free;
      frmLeadsOnlineSoapExport := nil;
    end;
  end
  else
  begin
    frmExportPoliceInformation := TfrmExportPoliceInformation.Create(Self);
    try
      frmExportPoliceInformation.ShowModal;
    finally
      frmExportPoliceInformation.Free;
    end;
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
  frmLeadsOnlineSettings := TfrmLeadsOnlineSettings.Create(Self);
  try
    frmLeadsOnlineSettings.ShowModal;
  finally
    frmLeadsOnlineSettings.Free;
  end;
  // Turning LeadsOnline on or off here has to take effect now, not at the next
  // restart -- otherwise enabling it appears to do nothing.
  ApplyLeadsOnlineVisibility;
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
    frmSplash.st_Msg.Caption := GetVersionCaption;
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

// Resolves the unit gold prices are quoted in: [GOLD_PRICE] WeightUnit ('G' or
// 'P'), falling back to the store's own DefaultWeightMeasureUnit when the key is
// blank - so a pennyweight shop sees pennyweight without touching the ini.
procedure GetGoldPriceUnit(out AGramsPerUnit: Double; out ALongName, AShortName: string);
var
  WeightUnit: string;
begin
  WeightUnit := Trim(ReadIniFile(IniSecGoldPrice, IniKeyGoldPriceWeightUnit));
  if WeightUnit = '' then
    WeightUnit := DefaultWeightMeasureUnit;

  if SameText(WeightUnit, WeightUnitPennyweight) then
    begin
      AGramsPerUnit := GramsPerPennyweight;
      ALongName := 'pennyweight';
      AShortName := 'dwt';
    end
  else
    begin
      AGramsPerUnit := 1;
      ALongName := 'gram';
      AShortName := 'g';
    end;
end;

// Builds the karat melt line, e.g. "18K $72.34/g   14K $56.26/g   10K $40.19/g".
// Karats come from [GOLD_PRICE] Karats in PawnPro.ini so each store picks its
// own; blank or unparseable entries yield '' and the line is simply omitted.
// Value is pure melt - spot scaled by k/24 - with no buy percentage applied.
function BuildKaratPriceLine(APricePerOunce: Double): string;
var
  KaratList: TArray<string>;
  i, j, Karat: integer;
  Karats: TArray<integer>;
  Tmp: integer;
  PricePerUnit, GramsPerUnit: Double;
  UnitLongName, UnitShortName: string;
begin
  Result := '';

  KaratList := Trim(ReadIniFile(IniSecGoldPrice, IniKeyGoldPriceKarats)).Split([',']);
  SetLength(Karats, 0);
  for i := 0 to High(KaratList) do
    if TryStrToInt(Trim(KaratList[i]), Karat) and (Karat > 0) and (Karat <= 24) then
      begin
        SetLength(Karats, Length(Karats) + 1);
        Karats[High(Karats)] := Karat;
      end;

  if Length(Karats) = 0 then
    Exit;

  // highest karat first, so the line reads down from the 24K spot above it
  for i := 1 to High(Karats) do
    begin
      Tmp := Karats[i];
      j := i - 1;
      while (j >= 0) and (Karats[j] < Tmp) do
        begin
          Karats[j + 1] := Karats[j];
          Dec(j);
        end;
      Karats[j + 1] := Tmp;
    end;

  GetGoldPriceUnit(GramsPerUnit, UnitLongName, UnitShortName);
  PricePerUnit := APricePerOunce / GramsPerTroyOunce * GramsPerUnit;

  for i := 0 to High(Karats) do
    begin
      if Result <> '' then
        Result := Result + '   ';
      Result := Result + Format('%dK %m/%s',
        [Karats[i], PricePerUnit * Karats[i] / 24, UnitShortName]);
    end;
end;

procedure DisplayFormattedText(RichEdit: TRichEdit; YellowText: string; ColoredText: string;
  IsRed: Boolean; KaratText: string = '');
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

  // Second line: karat melt values, quieter than the spot price above them
  if KaratText <> '' then
    begin
      RichEdit.SelAttributes.Color := RGB(184, 134, 11);
      RichEdit.SelAttributes.Style := [];
      RichEdit.SelText := sLineBreak + KaratText + ' ';
    end;

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

procedure TfrmPawnMain.WMSettingChange(var Msg: TMessage);
begin
  inherited;
  // Windows broadcasts WM_SETTINGCHANGE when a user changes regional/locale
  // settings while the app is running, which can revert the global
  // FormatSettings the RTL/VCL re-read from the OS. Re-pin the USA date format
  // so date display/parsing stays consistent regardless of the machine locale.
  ConfigureUSDateFormat;
end;

procedure TfrmPawnMain.RefreshGoldPrice(var Msg: TMessage);
const
  // The gold display is cosmetic, so fail fast rather than let a worker linger.
  // Without these the RTL defaults to 60s each, which is how a task ends up
  // still in flight long after the user has closed the app.
  GoldPriceConnectTimeoutMs  = 5000;
  GoldPriceResponseTimeoutMs = 10000;
  // Yahoo rejects the RTL's default agent outright (400/429 depending on the
  // edge node) and answers 200 to anything that looks like a browser. Without
  // this the price bar shows "Error: Bad Request" and never recovers.
  GoldPriceUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
                       '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';
begin
  if AppShuttingDown then
    Exit;

  // All refresh requests (startup, timer, and button) arrive here on the main
  // thread.  Do not start another thread-pool task while the preceding fetch is
  // queued or running.
  if Assigned(FGoldPriceTask) and
     not (FGoldPriceTask.Status in [TTaskStatus.Completed,
                                    TTaskStatus.Canceled,
                                    TTaskStatus.Exception]) then
    Exit;

  RichEditGLdPrice.Clear;
  RichEditGLdPrice.SelAttributes.Color := clGray;
  RichEditGLdPrice.SelText := 'Loading price...';

  FGoldPriceTask := TTask.Run(
    procedure
    var
      LClient: TNetHTTPClient;
      LResponse: IHTTPResponse;
      LJSON: TJSONObject;
      PricePerOunce: Double;
      TitleStatusMessage, StatusMessage, KaratMessage: string;
      lblColorRed: boolean;
      GoldPriceUrl: string;
      LAsyncConn: TFDConnection;
      LSaveQuery: TFDQuery;
      GramsPerUnit: Double;
      UnitLongName, UnitShortName: string;
    begin
      // Bail before touching DM: if close already began, DM may be torn down
      // any moment. DM is only referenced up to ConfigureFBConnectionFor below;
      // after that the worker is self-contained (own connection, globals, ini).
      if AppShuttingDown then
        Exit;

      TitleStatusMessage := ' 24K Gold Price:';
      StatusMessage := 'Unable to load price.';
      KaratMessage := '';
      lblColorRed := True;
//      LAsyncConn := nil;

      // Thread-local FB connection, configured from the same
      // [CONNECTION_FB] params as DM.ConnFB. ConfigureFBConnectionFor writes
      // only into LAsyncConn -- the driver-link binding it used to perform was
      // moved to DM.BindFBClientLibrary (main thread, set-once) so this worker
      // no longer mutates any shared DM component.
      LAsyncConn := TFDConnection.Create(nil);
      try
        DM.ConfigureFBConnectionFor(LAsyncConn);
        LAsyncConn.Connected := True;

        LClient := TNetHTTPClient.Create(nil);
        try
          LClient.ConnectionTimeout := GoldPriceConnectTimeoutMs;
          LClient.ResponseTimeout   := GoldPriceResponseTimeoutMs;
          LClient.UserAgent         := GoldPriceUserAgent;
          LClient.AcceptEncoding    := 'identity';   // no gzip: ContentAsString parses the body directly

          GoldPriceUrl := Trim(ReadIniFile(IniSecGoldPrice, IniKeyGoldPriceUrl));
          if GoldPriceUrl = '' then
            GoldPriceUrl := 'https://query1.finance.yahoo.com/v8/finance/chart/GC=F?interval=1m&range=1d';

          LResponse := LClient.Get(GoldPriceUrl);

          // The HTTP call is the long pole. If close began while it ran, skip
          // the DB write and get out; the finally blocks still free the client
          // and connection. Exiting here keeps the shutdown join short.
          if AppShuttingDown then
            Exit;

          if LResponse.StatusCode = 200 then
          begin
            LJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
            if LJSON = nil then
              raise Exception.Create('Invalid gold price response.');
            try
              var ChartObj := LJSON.GetValue<TJSONObject>('chart');
              if ChartObj = nil then
                raise Exception.Create('Invalid Yahoo gold price response.');

              var ResultsArray := ChartObj.GetValue<TJSONArray>('result');
              if (ResultsArray = nil) or (ResultsArray.Count = 0) then
                raise Exception.Create('Yahoo gold price response has no result.');

              var ResultObj := ResultsArray.Items[0] as TJSONObject;
              var MetaObj := ResultObj.GetValue<TJSONObject>('meta');
              if MetaObj = nil then
                raise Exception.Create('Yahoo gold price response has no metadata.');

              PricePerOunce := MetaObj.GetValue<Double>('regularMarketPrice');
              TitleStatusMessage := ' 24K Gold Price:';
              GetGoldPriceUnit(GramsPerUnit, UnitLongName, UnitShortName);
              StatusMessage := Format(' %m per Ounce. %m per %s. ',
                [PricePerOunce, PricePerOunce / GramsPerTroyOunce * GramsPerUnit, UnitLongName]);
              KaratMessage := BuildKaratPriceLine(PricePerOunce);

              try
                LSaveQuery := TFDQuery.Create(nil);
                try
                  LSaveQuery.Connection := LAsyncConn;
                  LSaveQuery.SQL.Text :=
                    'SELECT FIRST 1 PRICE_PER_OUNCE ' +
                    'FROM GOLD_PRICE_HISTORY ' +
                    'ORDER BY PRICE_ID DESC';
                  LSaveQuery.Open;

                  var LastGldPrice: Currency := 0;
                  if not LSaveQuery.Eof then
                    LastGldPrice := LSaveQuery.FieldByName('PRICE_PER_OUNCE').AsCurrency;

                  lblColorRed := LastGldPrice > PricePerOunce;

                  if LastGldPrice <> PricePerOunce then
                  begin
                    LSaveQuery.Close;
                    LSaveQuery.SQL.Text :=
                      'INSERT INTO GOLD_PRICE_HISTORY (PRICE_PER_OUNCE, CURRENCY, FETCHDATETIME, SOURCE) ' +
                      'VALUES (:PRICE_PER_OUNCE, :CURRENCY, CURRENT_TIMESTAMP, :SOURCE)';
                    LSaveQuery.Params.ParamByName('PRICE_PER_OUNCE').AsCurrency := PricePerOunce;
                    LSaveQuery.Params.ParamByName('CURRENCY').AsString := 'USD';
                    LSaveQuery.Params.ParamByName('SOURCE').AsString := 'Yahoo';
                    LSaveQuery.ExecSQL;
                  end;
                finally
                  LSaveQuery.Free;
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
            StatusMessage := Format(' Error %d: %s ', [LResponse.StatusCode, LResponse.StatusText]);
        finally
          LClient.Free;
        end;
      except
        on E: Exception do
          StatusMessage := 'Error: ' + E.Message;
      end;

      try
        if Assigned(LAsyncConn) and LAsyncConn.Connected then
          LAsyncConn.Connected := False;
      finally
        LAsyncConn.Free;
      end;

      // Queue, never Synchronize. Synchronize blocks this worker until the main
      // thread drains the sync queue; if the user has closed the app the main
      // thread has already left its message loop, nobody drains it, and the
      // worker parks forever -- which in turn hangs thread-pool finalization and
      // leaves PawnProFB.exe alive as a windowless background process. Queue
      // hands the update over without waiting, so the worker always exits.
      TThread.Queue(nil, procedure
      begin
        if AppShuttingDown then
          Exit;
        DisplayFormattedText(RichEditGLdPrice, TitleStatusMessage, StatusMessage, lblColorRed, KaratMessage);
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
var
  SharedImagePath: string;
begin
  { DB image storage is retired in the Firebird version. Force FILE mode and
    overwrite any stale DATABASE/blank value in the ini so a machine that was
    previously misconfigured (or seeded before this fix) self-heals on launch. }
  if not SameText(ReadIniFile(IniSecImageStorage, IniKeyStorageMode), ImageStorageMode_File) then
    WriteIniFile(IniSecImageStorage, IniKeyStorageMode, ImageStorageMode_File);
  ImageStorageMode := ImageStorageMode_File;

  ImagesStoragePath := ReadIniFile(IniSecImageStorage, IniKeyImageDirectory);
  if not IsLocalDatabase then
  begin
    try
      SharedImagePath := Trim(DM.GetAppStateText(AppStateKeyImageSharedPath, ''));
      if (SharedImagePath <> '') and not SameText(SharedImagePath, ImagesStoragePath) then
      begin
        ImagesStoragePath := SharedImagePath;
        WriteIniFile(IniSecImageStorage, IniKeyImageDirectory, ImagesStoragePath);
      end;
    except
      { Keep workstation startup non-fatal if the APP_STATE migration has not run yet. }
    end;
  end;

  { Assign the correct procedures }
  if ImageStorageMode = ImageStorageMode_File then
  begin
    GetImageProc := DM.GetImageFromFile;
    GetImageBytesProc := DM.GetImageBytesFromFile;
    SaveImageProc := DM.SaveImageToFile_FromPath;
    DeleteImageProc := DM.DeleteImageFromFile;
  end
  else
  begin
    GetImageProc := DM.GetImageFromDatabase;
    GetImageBytesProc := DM.GetImageBytesFromDatabase;
    SaveImageProc := DM.SaveImageToDatabase_FromPath;
    DeleteImageProc := DM.DeleteImageFromDatabase;
  end;
end;

end.
