unit EditStockReceipt;

{ Pop-up to add or edit one stock receipt (a supplier invoice) -- the header
  of Receive Stock. Save writes it (TDM.SaveStockReceipt); Cancel writes
  nothing, so the receipt stays as it was.

  The Supplier box works like the Brand box of the item form: pick a name typed
  before, or type a new one -- it becomes a supplier on Save
  (TDM.FindOrAddSupplier). }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, RzEdit, RzButton;

type
  TfrmEditStockReceipt = class(TForm)
    gbReceipt: TGroupBox;
    lblReceiptNo: TLabel;
    lblSupplier: TLabel;
    cbSupplier: TComboBox;
    lblReceived: TLabel;
    edReceivedDate: TRzDateTimeEdit;
    lblInvoiceNo: TLabel;
    edInvoiceNo: TEdit;
    lblInvoiceDate: TLabel;
    edInvoiceDate: TRzDateTimeEdit;
    lblInvoiceTotal: TLabel;
    edInvoiceTotal: TRzNumericEdit;
    lblPayType: TLabel;
    cbPayType: TComboBox;
    lblNotes: TLabel;
    memNotes: TMemo;
    gbButtons: TGroupBox;
    BitBtn1: TBitBtn;
    RzBitBtn1: TRzBitBtn;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FReceiptNo: integer;
    procedure LoadLists;
    procedure LoadReceipt;
  public
    { Opens the pop-up on ReceiptNo, or on a new receipt (0). True when saved;
      ReceiptNo then holds the saved receipt's number. }
    class function Execute(AOwner: TComponent; var ReceiptNo: integer): boolean;
  end;

implementation

{$R *.dfm}

uses System.DateUtils, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  PawnDM, PawnGlobal, uPawnDialogs;

class function TfrmEditStockReceipt.Execute(AOwner: TComponent; var ReceiptNo: integer): boolean;
var
  Dlg: TfrmEditStockReceipt;
begin
  Dlg := TfrmEditStockReceipt.Create(AOwner);
  try
    Dlg.FReceiptNo := ReceiptNo;
    Dlg.LoadLists;
    Dlg.LoadReceipt;
    Result := Dlg.ShowModal = mrOk;
    if Result then
      ReceiptNo := Dlg.FReceiptNo;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmEditStockReceipt.FormShow(Sender: TObject);
begin
  // A new receipt starts on today. Set here, once the date box exists: set
  // before the form is shown it did not stick.
  if FReceiptNo = 0 then
    edReceivedDate.Date := Date;
  cbSupplier.SetFocus;
end;

{ Suppliers already used (active ones), and payment types: "(not set)" first,
  the rest carrying PAY_TYPE_NO in Objects. }
procedure TfrmEditStockReceipt.LoadLists;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.ConnFB;
    Q.SQL.Text := 'SELECT SUPPLIER_NAME FROM SUPPLIERS WHERE ACTIVE ORDER BY SUPPLIER_NAME';
    Q.Open;
    cbSupplier.Items.Clear;
    while not Q.Eof do
      begin
        cbSupplier.Items.Add(Q.Fields[0].AsString);
        Q.Next;
      end;

    Q.Close;
    Q.SQL.Text := 'SELECT PAY_TYPE_NO, PAYMENT_TYPE FROM PAYMENT_TYPES ORDER BY PAY_TYPE_NO';
    Q.Open;
    cbPayType.Items.Clear;
    cbPayType.Items.AddObject('(not set)', TObject(0));
    while not Q.Eof do
      begin
        cbPayType.Items.AddObject(Q.Fields[1].AsString, TObject(Q.Fields[0].AsInteger));
        Q.Next;
      end;
    cbPayType.ItemIndex := 0;
  finally
    Q.Free;
  end;
end;

procedure TfrmEditStockReceipt.LoadReceipt;
var
  Q: TFDQuery;
  i: integer;
begin
  if FReceiptNo = 0 then
    begin
      Caption := 'New Stock Receipt';
      lblReceiptNo.Caption := 'New receipt';
      edReceivedDate.Date := Date;
      edInvoiceDate.Clear;
      edInvoiceTotal.Value := 0;
      exit;
    end;

  Caption := 'Edit Stock Receipt';
  lblReceiptNo.Caption := Format('Receipt # %d', [FReceiptNo]);
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.ConnFB;
    Q.SQL.Text :=
      'SELECT r.*, s.SUPPLIER_NAME FROM STOCK_RECEIPTS r ' +
      'JOIN SUPPLIERS s ON s.SUPPLIER_NO = r.SUPPLIER_NO WHERE r.STOCK_RECEIPT_NO = :R';
    Q.ParamByName('R').AsInteger := FReceiptNo;
    Q.Open;
    cbSupplier.Text := Q.FieldByName('SUPPLIER_NAME').AsString;
    edReceivedDate.Date := Q.FieldByName('RECEIVED_DATE').AsDateTime;
    edInvoiceNo.Text := Q.FieldByName('INVOICE_NO').AsString;
    if Q.FieldByName('INVOICE_DATE').IsNull then
      edInvoiceDate.Clear
    else
      edInvoiceDate.Date := Q.FieldByName('INVOICE_DATE').AsDateTime;
    edInvoiceTotal.Value := Q.FieldByName('INVOICE_TOTAL').AsCurrency;
    for i := 1 to cbPayType.Items.Count - 1 do
      if integer(cbPayType.Items.Objects[i]) = Q.FieldByName('PAY_TYPE_NO').AsInteger then
        cbPayType.ItemIndex := i;
    memNotes.Text := Q.FieldByName('NOTES').AsString;
  finally
    Q.Free;
  end;
end;

procedure TfrmEditStockReceipt.btnSaveClick(Sender: TObject);
var
  SupplierNo, PayTypeNo: integer;
  InvDate, InvTotal, PayType: Variant;
begin
  if Trim(cbSupplier.Text) = '' then
    begin
      PawnInfo('Please enter the supplier.', Caption, Self);
      cbSupplier.SetFocus;
      exit;
    end;
  if edReceivedDate.Date = 0 then
    begin
      PawnInfo('Please enter the received date.', Caption, Self);
      edReceivedDate.SetFocus;
      exit;
    end;
  if edReceivedDate.Date > Date then
    begin
      PawnInfo('The received date cannot be in the future.', Caption, Self);
      edReceivedDate.SetFocus;
      exit;
    end;

  if Trim(edInvoiceDate.Text) = '' then InvDate := Null else InvDate := DateOf(edInvoiceDate.Date);
  if edInvoiceTotal.Value = 0 then InvTotal := Null else InvTotal := edInvoiceTotal.Value;
  PayTypeNo := 0;
  if cbPayType.ItemIndex > 0 then
    PayTypeNo := integer(cbPayType.Items.Objects[cbPayType.ItemIndex]);
  if PayTypeNo = 0 then PayType := Null else PayType := PayTypeNo;

  try
    SupplierNo := DM.FindOrAddSupplier(cbSupplier.Text);
    FReceiptNo := DM.SaveStockReceipt(FReceiptNo, SupplierNo, edReceivedDate.Date,
                                      edInvoiceNo.Text, InvDate, InvTotal, PayType, memNotes.Text);
  except
    on E: Exception do
      begin
        PawnWarn(E.Message, Caption, Self);
        exit;
      end;
  end;
  ModalResult := mrOk;
end;

end.
