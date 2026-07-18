unit Report01;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, ppBands, ppCache, ppDesignLayer, ppParameter, ppVar, ppPrnabl,
  ppCtrls, ppStrtch, ppSubRpt, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  Datasnap.Provider, Vcl.Mask, RzEdit, RzSpnEdt, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmReport01 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    dsLatePawn: TDataSource;
    DBPLatePawn: TppDBPipeline;
    RepLatePawn: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    lblRptLatePayTitle: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppLabel3: TppLabel;
    ppDBText4: TppDBText;
    qryPayments: TFDQuery;
    dsPayments: TDataSource;
    ppDBText2: TppDBText;
    prvLatePawn: TDataSetProvider;
    clnLatePawn: TClientDataSet;
    clnLatePawncFullName: TWideStringField;
    clnLatePawnTransactionNo: TIntegerField;
    clnLatePawnTranTicketNo: TWideStringField;
    clnLatePawnCustno: TIntegerField;
    clnLatePawnCustLast: TWideStringField;
    clnLatePawnCustFirst: TWideStringField;
    clnLatePawnCustMid: TWideStringField;
    clnLatePawnTranPawnAmount: TFloatField;
    clnLatePawnLatePayment: TIntegerField;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    DBPPayments: TppDBPipeline;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppDetailBand2: TppDetailBand;
    ppDBText3: TppDBText;
    ppDBText6: TppDBText;
    ppTitleBand1: TppTitleBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLine2: TppLine;
    ppSummaryBand1: TppSummaryBand;
    ppLine3: TppLine;
    Label2: TLabel;
    edMonths: TRzSpinEdit;
    btnExit: TBitBtn;
    spLatePawn: TFDQuery;
    clnLatePawnTranDate: TDateField;
    clnLatePawncPhones: TWideStringField;
    clnLatePawnCustPhCell: TWideStringField;
    clnLatePawnCustPhHome: TWideStringField;
    clnLatePawnCustPhBussiness: TWideStringField;
    ppLabel10: TppLabel;
    lblProgress: TLabel;
    ppDBText5: TppDBText;
    clnLatePawnInterestOwed: TFloatField;
    clnLatePawnNextDueDate: TDateField;
    clnLatePawnTranInterest: TFloatField;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppLabel1: TppLabel;
    ppLabel6: TppLabel;
    ppLabel9: TppLabel;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure clnLatePawnAfterScroll(DataSet: TDataSet);
    procedure clnLatePawnCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure PrintReport(Preview: boolean);
    procedure BuildLateList(MonthsBehind: Integer);
  public
    { Public declarations }
  end;

var
  frmReport01: TfrmReport01;

implementation

{$R *.dfm}

uses PawnDM, GLbUtils, PawnGlobal, System.Math, System.Generics.Collections;

procedure TfrmReport01.RzBitBtn1Click(Sender: TObject);
begin
  PrintReport(true);
end;

procedure TfrmReport01.RzBitBtn2Click(Sender: TObject);
begin
  PrintReport(false);
end;

procedure TfrmReport01.clnLatePawnAfterScroll(DataSet: TDataSet);
begin
  qryPayments.Close;
  qryPayments.Params.ParamByName('TransactionNo').AsInteger := clnLatePawnTransactionNo.AsInteger;
  qryPayments.Open;
end;

procedure TfrmReport01.clnLatePawnCalcFields(DataSet: TDataSet);
begin
  clnLatePawncFullName.AsString := GetFullName(clnLatePawnCustFirst.AsString, clnLatePawnCustMid.AsString, clnLatePawnCustLast.AsString);

  clnLatePawncPhones.AsString := CombinePhones(' / ',  [clnLatePawnCustPhCell.AsString,
                                                        clnLatePawnCustPhHome.AsString,
                                                        clnLatePawnCustPhBussiness.AsString]);

end;

procedure TfrmReport01.FormCreate(Sender: TObject);
begin
  lblProgress.Caption := '';
end;

procedure TfrmReport01.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);
end;

// Realigned late-payment logic. Instead of the old SQL proc's "months since last
// PAY_DATE" proxy (which knew nothing about the money and drifted from the app's
// real due-date model), spLatePawn now returns every ACTIVE pawn and we decide
// lateness here through the SAME engine the payment screen uses -- DM.GetInterest-
// AndNextPaymentInfo. A pawn is late when it has past-due interest today
// (InterestOwedToday > 0); "months behind" is that overdue interest expressed in
// whole months of the current monthly charge. Rows that are not at least
// MonthsBehind behind are pruned. Single source of truth: change the payment model
// and this report follows automatically, because it calls the same code.
type
  TPayRow = record
    PayDate: TDateTime;
    PayInterest: Currency;
    PrincBalance: Currency;
  end;

// Bulk-loaded, so the per-pawn loop makes ZERO extra DB round-trips:
//   * the interest rate now rides in spLatePawn (clnLatePawnTranInterest), so the
//     old per-pawn qryTran is gone;
//   * every active pawn's payments are read once into a dictionary keyed by
//     transaction, then each pawn's slice is replayed into one reusable memtable
//     that is handed to the same interest engine.
// This turns ~2*N queries (N = active pawns) into 2 queries total.
procedure TfrmReport01.BuildLateList(MonthsBehind: Integer);
var
  qryBulk: TFDQuery;
  mtOne: TFDMemTable;
  payMap: TDictionary<Integer, TList<TPayRow>>;
  payList: TList<TPayRow>;
  row: TPayRow;
  tranNo, i, iCount: Integer;
  IntBalAsOf, OwedToday, DueAtNext: Currency;
  NextDue: TDateTime;
  Rate, Amount, CurrPrinc, MonthlyInt: Currency;
  PawnDt: TDateTime;
  Behind: Integer;
begin
  payMap  := TDictionary<Integer, TList<TPayRow>>.Create;
  qryBulk := TFDQuery.Create(nil);
  mtOne   := TFDMemTable.Create(nil);
  try
    // Reusable per-pawn payment slice fed to GetInterestAndNextPaymentInfo. Field
    // names match what the engine reads.
    mtOne.FieldDefs.Add('PAY_DATE', ftDate);
    mtOne.FieldDefs.Add('PAY_INTEREST', ftCurrency);
    mtOne.FieldDefs.Add('PRINC_BALANCE', ftCurrency);
    mtOne.CreateDataSet;

    // 1) ONE query: all payments for active pawns, grouped into the dictionary.
    qryBulk.Connection := DM.ConnFB;
    qryBulk.SQL.Text :=
      'select P.TRANSACTION_NO, P.PAY_DATE, P.PAY_INTEREST, P.PRINC_BALANCE ' +
      'from PAYMENTS P ' +
      '  join TRANSACTIONS T on T.TRANSACTION_NO = P.TRANSACTION_NO ' +
      'where T.TRAN_TYPE = ''P'' and T.TRAN_STATUS = ''A'' ' +
      'order by P.TRANSACTION_NO, P.PAY_DATE, P.PAYMENT_NO';
    qryBulk.Open;
    while not qryBulk.Eof do
    begin
      tranNo           := qryBulk.FieldByName('TRANSACTION_NO').AsInteger;
      row.PayDate      := qryBulk.FieldByName('PAY_DATE').AsDateTime;
      row.PayInterest  := qryBulk.FieldByName('PAY_INTEREST').AsCurrency;
      row.PrincBalance := qryBulk.FieldByName('PRINC_BALANCE').AsCurrency;
      if not payMap.TryGetValue(tranNo, payList) then
      begin
        payList := TList<TPayRow>.Create;
        payMap.Add(tranNo, payList);
      end;
      payList.Add(row);
      qryBulk.Next;
    end;
    qryBulk.Close;

    // Don't accumulate a change log for edits/deletes we never apply back.
    clnLatePawn.LogChanges := False;

    // 2) Walk pawns; all inputs come from the CDS row or the dictionary.
    // Suppress clnLatePawnAfterScroll during the build: every First/Next/Delete
    // below would otherwise re-open qryPayments (a per-pawn query, the very cost
    // we are removing). It is restored before render, which is when the payment
    // subreport actually needs it.
    clnLatePawn.AfterScroll := nil;
    try
    iCount := 0;
    clnLatePawn.First;
    while not clnLatePawn.Eof do
    begin
      Inc(iCount);
      if (clnLatePawn.RecNo mod 250) = 0 then
      begin
        lblProgress.Caption := clnLatePawn.RecNo.ToString + ' of ' + clnLatePawn.RecordCount.ToString;
        lblProgress.Update;
      end;

      tranNo := clnLatePawnTransactionNo.AsInteger;
      Rate   := clnLatePawnTranInterest.AsCurrency;
      Amount := clnLatePawnTranPawnAmount.AsCurrency;
      PawnDt := clnLatePawnTranDate.AsDateTime;

      // Replay this pawn's payments (ascending) into the reusable slice.
      mtOne.EmptyDataSet;
      CurrPrinc := Amount;
      if payMap.TryGetValue(tranNo, payList) then
      begin
        for i := 0 to payList.Count - 1 do
        begin
          mtOne.Append;
          mtOne.FieldByName('PAY_DATE').AsDateTime      := payList[i].PayDate;
          mtOne.FieldByName('PAY_INTEREST').AsCurrency  := payList[i].PayInterest;
          mtOne.FieldByName('PRINC_BALANCE').AsCurrency := payList[i].PrincBalance;
          mtOne.Post;
        end;
        // Current principal (after the last payment) drives the per-month charge.
        CurrPrinc := payList[payList.Count - 1].PrincBalance;
      end;
      if CurrPrinc < 0 then
        CurrPrinc := 0;

      DM.GetInterestAndNextPaymentInfo(Date, PawnDt, 0, Amount, Rate, mtOne,
        IntBalAsOf, OwedToday, NextDue, DueAtNext);

      MonthlyInt := CurrPrinc * (Rate / 100.0);

      // Any past-due interest means at least one full period went unpaid, so a
      // late pawn is at least 1 month behind (Ceil, not Round).
      if (OwedToday > 0) and (MonthlyInt > 0) then
        Behind := Ceil(OwedToday / MonthlyInt)
      else
        Behind := 0;

      if (OwedToday > 0) and (Behind >= MonthsBehind) then
      begin
        clnLatePawn.Edit;
        clnLatePawnLatePayment.AsInteger  := Behind;  // repurposed: months behind
        clnLatePawnInterestOwed.AsFloat   := OwedToday;
        clnLatePawnNextDueDate.AsDateTime := NextDue;
        clnLatePawn.Post;
        clnLatePawn.Next;
      end
      else
        clnLatePawn.Delete;  // Delete advances to the next record
    end;
    finally
      clnLatePawn.AfterScroll := clnLatePawnAfterScroll;
    end;

    lblProgress.Caption := iCount.ToString + ' Total Pawns';

    clnLatePawn.First;  // AfterScroll active again: primes the first row's subreport
  finally
    for payList in payMap.Values do
      payList.Free;
    payMap.Free;
    mtOne.Free;
    qryBulk.Free;
  end;
end;

procedure TfrmReport01.PrintReport(Preview: boolean);
var
  LateMonths: integer;
begin
  Screen.Cursor := crHourGlass;
  try
    LateMonths := Trunc(edMonths.Value);
    if LateMonths < 1 then
      LateMonths := 1;

    qryPayments.Close;
    qryPayments.Open;

    // spLatePawn now returns ALL active pawns; BuildLateList prunes to the ones
    // that are genuinely >= LateMonths behind and stamps the months-behind count.
    clnLatePawn.Close;
    clnLatePawn.Open;
    BuildLateList(LateMonths);

  finally
    Screen.Cursor := crDefault;
  end;

  lblRptLatePayTitle.Caption := Format('Pawns with Payments %d Months Late', [LateMonths]);
  RepLatePawn.DeviceType := PrnPreview[Preview];
  RepLatePawn.Print;

end;

end.
