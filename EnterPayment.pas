unit EnterPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  DBCtrls, StdCtrls, Buttons, DateUtils, System.UITypes,
  RzButton, RzEdit, RzDBEdit, Vcl.Mask, Vcl.ExtCtrls, Vcl.Menus;

type
  TfrmEnterPayment = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TRzBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    MemoComment: TDBMemo;
    edInsterestBalance: TDBEdit;
    edPayPrinc: TDBEdit;
    edPrincBalance: TDBEdit;
    edPayInterest: TDBEdit;
    edAmount: TDBEdit;
    btnSplitPayment: TButton;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edAmountExit(Sender: TObject);
    procedure edDateAfterEnter(Sender: TObject);
    procedure edDateAfterExit(Sender: TObject);
    procedure btnSplitPaymentClick(Sender: TObject);
    procedure edPayPrincExit(Sender: TObject);
    procedure edPayInterestExit(Sender: TObject);
    procedure mnuEnablePrincClick(Sender: TObject);
  private
    InterestBalanceAsOf: Currency;
    InterestOwedToday: Currency;
    NextPaymentDate: TDatetime;
    InterestDueAtNext: Currency;
  public
    { Public declarations }
    NewRow: boolean;
//    LastPricipalBalance, LastInterestBalance: Double;
    SaveDate: TDateTime;
//    function CalcMonth(First:boolean): Integer;
//    procedure CalcBalances;
  end;

var
  frmEnterPayment: TfrmEnterPayment;

implementation

uses PawnDM, SearchClient;

{$R *.DFM}

{function MonthDiff(D1, D2: TDateTime): Double;
var
  ND, DayDelta: TDateTime;
  M: integer;
begin

  if D1 > D2 then
    begin
      ND := D1;
      D1 := D2;
      D2 := ND;
    end;

  ReplaceTime(D1, 0);
  ReplaceTime(D2, 0);
  ND := StartOfAMonth(YearOf(D1), MonthOf(D1));
  DayDelta := D1 - ND;
  D1 := D1 - DayDelta;
  D2 := D2 - DayDelta;
  M := MonthOf(D2) - MonthOf(D1);
  Result := M + DayOf(D2) / MonthDays[IsLeapYear(YearOf(D2)), MonthOf(D2)];
end;   }

//function TfrmEnterPayment.CalcMonth(First:boolean): Integer;
////var
////  F, F1, F2: Double;
//begin
////  if First then
////    begin
////      F := MonthsBetween(DM.qryPaymentsPAY_DATE.AsDateTime, DM.qryTransactionsTRAN_DATE.AsDateTime);//  MonthDiff(DM.qryTransactionsTRAN_DATE.AsDateTime, DM.qryPaymentsPAY_DATE.AsDateTime);
////      Result := trunc(F);
////      if (Frac(F) > 0) then
////        inc(Result);
////
////      if Result <= 0 then //If first month there is a minimum one month
////        Result := 1;
////    end
////  else
////    begin
////      F1 := MonthSpan(qryLastPaymentPayDate.AsDateTime, DM.qryTransactionsTRAN_DATE.AsDateTime);//MonthDiff(DM.qryTransactionsTRAN_DATE.AsDateTime, qryLastPaymentPayDate.AsDateTime);
////      F2 := MonthSpan(DM.qryPaymentsPAY_DATE.AsDateTime, DM.qryTransactionsTRAN_DATE.AsDateTime); //MonthDiff(DM.qryTransactionsTRAN_DATE.AsDateTime, DM.qryPaymentsPAY_DATE.AsDateTime);
////      Result := Abs(trunc(F2) - trunc(F1));
////    end;
//end;
//
//procedure TfrmEnterPayment.CalcBalances;
////var
////  MonthCount: integer;
//begin
////  MonthCount := CalcMonth(qryLastPaymentPaymentNo.AsInteger <= 0);
////  if qryLastPaymentPaymentNo.AsInteger <= 0 then
////    begin
////      LastPricipalBalance := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat;
////      LastInterestBalance := MonthCount * DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.0;
////    end
////  else
////    begin
////      LastPricipalBalance := qryLastPaymentPrincBalance.AsFloat;
////      LastInterestBalance := qryLastPaymentInsterestBalance.AsFloat + (MonthCount * qryLastPaymentPrincBalance.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat) / 100.0;
////    end;
////
//end;

procedure TfrmEnterPayment.FormShow(Sender: TObject);
begin
//  qryLastPayment.Close;
//  qryLastPayment.Open;
//  DM.LastPaymentForTransaction(DM.qryTransactionsTRANSACTION_NO.AsInteger);

  DM.GetPawnPaymentBalancesAndDueDate(InterestBalanceAsOf, InterestOwedToday, NextPaymentDate, InterestDueAtNext);

  if NewRow then
    begin
      DM.qryPayments.Append;
//      CalcBalances;

      DM.qryPaymentsINTEREST_BALANCE.AsCurrency := InterestBalanceAsOf;
      DM.qryPaymentsPRINC_BALANCE.AsCurrency := DM.qryTransactionsPRINC_BALANCE.AsCurrency;
{      if qryLastPaymentPaymentNo.AsInteger <= 0 then
        begin
          DM.qryPaymentsINTEREST_BALANCE.AsFloat :=
                MonthCount * DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.0;
          DM.qryPaymentsPRINC_BALANCE.AsFloat := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat;
        end
      else
        begin
          DM.qryPaymentsINTEREST_BALANCE.AsFloat :=
                qryLastPaymentInsterestBalance.AsFloat +
                MonthCount * qryLastPaymentPrincBalance.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.0;
          DM.qryPaymentsPRINC_BALANCE.AsFloat := qryLastPaymentPrincBalance.AsFloat;
        end;}
    end
  else
    begin
      DM.qryPayments.Edit;
      //CalcBalances;
    end;
    
  edAmount.SetFocus;
end;

procedure TfrmEnterPayment.mnuEnablePrincClick(Sender: TObject);
begin
  edPrincBalance.ReadOnly := false;
  edPrincBalance.Color := clWindow;
  edPrincBalance.PopupMenu := nil;
end;

procedure TfrmEnterPayment.btnCancelClick(Sender: TObject);
begin
  DM.qryPayments.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmEnterPayment.btnSaveClick(Sender: TObject);
var
  StartedFBTrans: Boolean;
begin
  if DM.qryPaymentsPAY_AMOUNT.AsFloat <> (DM.qryPaymentsPAY_PRINCIPAL.AsFloat + DM.qryPaymentsPAY_INTEREST.AsFloat) then
    begin
      MessageDlg('(Amount apply to interest + Amount apply to principal) must be equal to pay amount.', mtInformation, [mbOk], 0);
      exit;
    end;

{  if NewRow then
    begin
      DM.qryPaymentsPRINC_BALANCE.AsFloat := DM.qryPaymentsPRINC_BALANCE.AsFloat - DM.qryPaymentsPAY_PRINCIPAL.AsFloat;
      DM.qryPaymentsINTEREST_BALANCE.AsFloat := DM.qryPaymentsINTEREST_BALANCE.AsFloat - DM.qryPaymentsPAY_INTEREST.AsFloat;
    end;}

  StartedFBTrans := False;
  if not DM.ConnFB.InTransaction then
  begin
    DM.ConnFB.StartTransaction;
    StartedFBTrans := True;
  end;

  try
    DM.qryPayments.Post;

    DM.qryTransactions.Edit;
    DM.qryTransactionsPRINC_BALANCE.AsFloat := DM.qryPaymentsPRINC_BALANCE.AsFloat;
    DM.qryTransactionsINTEREST_BALANCE.AsFloat := DM.qryPaymentsINTEREST_BALANCE.AsFloat;
    DM.qryTransactions.Post;

    if StartedFBTrans and DM.ConnFB.InTransaction then
      DM.ConnFB.Commit;
  except
    if StartedFBTrans and DM.ConnFB.InTransaction then
      DM.ConnFB.Rollback;
    raise;
  end;
  
  ModalResult := mrOK;
end;

procedure TfrmEnterPayment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DM.qryPayments.State in [dsEdit, dsInsert] then
    DM.qryPayments.Cancel;
end;

procedure TfrmEnterPayment.edAmountExit(Sender: TObject);
begin
  if NewRow then
    begin
      btnSplitPaymentClick(nil);

      edPayInterestExit(nil);
      edPayPrincExit(nil);
    end;
end;

procedure TfrmEnterPayment.edDateAfterEnter(Sender: TObject);
begin
  SaveDate := DM.qryPaymentsPAY_DATE.AsDateTime;
end;

procedure TfrmEnterPayment.edDateAfterExit(Sender: TObject);
begin
  if DM.qryPaymentsPAY_DATE.AsDateTime <> SaveDate then
    begin
//      CalcBalances;
      edAmountExit(nil);
    end;
end;

procedure TfrmEnterPayment.btnSplitPaymentClick(Sender: TObject);
begin
  if (DM.qryPaymentsPAY_AMOUNT.AsFloat - InterestOwedToday) > 0 then
    begin
      DM.qryPaymentsPAY_INTEREST.AsFloat := InterestOwedToday;
      DM.qryPaymentsPAY_PRINCIPAL.AsFloat := DM.qryPaymentsPAY_AMOUNT.AsFloat - InterestOwedToday;
    end
  else
    begin
      DM.qryPaymentsPAY_INTEREST.AsFloat := DM.qryPaymentsPAY_AMOUNT.AsFloat;
      DM.qryPaymentsPAY_PRINCIPAL.AsFloat := 0;
    end;
end;

procedure TfrmEnterPayment.edPayPrincExit(Sender: TObject);
begin
  if NewRow then
    begin
      if DM.qryPaymentsINTEREST_BALANCE.AsFloat > 0 then
        DM.qryPaymentsPAY_PRINCIPAL.AsFloat := 0;

      DM.qryPaymentsPRINC_BALANCE.AsFloat := DM.qryTransactionsPRINC_BALANCE.AsCurrency - DM.qryPaymentsPAY_PRINCIPAL.AsFloat;
    end;
end;

procedure TfrmEnterPayment.edPayInterestExit(Sender: TObject);
begin
  if NewRow then
    DM.qryPaymentsINTEREST_BALANCE.AsFloat := InterestOwedToday - DM.qryPaymentsPAY_INTEREST.AsFloat;
end;

end.
