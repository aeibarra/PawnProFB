unit EnterTransactions;

interface

uses
  Windows, Messages, SysUtils, Classes, StrUtils, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Buttons, DBCtrls, Mask, System.UITypes, DateUtils, Variants,
  Grids, DBGrids, ExtCtrls,  RzButton, RzEdit, RzDBEdit, Vcl.Menus,
  RzCommon, RzLabel, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmEnterTransaction = class(TForm)
    gbBottom: TGroupBox;
    btnCancel: TBitBtn;
    gbTop: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edMemoComment: TDBMemo;
    edTicketNo: TDBEdit;
    edPawnAmount: TDBEdit;
    Label5: TLabel;
    edPrincBalance: TDBEdit;
    edInterest: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    dsInvItems: TDataSource;
    pnSelectItemsToCopy: TPanel;
    Panel2: TPanel;
    btnCheckAll: TButton;
    btnClearAll: TButton;
    Panel3: TPanel;
    Label9: TLabel;
    dbGridItems: TDBGrid;
    btnSave: TRzBitBtn;
    edPawnTranDate: TRzDBDateTimeEdit;
    edMaturityDate: TRzDBDateTimeEdit;
    RzMenuButton1: TRzMenuButton;
    PopupMenu1: TPopupMenu;
    First1: TMenuItem;
    Second1: TMenuItem;
    chkShowOnlyInTran: TCheckBox;
    PropertyStore: TRzPropertyStore;
    btnGetPawnAddingAllItemCost: TRzToolButton;
    lblItemsWithNoCost: TRzLabel;
    clnItemsToSelect: TClientDataSet;
    clnItemsToSelectInvItemBarcode: TWideStringField;
    clnItemsToSelectInvCatNo: TIntegerField;
    clnItemsToSelectJType: TWideStringField;
    clnItemsToSelectJStyle: TWideStringField;
    clnItemsToSelectJMetal: TWideStringField;
    clnItemsToSelectInvItemCount: TIntegerField;
    clnItemsToSelectSizeLength: TFloatField;
    clnItemsToSelectWeight: TFloatField;
    clnItemsToSelectKT: TFloatField;
    clnItemsToSelectCreated: TDateTimeField;
    clnItemsToSelectUnitCost: TBCDField;
    clnItemsToSelectUnitPrice: TBCDField;
    clnItemsToSelectInvItemStatus: TWideStringField;
    clnItemsToSelectTransactionNo: TIntegerField;
    clnItemsToSelectInvOriginalItemNo: TIntegerField;
    clnItemsToSelectInvItemBrand: TWideStringField;
    clnItemsToSelectSerialNumber: TWideStringField;
    clnItemsToSelectOwnerAppNumber: TWideStringField;
    clnItemsToSelectModelNumber: TWideStringField;
    clnItemsToSelectGender: TWideStringField;
    clnItemsToSelectDescription: TWideStringField;
    clnItemsToSelectJStyleDesc: TWideStringField;
    clnItemsToSelectJTypeDesc: TWideStringField;
    clnItemsToSelectJMetalDesc: TWideStringField;
    clnItemsToSelectInvItemNo: TIntegerField;
    clnItemsToSelectInvCategory: TWideStringField;
    clnItemsToSelectNote: TWideStringField;
    lblUnderAge: TLabel;
    qryInvItems: TFDQuery;
    qryInvItemsINV_ITEM_NO: TIntegerField;
    qryInvItemsINV_ITEM_BARCODE: TWideStringField;
    qryInvItemsINV_CAT_NO: TIntegerField;
    qryInvItemsJ_TYPE: TWideStringField;
    qryInvItemsJ_STYLE: TWideStringField;
    qryInvItemsJ_METAL: TWideStringField;
    qryInvItemsINV_ITEM_COUNT: TIntegerField;
    qryInvItemsNOTE: TWideStringField;
    qryInvItemsSIZE_LENGTH: TFloatField;
    qryInvItemsWEIGHT: TFloatField;
    qryInvItemsKT: TFloatField;
    qryInvItemsCREATED: TSQLTimeStampField;
    qryInvItemsUNIT_COST: TFMTBCDField;
    qryInvItemsUNIT_PRICE: TFMTBCDField;
    qryInvItemsINV_ITEM_STATUS: TWideStringField;
    qryInvItemsTRANSACTION_NO: TIntegerField;
    qryInvItemsINV_ORIGINAL_ITEM_NO: TIntegerField;
    qryInvItemsINV_ITEM_BRAND: TWideStringField;
    qryInvItemsSERIAL_NUMBER: TWideStringField;
    qryInvItemsOWNER_APP_NUMBER: TWideStringField;
    qryInvItemsMODEL_NUMBER: TWideStringField;
    qryInvItemsGENDER: TWideStringField;
    qryInvItemsDESCRIPTION: TWideStringField;
    qryInvItemsWEIGHT_UNIT: TWideStringField;
    qryInvItemsPAWNED_DATE: TDateField;
    qryInvItemsPURCHASE_DATE: TDateField;
    qryInvItemsREDEEMED_DATE: TDateField;
    qryInvItemsDEFAULTED_DATE: TDateField;
    qryInvItemsMELTED_DATE: TDateField;
    qryInvItemsFORSALE_DATE: TDateField;
    qryInvItemsSOLD_DATE: TDateField;
    qryInvItemsLAYAWAY_DATE: TDateField;
    qryInvItemsINV_CATEGORY: TWideStringField;
    qryInvItemsJ_STYLE_DESC: TWideStringField;
    qryInvItemsJ_TYPE_DESC: TWideStringField;
    qryInvItemsJ_METAL_DESC: TWideStringField;
    qryInsItems: TFDQuery;
    btnViewInLargeGrid: TRzToolButton;
    btnRecalcIntSameDayCreated: TRzToolButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItemsCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbGridItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure edPawnAmountExit(Sender: TObject);
    procedure dbGridItemsTitleClick(Column: TColumn);
    procedure First1Click(Sender: TObject);
    procedure Second1Click(Sender: TObject);
    procedure chkShowOnlyInTranClick(Sender: TObject);
    procedure btnGetPawnAddingAllItemCostClick(Sender: TObject);
    procedure edInterestExit(Sender: TObject);
    procedure edInterestChange(Sender: TObject);
    procedure btnViewInLargeGridClick(Sender: TObject);
    procedure btnRecalcIntSameDayCreatedClick(Sender: TObject);
  private
    LastIndexUsed: string;
    IntChanged: boolean;
    FCopySourceCustNo: integer;
    FCopySourceTransactionNo: integer;
    procedure OpenLookupItemQry;
    function GetLastTicketNo: integer;
    function CopyItemsMode: Boolean;
    { Private declarations }
  public
    { Public declarations }
    NewRow: boolean;
    SelectedItemList: TStringList;
    // Call this only for the "copy items from previous pawn" entry. Plain
    // add/edit doesn't need it -- copy mode stays off by default. Implies
    // NewRow := True since copy-items only makes sense for new transactions.
    procedure PrepareForCopyItems(SourceCustNo, SourceTransactionNo: integer);
    function InItemList(ItemNo: integer): boolean;
    procedure ClearAllItems;
    procedure CheckAllItems;
    procedure RemoveFromItemList(ItemNo: integer);
    procedure AddToItemList(ItemNo: integer);
    // Exposed read-only so the items-to-copy large grid form can read the
    // source customer/transaction without poking at private fields.
    property CopySourceCustNo: integer read FCopySourceCustNo;
    property CopySourceTransactionNo: integer read FCopySourceTransactionNo;
  end;

var
  frmEnterTransaction: TfrmEnterTransaction;

implementation

uses PawnDM, PawnGlobal, ItemsToCopyLargeGrid, GLbUtils, SearchClient;

{$R *.DFM}

function TfrmEnterTransaction.InItemList(ItemNo: integer): boolean;
begin
  Result := SelectedItemList.IndexOf(IntToStr(ItemNo)) >= 0;
end;

function TfrmEnterTransaction.CopyItemsMode: Boolean;
begin
  // Source customer set -> we're in the "copy items from previous pawn" flow.
  // Plain add/edit leaves FCopySourceCustNo at its default of 0.
  Result := FCopySourceCustNo > 0;
end;

procedure TfrmEnterTransaction.PrepareForCopyItems(SourceCustNo, SourceTransactionNo: integer);
begin
  FCopySourceCustNo := SourceCustNo;
  FCopySourceTransactionNo := SourceTransactionNo;
  NewRow := True;
end;

procedure TfrmEnterTransaction.AddToItemList(ItemNo: integer);
begin
  if not InItemList(ItemNo) then
    SelectedItemList.Add(IntToStr(ItemNo));
end;

procedure TfrmEnterTransaction.RemoveFromItemList(ItemNo: integer);
begin
  SelectedItemList.Delete(SelectedItemList.IndexOf(IntToStr(ItemNo)));
end;

procedure TfrmEnterTransaction.OpenLookupItemQry;
var
  FilterByTransactionNoVar: Variant;
  lcFieldName: string;
  i: integer;
begin
  if clnItemsToSelect.Active then
    clnItemsToSelect.Close;

  clnItemsToSelect.DisableControls;
  try
    clnItemsToSelect.IndexName := '';
    clnItemsToSelect.IndexFieldNames := '';
    clnItemsToSelect.IndexDefs.Clear;

    clnItemsToSelect.CreateDataSet;

    //Open Items Previous Items Look up
    if (FCopySourceTransactionNo <= 0) or (not chkShowOnlyInTran.Checked) then
      FilterByTransactionNoVar := null
    else
      FilterByTransactionNoVar := FCopySourceTransactionNo;

    qryInvItems.Close;
    qryInvItems.Params.ParamByName('TRANSACTION_NO').Value := FilterByTransactionNoVar;
    qryInvItems.Params.ParamByName('CUST_NO').AsInteger := FCopySourceCustNo;
    qryInvItems.Open;

    //Load ClientDataSet
    while not qryInvItems.Eof do
      begin
        //Check if the item does not exits. We add it
        if not clnItemsToSelect.Locate('DESCRIPTION;WEIGHT;SIZE_LENGTH;J_STYLE_DESC;J_TYPE_DESC;J_METAL_DESC',
                       VarArrayOf([qryInvItemsDESCRIPTION.AsString, qryInvItemsWEIGHT.AsFloat,
                                   qryInvItemsSIZE_LENGTH.AsFloat, qryInvItemsJ_STYLE_DESC.AsString,
                                  qryInvItemsJ_TYPE_DESC.AsString, qryInvItemsJ_METAL_DESC.AsString]), []) then
          begin
            clnItemsToSelect.Append;

            //Load Field by Field
            for i := 0 to qryInvItems.FieldCount - 1 do
              begin
                lcFieldName := qryInvItems.Fields[i].FieldName;

                if clnItemsToSelect.FieldDefs.IndexOf(lcFieldName) >= 0 then
                  begin
                    clnItemsToSelect.FieldByName(lcFieldName).Value := qryInvItems.Fields[i].Value;
                  end;
              end;

            clnItemsToSelect.Post;
          end;

        qryInvItems.Next;
      end;

    clnItemsToSelect.First;

    DoGridSorting(dbGridItems, dbGridItems.Columns[2], clnItemsToSelect, LastIndexUsed, WriteLogFile); // Sort Asc by Description

  finally
    clnItemsToSelect.EnableControls;
  end;

end;

function TfrmEnterTransaction.GetLastTicketNo: integer;
begin
  Result := DM.GetNextTicketNo(PawnTicketNo) - 1;
end;

procedure TfrmEnterTransaction.FormShow(Sender: TObject);
begin
  pnSelectItemsToCopy.Visible := CopyItemsMode;
  if CopyItemsMode then
    begin
      OpenLookupItemQry;
    end
  else
    begin
      gbTop.Width := edMaturityDate.Left + edMaturityDate.Width + 15;
      gbTop.Height := edMemoComment.Top + edMemoComment.Height + 15;
      gbBottom.Width := gbTop.Width;
      gbBottom.Top := gbTop.Top + gbTop.Height + 5;
    end;

  FrmSetViewSize(Self);

  if NewRow then
    begin
      DM.qryTransactions.Append;
      DM.qryTransactionsTRAN_TICKET_NO.AsInteger := GetLastTicketNo + 1;
      edPawnAmount.SetFocus;
    end
  else
    begin
      DM.qryTransactions.Edit;
      edPrincBalance.SetFocus;
    end;

  // "Re-Calc Interest" only makes sense when editing a Pawn transaction on the
  // same day it was created -- recalculating after that would change historical
  // interest already reflected on the customer's ticket.
  btnRecalcIntSameDayCreated.Visible :=
    (not NewRow) and
    (DM.qryTransactionsTRAN_TYPE.AsString = TranPawn) and
    (DM.qryTransactionsTRAN_DATE.AsDateTime = Date);

  // Only meaningful when clnItemsToSelect is loaded; CheckAllItems is itself
  // a no-op otherwise but calling it conditionally reads correctly.
  if CopyItemsMode then
    CheckAllItems;
end;

procedure TfrmEnterTransaction.btnCancelClick(Sender: TObject);
begin
  DM.qryTransactions.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmEnterTransaction.btnSaveClick(Sender: TObject);
var
  NewInvItemNo: integer;
  IntRate, IntAmount: Extended;
  AskIfUpdateTicketNo: boolean;
  StoneQry: TFDQuery;
  StartedFBTrans: Boolean;
begin
  AskIfUpdateTicketNo := false;
  StartedFBTrans := False;
  btnSave.SetFocus;

  if DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat <= 0 then
    begin
      MessageDlg('Please enter Pawn total amount.', mtInformation, [mbOk], 0);
      edPawnAmount.SetFocus;
      exit;
    end;

  if not DM.ConnFB.InTransaction then
  begin
    DM.ConnFB.StartTransaction;
    StartedFBTrans := True;
  end;
  try
   if NewRow then
     begin
       DM.qryTransactionsTRAN_TIME.AsDateTime := Time;

       if (DM.qryTransactionsINTEREST_BALANCE.AsFloat <= 0) and NewRow then
         begin
          IntRate := DM.qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat;
          DM.CalcInterest(DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency, IntRate, IntAmount);
          DM.qryTransactionsTRAN_INTEREST.AsFloat := ConvertTo2Dec(IntRate);
          DM.qryTransactionsINTEREST_BALANCE.AsCurrency := ConvertTo2Dec(IntAmount);
//          DM.qryTransactionsINTEREST_BALANCE.AsFloat := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.0;
         end;
       DM.qryTransactionsPRINC_BALANCE.AsFloat := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat;

       if GetLastTicketNo > DM.qryTransactionsTRAN_TICKET_NO.AsInteger then
       begin
         if MessageDlg('Warning!!! The ticket number you entered is lower then the previous one. Continue?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
           begin
             if StartedFBTrans and DM.ConnFB.InTransaction then
               DM.ConnFB.Rollback;

             exit;
           end;

         AskIfUpdateTicketNo := true;
       end;

       if not AskIfUpdateTicketNo or (AskIfUpdateTicketNo and (MessageDlg('Update Ticket Number?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)) then
         begin
           DM.UpdateLastTicketNo(PawnTicketNo, DM.qryTransactionsTRAN_TICKET_NO.AsInteger);
         end;

     end;

     DM.qryTransactions.Post;
//    DM.qryTransactions.Refresh;

    if clnItemsToSelect.Active then
      begin
        StoneQry := TFDQuery.Create(nil);
        try
          StoneQry.Connection := DM.ConnFB;
          // Carry STONE_WEIGHT_UNIT from the source; fall back to the store
          // default when the source row didn't set it (legacy data).
          StoneQry.SQL.Text :=
            'INSERT INTO STONES (INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT) ' +
            'SELECT :NEW_INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE, ' +
            '       COALESCE(STONE_WEIGHT_UNIT, :DEFAULT_WEIGHT_UNIT) ' +
            'FROM STONES ' +
            'WHERE INV_ITEM_NO = :OLD_INV_ITEM_NO';

        clnItemsToSelect.DisableControls;
        try
          clnItemsToSelect.First;
          while not clnItemsToSelect.Eof do
            begin
              if SelectedItemList.IndexOf(clnItemsToSelectInvItemNo.AsString) >= 0 then
                begin
                  qryInsItems.Close;
                  qryInsItems.Params.ParamByName('TRANSACTION_NO').Value := DM.qryTransactionsTRANSACTION_NO.AsInteger;
                  qryInsItems.Params.ParamByName('INV_CAT_NO').Value := clnItemsToSelectInvCatNo.AsInteger;
                  qryInsItems.Params.ParamByName('J_TYPE').Value := clnItemsToSelectJType.Value;
                  qryInsItems.Params.ParamByName('J_STYLE').Value := clnItemsToSelectJStyle.Value;
                  qryInsItems.Params.ParamByName('J_METAL').Value := clnItemsToSelectJMetal.AsString;
                  qryInsItems.Params.ParamByName('INV_ITEM_COUNT').Value := clnItemsToSelectInvItemCount.Value;
                  qryInsItems.Params.ParamByName('NOTE').Value := clnItemsToSelectNote.Value;
                  qryInsItems.Params.ParamByName('SIZE_LENGTH').Value := clnItemsToSelectSizeLength.Value;
                  qryInsItems.Params.ParamByName('WEIGHT').Value := clnItemsToSelectWeight.Value;
                  qryInsItems.Params.ParamByName('KT').Value := clnItemsToSelectKT.Value;
                  qryInsItems.Params.ParamByName('INV_ITEM_STATUS').Value := 'P';
                  qryInsItems.Params.ParamByName('INV_ITEM_BRAND').Value := clnItemsToSelectInvItemBrand.Value;

                  qryInsItems.Params.ParamByName('SERIAL_NUMBER').Value := clnItemsToSelectSerialNumber.Value;
                  qryInsItems.Params.ParamByName('OWNER_APP_NUMBER').Value := clnItemsToSelectOwnerAppNumber.Value;
                  qryInsItems.Params.ParamByName('MODEL_NUMBER').Value := clnItemsToSelectModelNumber.Value;
                  qryInsItems.Params.ParamByName('DESCRIPTION').Value := clnItemsToSelectDescription.Value;
                  qryInsItems.Params.ParamByName('GENDER').Value := clnItemsToSelectGender.Value;
                  qryInsItems.Params.ParamByName('WEIGHT_UNIT').AsString := DefaultWeightMeasureUnit;
                  // Items copied into a new pawn are newly pawned as of this
                  // ticket. Without this the row carries INV_ITEM_STATUS='P' but
                  // no date, and GetPawnItemStatus - which derives the status
                  // from the dates, not from INV_ITEM_STATUS - falls through
                  // every branch and reports the item as blank.
                  qryInsItems.Params.ParamByName('PAWNED_DATE').AsDate :=
                    DM.qryTransactionsTRAN_DATE.AsDateTime;

                  qryInsItems.Open;
                  NewInvItemNo := qryInsItems.FieldByName('INV_ITEM_NO').AsInteger;
                  qryInsItems.Close;

                  ExecSQLStatementFB(Format(
                    'UPDATE INVENTORY_ITEMS SET INV_ITEM_BARCODE = %s WHERE INV_ITEM_NO = %d',
                    [QuotedStr(DM.GetBarcode(NewInvItemNo)), NewInvItemNo]));

                  StoneQry.Params.ParamByName('NEW_INV_ITEM_NO').AsInteger := NewInvItemNo;
                  StoneQry.Params.ParamByName('OLD_INV_ITEM_NO').AsInteger := clnItemsToSelectInvItemNo.AsInteger;
                  StoneQry.Params.ParamByName('DEFAULT_WEIGHT_UNIT').AsString := DefaultWeightMeasureUnit;
                  StoneQry.ExecSQL;
                end;

              clnItemsToSelect.Next;
            end;
        finally
          clnItemsToSelect.EnableControls;
        end;
        finally
          StoneQry.Free;
        end;
      end;

    if StartedFBTrans and DM.ConnFB.InTransaction then
      DM.ConnFB.Commit;

//    Application.ProcessMessages;
//    DM.qryTransactions.Refresh;
  except
    if StartedFBTrans and DM.ConnFB.InTransaction then
      DM.ConnFB.Rollback;
    DM.qryTransactions.Refresh;
    Raise;
  end;
  ModalResult := mrOK;
end;

procedure TfrmEnterTransaction.First1Click(Sender: TObject);
begin
  DM.qryTransactionsTRAN_INTEREST.AsFloat := DM.qryTransactionsINTEREST_BALANCE.AsFloat / DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat * 100;
end;

procedure TfrmEnterTransaction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DM.qryTransactions.State in [dsEdit, dsInsert] then
    DM.qryTransactions.Cancel;
end;

procedure TfrmEnterTransaction.dbGridItemsCellClick(Column: TColumn);
begin
  // Defensively check Active; the panel is hidden in add/edit mode but events
  // can still fire from programmatic invalidation, focus changes, etc.
  if not clnItemsToSelect.Active then exit;
  if clnItemsToSelectInvItemNo.IsNull or (Column.Index <> 0) then
    exit;

   if InItemList(clnItemsToSelectInvItemNo.AsInteger) then
      RemoveFromItemList(clnItemsToSelectInvItemNo.AsInteger)
   else
     AddToItemList(clnItemsToSelectInvItemNo.AsInteger);

   dbGridItems.Invalidate;
end;

procedure TfrmEnterTransaction.FormCreate(Sender: TObject);
begin
  lblItemsWithNoCost.Caption := '';
  lblItemsWithNoCost.Visible := false;

  if DM.qryCustomerscCustAge.AsInteger <= LastMinorAge then
    begin
      lblUnderAge.Caption := DM.qryCustomerscCustAge.AsString + ' Years Old';
      lblUnderAge.Visible := true;
    end
  else
    begin
      lblUnderAge.Caption := '';
      lblUnderAge.Visible := false;
    end;

  DM.ReCalcMaturity := true;

  // PropertyStore persists to DM.RegIniFile (%LOCALAPPDATA%\PawnPro). On a
  // machine where that write occasionally fails (roaming profile, AV lock),
  // a raise here would abort the constructor -> auto-destruct -> and the
  // half-built form is left registered under its owner, so the NEXT open dies
  // with "A component named frmEnterTransaction already exists". The remembered
  // checkbox state is cosmetic; never let it take the form down.
  try
    PropertyStore.Load;
  except
    // ignore - open with default state rather than fail to open at all
  end;

  SelectedItemList := TStringList.Create;
end;

procedure TfrmEnterTransaction.FormDestroy(Sender: TObject);
begin
  DM.ReCalcMaturity := false;

  SelectedItemList.Free;

  // Must not raise: OnDestroy runs before the form is unlinked from its owner,
  // so an exception here leaves an orphan named frmEnterTransaction registered
  // under frmClients, and the next open fails with "already exists". See the
  // matching guard in FormCreate.
  try
    PropertyStore.Save;
  except
    // losing the persisted checkbox state is harmless; orphaning the form isn't
  end;
end;

procedure TfrmEnterTransaction.dbGridItemsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if not clnItemsToSelect.Active then exit;
  if clnItemsToSelectInvItemNo.IsNull then
    exit;

  GridCheckBox((Sender as TDBGrid), Rect, Column, DataCol, State, InItemList(clnItemsToSelectInvItemNo.AsInteger));
end;

procedure TfrmEnterTransaction.dbGridItemsTitleClick(Column: TColumn);
begin
  if not clnItemsToSelect.Active then exit;
  DoGridSorting(dbGridItems, Column, clnItemsToSelect, LastIndexUsed, WriteLogFile);
end;

procedure TfrmEnterTransaction.edInterestChange(Sender: TObject);
begin
  IntChanged := true;
end;

procedure TfrmEnterTransaction.edInterestExit(Sender: TObject);
begin
  if NewRow and IntChanged then
    begin
      Second1Click(nil);
    end;
end;

procedure TfrmEnterTransaction.edPawnAmountExit(Sender: TObject);
var
  IntRate, IntAmount: Extended;
begin
  if (not DM.qryTransactionsTRAN_PAWN_AMOUNT.IsNull) and NewRow and (DM.qryTransactionsTRAN_TYPE.AsString = TranPawn) then
    begin
      IntRate := DM.qryTransactionsTRAN_INTEREST.AsCurrency;
      DM.CalcInterest(DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency, IntRate, IntAmount);
      DM.qryTransactionsTRAN_INTEREST.AsFloat := ConvertTo2Dec(IntRate);
      DM.qryTransactionsINTEREST_BALANCE.AsCurrency := ConvertTo2Dec(IntAmount);
    end;

end;

procedure TfrmEnterTransaction.CheckAllItems;
var
  SavePos: integer;
begin
  if not clnItemsToSelect.Active then
    exit;

  SavePos := clnItemsToSelect.RecNo;
  try
    clnItemsToSelect.DisableControls;
    clnItemsToSelect.First;
    while not clnItemsToSelect.Eof do
      begin
        AddToItemList(clnItemsToSelectInvItemNo.AsInteger);
        clnItemsToSelect.Next;
      end;
  finally
    clnItemsToSelect.RecNo := SavePos;
    clnItemsToSelect.EnableControls;
  end;

  dbGridItems.Invalidate;
end;

procedure TfrmEnterTransaction.chkShowOnlyInTranClick(Sender: TObject);
begin
  OpenLookupItemQry;
end;

procedure TfrmEnterTransaction.ClearAllItems;
begin
  SelectedItemList.Free;
  SelectedItemList := TStringList.Create;
  dbGridItems.Invalidate;
end;

procedure TfrmEnterTransaction.btnViewInLargeGridClick(Sender: TObject);
begin
  frmItemsToCopyLargeGrid := TfrmItemsToCopyLargeGrid.Create(Self);
  try
    frmItemsToCopyLargeGrid.ShowModal;
    dbGridItems.Invalidate;
  finally
    frmItemsToCopyLargeGrid.Free;
  end;
end;

procedure TfrmEnterTransaction.btnCheckAllClick(Sender: TObject);
begin
  CheckAllItems;
end;

procedure TfrmEnterTransaction.btnClearAllClick(Sender: TObject);
begin
  ClearAllItems;
end;

procedure TfrmEnterTransaction.btnGetPawnAddingAllItemCostClick(Sender: TObject);
var
  PawnAmount: Currency;
  ItemsWithNoEnteredCost: integer;
  ItemPlural: string;
begin
    frmClients.CalcPawnAmountFromItemCost(PawnAmount, ItemsWithNoEnteredCost);
    DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency := PawnAmount;
    if ItemsWithNoEnteredCost > 0 then
      begin
        ItemPlural := IfThen(ItemsWithNoEnteredCost = 1, '', 's');
        lblItemsWithNoCost.Caption := Format('%d item%s with no cost entered.', [ItemsWithNoEnteredCost, ItemPlural]);
        lblItemsWithNoCost.Visible := true;
      end
    else
      begin
        lblItemsWithNoCost.Visible := false;
      end;
end;

procedure TfrmEnterTransaction.btnRecalcIntSameDayCreatedClick(Sender: TObject);
begin
  edPawnAmountExit(nil);
end;

procedure TfrmEnterTransaction.Second1Click(Sender: TObject);
var
  LastPayDate: TDateTime;
  MonthSinceLastPayment: integer;
  Amount: Currency;
begin
  if (DM.qryTransactionsTRAN_TYPE.AsString = TranPawn) and (not DM.qryTransactionsTRAN_PAWN_AMOUNT.IsNull) then
    begin
      LastPayDate := DM.LastPaymentForTransaction(DM.qryTransactionsTRANSACTION_NO.AsInteger);
      if LastPayDate > 0 then
        MonthSinceLastPayment := MonthsBetween(Date, LastPayDate)
      else
        MonthSinceLastPayment := 0;

      if NewRow then
        Amount := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency
      else
        Amount := DM.qryTransactionsPRINC_BALANCE.AsCurrency;

      DM.qryTransactionsINTEREST_BALANCE.AsFloat := DM.CalcNextInt(Amount, (DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.00), MonthSinceLastPayment);
    end;
end;

end.
