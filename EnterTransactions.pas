unit EnterTransactions;

interface

uses
  Windows, Messages, SysUtils, Classes, StrUtils, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, Buttons, DBCtrls, Mask, System.UITypes, DateUtils, Variants,
  ADODB, Grids, DBGrids, ExtCtrls,  RzButton, RzEdit, RzDBEdit, Vcl.Menus,
  RzCommon, RzLabel, Datasnap.DBClient;

type
  TfrmEnterTransaction = class(TForm)
    gbBottom: TGroupBox;
    btnCancel: TBitBtn;
    qryNextTicket: TADODataSet;
    qryNextTicketTableName: TStringField;
    qryNextTicketLastKey: TIntegerField;
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
    qryInvItems: TADOQuery;
    dsInvItems: TDataSource;
    qryTypes: TADOQuery;
    qryTypesJType: TStringField;
    qryTypesJTypeDesc: TStringField;
    qryStyles: TADOQuery;
    qryStylesJStyle: TStringField;
    qryStylesJStyleDesc: TStringField;
    qryMetal: TADOQuery;
    qryMetalJMetal: TStringField;
    qryMetalJMetalDesc: TStringField;
    qryCategories: TADOQuery;
    qryCategoriesInvCatNo: TAutoIncField;
    qryCategoriesInvCategory: TStringField;
    qryInsItems: TADOQuery;
    qryInvItems__: TADOQuery;
    qryInvItems__InvItemNo: TIntegerField;
    qryInvItems__InvItemBarcode: TStringField;
    qryInvItems__InvCatNo: TIntegerField;
    qryInvItems__JType: TStringField;
    qryInvItems__JStyle: TStringField;
    qryInvItems__JMetal: TStringField;
    qryInvItems__InvItemCount: TIntegerField;
    qryInvItems__Note: TStringField;
    qryInvItems__SizeLength: TFloatField;
    qryInvItems__Weight: TFloatField;
    qryInvItems__KT: TFloatField;
    qryInvItems__Created: TDateTimeField;
    qryInvItems__UnitCost: TBCDField;
    qryInvItems__UnitPrice: TBCDField;
    qryInvItems__InvItemStatus: TStringField;
    qryInvItems__TransactionNo: TIntegerField;
    qryInvItems__InvOriginalItemNo: TIntegerField;
    qryInvItems__InvItemBrand: TStringField;
    qryInvItems__OwnerAppNumber: TStringField;
    qryInvItems__ModelNumber: TStringField;
    qryInvItems__SerialNumber: TStringField;
    qryInvItems__Gender: TStringField;
    qryInvItems__Description: TStringField;
    pnSelectItemsToCopy: TPanel;
    Panel2: TPanel;
    btnCheckAll: TButton;
    btnClearAll: TButton;
    Panel3: TPanel;
    Label9: TLabel;
    dbGridItems: TDBGrid;
    qryInvItems__InvCategory: TStringField;
    qryInvItems__JStyleDesc: TStringField;
    qryInvItems__JTypeDesc: TStringField;
    qryInvItems__JMetalDesc: TStringField;
    SpeedButton2: TSpeedButton;
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
    qryInvItemsInvItemNo: TIntegerField;
    qryInvItemsInvItemBarcode: TStringField;
    qryInvItemsInvCatNo: TIntegerField;
    qryInvItemsJType: TStringField;
    qryInvItemsJStyle: TStringField;
    qryInvItemsJMetal: TStringField;
    qryInvItemsInvItemCount: TIntegerField;
    qryInvItemsNote: TStringField;
    qryInvItemsSizeLength: TFloatField;
    qryInvItemsWeight: TFloatField;
    qryInvItemsKT: TFloatField;
    qryInvItemsCreated: TDateTimeField;
    qryInvItemsUnitCost: TBCDField;
    qryInvItemsUnitPrice: TBCDField;
    qryInvItemsInvItemStatus: TStringField;
    qryInvItemsTransactionNo: TIntegerField;
    qryInvItemsInvOriginalItemNo: TIntegerField;
    qryInvItemsInvItemBrand: TStringField;
    qryInvItemsOwnerAppNumber: TStringField;
    qryInvItemsModelNumber: TStringField;
    qryInvItemsSerialNumber: TStringField;
    qryInvItemsGender: TStringField;
    qryInvItemsDescription: TStringField;
    qryInvItemsInvCategory: TStringField;
    qryInvItemsJStyleDesc: TStringField;
    qryInvItemsJTypeDesc: TStringField;
    qryInvItemsJMetalDesc: TStringField;
    clnItemsToSelectNote: TStringField;
    lblUnderAge: TLabel;
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
    procedure qryInvItems__CalcFields(DataSet: TDataSet);
    procedure dbGridItemsTitleClick(Column: TColumn);
    procedure SpeedButton2Click(Sender: TObject);
    procedure First1Click(Sender: TObject);
    procedure Second1Click(Sender: TObject);
    procedure chkShowOnlyInTranClick(Sender: TObject);
    procedure btnGetPawnAddingAllItemCostClick(Sender: TObject);
    procedure edInterestExit(Sender: TObject);
    procedure edInterestChange(Sender: TObject);
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

procedure TfrmEnterTransaction.qryInvItems__CalcFields(DataSet: TDataSet);
begin
{  if qryTypes.Locate('JType', qryInvItemsJType.AsString, []) then
    qryInvItemscType.AsString := qryTypesJTypeDesc.AsString;

  if qryStyles.Locate('JStyle', qryInvItemsJStyle.AsString, []) then
     qryInvItemscStyle.AsString := qryStylesJStyleDesc.AsString;

  if qryMetal.Locate('JMetal', qryInvItemsJMetal.AsString, []) then
    qryInvItemscMetal.AsString := qryMetalJMetalDesc.AsString;

  if qryCategories.Locate('InvCatNo', qryInvItemsInvCatNo.AsInteger, []) then
    qryInvItemscCatName.AsString := qryCategoriesInvCategory.AsString;}
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
    qryInvItems.Parameters.ParamByName('TransactionNo').Value := FilterByTransactionNoVar;
    qryInvItems.Parameters.ParamByName('CustNo').Value := CustNo;
    qryInvItems.Open;
//    qryInvItems.Sort := 'Description';

    //Load ClientDataSet
    while not qryInvItems.Eof do
      begin
        //Check if the item does not exits. We add it
        if not clnItemsToSelect.Locate('Description;Weight;SizeLength;JStyleDesc;JTypeDesc;JMetalDesc',
                       VarArrayOf([qryInvItemsDescription.AsString, qryInvItemsWeight.AsFloat,
                                   qryInvItemsSizeLength.AsFloat, qryInvItemsJStyleDesc.AsString,
                                  qryInvItemsJTypeDesc.AsString, qryInvItemsJMetalDesc.AsString]), []) then
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
  qryNextTicket.Close;
  qryNextTicket.Open;
  Result := qryNextTicketLastKey.AsInteger;
  qryNextTicket.Close;
end;

procedure TfrmEnterTransaction.FormShow(Sender: TObject);
begin
  pnSelectItemsToCopy.Visible := CustNo > 0;
  if CustNo > 0 then
    begin
//      Height := 512;
//      Width := 643;
      pnSelectItemsToCopy.Visible := true;

      qryTypes.Open;
      qryStyles.Open;
      qryMetal.Open;
      qryCategories.Open;

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
begin
  AskIfUpdateTicketNo := false;
  btnSave.SetFocus;

  if DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat <= 0 then
    begin
      MessageDlg('Please enter Pawn total amount.', mtInformation, [mbOk], 0);
      edPawnAmount.SetFocus;
      exit;
    end;

  DM.ConnDB.BeginTrans;
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
             if DM.ConnDB.Connected and DM.ConnDB.InTransaction then
               DM.ConnDB.RollbackTrans;

             exit;
           end;

         AskIfUpdateTicketNo := true;
       end;

       if not qryNextTicket.Active then
         begin
           qryNextTicket.Open;
         end;

       if not AskIfUpdateTicketNo or (AskIfUpdateTicketNo and (MessageDlg('Update Ticket Number?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)) then
         begin
           qryNextTicket.Edit;
           qryNextTicketLastKey.AsInteger := DM.qryTransactionsTRAN_TICKET_NO.AsInteger;
           qryNextTicket.Post;
         end;

     end;

     DM.qryTransactions.Post;
//    DM.qryTransactions.Refresh;

    if clnItemsToSelect.Active then
      begin
        clnItemsToSelect.DisableControls;
        try
          clnItemsToSelect.First;
          while not clnItemsToSelect.Eof do
            begin
              if SelectedItemList.IndexOf(clnItemsToSelectInvItemNo.AsString) >= 0 then
                begin
                  NewInvItemNo := DM.GetNextKey('InventoryItems');
                  qryInsItems.Parameters.ParamByName('InvItemNo').Value := NewInvItemNo;
                  qryInsItems.Parameters.ParamByName('TransactionNo').Value := DM.qryTransactionsTRANSACTION_NO.AsInteger;
                  qryInsItems.Parameters.ParamByName('InvItemBarcode').Value := DM.GetBarcode(NewInvItemNo);
                  qryInsItems.Parameters.ParamByName('InvCatNo').Value :=  clnItemsToSelectInvCatNo.AsInteger;
                  qryInsItems.Parameters.ParamByName('JType').Value := clnItemsToSelectJType.Value;
                  qryInsItems.Parameters.ParamByName('JStyle').Value := clnItemsToSelectJStyle.Value;
                  qryInsItems.Parameters.ParamByName('JMetal').Value := clnItemsToSelectJMetal.AsString;
                  qryInsItems.Parameters.ParamByName('InvItemCount').Value := clnItemsToSelectInvItemCount.Value;
                  qryInsItems.Parameters.ParamByName('Note').Value := clnItemsToSelectNote.Value;
                  qryInsItems.Parameters.ParamByName('SizeLength').Value := clnItemsToSelectSizeLength.Value;
                  qryInsItems.Parameters.ParamByName('Weight').Value := clnItemsToSelectWeight.Value;
                  qryInsItems.Parameters.ParamByName('KT').Value := clnItemsToSelectKT.Value;
                  qryInsItems.Parameters.ParamByName('InvItemStatus').Value := 'P';
                  qryInsItems.Parameters.ParamByName('InvItemBrand').Value := clnItemsToSelectInvItemBrand.Value;

                  qryInsItems.Parameters.ParamByName('SerialNumber').Value := clnItemsToSelectSerialNumber.Value;
                  qryInsItems.Parameters.ParamByName('OwnerAppNumber').Value := clnItemsToSelectOwnerAppNumber.Value;
                  qryInsItems.Parameters.ParamByName('ModelNumber').Value := clnItemsToSelectModelNumber.Value;
                  qryInsItems.Parameters.ParamByName('Description').Value := clnItemsToSelectDescription.Value;
                  qryInsItems.Parameters.ParamByName('Gender').Value := clnItemsToSelectGender.Value;

                  qryInsItems.ExecSQL;

                  DM.ConnDB.Execute(
                    'INSERT INTO Stones (InvItemNo, StoneNumber, StoneShape, StoneColor, CT, WT, StoneType) ' +
                    '             SELECT ' + IntToStr(NewInvItemNo) + ', StoneNumber, StoneShape, StoneColor, CT, WT, StoneType ' +
                    '             FROM Stones  ' +
                    '             WHERE InvItemNo = ' + clnItemsToSelectInvItemNo.AsString);
                end;

              clnItemsToSelect.Next;
            end;
        finally
          clnItemsToSelect.EnableControls;
        end;
      end;

    DM.ConnDB.CommitTrans;
    Application.ProcessMessages;
    DM.qryTransactions.Refresh;
  except
    if DM.ConnDB.InTransaction then
      DM.ConnDB.RollbackTrans;
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

procedure TfrmEnterTransaction.SpeedButton2Click(Sender: TObject);
begin
  frmItemsToCopyLargeGrid := TfrmItemsToCopyLargeGrid.Create(Self);
  try
    frmItemsToCopyLargeGrid.ShowModal;
    dbGridItems.Invalidate; 
  finally
    frmItemsToCopyLargeGrid.Free;
  end;
end;

end.
