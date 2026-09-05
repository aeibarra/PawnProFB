program PawnProFB;

// OFF. Diagnostic memory-manager build, kept for the next time something needs
// hunting rather than deleted -- it earned its place once already.
//
// Uncommenting the define links FastMM4 in FullDebugMode: every allocation gets
// guard blocks and a recorded stack trace, so a double-free, use-after-free or
// overrun is caught AT THE MOMENT IT HAPPENS rather than later somewhere
// unrelated, and both the allocation and free stacks are appended to
// PawnProFB_MemoryManager_EventLog.txt beside the EXE.
//
// It found the VFrames.TVideoImage use-after-free in July 2026 (see the camera
// capture fix and Docs\ImageAuditTestPlan.md) after that bug had been producing
// "component already exists" and out-of-memory reports for months.
//
// If you turn it back on, ALL of the following must sit beside the EXE:
//   FastMM_FullDebugMode64.dll   stack capture -- the app will NOT start without it
//   PawnProFB.map               resolves traces to unit + line, and must be
//                               REGENERATED WITH THE SAME BUILD; a stale map
//                               silently resolves addresses to the wrong code
// and the Release config needs DCC_DebugInformation 2, DCC_LocalDebugSymbols,
// DCC_GenerateStackFrames and DCC_MapFile 3 restored, or the traces come back as
// raw addresses.
//
// Store-safety settings live in FastMM4Options.inc -- NoMessageBoxes ON so a
// detected error is logged instead of popping a dialog at the register, and
// RawStackTraces / AlwaysAllocateTopDown OFF so it stays usable all day. That
// file is .gitignored, along with FastMM4.pas and the DLL, so a fresh clone will
// not compile with MMDEBUG defined until they are copied back in.
//
// With the define commented out FastMM4 is not linked at all and the binary is
// unaffected.
{.$DEFINE MMDEBUG}

uses
  {$IFDEF MMDEBUG}
  FastMM4,   // MUST be first: installs the memory manager before any allocation
  {$ENDIF}
  Forms,
  MidasLib,
  StFirst,
  PawnMain in 'PawnMain.pas' {frmPawnMain},
  PawnSplash in 'PawnSplash.pas' {frmSplash},
  PawnDM in 'PawnDM.pas' {DM: TDataModule},
  PawnGlobal in 'PawnGlobal.pas',
  SearchClient in 'SearchClient.pas' {frmClients},
  EnterClientInfo in 'EnterClientInfo.pas' {frmEnterClientInfo},
  EnterTransactions in 'EnterTransactions.pas' {frmEnterTransaction},
  EnterPayment in 'EnterPayment.pas' {frmEnterPayment},
  CardReader in 'CardReader.pas' {frmDriverLicCardReader},
  Inventory in 'Inventory.pas' {frmInventory},
  EditInvCategory in 'EditInvCategory.pas' {frmEditInvCat},
  EditInvItem in 'EditInvItem.pas' {frmEditInvItem},
  MaintenanceJewle in 'MaintenanceJewle.pas' {frmMaintenanceJ},
  EditMaintenance in 'EditMaintenance.pas' {frmEditMaintenance},
  EnterStoneInfo in 'EnterStoneInfo.pas' {frmEnterStoneInfo},
  SetupBarcodePrinter in 'SetupBarcodePrinter.pas' {frmSetupBarcodePrinter},
  Entertems in 'Entertems.pas' {frmEnterItems},
  EnterPawnStoneInfo in 'EnterPawnStoneInfo.pas' {frmEnterPawnStoneInfo},
  BackupDB in 'BackupDB.pas' {frmBackupDB},
  EnterPurchase in 'EnterPurchase.pas' {frmEnterPurchase},
  ViewBackupHistory in 'ViewBackupHistory.pas' {frmViewBackupHist},
  PoliceAdj in 'PoliceAdj.pas' {frmPoliceRptAdj},
  TransactionList in 'TransactionList.pas' {frmTransactionList},
  ItemsToCopyLargeGrid in 'ItemsToCopyLargeGrid.pas' {frmItemsToCopyLargeGrid},
  ExportPoliceInformation in 'ExportPoliceInformation.pas' {frmExportPoliceInformation},
  Report01 in 'Report01.pas' {frmReport01},
  Report02 in 'Report02.pas' {frmReport02},
  GLbUtils in '..\COMMON\GLbUtils.pas',
  RepPurchases in 'RepPurchases.pas' {frmRepPurchases},
  ReportExportTransactions in 'ReportExportTransactions.pas' {frmReportExportTransactions},
  SetDefaultMaturityMonth in 'SetDefaultMaturityMonth.pas' {frmSetDefaultMaturityMonth},
  IDNumCalc in '..\COMMON\IDNumCalc.pas',
  LeadsOnlineDM in 'LeadsOnlineDM.pas' {DM_LeadsOnline: TDataModule},
  ItemPictures in 'ItemPictures.pas' {frmItemPictures},
  CapturePicFromCamera in 'CapturePicFromCamera.pas' {frmCapturePicFromCamera},
  VFrames in 'VFrames.pas',
  VSample in 'VSample.pas',
  Vcl.Themes,
  Vcl.Styles,
  ViewImage in 'ViewImage.pas' {frmViewImage},
  LeadsOnlineSettings in 'LeadsOnlineSettings.pas' {frmLeadsOnlineSettings},
  Nvv.IO.CSV.Delphi.NvvCSVClasses in '..\COMMON\Nvv.IO.CSV.Delphi.NvvCSVClasses.pas',
  Nvv.FB5.DBA in '..\COMMON\Nvv.FB5.DBA.pas',
  DPAPIUtils in '..\COMMON\DPAPIUtils.pas',
  SealedBox in '..\COMMON\SealedBox.pas',
  Nvv.Crypto.FileEnvelope in '..\COMMON\Nvv.Crypto.FileEnvelope.pas',
  DrvLic_PDF417Parsing in 'DrvLic_PDF417Parsing.pas',
  SelectedItemsInGridClass in '..\COMMON\SelectedItemsInGridClass.pas',
  CheckBoxDrawer in 'CheckBoxDrawer.pas',
  LeadsOnlineWS in 'LeadsOnlineWS.pas',
  uLeadsOnlineClient in 'uLeadsOnlineClient.pas',
  uLeadsOnlineTicketMap in 'uLeadsOnlineTicketMap.pas',
  ReportsDM in 'ReportsDM.pas' {DMReports: TDataModule},
  uPawnProIniPrinters in 'uPawnProIniPrinters.pas',
  uPawnIniDefaults in 'uPawnIniDefaults.pas',
  PaymentLayaway in 'PaymentLayaway.pas' {frmPaymentLayaway},
  EnterLayaway in 'EnterLayaway.pas' {frmEnterLayaway},
  ConfirmCloseLayaway in 'ConfirmCloseLayaway.pas' {frmConfirmCloseLayaway},
  ImagesStorageSettings in 'ImagesStorageSettings.pas' {frmImagesStorageSettings},
  uPawnDialogs in 'uPawnDialogs.pas',
  BackupInProgress in 'BackupInProgress.pas' {frmBackupInProgress},
  PawnChangeStatus in 'PawnChangeStatus.pas' {frmPawnChangeStatus},
  ItemHistory in 'ItemHistory.pas' {frmItemHistory},
  uImageMaintenanceGate in 'uImageMaintenanceGate.pas',
  uImageBackupAudit in 'uImageBackupAudit.pas',
  uImageAuditController in 'uImageAuditController.pas',
  LeadsOnlineSoapExport in 'LeadsOnlineSoapExport.pas' {frmLeadsOnlineSoapExport},
  ViewSentTickets in 'ViewSentTickets.pas' {frmViewSentTickets};

{$R *.RES}

begin
  if not IsFirstInstance then
    begin
      ActivateFirst('');
      exit;
    end;

  ConfigureUSDateFormat;
  Application.Initialize;

  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Update;
  frmSplash.st_Msg.Caption := 'Initializing System. Please wait. . .';

  Application.Title := 'The Pawn App.';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMReports, DMReports);
  Application.CreateForm(TfrmPawnMain, frmPawnMain);
  // TfrmLeadsOnlineSoapExport is created on demand by actLeadsOnlineExport,
  // like every other dialog here -- auto-creating it would keep the form and
  // its datasets alive for the whole session and collide with the create/free
  // in that handler.
  Application.Run;
end.
