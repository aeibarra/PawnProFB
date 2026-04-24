object DM_LeadsOnline: TDM_LeadsOnline
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 389
  Width = 528
  object qryGetDataToExp: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryGetDataToExpCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT --<LIMIT_ROWS>'
      
        '    ROW_NUMBER( ) OVER ( ORDER BY T1.TransactionNo ) AS RowNo, T' +
        '3.InvItemNo,'
      
        '    (case TranType when '#39'P'#39' then 2 when '#39'U'#39' then 1 end) as ticke' +
        't_type, TranTicketNo,'
      
        '    T1.TransactionNo, TranDate, CAST('#39'OPERATOR'#39' as varchar(50)) ' +
        'as ClerkName,'
      '    Cast('#39'N'#39' as char(1)) as TranVoided,'
      
        '    CustLast, CustFirst, CustMid, CustAddr, CustCity, CustState,' +
        ' CustZip,'
      '    CustPhHome, CustPhBussiness, CustPhBeep, CustPhCell,'
      '    CustFlDrvLic, CustID, CustIDType, CustIDAgencyState,'
      '    CustDOB, CustWeight, CustHeight, CustEyes,'
      
        '    CustHair, CustRace, CustGender, InvItemCount, CustPlaceEmply' +
        ','
      '    InvItemBrand, ModelNumber, SerialNumber,'
      
        '    Description, Note, UnitCost, T4.JStyleDesc, T5.JMetalDesc, K' +
        'T, Weight, SizeLength, Gender'
      'FROM Transactions T1'
      '  join Customer T2 ON T1.CustNo = T2.Custno'
      '  join InventoryItems T3 ON T3.TransactionNo = T1.TransactionNo'
      '  left outer join JStyles T4 ON T4.JStyle = T3.JStyle'
      '  left outer join JMetals T5 ON T5.JMetal = T3.JMetal'
      'WHERE T1.TranType in ('#39'P'#39', '#39'U'#39') --<FILTER>'
      'ORDER BY T1.TransactionNo, T1.TranType, T3.InvItemNo'
      ''
      '')
    Left = 112
    Top = 32
    object qryGetDataToExpRowNo: TIntegerField
      FieldName = 'RowNo'
    end
    object qryGetDataToExpticket_type: TSmallintField
      FieldName = 'ticket_type'
    end
    object qryGetDataToExpTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryGetDataToExpTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryGetDataToExpInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryGetDataToExpTranDate: TDateTimeField
      FieldName = 'TranDate'
    end
    object qryGetDataToExpClerkName: TStringField
      FieldName = 'ClerkName'
      Size = 50
    end
    object qryGetDataToExpTranVoided: TStringField
      FieldName = 'TranVoided'
      Size = 1
    end
    object qryGetDataToExpCustLast: TStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryGetDataToExpCustFirst: TStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryGetDataToExpCustMid: TStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryGetDataToExpCustAddr: TStringField
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryGetDataToExpCustCity: TStringField
      FieldName = 'CustCity'
      Size = 40
    end
    object qryGetDataToExpCustState: TStringField
      FieldName = 'CustState'
      Size = 2
    end
    object qryGetDataToExpCustZip: TStringField
      FieldName = 'CustZip'
      Size = 11
    end
    object qryGetDataToExpCustPhHome: TStringField
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryGetDataToExpCustPhBussiness: TStringField
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryGetDataToExpCustPhBeep: TStringField
      FieldName = 'CustPhBeep'
      Size = 14
    end
    object qryGetDataToExpCustPhCell: TStringField
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryGetDataToExpCustFlDrvLic: TStringField
      FieldName = 'CustFlDrvLic'
    end
    object qryGetDataToExpCustID: TStringField
      FieldName = 'CustID'
      Size = 25
    end
    object qryGetDataToExpCustIDType: TStringField
      FieldName = 'CustIDType'
    end
    object qryGetDataToExpCustIDAgencyState: TStringField
      FieldName = 'CustIDAgencyState'
      Size = 10
    end
    object qryGetDataToExpCustDOB: TDateField
      FieldName = 'CustDOB'
    end
    object qryGetDataToExpCustWeight: TFloatField
      FieldName = 'CustWeight'
    end
    object qryGetDataToExpCustHeight: TStringField
      FieldName = 'CustHeight'
      Size = 8
    end
    object qryGetDataToExpCustEyes: TStringField
      FieldName = 'CustEyes'
      Size = 5
    end
    object qryGetDataToExpCustHair: TStringField
      FieldName = 'CustHair'
      Size = 5
    end
    object qryGetDataToExpCustRace: TStringField
      FieldName = 'CustRace'
      Size = 1
    end
    object qryGetDataToExpCustGender: TStringField
      FieldName = 'CustGender'
      Size = 1
    end
    object qryGetDataToExpCustPlaceEmply: TStringField
      FieldName = 'CustPlaceEmply'
      Size = 30
    end
    object qryGetDataToExpInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryGetDataToExpInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryGetDataToExpModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryGetDataToExpSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryGetDataToExpDescription: TStringField
      FieldName = 'Description'
      Size = 120
    end
    object qryGetDataToExpNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryGetDataToExpUnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object qryGetDataToExpJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryGetDataToExpJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
    object qryGetDataToExpKT: TFloatField
      FieldName = 'KT'
    end
    object qryGetDataToExpWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryGetDataToExpSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryGetDataToExpGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryGetDataToExpAmountRedeemDefaultDate: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'AmountRedeemDefaultDate'
      Calculated = True
    end
    object qryGetDataToExpClientPhone: TStringField
      FieldKind = fkCalculated
      FieldName = 'ClientPhone'
      Calculated = True
    end
    object qryGetDataToExpClientIdType: TStringField
      FieldKind = fkCalculated
      FieldName = 'ClientIdType'
      Size = 25
      Calculated = True
    end
    object qryGetDataToExpClientIdState: TStringField
      FieldKind = fkCalculated
      FieldName = 'ClientIdState'
      Size = 2
      Calculated = True
    end
    object qryGetDataToExpClientIdNumber: TStringField
      FieldKind = fkCalculated
      FieldName = 'ClientIdNumber'
      Size = 50
      Calculated = True
    end
    object qryGetDataToExpStoneType1: TStringField
      FieldKind = fkCalculated
      FieldName = 'StoneType1'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpJStoneDesc1: TStringField
      FieldKind = fkCalculated
      FieldName = 'JStoneDesc1'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpStoneNumber1: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'StoneNumber1'
      Calculated = True
    end
    object qryGetDataToExpJShapeDesc1: TStringField
      FieldKind = fkCalculated
      FieldName = 'JShapeDesc1'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpCT1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CT1'
      DisplayFormat = '##0.00'
      Calculated = True
    end
    object qryGetDataToExpStoneType2: TStringField
      FieldKind = fkCalculated
      FieldName = 'StoneType2'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpJStoneDesc2: TStringField
      FieldKind = fkCalculated
      FieldName = 'JStoneDesc2'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpStoneNumber2: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'StoneNumber2'
      Calculated = True
    end
    object qryGetDataToExpJShapeDesc2: TStringField
      FieldKind = fkCalculated
      FieldName = 'JShapeDesc2'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpCT2: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CT2'
      DisplayFormat = '##0.00'
      Calculated = True
    end
  end
  object clnExpData_: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 420
    Top = 27
    object clnExpData_ticket_type: TSmallintField
      FieldName = 'ticket_type'
    end
    object clnExpData_TransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object clnExpData_ClerkName: TStringField
      FieldName = 'ClerkName'
      Size = 50
    end
    object clnExpData_TranDate: TStringField
      FieldName = 'TranDate'
    end
    object clnExpData_TranVoided: TStringField
      FieldName = 'TranVoided'
      Size = 1
    end
    object clnExpData_CustLast: TStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object clnExpData_CustFirst: TStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object clnExpData_CustMid: TStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object clnExpData_CustAddr: TStringField
      FieldName = 'CustAddr'
      Size = 55
    end
    object clnExpData_CustCity: TStringField
      FieldName = 'CustCity'
      Size = 40
    end
    object clnExpData_CustState: TStringField
      FieldName = 'CustState'
      Size = 2
    end
    object clnExpData_CustZip: TStringField
      FieldName = 'CustZip'
      Size = 11
    end
    object clnExpData_CustDOB: TStringField
      FieldName = 'CustDOB'
    end
    object clnExpData_CustWeight: TFloatField
      FieldName = 'CustWeight'
    end
    object clnExpData_CustHeight: TStringField
      FieldName = 'CustHeight'
      Size = 8
    end
    object clnExpData_CustEyes: TStringField
      FieldName = 'CustEyes'
      Size = 5
    end
    object clnExpData_CustHair: TStringField
      FieldName = 'CustHair'
      Size = 5
    end
    object clnExpData_CustRace: TStringField
      FieldName = 'CustRace'
      Size = 1
    end
    object clnExpData_CustGender: TStringField
      FieldName = 'CustGender'
      Size = 1
    end
    object clnExpData_InvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object clnExpData_InvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object clnExpData_ModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object clnExpData_SerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object clnExpData_Description: TStringField
      FieldName = 'Description'
      Size = 120
    end
    object clnExpData_Note: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object clnExpData_UnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object clnExpData_JStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object clnExpData_JMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
    object clnExpData_KT: TFloatField
      FieldName = 'KT'
    end
    object clnExpData_Weight: TFloatField
      FieldName = 'Weight'
    end
    object clnExpData_SizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object clnExpData_Gender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
  end
  object qryExportFileFormat: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from ExportFormat'
      'order by ID')
    Left = 112
    Top = 116
  end
  object prvExportFileFormat: TDataSetProvider
    DataSet = qryExportFileFormat
    Left = 113
    Top = 165
  end
  object clnExportFileFormat: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prvExportFileFormat'
    Left = 112
    Top = 216
    object clnExportFileFormatID: TIntegerField
      FieldName = 'ID'
    end
    object clnExportFileFormatDataFieldName: TStringField
      FieldName = 'DataFieldName'
      Size = 50
    end
    object clnExportFileFormatDataFieldType: TSmallintField
      FieldName = 'DataFieldType'
    end
    object clnExportFileFormatDataFieldMaxSize: TIntegerField
      FieldName = 'DataFieldMaxSize'
    end
    object clnExportFileFormatDataFieldCaption: TStringField
      FieldName = 'DataFieldCaption'
      Size = 50
    end
    object clnExportFileFormatDataFieldDesc: TStringField
      FieldName = 'DataFieldDesc'
      Size = 200
    end
  end
  object qryItemStones: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'InvItemNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = 1
      end>
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER (ORDER BY InvItemNo, StoneNo) as No,'
      '  InvItemNo, StoneNo,'
      
        '  T1.StoneType, T2.JStoneDesc, T1.StoneNumber, T3.JShapeDesc, T1' +
        '.CT'
      'FROM Stones T1'
      '  join JStoneColors T2 on T1.StoneColor = T2.JStoneColor'
      '  join JStoneShapes T3 on T1.StoneShape = T3.JShape'
      'where InvItemNo = :InvItemNo'
      'order by InvItemNo, StoneNo'
      '')
    Left = 253
    Top = 29
    object qryItemStonesNo: TIntegerField
      FieldName = 'No'
    end
    object qryItemStonesInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryItemStonesStoneNo: TIntegerField
      FieldName = 'StoneNo'
    end
    object qryItemStonesStoneType: TStringField
      FieldName = 'StoneType'
      Size = 30
    end
    object qryItemStonesJStoneDesc: TStringField
      FieldName = 'JStoneDesc'
      Size = 30
    end
    object qryItemStonesStoneNumber: TIntegerField
      FieldName = 'StoneNumber'
    end
    object qryItemStonesJShapeDesc: TStringField
      FieldName = 'JShapeDesc'
      Size = 30
    end
    object qryItemStonesCT: TFloatField
      FieldName = 'CT'
    end
  end
  object spCreateExpLog: TADOStoredProc
    Connection = DM.ConnDB
    ProcedureName = 'CreateExportLog'
    Parameters = <
      item
        Name = '@FileName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@ExportLogID'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Value = Null
      end>
    Left = 253
    Top = 109
  end
  object qryInsExpLogLine: TADOQuery
    Connection = DM.ConnDB
    Parameters = <
      item
        Name = 'ExportLogID'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'ExportLine'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'InvItemNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'ItemSeq'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'insert into ExportLogFileDetail(ExportLogID, TransactionNo, Expo' +
        'rtLine, InvItemNo, ItemSeq)'
      
        'values(:ExportLogID, :TransactionNo, :ExportLine, :InvItemNo, :I' +
        'temSeq)')
    Left = 252
    Top = 157
  end
  object qryUpdItemCount: TADOQuery
    Connection = DM.ConnDB
    Parameters = <
      item
        Name = 'ItemCount'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'ExportLogID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'update ExportFileLog set ItemCount = :ItemCount'
      'where ExportLogID = :ExportLogID'
      '')
    Left = 252
    Top = 213
  end
  object qryRegenExportFile: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ExportLogID'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      'from ExportLogFileDetail'
      'where ExportLogID = :ExportLogID'
      '')
    Left = 401
    Top = 103
    object qryRegenExportFileID: TIntegerField
      FieldName = 'ID'
    end
    object qryRegenExportFileExportLogID: TIntegerField
      FieldName = 'ExportLogID'
    end
    object qryRegenExportFileTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryRegenExportFileExportLine: TMemoField
      FieldName = 'ExportLine'
      BlobType = ftMemo
    end
  end
  object qryExpImgMarkAsSent: TADOQuery
    Connection = DM.ConnDB
    Parameters = <
      item
        Name = 'UploadFileName'
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = 'ImagesDataNo'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'update ImagesData set UploadTime = GETDATE(), UploadFileName = :' +
        'UploadFileName'
      'where ImagesDataNo = :ImagesDataNo'
      '')
    Left = 115
    Top = 292
  end
end
