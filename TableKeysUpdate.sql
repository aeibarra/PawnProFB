  if not exists(select * from TableKeys where TableName = 'Customer')
    begin
      insert into TableKeys (TableName, LastKey) values('Customer', 1)
    end

  update TableKeys set LastKey = (select IsNull((max(CustNo) + 1), 1) from Customer) where TableName = 'Customer';
  update TableKeys set LastKey = (select IsNull((max(InvItemNo) + 1), 1) from InventoryItems) where TableName = 'InventoryItems';
  update TableKeys set LastKey = (select IsNull((max(PaymentNo) + 1), 1) from PAYMENTS) where TableName = 'Payments';
  update TableKeys set LastKey = (select IsNull((max(TransactionNo) + 1), 1) from Transactions) where TableName = 'Transactions';

  select * from TableKeys
