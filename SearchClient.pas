unit SearchClient;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Vcl.Graphics, Vcl.Dialogs,
  ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, ComCtrls, DBCtrls, Mask, ActnList, DB, ppComm,
  ppRelatv, ppDB, ppDBPipe, ppProd, ppClass, ppReport, ppPrnabl, ppCtrls, StrUtils,
  ppBands, ppCache, ppVar, IniFiles, Menus, System.UITypes, Variants,
  myChkBox, ppParameter, ppDesignLayer, RzForms, RzCommon, System.Actions, PawnGlobal,
  Datasnap.Provider, Datasnap.DBClient, RzButton, FireDAC.Stan.Param,
  ppStrtch, ppRegion, DrvLic_PDF417Parsing, RzTabs, uPawnPhoneEdit, RzLabel,
  RzDBLbl, RzEdit, JvExControls, JvLinkLabel, JvExStdCtrls, JvHtControls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

const
  sx_ProcessCardScanning = wm_User + 100;
  sx_RefreshPaymentDueDateMesg = wm_User + 101;

type
  TfrmClients = class(TForm)
    ActionListKeys: TActionList;
    ActionAddClient: TAction;
    ActionEditClient: TAction;
    ActionAddTran: TAction;
    ActionEditTran: TAction;
    ActionAddPay: TAction;
    ActionEditPay: TAction;
    ActionPrintPoliceRpt: TAction;
    ActionScanCard: TAction;
    dsInvItems: TDataSource;
    pnTop: TPanel;
    PanelClientInfo: TPanel;
    gridClients: TDBGrid;
    Panel12: TPanel;
    btnClientDelete: TBitBtn;
    btnClientAdd: TBitBtn;
    btnClientEdit: TBitBtn;
    btnPrintPolRpt: TBitBtn;
    PanelDetail: TPanel;
    SplitterBottom: TSplitter;
    Splitter1: TSplitter;
    PDBPoliceRep: TppDBPipeline;
    dsPoliceRepCust: TDataSource;
    DBPStoreInfo: TppDBPipeline;
    DBPTransaction: TppDBPipeline;
    PopMnuTransactions: TPopupMenu;
    DBPPawnItems: TppDBPipeline;
    dsPawnItems: TDataSource;
    ActionAddPurchase: TAction;
    ActionEditPurchase: TAction;
    qryPoliceRepCust: TFDQuery;
    qryPawnItems: TFDQuery;
    qryPawnStones: TFDQuery;
    qryPoliceRepCustCustno: TIntegerField;
    qryPoliceRepCustCustTicketNo: TWideStringField;
    qryPoliceRepCustCustLast: TWideStringField;
    qryPoliceRepCustCustFirst: TWideStringField;
    qryPoliceRepCustCustMid: TWideStringField;
    qryPoliceRepCustCustDOB: TDateField;
    qryPoliceRepCustCustGender: TWideStringField;
    qryPoliceRepCustCustRace: TWideStringField;
    qryPoliceRepCustCustHair: TWideStringField;
    qryPoliceRepCustCustEyes: TWideStringField;
    qryPoliceRepCustCustMark: TWideStringField;
    qryPoliceRepCustCustWeight: TFloatField;
    qryPoliceRepCustCustHeight: TWideStringField;
    qryPoliceRepCustCustAddr: TWideStringField;
    qryPoliceRepCustCustApt: TWideStringField;
    qryPoliceRepCustCustCity: TWideStringField;
    qryPoliceRepCustCustState: TWideStringField;
    qryPoliceRepCustCustZip: TWideStringField;
    qryPoliceRepCustCustPlaceEmply: TWideStringField;
    qryPoliceRepCustCustFlDrvLic: TWideStringField;
    qryPoliceRepCustCustID: TWideStringField;
    qryPoliceRepCustCustIDType: TWideStringField;
    qryPoliceRepCustCustIDAgencyState: TWideStringField;
    qryPoliceRepCustCustPhHome: TWideStringField;
    qryPoliceRepCustCustPhBussiness: TWideStringField;
    qryPoliceRepCustCustPhBeep: TWideStringField;
    qryPoliceRepCustCustPhCell: TWideStringField;
    qryPoliceRepCustCustComment: TMemoField;
    qryPawnItemsInvItemNo: TIntegerField;
    qryPawnItemsInvItemBarcode: TStringField;
    qryPawnItemsInvCatNo: TIntegerField;
    qryPawnItemsJType: TStringField;
    qryPawnItemsJStyle: TStringField;
    qryPawnItemsJMetal: TStringField;
    qryPawnItemsInvItemCount: TIntegerField;
    qryPawnItemsNote: TStringField;
    qryPawnItemsSizeLength: TFloatField;
    qryPawnItemsWeight: TFloatField;
    qryPawnItemsKT: TFloatField;
    qryPawnItemsCreated: TSQLTimeStampField;
    qryPawnItemsUnitCost: TFMTBCDField;
    qryPawnItemsUnitPrice: TFMTBCDField;
    qryPawnItemsInvItemStatus: TStringField;
    qryPawnItemsTransactionNo: TIntegerField;
    qryPawnItemsInvOriginalItemNo: TIntegerField;
    qryPawnItemsInvItemBrand: TStringField;
    qryPawnItemsOwnerAppNumber: TStringField;
    qryPawnItemsModelNumber: TStringField;
    qryPawnItemsSerialNumber: TStringField;
    qryPawnItemsGender: TStringField;
    qryPawnStonesStoneNo: TIntegerField;
    qryPawnStonesInvItemNo: TIntegerField;
    qryPawnStonesStoneNumber: TIntegerField;
    qryPawnStonesStoneShape: TStringField;
    qryPawnStonesStoneColor: TStringField;
    qryPawnStonesCT: TFloatField;
    qryPawnStonesWT: TFloatField;
    qryPawnStonesStoneType: TStringField;
    qryPawnItemscStone1Shape: TStringField;
    qryPawnItemscStone1Color: TStringField;
    qryPawnItemscStone1CT: TFloatField;
    qryPawnItemscStone1Qty: TIntegerField;
    qryPawnItemscStone2Shape: TStringField;
    qryPawnItemscStone2Color: TStringField;
    qryPawnItemscStone2CT: TFloatField;
    qryPawnItemscStone2Qty: TIntegerField;
    qryPawnItemsDescription: TStringField;
    mnuPawnStatusActive: TMenuItem;
    mnuPawnStatusInactive: TMenuItem;
    FormState: TRzFormState;
    PropertyStore: TRzPropertyStore;
    TimerScanningTimeOut: TTimer;
    RepPoliceLaser: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppDBText10: TppDBText;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText52: TppDBText;
    ppDBText53: TppDBText;
    ppDBText54: TppDBText;
    ppDBText55: TppDBText;
    ppDBText56: TppDBText;
    ppLabel10: TppLabel;
    ppDBText57: TppDBText;
    ppDBText58: TppDBText;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppDBText59: TppDBText;
    ppDBText60: TppDBText;
    ppDBText61: TppDBText;
    ppDBText62: TppDBText;
    ppDBText63: TppDBText;
    ppLabel14: TppLabel;
    ppDBText64: TppDBText;
    ppDBText65: TppDBText;
    ppChkPawnLetter: TmyCheckBox;
    chkChkPurchase: TmyCheckBox;
    ppDBText66: TppDBText;
    ppDBText67: TppDBText;
    ppDetailBand1: TppDetailBand;
    ppDBText68: TppDBText;
    ppDBText69: TppDBText;
    ppDBText70: TppDBText;
    ppDBText71: TppDBText;
    ppDBText72: TppDBText;
    ppDBText73: TppDBText;
    ppDBText74: TppDBText;
    ppDBText75: TppDBText;
    ppDBText76: TppDBText;
    ppDBText77: TppDBText;
    ppDBText78: TppDBText;
    ppDBText79: TppDBText;
    ppDBText80: TppDBText;
    ppDBText81: TppDBText;
    ppDBText82: TppDBText;
    ppDBText83: TppDBText;
    ppDBText84: TppDBText;
    ppDBText85: TppDBText;
    ppDBText86: TppDBText;
    ppDBText87: TppDBText;
    ppDBText88: TppDBText;
    ppDBText89: TppDBText;
    ppDBText90: TppDBText;
    ppDBText91: TppDBText;
    ppDBText92: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppLabel25: TppLabel;
    ppShape1: TppShape;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edFirst: TEdit;
    edLast: TEdit;
    btnExit: TBitBtn;
    edTicketNo: TEdit;
    ppLabel34: TppLabel;
    ppShape2: TppShape;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLabel46: TppLabel;
    ppLabel47: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel50: TppLabel;
    ppLabel51: TppLabel;
    ppLabel52: TppLabel;
    ppLabel53: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppLabel56: TppLabel;
    ppLabel57: TppLabel;
    ppShape3: TppShape;
    ppLabel58: TppLabel;
    ppShape4: TppShape;
    ppLabel59: TppLabel;
    ppLabel60: TppLabel;
    ppLabel61: TppLabel;
    ppLabel62: TppLabel;
    ppLabel63: TppLabel;
    ppLabel64: TppLabel;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppLabel68: TppLabel;
    ppLabel69: TppLabel;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppLabel72: TppLabel;
    ppLabel73: TppLabel;
    ppLabel74: TppLabel;
    ppLabel75: TppLabel;
    ppLabel76: TppLabel;
    ppLabel77: TppLabel;
    ppLabel78: TppLabel;
    ppLabel79: TppLabel;
    ppLabel80: TppLabel;
    ppLabel81: TppLabel;
    ppLabel82: TppLabel;
    ppLabel83: TppLabel;
    ppLabel84: TppLabel;
    ppLabel85: TppLabel;
    ppLabel86: TppLabel;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppLabel89: TppLabel;
    ppLabel90: TppLabel;
    ppLabel91: TppLabel;
    ppLabel92: TppLabel;
    ppLabel93: TppLabel;
    ppLabel94: TppLabel;
    ppLabel95: TppLabel;
    ppLabel96: TppLabel;
    ppLabel97: TppLabel;
    ppLabel98: TppLabel;
    ppLabel101: TppLabel;
    ppLabel107: TppLabel;
    ppLabel113: TppLabel;
    ppLabel119: TppLabel;
    ppLabel120: TppLabel;
    ppLabel121: TppLabel;
    ppLabel122: TppLabel;
    ppLabel123: TppLabel;
    ppLabel99: TppLabel;
    ppLabel100: TppLabel;
    ppLabel108: TppLabel;
    ppLabel109: TppLabel;
    ppLabel110: TppLabel;
    ppLabel111: TppLabel;
    ppLabel112: TppLabel;
    ppLabel114: TppLabel;
    ppLabel115: TppLabel;
    ppLabel116: TppLabel;
    ppLabel117: TppLabel;
    ppLabel118: TppLabel;
    ppLabel124: TppLabel;
    ppLabel125: TppLabel;
    ppLabel126: TppLabel;
    ppLabel127: TppLabel;
    ppLabel128: TppLabel;
    ppLabel130: TppLabel;
    ppLabel131: TppLabel;
    ppLabel132: TppLabel;
    ppLabel133: TppLabel;
    ppLabel134: TppLabel;
    ppLabel135: TppLabel;
    ppLabel136: TppLabel;
    ppLabel137: TppLabel;
    ppLabel138: TppLabel;
    ppLabel139: TppLabel;
    ppLabel102: TppLabel;
    ppLabel103: TppLabel;
    ppLabel104: TppLabel;
    ppLine11: TppLine;
    ppLabel105: TppLabel;
    ppLabel106: TppLabel;
    ppLabel129: TppLabel;
    ppLine15: TppLine;
    ppLabel140: TppLabel;
    ppLabel141: TppLabel;
    ppLabel142: TppLabel;
    ppLine16: TppLine;
    ppLabel143: TppLabel;
    ppLabel144: TppLabel;
    ppLine17: TppLine;
    ppLabel145: TppLabel;
    ppLine18: TppLine;
    ppLabel147: TppLabel;
    ppLabel148: TppLabel;
    ppLabel149: TppLabel;
    ppLabel150: TppLabel;
    ppLabel151: TppLabel;
    ppLabel152: TppLabel;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLabel146: TppLabel;
    ppLabel153: TppLabel;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLabel154: TppLabel;
    ppShape5: TppShape;
    ppLine24: TppLine;
    ppLabel155: TppLabel;
    ppLabel156: TppLabel;
    ppLabel157: TppLabel;
    ppShape6: TppShape;
    ppLabel158: TppLabel;
    ppLine25: TppLine;
    ppLabel159: TppLabel;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine28: TppLine;
    ppLine30: TppLine;
    ppLine31: TppLine;
    ppLabel160: TppLabel;
    ppLabel161: TppLabel;
    ppLabel162: TppLabel;
    ppLabel163: TppLabel;
    ppLabel164: TppLabel;
    ppLabel165: TppLabel;
    ppLabel167: TppLabel;
    ppLabel168: TppLabel;
    ppLabel169: TppLabel;
    ppLabel170: TppLabel;
    ppLabel172: TppLabel;
    ppLabel173: TppLabel;
    ppLabel174: TppLabel;
    ppLabel175: TppLabel;
    ppLine34: TppLine;
    ppLine35: TppLine;
    ppLabel176: TppLabel;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLabel177: TppLabel;
    ppLabel178: TppLabel;
    ppLabel179: TppLabel;
    ppLabel180: TppLabel;
    ppLabel181: TppLabel;
    ppLine38: TppLine;
    ppLabel182: TppLabel;
    ppLabel183: TppLabel;
    ppLabel184: TppLabel;
    ppLabel185: TppLabel;
    ppLabel186: TppLabel;
    ppLabel187: TppLabel;
    ppLabel188: TppLabel;
    ppLine39: TppLine;
    ppLabel189: TppLabel;
    ppLabel190: TppLabel;
    ppLabel191: TppLabel;
    ppLabel192: TppLabel;
    ppLabel193: TppLabel;
    ppLabel194: TppLabel;
    ppLabel195: TppLabel;
    ppShape7: TppShape;
    ppLabel196: TppLabel;
    ppLabel197: TppLabel;
    ppLabel198: TppLabel;
    ppLabel199: TppLabel;
    ppLabel200: TppLabel;
    ppLabel201: TppLabel;
    ppLabel202: TppLabel;
    ppLine40: TppLine;
    ppLine42: TppLine;
    ppShape8: TppShape;
    ppLabel203: TppLabel;
    ppLabel204: TppLabel;
    ppLabel205: TppLabel;
    ppLabel206: TppLabel;
    ppLabel207: TppLabel;
    ppLabel208: TppLabel;
    ppLabel209: TppLabel;
    ppLine23: TppLine;
    ppLine29: TppLine;
    calcItem: TppDBCalc;
    ppLine12: TppLine;
    clnPawnItems: TClientDataSet;
    dsPawnItemsLaser: TDataSource;
    prvPawnItems: TDataSetProvider;
    DBPPawnItemsLaser: TppDBPipeline;
    clnPawnItemscStone1Shape: TStringField;
    clnPawnItemscStone1Color: TStringField;
    clnPawnItemsInvItemNo: TIntegerField;
    clnPawnItemsInvItemBarcode: TStringField;
    clnPawnItemsInvCatNo: TIntegerField;
    clnPawnItemsJType: TStringField;
    clnPawnItemsJStyle: TStringField;
    clnPawnItemsJMetal: TStringField;
    clnPawnItemsInvItemCount: TIntegerField;
    clnPawnItemsNote: TStringField;
    clnPawnItemsSizeLength: TFloatField;
    clnPawnItemsWeight: TFloatField;
    clnPawnItemsKT: TFloatField;
    clnPawnItemsCreated: TSQLTimeStampField;
    clnPawnItemsUnitCost: TFMTBCDField;
    clnPawnItemsUnitPrice: TFMTBCDField;
    clnPawnItemsInvItemStatus: TStringField;
    clnPawnItemsTransactionNo: TIntegerField;
    clnPawnItemsInvOriginalItemNo: TIntegerField;
    clnPawnItemsInvItemBrand: TStringField;
    clnPawnItemsOwnerAppNumber: TStringField;
    clnPawnItemsModelNumber: TStringField;
    clnPawnItemsSerialNumber: TStringField;
    clnPawnItemsGender: TStringField;
    clnPawnItemsDescription: TStringField;
    clnPawnItemscStone1CT: TFloatField;
    clnPawnItemscStone1Qty: TIntegerField;
    clnPawnItemscStone2Shape: TStringField;
    clnPawnItemscStone2Color: TStringField;
    clnPawnItemscStone2CT: TFloatField;
    clnPawnItemscStone2Qty: TIntegerField;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine45: TppLine;
    ppLine46: TppLine;
    ppLine47: TppLine;
    ppLine49: TppLine;
    ppLine50: TppLine;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppLine54: TppLine;
    ppLine55: TppLine;
    ppLine56: TppLine;
    ppLine57: TppLine;
    ppLine58: TppLine;
    ppLine59: TppLine;
    ppLine60: TppLine;
    ppLine41: TppLine;
    ppLine61: TppLine;
    ppLine62: TppLine;
    ppLine63: TppLine;
    btnClearSearchFields: TSpeedButton;
    ActionClearSearchFields: TAction;
    Action1: TAction;
    btnSearch: TRzBitBtn;
    qryPoliceRepCustCCustPhHome: TStringField;
    qryPoliceRepCustCCustPhBussiness: TStringField;
    qryPoliceRepCustCCustPhBeep: TStringField;
    qryPoliceRepCustcCustPhCell: TStringField;
    qryPoliceRepCustcCustFlDrvLic: TStringField;
    Label5: TLabel;
    RptPoliceLaserPrePrinted: TppReport;
    ppHeaderBand3: TppHeaderBand;
    ppDBText93: TppDBText;
    ppDBText94: TppDBText;
    ppDBText95: TppDBText;
    ppDBText96: TppDBText;
    ppDBText97: TppDBText;
    ppDBText98: TppDBText;
    ppDBText99: TppDBText;
    ppDBText100: TppDBText;
    ppDBText101: TppDBText;
    ppDBText102: TppDBText;
    ppLabel6: TppLabel;
    ppDBText103: TppDBText;
    ppDBText104: TppDBText;
    ppLabel166: TppLabel;
    ppLabel171: TppLabel;
    ppLabel210: TppLabel;
    ppDBText105: TppDBText;
    ppDBText106: TppDBText;
    ppDBText107: TppDBText;
    ppDBText108: TppDBText;
    ppDBText109: TppDBText;
    ppLabel211: TppLabel;
    ppDBText110: TppDBText;
    ppDBText111: TppDBText;
    ppChkPawnLetterPrePrinted: TmyCheckBox;
    chkChkPurchaseLetterPrePrinted: TmyCheckBox;
    ppDBText112: TppDBText;
    ppDBText113: TppDBText;
    DetailBandpPreLaser2: TppDetailBand;
    ppDBText114: TppDBText;
    ppDBText115: TppDBText;
    ppDBText116: TppDBText;
    ppDBText117: TppDBText;
    ppDBText118: TppDBText;
    ppDBText119: TppDBText;
    ppDBText120: TppDBText;
    ppDBText121: TppDBText;
    ppDBText122: TppDBText;
    ppDBText123: TppDBText;
    ppDBText124: TppDBText;
    ppDBText125: TppDBText;
    ppDBText126: TppDBText;
    ppDBText127: TppDBText;
    ppDBText128: TppDBText;
    ppDBText129: TppDBText;
    ppDBText130: TppDBText;
    ppDBText131: TppDBText;
    ppDBText132: TppDBText;
    ppDBText133: TppDBText;
    ppDBText134: TppDBText;
    ppDBText135: TppDBText;
    ppDBText136: TppDBText;
    ppDBText137: TppDBText;
    ppDBText138: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppLabel212: TppLabel;
    ppLabel213: TppLabel;
    ppLabel214: TppLabel;
    ppLabel215: TppLabel;
    ppLabel216: TppLabel;
    ppLabel217: TppLabel;
    ppLabel218: TppLabel;
    ppLabel219: TppLabel;
    ppLabel220: TppLabel;
    ppLabel221: TppLabel;
    ppDesignLayers3: TppDesignLayers;
    ppDesignLayer3: TppDesignLayer;
    ppParameterList3: TppParameterList;
    RptDotMatrix0924: TppReport;
    ppHeaderBand4: TppHeaderBand;
    ppDBText139: TppDBText;
    ppDBText140: TppDBText;
    ppDBText141: TppDBText;
    ppDBText142: TppDBText;
    ppDBText143: TppDBText;
    ppDBText144: TppDBText;
    ppDBText145: TppDBText;
    ppDBText146: TppDBText;
    ppDBText147: TppDBText;
    ppDBText148: TppDBText;
    ppLabel223: TppLabel;
    ppDBText149: TppDBText;
    ppDBText150: TppDBText;
    ppLabel224: TppLabel;
    ppLabel225: TppLabel;
    ppLabel226: TppLabel;
    ppDBText151: TppDBText;
    ppDBText152: TppDBText;
    ppDBText153: TppDBText;
    ppDBText154: TppDBText;
    ppDBText155: TppDBText;
    ppLabel227: TppLabel;
    ppDBText156: TppDBText;
    ppDBText157: TppDBText;
    ppChkPawn0924: TmyCheckBox;
    ppChkPurchase0924: TmyCheckBox;
    ppDBText158: TppDBText;
    ppDBText159: TppDBText;
    ppDetailBand3: TppDetailBand;
    ppDBText160: TppDBText;
    ppDBText161: TppDBText;
    ppDBText162: TppDBText;
    ppDBText163: TppDBText;
    ppDBText164: TppDBText;
    ppDBText165: TppDBText;
    ppDBText166: TppDBText;
    ppDBText167: TppDBText;
    ppDBText168: TppDBText;
    ppDBText169: TppDBText;
    ppDBText170: TppDBText;
    ppDBText171: TppDBText;
    ppDBText172: TppDBText;
    ppDBText173: TppDBText;
    ppDBText174: TppDBText;
    ppDBText175: TppDBText;
    ppDBText176: TppDBText;
    ppDBText177: TppDBText;
    ppDBText178: TppDBText;
    ppDBText179: TppDBText;
    ppDBText180: TppDBText;
    ppDBText181: TppDBText;
    ppDBText182: TppDBText;
    ppDBText183: TppDBText;
    ppDBText184: TppDBText;
    ppFooterBand3: TppFooterBand;
    ppLabel228: TppLabel;
    ppLabel229: TppLabel;
    ppLabel230: TppLabel;
    ppLabel231: TppLabel;
    ppLabel232: TppLabel;
    ppLabel233: TppLabel;
    ppLabel234: TppLabel;
    ppLabel235: TppLabel;
    ppLabel236: TppLabel;
    ppLabel237: TppLabel;
    ppDesignLayers4: TppDesignLayers;
    ppDesignLayer4: TppDesignLayer;
    ppParameterList4: TppParameterList;
    RptPoliceRep: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppLabel1: TppLabel;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppLabel5: TppLabel;
    ppDBText50: TppDBText;
    ppDBText51: TppDBText;
    ppChkPawn: TmyCheckBox;
    ppChkPurchase: TmyCheckBox;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    DetailBand: TppDetailBand;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppDBText41: TppDBText;
    ppDBText43: TppDBText;
    ppDBText44: TppDBText;
    ppDBText42: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText47: TppDBText;
    ppDBText48: TppDBText;
    ppDBText49: TppDBText;
    ppDBText31: TppDBText;
    FooterBand: TppFooterBand;
    lblAmount: TppLabel;
    ppLabel7: TppLabel;
    lblTranInterestAtMaturity: TppLabel;
    lblTotalAmountAtMaturity: TppLabel;
    lblAnnualPercRate: TppLabel;
    lblTranMaturity: TppLabel;
    lblPawnDefaultDate: TppLabel;
    lblTAmountRedeemDefaultDate: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    lblPrePrintedLaserPageType: TppLabel;
    lblPageTypeInitial: TppLabel;
    rgStoreName: TppRegion;
    ppRegion2: TppRegion;
    lblStoreName2: TppLabel;
    TimerForScan: TTimer;
    qryPoliceRepCustcPrnHPhone: TStringField;
    qryPawnItemsWeightUnit: TStringField;
    clnPawnItemsWeightUnit: TStringField;
    qryPawnItemscWeightToPrint: TStringField;
    clnPawnItemscWeightToPrint: TStringField;
    qryPawnItemscStone1WT: TStringField;
    qryPawnItemscStone2WT: TStringField;
    clnPawnItemscStone1WT: TStringField;
    clnPawnItemscStone2WT: TStringField;
    qryPawnStonesStoneWeightUnit: TStringField;
    pgTransactions: TRzPageControl;
    TabPawnTran: TRzTabSheet;
    TabPurchaseTran: TRzTabSheet;
    gridPawn: TDBGrid;
    Panel4: TPanel;
    btnNewPawn: TBitBtn;
    btnEditPawn: TBitBtn;
    btnDelPawn: TBitBtn;
    btnNewPathWithItems: TRzBitBtn;
    DBGrid6: TDBGrid;
    Panel5: TPanel;
    btnNewPurchase: TBitBtn;
    btnEditPurchase: TBitBtn;
    btnDeletePurchase: TBitBtn;
    pgTransDetail: TRzPageControl;
    TabPayment: TRzTabSheet;
    TabItems: TRzTabSheet;
    gridItems: TDBGrid;
    Panel7: TPanel;
    bntCalcUnitcost: TRzToolButton;
    btnAddInvItems: TBitBtn;
    btnEditInvItems: TBitBtn;
    btnDeleteItem: TBitBtn;
    btnItemPictures: TRzBitBtn;
    gridPayments: TDBGrid;
    Panel3: TPanel;
    btnPayAdd: TBitBtn;
    btnPayEdit: TBitBtn;
    btnPayDelete: TBitBtn;
    PopMnuPawnItems: TPopupMenu;
    popmnuItemRedeemed: TMenuItem;
    popmnuItemDefaulted: TMenuItem;
    N1: TMenuItem;
    popmnuItemMeltedScrap: TMenuItem;
    popmnuItemForSale: TMenuItem;
    popmnuItemPawned: TMenuItem;
    N2: TMenuItem;
    btnPrintPayReceipt: TRzToolButton;
    btnPrintEnvLabel: TRzToolButton;
    edPhone: TPawnPhoneEdit;
    pnPawnPayBalance: TPanel;
    pnPawnItemBalance: TPanel;
    lblNextPaymentInfoItems: TJvLinkLabel;
    lblNextPaymentInfo: TJvLinkLabel;
    TabLayawayTran: TRzTabSheet;
    DBGrid1: TDBGrid;
    Panel6: TPanel;
    btnNewLayaway: TBitBtn;
    btnEditLayaway: TBitBtn;
    btnDeleteLayaway: TBitBtn;
    btnLayawayRcpt: TRzToolButton;
    PopMnuLayaway: TPopupMenu;
    mnuCloseLayaway: TMenuItem;
    N3: TMenuItem;
    mnuReOpenLayaway: TMenuItem;
    btnCloseLayaway: TBitBtn;
    btnAdjPoliceReport: TRzToolButton;
    qryInvItems: TFDQuery;
    qryInvItemsHAS_PICS: TBooleanField;
    qryInvItemsINV_ITEM_NO: TIntegerField;
    qryInvItemsINV_ITEM_BARCODE: TStringField;
    qryInvItemsINV_CAT_NO: TIntegerField;
    qryInvItemsJ_TYPE: TStringField;
    qryInvItemsJ_STYLE: TStringField;
    qryInvItemsJ_METAL: TStringField;
    qryInvItemsINV_ITEM_COUNT: TIntegerField;
    qryInvItemsNOTE: TStringField;
    qryInvItemsSIZE_LENGTH: TFloatField;
    qryInvItemsWEIGHT: TFloatField;
    qryInvItemsKT: TFloatField;
    qryInvItemsCREATED: TSQLTimeStampField;
    qryInvItemsUNIT_COST: TFMTBCDField;
    qryInvItemsUNIT_PRICE: TFMTBCDField;
    qryInvItemsINV_ITEM_STATUS: TStringField;
    qryInvItemsTRANSACTION_NO: TIntegerField;
    qryInvItemsINV_ORIGINAL_ITEM_NO: TIntegerField;
    qryInvItemsINV_ITEM_BRAND: TStringField;
    qryInvItemsSERIAL_NUMBER: TStringField;
    qryInvItemsOWNER_APP_NUMBER: TStringField;
    qryInvItemsMODEL_NUMBER: TStringField;
    qryInvItemsGENDER: TStringField;
    qryInvItemsDESCRIPTION: TStringField;
    qryInvItemsWEIGHT_UNIT: TStringField;
    qryInvItemsPAWNED_DATE: TDateField;
    qryInvItemsPURCHASE_DATE: TDateField;
    qryInvItemsREDEEMED_DATE: TDateField;
    qryInvItemsDEFAULTED_DATE: TDateField;
    qryInvItemsMELTED_DATE: TDateField;
    qryInvItemsFORSALE_DATE: TDateField;
    qryInvItemsSOLD_DATE: TDateField;
    qryInvItemsLAYAWAY_DATE: TDateField;
    qryInvItemscType: TStringField;
    qryInvItemscStyle: TStringField;
    qryInvItemscMetal: TStringField;
    qryInvItemscTotalWeight: TFloatField;
    qryInvItemscStatus: TStringField;
    qryInvItemscHasPics: TStringField;
    qryStyles: TFDMemTable;
    qryTypes: TFDMemTable;
    qryMetal: TFDMemTable;
    qryStylesJ_STYLE: TStringField;
    qryStylesJ_STYLE_DESC: TStringField;
    qryTypesJ_TYPE: TStringField;
    qryTypesJ_TYPE_DESC: TStringField;
    qryMetalJ_METAL: TStringField;
    qryMetalJ_METAL_DESC: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnClientEditClick(Sender: TObject);
    procedure btnClientAddClick(Sender: TObject);
    procedure btnClientDeleteClick(Sender: TObject);
    procedure btnTranEditClick(Sender: TObject);
    procedure btnTranAddClick(Sender: TObject);
    procedure btnTranDeleteClick(Sender: TObject);
    procedure btnPayEditClick(Sender: TObject);
    procedure btnPayAddClick(Sender: TObject);
    procedure btnPayDeleteClick(Sender: TObject);
    procedure btnPrintPolRptClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ActionScanCardExecute(Sender: TObject);
    procedure btnAddInvItemsClick(Sender: TObject);
    procedure btnEditInvItemsClick(Sender: TObject);
    procedure qryInvItemsCalcFields(DataSet: TDataSet);
    procedure qryInvItemsNewRecord(DataSet: TDataSet);
    procedure qryInvItemsAfterPost(DataSet: TDataSet);
    procedure ppLabel1GetText(Sender: TObject; var Text: String);
    procedure txtAdjTopMarginKeyPress(Sender: TObject; var Key: Char);
    procedure ppLabel2GetText(Sender: TObject; var Text: String);
    procedure ppLabel3GetText(Sender: TObject; var Text: String);
    procedure ppLabel4GetText(Sender: TObject; var Text: String);
    procedure ppLabel5GetText(Sender: TObject; var Text: String);
    procedure btnNewWithCopyItemsClick(Sender: TObject);
    procedure btnDeleteItemClick(Sender: TObject);
    procedure qryPawnItemsCalcFields(DataSet: TDataSet);
    procedure pgTransactionsChange(Sender: TObject);
    procedure btnNewPurchaseClick(Sender: TObject);
    procedure btnEditPurchaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblAmountGetText(Sender: TObject; var Text: String);
    procedure ppLabel7GetText(Sender: TObject; var Text: String);
    procedure lblTranInterestAtMaturityGetText(Sender: TObject;
      var Text: String);
    procedure lblTotalAmountAtMaturityGetText(Sender: TObject; var Text: String);
    procedure lblAnnualPercRateGetText(Sender: TObject; var Text: String);
    procedure lblTranMaturityGetText(Sender: TObject; var Text: String);
    procedure lblPawnDefaultDateGetText(Sender: TObject; var Text: String);
    procedure lblTAmountRedeemDefaultDateGetText(Sender: TObject;
      var Text: String);
    procedure ppChkPurchasePrint(Sender: TObject);
    procedure ppChkPawnPrint(Sender: TObject);
    procedure btnAdjPoliceReportClick(Sender: TObject);
    procedure ppLabel8GetText(Sender: TObject; var Text: string);
    procedure ppLabel9GetText(Sender: TObject; var Text: string);
    procedure bntCalcUnitcostClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure PopMnuTransactionsPopup(Sender: TObject);
    procedure mnuPawnStatusActiveClick(Sender: TObject);
    procedure DBGridTranDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TimerScanningTimeOutTimer(Sender: TObject);
    procedure ppLabel176GetText(Sender: TObject; var Text: string);
    procedure btnClearSearchFieldsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure qryPoliceRepCustCalcFields(DataSet: TDataSet);
    procedure btnItemPicturesClick(Sender: TObject);
    procedure TimerForScanTimer(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure pgTransDetailChange(Sender: TObject);
    procedure btnPrintPayReceiptClick(Sender: TObject);
    procedure gridItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PopMnuPawnItemsPopup(Sender: TObject);
    procedure popmnuItemRedeemedClick(Sender: TObject);
    procedure popmnuItemDefaultedClick(Sender: TObject);
    procedure popmnuItemMeltedScrapClick(Sender: TObject);
    procedure popmnuItemForSaleClick(Sender: TObject);
    procedure popmnuItemPawnedClick(Sender: TObject);
    procedure btnPrintEnvLabelClick(Sender: TObject);
    procedure qryInvItemsAfterScroll(DataSet: TDataSet);
    procedure gridPaymentsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnNewLayawayClick(Sender: TObject);
    procedure btnLayawayRcptClick(Sender: TObject);
    procedure btnEditLayawayClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PopMnuLayawayPopup(Sender: TObject);
    procedure mnuCloseLayawayClick(Sender: TObject);
    procedure btnCloseLayawayClick(Sender: TObject);
    procedure mnuPawnStatusInactiveClick(Sender: TObject);
    procedure mnuReOpenLayawayClick(Sender: TObject);
  private
    LastThreeKeys: TKeyQueue;
    ScanningCard, PreHeaderDetected: boolean;
    ReadingCardBuffer: string;
    CardScanNewLineCounter: integer;
    ScanningPDF417Barcode: boolean;
    ReadChars: string;
    ScanData: TScanDataList;
    LastDataCount: integer;
    procedure AddToKeyQueue(Key: Word);
    function MatchLastKeys(KeyPattern: TKeyQueue): boolean;
    procedure ProcessScannedCard(var Msg: TMessage); Message sx_ProcessCardScanning;
    procedure KeyPressForMagneticScan(var Key: Char);
    procedure PopulateFieldsWithDrvLicInfo(const DrvLicInfo: TDriverLicenseInfo);
    procedure ProcessAndShowBarcodeData;
    procedure AddEditTransaction(NewTransaction: boolean);
    function GetPawnItemStatus: string;
    function GetItemAction: string;
    procedure UpdateStatusOnSelectedItemInPopUp(TransactionNo, ItemNo: integer;
      const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
    procedure GetPaymentDueDateBalanceMessage;
    procedure ProcessNewPaymentDueDateMessage(var Msg: TMessage); Message sx_RefreshPaymentDueDateMesg;
    procedure AddEditPayments(NewRow: boolean);
    procedure AddEditLayaway(NewRow: boolean);
  public
//    PoliceRptPrinter, PoliceRptPrinterBin, PayReceiptPrinterName, PayReceiptPrinterNameBin: string;
    procedure OpenClientsQuery(FName, LName: string);
    procedure SaveTopMarginPolRep;
    procedure CalcPawnAmountFromItemCost(var PawnAmount: Currency; var ItemsWithNoEnteredCost: integer);
  end;

var
  frmClients: TfrmClients;

implementation

uses PawnMain, PawnDM, EnterClientInfo, EnterTransactions,
  EnterPayment, CardReader, EditInvItem, Entertems,
  EnterPurchase, PoliceAdj, IDNumCalc, ItemPictures,
  ReportsDM, uPawnProIniPrinters, EnterLayaway,
  PaymentLayaway, ConfirmCloseLayaway, GLbUtils, PawnChangeStatus;

{$R *.DFM}

procedure TfrmClients.OpenClientsQuery(FName, LName: string);
var
  SQLStr: string;
begin
  DM.qryCustomers.Close;

  if FName <> '' then
    Fname := '%' + FName + '%'
  else
    Fname := '%';

  if LName <> '' then
    LName := '%' + LName + '%'
  else
    LName := '%';

  SQLStr := DM.SaveCustQry;

  if trim(edTicketNo.Text) <> '' then
    begin
      SQLStr := ReplaceStr(SQLStr, '--SearchByTicketNo', ' AND CUST_NO in (select CUST_NO from TRANSACTIONS where TRAN_TICKET_NO = ' + QuotedStr(trim(edTicketNo.Text)) + ') ');
    end;

  if trim(edPhone.Digits) <> '' then
    begin
      SQLStr := ReplaceStr(SQLStr, '--SearchByPhone', ' AND ' + QuotedStr( trim(edPhone.Digits) ) + ' in (CUST_PH_BEEP, CUST_PH_BUSINESS, CUST_PH_CELL, CUST_PH_HOME) ');
    end;


  DM.qryCustomers.SQL.Text := SQLStr;

  DM.qryCustomers.Params.ParamByName('CUST_LAST').AsString := LName;
  DM.qryCustomers.Params.ParamByName('CUST_FIRST').AsString := Fname;

  Screen.Cursor := crHourGlass;
  try
    DM.qryCustomers.Open;

    pgTransactionsChange(nil);
    DM.qryCustomersAfterScroll(nil);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmClients.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PropertyStore.Save;
  DM.qryTransactions.Filter := '';

//  frmPawnMain.ClientsMnu.Visible := false;
  frmPawnMain.btnTabClient.Enabled := false;

  DM.qryPayments.Close;
  DM.qryTransactions.Close;
  DM.qryCustomers.Close;
//  PostMessage(frmPawnMain.Handle, sx_CloseClients, 0, 0);

  SaveTopMarginPolRep;

  Action := caFree;
  frmClients := nil;

end;

procedure TfrmClients.FormShow(Sender: TObject);
begin
  lblNextPaymentInfo.Caption := '';
  lblNextPaymentInfoItems.Caption := '';

  pgTransDetail.ActivePageIndex := 1;
  pgTransactions.ActivePageIndex := 0;

  btnPrintPayReceipt.Visible := AppPrinterSettings.UsePaymentReceiptPrinter;
  btnPrintEnvLabel.Visible := AppPrinterSettings.UseEnvelopeLabelPrinter;

  LoadPrinterSettingsFromIni(GlobalIniFile, AppPrinterSettings);

  DM.RefreshStoreQry;

  btnAdjPoliceReport.Visible := DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger in [1, 3, 4];

  DM.GetJTypes(qryTypes);
  DM.GetJStyles(qryStyles);
  DM.GetJMetals(qryMetal);
//  qryStatus.Open;

  qryInvItems.Open;

  OpenClientsQuery('', '');
  DM.qryTransactions.Open;
  DM.qryPayments.Open;
  DM.qryLastPayment.Open;

  DM.RefreshStoreQry;

  //txtAdjTopMargin.Text := IntToStr(DM.qryStoreSTORE_ADJ_TOP_MARG.AsInteger);
//  frmPawnMain.ClientsMnu.Visible := true;
  frmPawnMain.btnTabClient.Enabled := true;

  edFirst.SetFocus;
  pgTransDetailChange(nil);
  Invalidate;
end;

procedure TfrmClients.btnSearchClick(Sender: TObject);
begin
  OpenClientsQuery(trim(edFirst.Text), trim(edLast.Text));
end;

procedure TfrmClients.btnClientEditClick(Sender: TObject);
begin
  if DM.qryCustomersCUST_NO.AsInteger <= 0 then
    begin
      MessageDlg('Nothing to edit.', mtInformation, [mbOK], 0);
      exit;
    end;

  frmEnterClientInfo := TfrmEnterClientInfo.Create(Self);
  try
    frmEnterClientInfo.NewRow := false;
    frmEnterClientInfo.ShowModal;
  finally
    frmEnterClientInfo.Free;
  end;
end;

procedure TfrmClients.btnClearSearchFieldsClick(Sender: TObject);
begin
  edFirst.Text := '';
  edLast.Text := '';
  edTicketNo.Text := '';
  edPhone.ClearField;

  edFirst.SetFocus;
end;

procedure TfrmClients.btnClientAddClick(Sender: TObject);
begin
  frmEnterClientInfo := TfrmEnterClientInfo.Create(Self);
  try
    frmEnterClientInfo.NewRow := true;
    frmEnterClientInfo.ShowModal;
  finally
    frmEnterClientInfo.Free;
  end;
end;

procedure TfrmClients.btnClientDeleteClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete this Client?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DM.qryCustomers.Delete;
//      DM.qryCustomers.ApplyUpdates;
    end;
end;

procedure TfrmClients.Button1Click(Sender: TObject);
begin
end;

//type
//  TCustDBGridEx=class(TCustomDBGrid);

procedure TfrmClients.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DBGrid: TDBGrid;
begin
  DBGrid := (Sender as TDBGrid);

  if DataCol = 0 then
    begin
      DBGrid.Canvas.Brush.Color := clWhite;
      if DM.qryTransactionsTRAN_STATUS.AsString = 'I' then
        begin
          DBGrid.Canvas.Brush.Color := clDkGray;
          DBGrid.Canvas.Font.Color  := clWhite;
        end;

      DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;

procedure TfrmClients.DBGridTranDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DBGrid: TDBGrid;
//  DBCustGrid : TCustDBGridEx;
//  DataLink    : TDataLink;
begin
  DBGrid := (Sender as TDBGrid);

  if DataCol = 0 then
    begin
      DBGrid.Canvas.Brush.Color := clWhite;
      if DM.qryTransactionsTRAN_STATUS.AsString = 'I' then
        begin
          DBGrid.Canvas.Brush.Color := clDkGray;
          DBGrid.Canvas.Font.Color  := clWhite;
        end;
      DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;

procedure TfrmClients.btnTestClick(Sender: TObject);
//var
//  DrvLicData: TStringList;
//  DrvLic: TDriverLicenseInfo;
//  BarcodeData: string;
begin
//  Memo1.Lines.Clear;
//  DrvLicData := TStringList.Create;
//  try
//    DrvLicData.LoadFromFile('D:\Pawn\Driver_License.txt');
//    BarcodeData := DrvLicData.Text;
//    ParsePDF417_US_Driver_License(BarcodeData, DrvLic);
//
//    Memo1.Lines.Add('FirstName:' + DrvLic.FirstName);
//    Memo1.Lines.Add('MiddleName:' + DrvLic.MiddleName);
//    Memo1.Lines.Add('LastName:' + DrvLic.LastName);
//    Memo1.Lines.Add('Sex:' + DrvLic.Sex);
//    Memo1.Lines.Add('PersonHeight:' + DrvLic.PersonHeight);
//
//    Memo1.Lines.Add('Address:' + DrvLic.Address);
//    Memo1.Lines.Add('City:' + DrvLic.City);
//    Memo1.Lines.Add('State:' + DrvLic.State);
//    Memo1.Lines.Add('ZipCode:' + DrvLic.ZipCode);
//    Memo1.Lines.Add('Country:' + DrvLic.Country);
//
//    Memo1.Lines.Add('DOB:' + FormatDateTime('mm/dd/yyyy', DrvLic.DOB));
//    Memo1.Lines.Add('IssuedDate:' + FormatDateTime('mm/dd/yyyy', DrvLic.IssuedDate));
//    Memo1.Lines.Add('Exp:' + FormatDateTime('mm/dd/yyyy', DrvLic.Exp));
//
//    Memo1.Lines.Add('VehicleClass:' + DrvLic.VehicleClass);
//    Memo1.Lines.Add('DrivervLicNumber:' + DrvLic.DrivervLicNumber);
//
//  finally
//    DrvLicData.Free;
//  end;
end;

procedure TfrmClients.CalcPawnAmountFromItemCost(var PawnAmount: Currency; var ItemsWithNoEnteredCost: integer);
var
  BK: TBookmark;
begin
  PawnAmount := 0;
  ItemsWithNoEnteredCost := 0;

  if qryInvItems.RecordCount = 0 then
    exit;

  BK := qryInvItems.Bookmark;
  qryInvItems.DisableControls;

  try
    qryInvItems.First;
    while not qryInvItems.Eof do
      begin
        if qryInvItemsUNIT_COST.AsCurrency > 0 then
          PawnAmount := PawnAmount + qryInvItemsUNIT_COST.AsCurrency
        else
          inc(ItemsWithNoEnteredCost);

        qryInvItems.Next;
      end;

  finally
    qryInvItems.Bookmark := BK;
    qryInvItems.EnableControls;
  end;
end;

procedure TfrmClients.AddEditTransaction(NewTransaction: boolean);
var
  EnableCalcPawnAmountFromItemsCost: boolean;
begin
  pgTransactions.ActivePageIndex := 0;
  pgTransactionsChange(nil);

  if DM.qryCustomersCUST_NO.AsInteger <= 0 then
    begin
      MessageDlg('Please enter client information first', mtInformation, [mbOK], 0);
      exit;
    end;

  if not NewTransaction and (DM.qryTransactionsTRANSACTION_NO.AsInteger <= 0) then
    begin
      MessageDlg('Nothing to edit.', mtInformation, [mbOK], 0);
      exit;
    end;

  EnableCalcPawnAmountFromItemsCost := not NewTransaction and (qryInvItems.RecordCount > 0);

  frmEnterTransaction := TfrmEnterTransaction.Create(Self);
  try
    frmEnterTransaction.NewRow := NewTransaction;
    frmEnterTransaction.CustNo := 0;
    frmEnterTransaction.btnGetPawnAddingAllItemCost.Enabled := EnableCalcPawnAmountFromItemsCost;
    frmEnterTransaction.ShowModal;
    GetPaymentDueDateBalanceMessage;
  finally
    frmEnterTransaction.Free;
  end;

end;

procedure TfrmClients.btnTranAddClick(Sender: TObject);
begin
  AddEditTransaction(true);
//  pgTransactions.ActivePageIndex := 0;
//  pgTransactionsChange(nil);
//  if DM.qryCustomersCustNo.AsInteger <= 0 then
//    begin
//      MessageDlg('Please enter client information first', mtInformation, [mbOK], 0);
//      exit;
//    end;
//
//  frmEnterTransaction := TfrmEnterTransaction.Create(Self);
//  try
//    frmEnterTransaction.NewRow := true;
//    frmEnterTransaction.CustNo := 0;
//    frmEnterTransaction.ShowModal;
//  finally
//    frmEnterTransaction.Free;
//  end;
end;

procedure TfrmClients.btnTranEditClick(Sender: TObject);
begin
  AddEditTransaction(false);
end;


procedure TfrmClients.btnTranDeleteClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete this Transaction?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DM.qryTransactions.Delete;
    end;

end;

procedure TfrmClients.AddEditPayments(NewRow: boolean);
begin
  pgTransDetail.ActivePageIndex := 0;

  if pgTransactions.ActivePageIndex <> 2 then
    begin
      frmEnterPayment := TfrmEnterPayment.Create(Self);
      try
        frmEnterPayment.NewRow := NewRow;
        if frmEnterPayment.ShowModal = mrOk then
          begin
            DM.qryPayments.Close;
            DM.qryPayments.Open;
            GetPaymentDueDateBalanceMessage;
          end;
      finally
        frmEnterPayment.Free;
      end;
    end
  else
    begin
      frmPaymentLayaway := TfrmPaymentLayaway.Create(self);
      try
        frmPaymentLayaway.NewRow := NewRow;
        if frmPaymentLayaway.ShowModal = mrOk then
          begin
            DM.qryPayments.Close;
            DM.qryPayments.Open;
          end;
      finally
        frmPaymentLayaway.Free;
      end;
    end;
end;

procedure TfrmClients.btnPayAddClick(Sender: TObject);
begin
  if DM.qryTransactionsTRANSACTION_NO.AsInteger <= 0 then
    begin
      MessageDlg('Please enter Transaction information first', mtInformation, [mbOK], 0);
      exit;
    end;

  AddEditPayments(True);
end;

procedure TfrmClients.btnPayEditClick(Sender: TObject);
begin
  if DM.qryPaymentsPAYMENT_NO.AsInteger <= 0 then
    begin
      MessageDlg('Nothing to edit.', mtInformation, [mbOK], 0);
      exit;
    end;

  AddEditPayments(false);
end;

procedure TfrmClients.btnPayDeleteClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete this Payment?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DM.qryPayments.Delete;
      case pgTransactions.ActivePageIndex of
      0: GetPaymentDueDateBalanceMessage; //Pawn
      2: DM.RecalcLayawayPBalance; //Layaway
      end;
    end;
end;

procedure TfrmClients.btnPrintEnvLabelClick(Sender: TObject);
var
  qry: TFDQuery;
  TotalItems, iPos: integer;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.ConnFB;
    qry.SQL.Text := 'select INV_ITEM_NO from INVENTORY_ITEMS where TRANSACTION_NO = :TRANSACTION_NO order by INV_ITEM_NO';
    qry.Params.ParamByName('TRANSACTION_NO').AsInteger := DM.qryTransactionsTRANSACTION_NO.AsInteger;
    qry.Open;
    TotalItems := qry.RecordCount;
    iPos := 0;
    while not qry.Eof do
    begin
      inc(iPos);
      DMReports.PrintItemEnvelopeLable(qry.FieldByName('INV_ITEM_NO').AsInteger, iPos, TotalItems);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmClients.btnPrintPayReceiptClick(Sender: TObject);
begin
  if DM.qryPayments.RecordCount > 0 then
    DMReports.PrintPaymentReceipt(DM.qryPaymentsPAYMENT_NO.AsInteger, AppPrinterSettings.PayReceiptPrinter, AppPrinterSettings.PayReceiptPrinterBin);
end;

procedure TfrmClients.btnPrintPolRptClick(Sender: TObject);
const
  ItemsPerPage = 6;
var
  items, i: integer;
  mult: Extended;
begin
  DM.RefreshStoreQry;

  if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger in [1, 3, 4] then
    begin
      qryPawnItems.Close;
      qryPawnItems.Params.ParamByName('TransactionNo').AsInteger := DM.qryTransactionsTRANSACTION_NO.AsInteger;
      qryPawnItems.Open;
    end
  else if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger = 2 then
    begin
      clnPawnItems.Close;
      clnPawnItems.Params.ParamByName('TransactionNo').AsInteger := DM.qryTransactionsTRANSACTION_NO.AsInteger;
      clnPawnItems.Open;

      mult := clnPawnItems.RecordCount / (ItemsPerPage * 1.0);
      if (Frac(mult) <> 0) or (clnPawnItems.RecordCount = 0) then
        begin
           items := ((trunc(mult) + 1) * ItemsPerPage) - clnPawnItems.RecordCount;
           clnPawnItems.Last;
           for i := 1 to items do
             begin
               clnPawnItems.Append;
               clnPawnItems.Post;
             end;
        end;
       clnPawnItems.First;
    end;

  qryPoliceRepCust.Close;
  qryPoliceRepCust.Params.ParamByName('Custno').AsInteger := DM.qryCustomersCUST_NO.AsInteger;
  qryPoliceRepCust.Open;

  lblStoreName2.Visible := false;
  lblStoreName2.Caption := 'Pawnshop';

  RptPoliceRep.PrinterSetup.PrinterName := AppPrinterSettings.PoliceReportPrinter;
  RptPoliceRep.PrinterSetup.MarginTop := 0.01 * DM.qryStoreSTORE_ADJ_TOP_MARG.AsInteger;

  RptPoliceLaserPrePrinted.PrinterSetup.MarginTop := 0.01 * DM.qryStoreSTORE_ADJ_TOP_MARG.AsInteger;

  if DM.qryStoreSTORE_ADJ_DETAIL_HEIGHT.AsInteger > 0 then
    begin
//      RptPoliceRep.DetailBand.Height := 0.01 * DM.qryStoreSTORE_ADJ_DETAIL_HEIGHT.AsInteger;
//      RptPoliceLaserPrePrinted.DetailBand.Height := 0.01 * DM.qryStoreSTORE_ADJ_DETAIL_HEIGHT.AsInteger;
    end;

//////////////////////////////////////////PRINT SELECTED REPORT///////////////////////////////////////////////
  if DM.qryStoreSTORE_ADJ_FOOTER_HEIGHT.AsInteger > 0 then
    begin
      RptPoliceRep.FooterBand.Height := 0.01 * DM.qryStoreSTORE_ADJ_FOOTER_HEIGHT.AsInteger;
      RptPoliceLaserprePrinted.FooterBand.Height := 0.01 * DM.qryStoreSTORE_ADJ_FOOTER_HEIGHT.AsInteger;
    end;

  if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger = 1 then //Dot Matrix 0920
    begin
      RptPoliceRep.Print
    end
  else if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger = 2 then //Laser Print all form
    begin
      RepPoliceLaser.PrinterSetup.PrinterName := AppPrinterSettings.PoliceReportPrinter;
      RepPoliceLaser.PrinterSetup.Copies := DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger;

      DMReports.PrintToTray(RepPoliceLaser, AppPrinterSettings.PoliceReportPrinter, AppPrinterSettings.PoliceReportBin);  /////////////LASER/////////////////////////
    end
  else if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger = 3 then //Laser PrePrinted
    begin
      for i := 1 to DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger do
        begin
          RptPoliceLaserprePrinted.PrinterSetup.PrinterName := AppPrinterSettings.PoliceReportPrinter;
    //      RptPoliceLaserprePrinted.PrinterSetup.Copies := DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger;
          case i of
          1:
            begin
              lblPrePrintedLaserPageType.Caption := 'Client Copy';
              lblPageTypeInitial.Caption := 'C';
            end;
          2:
            begin
              lblPrePrintedLaserPageType.Caption := 'Police Copy';
              lblPageTypeInitial.Caption := 'P';
            end;
          3:
            begin
              lblPrePrintedLaserPageType.Caption := 'Store Copy';
              lblPageTypeInitial.Caption := 'S';
            end
          else
            lblPrePrintedLaserPageType.Caption := '';
          end;

          DMReports.PrintToTray(RptPoliceLaserPrePrinted, AppPrinterSettings.PoliceReportPrinter, AppPrinterSettings.PoliceReportBin); /////////////LASER/////////////////////////
        end;
    end
  else if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger = 4 then //Dot Matrix 0924
    begin
      RptDotMatrix0924.PrinterSetup.PrinterName := RptPoliceRep.PrinterSetup.PrinterName;
      RptDotMatrix0924.PrinterSetup.MarginTop := RptPoliceRep.PrinterSetup.MarginTop;
      RptDotMatrix0924.DetailBand.Height := RptPoliceRep.DetailBand.Height;
      RptDotMatrix0924.FooterBand.Height := RptPoliceRep.FooterBand.Height;

      RptDotMatrix0924.PrintReport;
    end;

  qryPoliceRepCust.Close;
end;

procedure TfrmClients.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmClients.btnCloseLayawayClick(Sender: TObject);
begin
  if DM.qryTransactions.RecordCount = 0 then
    exit;

  if DM.qryTransactionsTRAN_STATUS.AsString = TranStatus_Inactive then
    begin
      MsgInfo('This Layaway is already close.');
      exit;
    end;

  if DM.qryTransactionsPRINC_BALANCE.AsCurrency > 0 then
    begin
      frmConfirmCloseLayaway := TfrmConfirmCloseLayaway.Create(Self);
      try
        frmConfirmCloseLayaway.LayawayBalance := DM.qryTransactionsPRINC_BALANCE.AsCurrency;
        if frmConfirmCloseLayaway.ShowModal = mrCancel then
          exit;

      finally
        frmConfirmCloseLayaway.Free;
      end;
    end
  else
    begin
      DM.LaywayClosePayoffBalance(DM.qryTransactionsTRANSACTION_NO.AsInteger, false);
    end;

   DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.ActionScanCardExecute(Sender: TObject);
begin
  frmDriverLicCardReader := TfrmDriverLicCardReader.Create(Application);
  try
    if frmDriverLicCardReader.ShowModal = mrOK then
      begin
        edFirst.Text := frmDriverLicCardReader.edFirst.Text;
        edLast.Text := frmDriverLicCardReader.edLast.Text;
        btnSearchClick(nil);
      end;
  finally
    frmDriverLicCardReader.Free;
  end;
end;

procedure TfrmClients.bntCalcUnitcostClick(Sender: TObject);
begin
  DM.CalcUnitCostFromWeight(DM.qryTransactionsTRANSACTION_NO.AsInteger);
  qryInvItems.Close;
  qryInvItems.Open;
end;

procedure TfrmClients.btnAddInvItemsClick(Sender: TObject);
begin
  if DM.qryTransactionsTRANSACTION_NO.AsInteger <= 0 then
    begin
      MessageDlg('Please enter Transaction information first', mtInformation, [mbOK], 0);
      exit;
    end;

  frmEnterItems := TfrmEnterItems.Create(Self);
  try
    frmEnterItems.NewRow := true;
    frmEnterItems.dsInvItems.DataSet := qryInvItems;
    frmEnterItems.ShowModal;
  finally
    frmEnterItems.Free;
  end;
end;

procedure TfrmClients.btnEditInvItemsClick(Sender: TObject);
begin
  if qryInvItems.RecordCount = 0 then
    begin
      MessageDlg('Nothing to edit', mtInformation, [mbOk], 0);
      exit;
    end;

  frmEnterItems := TfrmEnterItems.Create(Self);
  try
    frmEnterItems.NewRow := false;
    frmEnterItems.dsInvItems.DataSet := qryInvItems;
    frmEnterItems.ShowModal;
  finally
    frmEnterItems.Free;
  end;
end;

procedure TfrmClients.btnEditLayawayClick(Sender: TObject);
begin
  AddEditLayaway(false);
end;

function TfrmClients.GetItemAction: string;
begin
  Result := '';
  if not qryInvItemsMELTED_DATE.IsNull then
    Result := PawnItemStatus_Melted
  else if not qryInvItemsFORSALE_DATE.IsNull then
    Result := PawnItemStatus_ForSale;
end;

function TfrmClients.GetPawnItemStatus: string;
begin
  if not qryInvItemsPAWNED_DATE.IsNull then
    begin
      if not qryInvItemsREDEEMED_DATE.IsNull then
        begin
          Result := PawnItemStatus_Redeemed;
        end
      else if not qryInvItemsDEFAULTED_DATE.IsNull then
        begin
          Result := GetItemAction;
          if Result = '' then
            Result := PawnItemStatus_Defaulted;
        end
      else
        Result := PawnItemStatus_Pawned;
    end
  else if not qryInvItemsPURCHASE_DATE.IsNull then
    begin
      Result := GetItemAction;
      if Result = '' then
        Result := 'Purchased';
    end
  else if not qryInvItemsSOLD_DATE.IsNull then
    begin
      Result := PawnItemStatus_Sold;
    end;
end;

procedure TfrmClients.gridItemsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  C: TPawnStatusColor;
  Grid: TDBGrid;
  DrawDefault: boolean;
//  RowNum: Integer;
//  RowNumStr: string;
//  Flags: UINT;
//  R: TRect;
begin
  DrawDefault := true;
  if (Sender is TDBGrid) then
    begin
      Grid := Sender as TDBGrid;

//      if Column.Index = 0 then   // First column = row number column
//        begin
//          RowNum := TDBGrid(Sender).DataSource.DataSet.RecNo;
//          if RowNum > 0 then
//            begin
//              //RowNum := TDBGrid(Sender).DataSource.DataSet.RecordCount - RowNum + 1;
//              RowNumStr := RowNum.ToString;
//              Grid.Canvas.FillRect(Rect);
//              Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE;
//              R := Rect;
//              DrawText(Grid.Canvas.Handle, PChar(RowNumStr), Length(lpStr(RowNumStr)), R, Flags);
//              DrawDefault := false;
//            end;
//        end;

      if Column.FieldName = 'cStatus' then
        begin
          C := GetPawnStatusColor(Column.Field.AsString);

          Grid.Canvas.Brush.Color := C.BG;
          Grid.Canvas.Font.Color  := C.FG;

          Grid.Canvas.FillRect(Rect);
          Grid.Canvas.TextRect(Rect, Rect.Left + 4, Rect.Top + 2, Column.Field.AsString);
          DrawDefault := false;
        end;

      if DrawDefault then
        gridItems.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;

procedure TfrmClients.gridPaymentsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Grid: TDBGrid;
  RowNum: Integer;
  RowNumStr: string;
  DrawDefault: boolean;
  Flags: UINT;
  R: TRect;
begin
  DrawDefault := true;
  if (Sender is TDBGrid) then
    begin
      Grid := Sender as TDBGrid;

      if Column.Index = 0 then   // First column = row number column
        begin
          RowNum := TDBGrid(Sender).DataSource.DataSet.RecNo;
          if RowNum > 0 then
            begin
              RowNum := TDBGrid(Sender).DataSource.DataSet.RecordCount - RowNum + 1;
              RowNumStr := RowNum.ToString;
              Grid.Canvas.FillRect(Rect);
              Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE;
              R := Rect;
              DrawText(Grid.Canvas.Handle, PChar(RowNumStr), Length(RowNumStr), R, Flags);
              DrawDefault := false;
            end;
        end;

      if DrawDefault then
        gridItems.DefaultDrawColumnCell(Rect, DataCol, Column, State);

    end;
end;

procedure TfrmClients.GetPaymentDueDateBalanceMessage;
var
  Msg: string;
begin
  Msg := DM.GetPawnPaymentUserMessageAboutBalancesAndDueDate;

  lblNextPaymentInfo.Caption := Msg;
  lblNextPaymentInfoItems.Caption := Msg;

end;

procedure TfrmClients.ProcessNewPaymentDueDateMessage(var Msg: TMessage);
begin
  GetPaymentDueDateBalanceMessage;
end;

procedure TfrmClients.qryInvItemsAfterScroll(DataSet: TDataSet);
begin
  lblNextPaymentInfo.Caption := DM.qryTransactionscPawnNextMinPayment.AsString;
  lblNextPaymentInfoItems.Caption := DM.qryTransactionscPawnNextMinPayment.AsString;
end;

// FB IDENTITY assigns INV_ITEM_NO on Post; barcode is derived from it, so it
// has to be set after the insert lands. The barcode-empty guard stops the
// inner Post from re-firing this handler indefinitely.
procedure TfrmClients.qryInvItemsAfterPost(DataSet: TDataSet);
begin
  if qryInvItemsINV_ITEM_BARCODE.AsString = '' then
  begin
    qryInvItems.Edit;
    qryInvItemsINV_ITEM_BARCODE.AsString := DM.GetBarcode(qryInvItemsINV_ITEM_NO.AsInteger);
    qryInvItems.Post;
  end;
end;

procedure TfrmClients.qryInvItemsCalcFields(DataSet: TDataSet);
begin
  qryInvItemscTotalWeight.AsFloat := qryInvItemsINV_ITEM_COUNT.AsInteger * qryInvItemsWEIGHT.AsFloat;

  if qryTypes.Locate('J_TYPE', qryInvItemsJ_TYPE.AsString, []) then
    qryInvItemscType.AsString := qryTypesJ_TYPE_DESC.AsString;

  if qryStyles.Locate('J_STYLE', qryInvItemsJ_STYLE.AsString, []) then
     qryInvItemscStyle.AsString := qryStylesJ_STYLE_DESC.AsString;

  if qryMetal.Locate('J_METAL', qryInvItemsJ_METAL.AsString, []) then
    qryInvItemscMetal.AsString := qryMetalJ_METAL_DESC.AsString;

  qryInvItemscStatus.AsString := GetPawnItemStatus;

  if qryInvItemsHAS_PICS.AsBoolean then
    qryInvItemscHasPics.AsString := 'X'
  else
    qryInvItemscHasPics.AsString := '';
end;

procedure TfrmClients.qryInvItemsNewRecord(DataSet: TDataSet);
begin
  qryInvItemsPAWNED_DATE.Clear;
  qryInvItemsPURCHASE_DATE.Clear;
  qryInvItemsREDEEMED_DATE.Clear;
  qryInvItemsDEFAULTED_DATE.Clear;
  qryInvItemsMELTED_DATE.Clear;
  qryInvItemsFORSALE_DATE.Clear;
  qryInvItemsSOLD_DATE.Clear;
  qryInvItemsLAYAWAY_DATE.Clear;

  qryInvItemsINV_ITEM_COUNT.AsInteger := 1;
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    begin
      qryInvItemsINV_ITEM_STATUS.AsString := 'P';  //For Pawn
      qryInvItemsPAWNED_DATE.AsDateTime := Now;
    end
  else if DM.qryTransactionsTRAN_TYPE.AsString = TranPurchase then
    begin
      qryInvItemsINV_ITEM_STATUS.AsString := 'S';  //For purchase
      qryInvItemsPURCHASE_DATE.AsDateTime := Now;
    end
  else if DM.qryTransactionsTRAN_TYPE.AsString = TranLayaway then
    begin
      qryInvItemsINV_ITEM_STATUS.AsString := 'L';  //Layaway
      qryInvItemsLAYAWAY_DATE.AsDateTime := Now;
    end;

  qryInvItemsTRANSACTION_NO.AsInteger := DM.qryTransactionsTRANSACTION_NO.AsInteger;

  // INV_ITEM_NO is FB IDENTITY - assigned on Post via UpdateOptions.AutoIncFields.
  // INV_ITEM_BARCODE is computed in qryInvItemsAfterPost once the IDENTITY
  // value is available.
  qryInvItemsINV_CAT_NO.AsInteger := 11; //Other
  qryInvItemsWEIGHT_UNIT.AsString := DefaultWeightMeasureUnit;

end;

procedure TfrmClients.ppLabel176GetText(Sender: TObject; var Text: string);
var
  i: integer;
begin
  i := calcItem.Value - 1;
  Text := 'ITEM ' + IntToStr((i mod 6) + 1);
end;

procedure TfrmClients.ppLabel1GetText(Sender: TObject; var Text: String);
begin
  Text := qryPoliceRepCustCustAddr.AsString;
  if not qryPoliceRepCustCustApt.IsNull then
    Text := Text + ' Apt: '+qryPoliceRepCustCustApt.AsString;
  Text := Text + ' ' + qryPoliceRepCustCustCity.AsString + ', ' +
           qryPoliceRepCustCustState.AsString + ' ' + qryPoliceRepCustCustZip.AsString

end;

procedure TfrmClients.SaveTopMarginPolRep;
begin
end;

procedure TfrmClients.btnAdjPoliceReportClick(Sender: TObject);
begin
  frmPoliceRptAdj := TfrmPoliceRptAdj.Create(Self);
  try
    frmPoliceRptAdj.FooterH := RptPoliceRep.FooterBand.Height;
    frmPoliceRptAdj.DetailH := RptPoliceRep.DetailBand.Height;
    frmPoliceRptAdj.ShowModal;
  finally
    frmPoliceRptAdj.Free;
  end;
end;

procedure TfrmClients.ProcessAndShowBarcodeData;
var
  DrvLicInfo: TDriverLicenseInfo;
begin
  ParseScanBarcodeData(ScanData, DrvLicInfo);

  PopulateFieldsWithDrvLicInfo(DrvLicInfo);

  ScanData.Clear;
end;

procedure TfrmClients.TimerForScanTimer(Sender: TObject);
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
      btnSearchClick(nil);
    end;
end;

procedure TfrmClients.TimerScanningTimeOutTimer(Sender: TObject);
begin
  if ScanningCard then
    PostMessage(Handle, sx_ProcessCardScanning, 0, 0);
end;

procedure TfrmClients.txtAdjTopMarginKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9']) or (Key < #32)) then
    Key := #0;
end;

procedure TfrmClients.ppLabel2GetText(Sender: TObject; var Text: String);
begin
  if (qryPoliceRepCustCustID.IsNull) or (length(qryPoliceRepCustCustID.AsString)=0) then
    Text := qryPoliceRepCustCustFlDrvLic.AsString
  else
    Text := qryPoliceRepCustCustID.AsString;
end;

procedure TfrmClients.ppLabel3GetText(Sender: TObject; var Text: String);
begin
  if qryPoliceRepCustCustID.IsNull then
    Text := 'Driver License'
  else
    Text := qryPoliceRepCustCustIDType.AsString;
end;

procedure TfrmClients.ppLabel4GetText(Sender: TObject; var Text: String);
begin
  if qryPoliceRepCustCustID.IsNull then
    Text := 'Florida'
  else
    Text := qryPoliceRepCustCustIDAgencyState.AsString;
end;

procedure TfrmClients.ppLabel5GetText(Sender: TObject; var Text: String);
begin
  Text := qryPoliceRepCustCustLast.AsString + ', ' +
          qryPoliceRepCustCustFirst.AsString + ' ' +
          qryPoliceRepCustCustMid.AsString;
end;

procedure TfrmClients.btnNewWithCopyItemsClick(Sender: TObject);
var
  SavePos: integer;
begin
  if DM.qryCustomersCUST_NO.AsInteger <= 0 then
    begin
      MessageDlg('Please enter client information first', mtInformation, [mbOK], 0);
      exit;
    end;

{  if DM.qryTransactionsTRANSACTION_NO.AsInteger <= 0 then
    begin
      MessageDlg('No Existing transaction to copy items from.', mtInformation, [mbOK], 0);
      exit;
    end;
}
{
  if qryInvItems.RecordCount <= 0 then
    begin
      MessageDlg('No Existing item for selected transaction.', mtInformation, [mbOK], 0);
      exit;
    end;
}
  frmEnterTransaction := TfrmEnterTransaction.Create(Self);
  try
    frmEnterTransaction.NewRow := true;
    frmEnterTransaction.CustNo := DM.qryCustomersCUST_NO.AsInteger;
    if OpenSQLStatementFB('select count(*) from TRANSACTIONS T1 JOIN INVENTORY_ITEMS T2 ON T1.TRANSACTION_NO = T2.TRANSACTION_NO where T1.CUST_NO = ' + DM.qryCustomersCUST_NO.AsString) <= 0 then
//    frmEnterTransaction.qryInvItems.RecordCount <= 0 then
      begin
        MessageDlg('No Existing transaction to copy items from.', mtInformation, [mbOK], 0);
        exit;
      end;

    SavePos := DM.qryTransactions.RecNo;
    frmEnterTransaction.FilterByTransactionNo := DM.qryTransactionsTRANSACTION_NO.AsInteger;
    if frmEnterTransaction.ShowModal = mrOk then
      begin
       qryInvItems.Close;
       qryInvItems.Open;
      end
    else
      DM.qryTransactions.RecNo := SavePos;

  finally
    frmEnterTransaction.Free;
  end;

end;

procedure TfrmClients.btnDeleteItemClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete this item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ExecSQLStatementFB('delete from STONES where INV_ITEM_NO=' + qryInvItemsINV_ITEM_NO.AsString);
    ExecSQLStatementFB('delete from IMAGES_DATA where IMAG_REF_TO_ROW_NO=' + qryInvItemsINV_ITEM_NO.AsString);

    qryInvItems.Delete;
  end;
end;

procedure TfrmClients.qryPawnItemsCalcFields(DataSet: TDataSet);
var
 StonesCount: integer;
begin
  qryPawnItemscWeightToPrint.AsString := FloatToStr(qryPawnItemsWeight.AsFloat) + DM.GetWeightUnitAbbr(qryPawnItemsWeightUnit.AsString);

  qryPawnStones.Close;
  qryPawnStones.Params.ParamByName('InvItemNo').AsInteger := qryPawnItemsInvItemNo.AsInteger;
  qryPawnStones.Open;

  StonesCount := qryPawnStones.RecordCount;

  if StonesCount >= 1 then
    begin
      qryPawnStones.RecNo := 1;
      qryPawnItemscStone1Shape.AsString := qryPawnStonesStoneShape.AsString;
      qryPawnItemscStone1Color.AsString := qryPawnStonesStoneColor.AsString;
      qryPawnItemscStone1CT.AsFloat := qryPawnStonesCT.AsFloat;
      qryPawnItemscStone1WT.AsString := qryPawnStonesWT.AsString + DM.GetWeightUnitAbbr(qryPawnStonesStoneWeightUnit.AsString);
      qryPawnItemscStone1Qty.AsInteger := qryPawnStonesStoneNumber.AsInteger;
    end;
  if StonesCount >= 2 then
    begin
      qryPawnStones.RecNo := 2;
      qryPawnItemscStone2Shape.AsString := qryPawnStonesStoneShape.AsString;
      qryPawnItemscStone2Color.AsString := qryPawnStonesStoneColor.AsString;
      qryPawnItemscStone2CT.AsFloat := qryPawnStonesCT.AsFloat;
      qryPawnItemscStone2WT.AsString := qryPawnStonesWT.AsString + DM.GetWeightUnitAbbr(qryPawnStonesStoneWeightUnit.AsString);
      qryPawnItemscStone2Qty.AsInteger := qryPawnStonesStoneNumber.AsInteger;
    end;
    
  qryPawnStones.Close;
end;

procedure TfrmClients.qryPoliceRepCustCalcFields(DataSet: TDataSet);
var
  Ph: string;
begin
  qryPoliceRepCustCCustPhHome.AsString := FormatPhoneUSA(qryPoliceRepCustCustPhHome.AsString);
  qryPoliceRepCustCCustPhBussiness.AsString := FormatPhoneUSA(qryPoliceRepCustCustPhBussiness.AsString);
  qryPoliceRepCustCCustPhBeep.AsString := FormatPhoneUSA(qryPoliceRepCustCustPhBeep.AsString);
  qryPoliceRepCustcCustPhCell.AsString := FormatPhoneUSA(qryPoliceRepCustCustPhCell.AsString);
  if trim(qryPoliceRepCustCustFlDrvLic.AsString) <> '' then
    qryPoliceRepCustcCustFlDrvLic.AsString := FormatFLDriverLic(trim(qryPoliceRepCustCustFlDrvLic.AsString));

  if trim(qryPoliceRepCustCustPhHome.AsString) <> '' then
    Ph := qryPoliceRepCustCCustPhHome.AsString
  else if trim(qryPoliceRepCustCustPhCell.AsString) <> '' then
    Ph := qryPoliceRepCustcCustPhCell.AsString
  else if trim(qryPoliceRepCustCCustPhBeep.AsString) <> '' then
    Ph := qryPoliceRepCustcCustPhCell.AsString
  else
    Ph := '';

  qryPoliceRepCustcPrnHPhone.AsString := Ph
end;

procedure TfrmClients.pgTransactionsChange(Sender: TObject);
var
  Filter: string;
  PawnTabActive: boolean;
begin
  case pgTransactions.ActivePageIndex of
  0: Filter := 'TRAN_TYPE = ''P'''; //Pawn
  1: Filter := 'TRAN_TYPE = ''U'''; //Purchase
  2: Filter := 'TRAN_TYPE = ''L'''; //Layaway
  else
    Filter := '';
  end;

  DM.qryTransactions.Filter := Filter;

  PawnTabActive := pgTransactions.ActivePageIndex = 0;  //Pawn
  pnPawnPayBalance.Visible := PawnTabActive;
  pnPawnItemBalance.Visible := PawnTabActive;
  btnPrintPayReceipt.Visible := PawnTabActive;  //Pawn

//  if DM.qryTransactions.Active then
//    DM.qryTransactions.First;
end;

procedure TfrmClients.PopMnuLayawayPopup(Sender: TObject);
begin
  mnuReOpenLayaway.Enabled := DM.qryTransactionsTRAN_STATUS.AsString <> 'A';
  mnuCloseLayaway.Enabled := DM.qryTransactionsTRAN_STATUS.AsString <> 'I';

end;

procedure TfrmClients.PopMnuPawnItemsPopup(Sender: TObject);
var
  EnabledMnuEntries: boolean;
begin
  if (qryInvItemscStatus.AsString <> PawnItemStatus_Pawned) or (not qryInvItemsSOLD_DATE.IsNull) then
    begin
      EnabledMnuEntries :=  false;
    end
  else
    begin
      EnabledMnuEntries :=  true;
    end;

  popmnuItemPawned.Enabled := qryInvItemscStatus.AsString <> PawnItemStatus_Pawned;
  popmnuItemRedeemed.Enabled := EnabledMnuEntries;
  popmnuItemDefaulted.Enabled := EnabledMnuEntries;
  popmnuItemMeltedScrap.Enabled := EnabledMnuEntries;
  popmnuItemForSale.Enabled := EnabledMnuEntries;
end;

procedure TfrmClients.PopMnuTransactionsPopup(Sender: TObject);
begin
  mnuPawnStatusActive.Enabled := DM.qryTransactionsTRAN_STATUS.AsString <> 'A';
  mnuPawnStatusInactive.Enabled := DM.qryTransactionsTRAN_STATUS.AsString <> 'I';
end;

procedure TfrmClients.AddEditLayaway(NewRow: boolean);
begin
  frmEnterLayaway := TfrmEnterLayaway.Create(Self);
  try
    frmEnterLayaway.NewRow := NewRow;
    frmEnterLayaway.ShowModal;
  finally
    frmEnterLayaway.Free;
  end;
end;

procedure TfrmClients.btnNewLayawayClick(Sender: TObject);
begin
  AddEditLayaway(true);
end;

procedure TfrmClients.btnNewPurchaseClick(Sender: TObject);
begin
  pgTransactions.ActivePageIndex := 1;
  pgTransactionsChange(nil);
  frmEnterPurchase := TfrmEnterPurchase.Create(Self);
  try
    frmEnterPurchase.NewRow := true;
    frmEnterPurchase.ShowModal;
  finally
    frmEnterPurchase.Free;
  end;
end;

procedure TfrmClients.btnEditPurchaseClick(Sender: TObject);
begin
  pgTransactions.ActivePageIndex := 1;
  pgTransactionsChange(nil);
  if DM.qryTransactionsTRANSACTION_NO.AsInteger <= 0 then
    begin
      MessageDlg('Nothing to edit.', mtInformation, [mbOK], 0);
      exit;
    end;

  frmEnterPurchase := TfrmEnterPurchase.Create(Self);
  try
    frmEnterPurchase.NewRow := false;
    frmEnterPurchase.ShowModal;
  finally
    frmEnterPurchase.Free;
  end;
end;

procedure TfrmClients.btnExitClick(Sender: TObject);
begin
  Close
end;

procedure TfrmClients.btnItemPicturesClick(Sender: TObject);
var
  SaveRecNo: integer;
begin
  if qryInvItems.RecordCount = 0 then
    exit;

  frmItemPictures := TfrmItemPictures.Create(self);
  try
    frmItemPictures.ImagRefToRowNo := qryInvItemsINV_ITEM_NO.AsInteger;
    frmItemPictures.TicketNo := DM.qryTransactionsTRAN_TICKET_NO.AsString;
    frmItemPictures.ItemCountInTran := GetRecNo(qryInvItems.RecNo);
    frmItemPictures.ShowModal;
    if frmItemPictures.PictureTaken then
      begin
        SaveRecNo := qryInvItems.RecNo;

        qryInvItems.Close;
        qryInvItems.Open;

        qryInvItems.RecNo := SaveRecNo;
      end;
  finally
    frmItemPictures.Free;
  end;
end;

procedure TfrmClients.btnLayawayRcptClick(Sender: TObject);
begin
  DMReports.PrintLAYAWAYReceipt(DM.qryTransactionsTRANSACTION_NO.AsInteger, AppPrinterSettings.PayReceiptPrinter, AppPrinterSettings.PayReceiptPrinterBin);
end;

procedure TfrmClients.FormCreate(Sender: TObject);
begin
  ScanData := TScanDataList.Create;
  ScanData.Clear;

  ScanningPDF417Barcode := false;

  PropertyStore.Load;
end;

procedure TfrmClients.lblAmountGetText(Sender: TObject; var Text: String);
begin //Poner esta opcion en el futuro que se pueda cambiar
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := Format('%m', [DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency])
  else
    Text := '$0.00';
end;

procedure TfrmClients.ppLabel7GetText(Sender: TObject; var Text: String);
begin
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPurchase then
    Text := Format('%.2f', [DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency])
  else
    Text := '';
end;

procedure TfrmClients.ppLabel8GetText(Sender: TObject; var Text: string);
begin
  Text := DM.qryStoreSTORE_POLICE_ID.AsString;
end;

procedure TfrmClients.ppLabel9GetText(Sender: TObject; var Text: string);
begin
  Text := trim(DM.qryTransactionsTRAN_TICKET_NO.AsString);
end;

procedure TfrmClients.lblTranInterestAtMaturityGetText(Sender: TObject;
  var Text: String);
begin
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := Format('%.2f', [DM.qryTransactionscTranTotalInterestAtMaturity.AsCurrency])
  else
    Text := '0.00';
end;

procedure TfrmClients.lblTotalAmountAtMaturityGetText(Sender: TObject;
  var Text: String);
begin
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := Format('%.2f', [DM.qryTransactionscTranTotalAmountAtMaturity.AsCurrency ])
  else
    Text := '0.00';
end;

procedure TfrmClients.lblAnnualPercRateGetText(Sender: TObject;
  var Text: String);
begin
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := Format('%.2f', [DM.qryTransactionscAnnualPercRate.AsFloat])
  else
    Text := '0.00';
end;

procedure TfrmClients.lblTranMaturityGetText(Sender: TObject;
  var Text: String);
begin
//  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := FormatDateTime('mm/dd/yyyy', DM.qryTransactionsTRAN_MATURITY.AsDateTime)
//  else
//    Text := '';
end;

procedure TfrmClients.pgTransDetailChange(Sender: TObject);
begin
//  if pgTransDetail.ActivePage = TabPayment then
//    begin
//      TabPayment.Caption := 'Payments    ';
//      TabItems.Caption := '         Items         ';
//      TabPayment.ImageIndex := 23;
//      TabItems.ImageIndex := -1;
//    end
//  else if pgTransDetail.ActivePage = TabItems then
//    begin
//      TabPayment.Caption := '    Payments    ';
//      TabItems.Caption := 'Items         ';
//      TabItems.ImageIndex := 22;
//      TabPayment.ImageIndex := -1;
//    end;

end;

procedure TfrmClients.UpdateStatusOnSelectedItemInPopUp(TransactionNo, ItemNo: integer;
                  const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
begin
  DM.UpdatePawnItemStatus(qryInvItemsINV_ITEM_NO.AsInteger, RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate);
  DM.UpdatePawnStatusBaseOnItems(DM.qryTransactionsTRANSACTION_NO.AsInteger);
  DM.RefreshFBQry(qryInvItems);
  DM.RefreshFBQry(DM.qryTransactions);
end;

procedure TfrmClients.popmnuItemPawnedClick(Sender: TObject);
begin
  UpdateStatusOnSelectedItemInPopUp(DM.qryTransactionsTRANSACTION_NO.AsInteger, qryInvItemsINV_ITEM_NO.AsInteger,
                                    null, null, null, null);
//  DM.UpdatePawnItemStatus(qryInvItemsINV_ITEM_NO.AsInteger, null, null, null, null);
//  DM.UpdatePawnStatusBaseOnItems(DM.qryTransactionsTRANSACTION_NO.AsInteger);
//  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.popmnuItemDefaultedClick(Sender: TObject);
begin
  UpdateStatusOnSelectedItemInPopUp(DM.qryTransactionsTRANSACTION_NO.AsInteger, qryInvItemsINV_ITEM_NO.AsInteger,
                                    null, Date, null, null);

//  DM.UpdatePawnItemStatus(qryInvItemsINV_ITEM_NO.AsInteger, null, Date, null, null);
//  DM.UpdatePawnStatusBaseOnItems(DM.qryTransactionsTRANSACTION_NO.AsInteger);
//  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.popmnuItemForSaleClick(Sender: TObject);
begin
  UpdateStatusOnSelectedItemInPopUp(DM.qryTransactionsTRANSACTION_NO.AsInteger, qryInvItemsINV_ITEM_NO.AsInteger,
                                    null, Date, null, Date);
//  DM.UpdatePawnItemStatus(qryInvItemsINV_ITEM_NO.AsInteger, null, Date, null, Date);
//  DM.UpdatePawnStatusBaseOnItems(DM.qryTransactionsTRANSACTION_NO.AsInteger);
//  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.popmnuItemMeltedScrapClick(Sender: TObject);
begin
  UpdateStatusOnSelectedItemInPopUp(DM.qryTransactionsTRANSACTION_NO.AsInteger, qryInvItemsINV_ITEM_NO.AsInteger,
                                    null, Date, Date, null);
//  DM.UpdatePawnItemStatus(qryInvItemsINV_ITEM_NO.AsInteger, null, Date, Date, null);
//  DM.UpdatePawnStatusBaseOnItems(DM.qryTransactionsTRANSACTION_NO.AsInteger);
//  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.popmnuItemRedeemedClick(Sender: TObject);
begin
  UpdateStatusOnSelectedItemInPopUp(DM.qryTransactionsTRANSACTION_NO.AsInteger, qryInvItemsINV_ITEM_NO.AsInteger,
                                    Date, null, null, null);
//  DM.UpdatePawnItemStatus(qryInvItemsINV_ITEM_NO.AsInteger, Date, null, null, null);
//  DM.UpdatePawnStatusBaseOnItems(DM.qryTransactionsTRANSACTION_NO.AsInteger);
//  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.mnuCloseLayawayClick(Sender: TObject);
begin
  if DM.qryTransactionsPRINC_BALANCE.AsCurrency > 0 then
    if MessageDlg('The Layaway balance is not zero. Close Layaway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;

  DM.LaywayClosePayoffBalance(DM.qryTransactionsTRANSACTION_NO.AsInteger, false);

  DM.RefreshFBQry(DM.qryTransactions);

end;

procedure TfrmClients.mnuPawnStatusActiveClick(Sender: TObject);
begin
  DM.PutPawnBackToActive(DM.qryTransactionsTRANSACTION_NO.AsInteger);

  DM.RefreshFBQry(DM.qryTransactions);
  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.mnuPawnStatusInactiveClick(Sender: TObject);
begin
  frmPawnChangeStatus := TfrmPawnChangeStatus.Create(Self);
  try
    CenterPopupOnControl(gridPawn, frmPawnChangeStatus);
    frmPawnChangeStatus.TransactionNo := DM.qryTransactionsTRANSACTION_NO.AsInteger;
    if frmPawnChangeStatus.ShowModal = mrOk then
      begin
        DM.RefreshFBQry(DM.qryTransactions);
        DM.RefreshFBQry(qryInvItems);
      end;
  finally
    frmPawnChangeStatus.Free;
  end;
end;

procedure TfrmClients.mnuReOpenLayawayClick(Sender: TObject);
begin
  DM.ReactivateLayway(DM.qryTransactionsTRANSACTION_NO.AsInteger);

  DM.RefreshFBQry(DM.qryTransactions);
  DM.RefreshFBQry(qryInvItems);
end;

procedure TfrmClients.lblPawnDefaultDateGetText(Sender: TObject;
  var Text: String);
begin
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := FormatDateTime('mm/dd/yyyy', DM.qryTransactionscPawnDefaultDate.AsDateTime)
  else
    Text := '';
end;

procedure TfrmClients.lblTAmountRedeemDefaultDateGetText(Sender: TObject;
  var Text: String);
begin
  if DM.qryTransactionsTRAN_TYPE.AsString = TranPawn then
    Text := Format('%.2f', [DM.qryTransactionscTAmountRedeemDefaultDate.AsCurrency])
  else
    Text := '$0.00';
end;

procedure TfrmClients.ppChkPurchasePrint(Sender: TObject);
begin
  ppChkPurchase.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPurchase;
  chkChkPurchase.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPurchase;
  chkChkPurchaseLetterPrePrinted.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPurchase;
  ppChkPurchase0924.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPurchase;
end;

procedure TfrmClients.ppChkPawnPrint(Sender: TObject);
begin
  ppChkPawn.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPawn;
  ppChkPawn0924.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPawn;
  ppChkPawnLetter.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPawn;
  ppChkPawnLetterPrePrinted.Checked := DM.qryTransactionsTRAN_TYPE.AsString = TranPawn;
end;

procedure TfrmClients.PopulateFieldsWithDrvLicInfo(const DrvLicInfo: TDriverLicenseInfo);
begin
  edFirst.Text := DrvLicInfo.FirstName;
  edLast.Text := DrvLicInfo.LastName;
end;

procedure TfrmClients.ProcessScannedCard(var Msg: TMessage);
var
  DrvLicInfo: TDriverLicenseInfo;
begin
  TimerScanningTimeOut.Enabled := false;

  ScanningCard := false;
  PreHeaderDetected := false;
  ParseFL_DL(ReadingCardBuffer, DrvLicInfo);

  PopulateFieldsWithDrvLicInfo(DrvLicInfo);
end;

procedure TfrmClients.AddToKeyQueue(Key: Word);
begin
  LastThreeKeys[1] := LastThreeKeys[2];
  LastThreeKeys[2] := Key;
end;

function TfrmClients.MatchLastKeys(KeyPattern: TKeyQueue): boolean;
begin
  Result := (LastThreeKeys[1] = KeyPattern[1]) and (LastThreeKeys[2] = KeyPattern[2]);
end;

procedure TfrmClients.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TfrmClients.KeyPressForMagneticScan( var Key: Char);
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
//      Memo1.Lines.Add('Reading Keys');
      Key := #0;
    end
  else
    begin
      PreHeaderDetected := false;
    end;
end;

procedure TfrmClients.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  if Key < #32 then
//    Memo1.Lines.Add(GetStrToShow(Key));

  KeyPressForMagneticScan(Key);

  ProcessKeyForPDF417barcodeScan(Key,
                                 ScanningPDF417Barcode,
                                 ScanData,
                                 ReadChars,
                                 TimerForScan,
                                 LastDataCount);


end;

end.
