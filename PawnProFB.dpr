program PawnProFB;



uses
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
  LeadsOnlineFTPParams in 'LeadsOnlineFTPParams.pas' {frmLeadsOnlineFTPParams},
  Nvv.IO.CSV.Delphi.NvvCSVClasses in '..\COMMON\Nvv.IO.CSV.Delphi.NvvCSVClasses.pas',
  Nvv.FB5.DBA in '..\COMMON\Nvv.FB5.DBA.pas',
  DrvLic_PDF417Parsing in 'DrvLic_PDF417Parsing.pas',
  SelectedItemsInGridClass in '..\COMMON\SelectedItemsInGridClass.pas',
  CheckBoxDrawer in 'CheckBoxDrawer.pas',
  leadsonline in 'leadsonline.pas',
  ReportsDM in 'ReportsDM.pas' {DMReports: TDataModule},
  uPawnProIniPrinters in 'uPawnProIniPrinters.pas',
  PaymentLayaway in 'PaymentLayaway.pas' {frmPaymentLayaway},
  EnterLayaway in 'EnterLayaway.pas' {frmEnterLayaway},
  ConfirmCloseLayaway in 'ConfirmCloseLayaway.pas' {frmConfirmCloseLayaway},
  ImagesStorageSettings in 'ImagesStorageSettings.pas' {frmImagesStorageSettings},
  uPawnDialogs in 'uPawnDialogs.pas',
  BackupInProgress in 'BackupInProgress.pas' {frmBackupInProgress},
  PawnChangeStatus in 'PawnChangeStatus.pas' {frmPawnChangeStatus};

{$R *.RES}

begin
  if not IsFirstInstance then
    begin
      ActivateFirst('');
      exit;
    end;

  Application.Initialize;

  frmSplash := TfrmSplash.Create(Application);
  frmSplash.Show;
  frmSplash.Update;
  frmSplash.st_Msg.Caption := 'Initializing System. Please wait. . .';

  Application.Title := 'The Pawn App.';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMReports, DMReports);
  Application.CreateForm(TfrmPawnMain, frmPawnMain);
  Application.Run;
end.
