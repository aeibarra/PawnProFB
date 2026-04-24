InvItemNo, InvItemStatus, TransactionNo, PawnedDate, PurchaseDate, RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate, SoldDate

UPDATE InventoryItems
  SET
    RedeemedDate = :RedeemedDate,
    DefaultedDate = :DefaultedDate,
    MeltedDate = :MeltedDate,
    ForSaleDate = :ForSaleDate
where TransactionNo = :TransactionNo
  and InvItemStatus = 'P' and RedeemedDate is null and DefaultedDate is NULL


UPDATE InventoryItems set DefaultedDate = NULL 
where DefaultedDate is not NULL 


select *
from InventoryItems
where TransactionNo = 1197

SELECT T1.TransactionNo, T1.PayDate, T1.PayInterest, T1.PayPrincipal, 
     T2.TranDate, T2.TranPawnAmount, T2.TranTicketNo, T1.PrincBalance,
     T3.CustFirst, T3.CustMid, T3.CustLast, T3.CustPhCell, T3.CustPhHome, T3.CustPhBussiness,
     T3.CustFlDrvLic, T3.CustIDType, T3.CustID, T3.CustIDAgencyState
FROM Payments T1 
  JOIN Transactions T2 ON T1.TransactionNo = T2.TransactionNo
  JOIN Customer T3 ON T3.Custno = T2.CustNo
WHERE PaymentNo = 31

From Delphi I need to check if this two objects exists in the database. And if not, create them from Delphi code. using Connection execute method.

CREATE FUNCTION "DBA"."fn_TranWithLatePayment"( @TransactionNo integer, @Mons INTEGER = 1 ) 
returns bit
as
begin
  declare @R integer
  declare @PawnDate date,@LastPayDay date,@CmpDate date
  select @PawnDate = TranDate
    from Transactions
    where TransactionNo = @TransactionNo
  select @LastPayDay = max(PayDate)
    from Payments
    where TransactionNo = @TransactionNo
  if @LastPayDay is null
    set @CmpDate = @PawnDate
  else
    set @CmpDate = @LastPayDay
  if abs(datediff(month,getdate(),@CmpDate)) > @Mons
    set @R = 1
  else
    set @R = 0
  return @R
end

CREATE PROCEDURE "DBA"."Rep_CustomerWithLatePayments" (
  @Mons INTEGER = 1
)
as
begin
  create table #PawnTran(
    Custno integer null,
    TransactionNo integer null,
    LatePayment integer null,
    )
  insert into #PawnTran( Custno,TransactionNo,LatePayment ) 
    select T1.Custno,T2.TransactionNo,fn_TranWithLatePayment(T2.TransactionNo)
      from Customer as T1
        join Transactions as T2 on T1.Custno = T2.CustNo
      where T2.TranType = 'P' and T2.TranStatus = 'A'
  select top 1000 T1.TransactionNo,T3.TranTicketNo, cast(T3.TranDate as DateTime) as TranDate,
         LatePayment,
         T2.Custno, T2.CustLast, T2.CustFirst, T2.CustMid, T2.CustPhCell, T2.CustPhHome, T2.CustPhBussiness,
         T3.TranPawnAmount
    from #PawnTran as T1
      join Customer as T2 on T1.Custno = T2.Custno
      join Transactions as T3 on T1.TransactionNo = T3.TransactionNo
    where LatePayment = 1
    order by T2.CustFirst asc,T2.CustLast asc,T2.Custno asc
  drop table #PawnTran
end
