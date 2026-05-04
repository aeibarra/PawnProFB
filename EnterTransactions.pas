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
    clnItemsToSelectInvItemBarcode: TStringField;
    clnItemsToSelectInvCatNo: TIntegerField;
    clnItemsToSelectJType: TStringField;
    clnItemsToSelectJStyle: TStringField;
    clnItemsToSelectJMetal: TStringField;
    clnItemsToSelectInvItemCount: TIntegerField;
    clnItemsToSelectSizeLength: TFloatField;
    clnItemsToSelectWeight: TFloatField;
    clnItemsToSelectKT: TFloatField;
    clnItemsToSelectCreated: TDateTimeField;
    clnItemsToSelectUnitCost: TBCDField;
    clnItemsToSelectUnitPrice: TBCDField;
    clnItemsToSelectInvItemStatus: TStringField;
    clnItemsToSelectTransactionNo: TIntegerField;
    clnItemsToSelectInvOriginalItemNo: TIntegerField;
    clnItemsToSelectInvItemBrand: TStringField;
    clnItemsToSelectSerialNumber: TStringField;
    clnItemsToSelectOwnerAppNumber: TStringField;
    clnItemsToSelectModelNumber: TStringField;
    clnItemsToSelectGender: TStringField;
    clnItemsToSelectDescription: TStringField;
    clnItemsToSelectJStyleDesc: TStringField;
    clnItemsToSelectJTypeDesc: TStringField;
    clnItemsToSelectJMetalDesc: TStringField;
    clnItemsToSelectInvItemNo: TIntegerField;
    clnItemsToSelectInvCategory: TStringField;
    clnItemsToSelectNote: TStringField;
    lblUnderAge: TLabel;
    qryInvItems: TFDQuery;
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
    qryInvItemsINV_CATEGORY: TStringField;
    qryInvItemsJ_STYLE_DESC: TStringField;
    qryInvItemsJ_TYPE_DESC: TStringField;
    qryInvItemsJ_METAL_DESC: TStringField;
    qryInsItems: TFDQuery;
    btnViewInLargeGrid: TRzToolButton;
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
  private
    LastIndexUsed: string;
    IntChanged: boolean;
    procedure OpenLookupItemQry;
    function GetLastTicketNo: integer;
    { Private declarations }
  public
    { Public declarations }
    NewRow: boolean;
    CustNo: integer;
    SelectedItemList: TStringList;
    FilterByTransactionNo: integer;
    function InItemList(ItemNo: integer): boolean;
    procedure ClearAllItems;
    procedure CheckAllItems;
    procedure RemoveFromItemList(ItemNo: integer);
    procedure AddToItemList(ItemNo: integer);
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
    begin
      clnItemsToSelect.EmptyDataSet;
      clnItemsToSelect.Close;
    end;

  clnItemsToSelect.DisableControls;
  try
    clnItemsToSelect.IndexName := '';
    clnItemsToSelect.IndexFieldNames := '';
    clnItemsToSelect.IndexDefs.Clear;

    clnItemsToSelect.CreateDataSet;

    //Open Items Previous Items Look up
    if (FilterByTransactionNo <= 0) or (not chkShowOnlyInTran.Checked) then
      FilterByTransactionNoVar := null
    else
      FilterByTransactionNoVar := FilterByTransactionNo;

    qryInvItems.Close;
    qryInvItems.Params.ParamByName('TRANSACTION_NO').Value := FilterByTransactionNoVar;
    qryInvItems.Params.ParamByName('CUST_NO').AsInteger := CustNo;
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
  pnSelectItemsToCopy.Visible := CustNo > 0;
  if CustNo > 0 then
    begin
//      Height := 512;
//      Width := 643;
      pnSelectItemsToCopy.Visible := true;

      OpenLookupItemQry;

    end
  else
    begin
//      Height := 242;
//      Width := 371;
      gbTop.Width := edMaturityDate.Left + edMaturityDate.Width + 15;
      gbTop.Height := edMemoComment.Top + edMemoComment.Height + 15;
      gbBottom.Width := gbTop.Width;
      gbBottom.Top := gbTop.Top + gbTop.Height + 5;
      pnSelectItemsToCopy.Visible := false;
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
          StoneQry.SQL.Text :=
            'INSERT INTO STONES (INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE) ' +
            'SELECT :NEW_INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE ' +
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

                  qryInsItems.Open;
                  NewInvItemNo := qryInsItems.FieldByName('INV_ITEM_NO').AsInteger;
                  qryInsItems.Close;

                  ExecSQLStatementFB(Format(
                    'UPDATE INVENTORY_ITEMS SET INV_ITEM_BARCODE = %s WHERE INV_ITEM_NO = %d',
                    [QuotedStr(DM.GetBarcode(NewInvItemNo)), NewInvItemNo]));

                  StoneQry.Params.ParamByName('NEW_INV_ITEM_NO').AsInteger := NewInvItemNo;
                  StoneQry.Params.ParamByName('OLD_INV_ITEM_NO').AsInteger := clnItemsToSelectInvItemNo.AsInteger;
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
    Application.ProcessMessages;
    DM.qryTransactions.Refresh;
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

  PropertyStore.Load;

  SelectedItemList := TStringList.Create;
end;

procedure TfrmEnterTransaction.FormDestroy(Sender: TObject);
begin
  DM.ReCalcMaturity := false;

  SelectedItemList.Free;
  PropertyStore.Save;
end;

procedure TfrmEnterTransaction.dbGridItemsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if clnItemsToSelectInvItemNo.IsNull then
    exit;

  GridCheckBox((Sender as TDBGrid), Rect, Column, DataCol, State, InItemList(clnItemsToSelectInvItemNo.AsInteger));
end;

procedure TfrmEnterTransaction.dbGridItemsTitleClick(Column: TColumn);
begin
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
