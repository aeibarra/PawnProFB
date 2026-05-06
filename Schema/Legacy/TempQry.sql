select t.CustNo, c.CustLast, c.CustFirst, c.CustMid, c.CustAddr, c.CustApt, c.CustCity, c.CustState, c.CustZip, 
       COALESCE(c.CustPhCell, c.CustPhHome, c.CustPhBussiness, c.CustPhBeep) as CustPhoneNumber,
       i.Description as ItemDescription, Weight, WeightUnit
from Customer c
  JOIN Transactions t ON c.Custno = t.Custno
--  JOIN Payments p on p.TransactionNo = t.TransactionNo
  JOIN InventoryItems i on i.TransactionNo = t.TransactionNo
where t.TransactionNo = 19222
