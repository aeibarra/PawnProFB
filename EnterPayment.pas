unit EnterPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  DBCtrls, StdCtrls, Buttons, DateUtils, System.UITypes,
  ADODB, RzButton, RzEdit, RzDBEdit, Vcl.Mask, Vcl.ExtCtrls, Vcl.Menus;

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
////      F := MonthsBetween(DM.qryPaymentsPayDate.AsDateTime, DM.qryTransactionsTRAN_DATE.AsDateTime);//  MonthDiff(DM.qryTransactionsTRAN_DATE.AsDateTime, DM.qryPaymentsPayDate.AsDateTime);
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
////      F2 := MonthSpan(DM.qryPaymentsPayDate.AsDateTime, DM.qryTransactionsTRAN_DATE.AsDateTime); //MonthDiff(DM.qryTransactionsTRAN_DATE.AsDateTime, DM.qryPaymentsPayDate.AsDateTime);
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
//  qryLastPayment.Parameters.ParamByName('TransactionNo').Value := DM.qryTransactionsTRANSACTION_NO.AsInteger;
//  qryLastPayment.Open;
//  DM.LastPaymentForTransaction(DM.qryTransactionsTRANSACTION_NO.AsInteger);

  DM.GetPawnPaymentBalancesAndDueDate(InterestBalanceAsOf, InterestOwedToday, NextPaymentDate, InterestDueAtNext);

  if NewRow then
    begin
      DM.qryPayments.Append;
//      CalcBalances;

      DM.qryPaymentsInsterestBalance.AsCurrency := InterestBalanceAsOf;
      DM.qryPaymentsPrincBalance.AsCurrency := DM.qryTransactionsPRINC_BALANCE.AsCurrency;
{      if qryLastPaymentPaymentNo.AsInteger <= 0 then
        begin
          DM.qryPaymentsInsterestBalance.AsFloat :=
                MonthCount * DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.0;
          DM.qryPaymentsPrincBalance.AsFloat := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat;
        end
      else
        begin
          DM.qryPaymentsInsterestBalance.AsFloat :=
                qryLastPaymentInsterestBalance.AsFloat +
                MonthCount * qryLastPaymentPrincBalance.AsFloat * DM.qryTransactionsTRAN_INTEREST.AsFloat / 100.0;
          DM.qryPaymentsPrincBalance.AsFloat := qryLastPaymentPrincBalance.AsFloat;
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
begin
  if DM.qryPaymentsPayAmount.AsFloat <> (DM.qryPaymentsPayPrincipal.AsFloat + DM.qryPaymentsPayInterest.AsFloat) then
    begin
      MessageDlg('(Amount apply to interest + Amount apply to principal) must be equal to pay amount.', mtInformation, [mbOk], 0);
      exit;
    end;

{  if NewRow then
    begin
      DM.qryPaymentsPrincBalance.AsFloat := DM.qryPaymentsPrincBalance.AsFloat - DM.qryPaymentsPayPrincipal.AsFloat;
      DM.qryPaymentsInsterestBalance.AsFloat := DM.qryPaymentsInsterestBalance.AsFloat - DM.qryPaymentsPayInterest.AsFloat;
    end;}

  DM.ConnDB.BeginTrans;
  try
    DM.qryPayments.Post;

    DM.qryTransactions.Edit;
    DM.qryTransactionsPRINC_BALANCE.AsFloat := DM.qryPaymentsPrincBalance.AsFloat;
    DM.qryTransactionsINTEREST_BALANCE.AsFloat := DM.qryPaymentsInsterestBalance.AsFloat;
    DM.qryTransactions.Post;
  except
    DM.ConnDB.RollbackTrans;
  end;
  DM.ConnDB.CommitTrans;
  
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
  SaveDate := DM.qryPaymentsPayDate.AsDateTime;
end;

procedure TfrmEnterPayment.edDateAfterExit(Sender: TObject);
begin
  if DM.qryPaymentsPayDate.AsDateTime <> SaveDate then
    begin
//      CalcBalances;
      edAmountExit(nil);
    end;
end;

procedure TfrmEnterPayment.btnSplitPaymentClick(Sender: TObject);
begin
  if (DM.qryPaymentsPayAmount.AsFloat - InterestOwedToday) > 0 then
    begin
      DM.qryPaymentsPayInterest.AsFloat := InterestOwedToday;
      DM.qryPaymentsPayPrincipal.AsFloat := DM.qryPaymentsPayAmount.AsFloat - InterestOwedToday;
    end
  else
    begin
      DM.qryPaymentsPayInterest.AsFloat := DM.qryPaymentsPayAmount.AsFloat;
      DM.qryPaymentsPayPrincipal.AsFloat := 0;
    end;
end;

procedure TfrmEnterPayment.edPayPrincExit(Sender: TObject);
begin
  if NewRow then
    begin
      if DM.qryPaymentsInsterestBalance.AsFloat > 0 then
        DM.qryPaymentsPayPrincipal.AsFloat := 0;

      DM.qryPaymentsPrincBalance.AsFloat := DM.qryTransactionsPRINC_BALANCE.AsCurrency - DM.qryPaymentsPayPrincipal.AsFloat;
    end;
end;

procedure TfrmEnterPayment.edPayInterestExit(Sender: TObject);
begin
  if NewRow then
    DM.qryPaymentsInsterestBalance.AsFloat := InterestOwedToday - DM.qryPaymentsPayInterest.AsFloat;
end;

end.
