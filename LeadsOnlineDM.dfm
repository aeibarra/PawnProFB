object DM_LeadsOnline: TDM_LeadsOnline
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 389
  Width = 528
  object qryGetDataToExp: TFDQuery
    Connection = DM.ConnFB
    OnCalcFields = qryGetDataToExpCalcFields
    SQL.Strings = (
      'SELECT --<LIMIT_ROWS>'
      
        '    CAST(ROW_NUMBER() OVER (ORDER BY T1.TRANSACTION_NO) AS INTE' +
        'GER) AS "RowNo",'
      '    T3.INV_ITEM_NO AS "InvItemNo",'
      
        '    CAST(case T1.TRAN_TYPE when '#39'P'#39' then 2 when '#39'U'#39' then 1 end ' +
        'AS SMALLINT) as "ticket_type",'
      '    T1.TRAN_TICKET_NO AS "TranTicketNo",'
      '    T1.TRANSACTION_NO AS "TransactionNo",'
      '    T1.TRAN_DATE AS "TranDate",'
      '    CAST('#39'OPERATOR'#39' as varchar(50)) as "ClerkName",'
      '    Cast('#39'N'#39' as char(1)) as "TranVoided",'
      '    T2.CUST_LAST AS "CustLast",'
      '    T2.CUST_FIRST AS "CustFirst",'
      '    T2.CUST_MID AS "CustMid",'
      '    T2.CUST_ADDR AS "CustAddr",'
      '    T2.CUST_CITY AS "CustCity",'
      '    T2.CUST_STATE AS "CustState",'
      '    T2.CUST_ZIP AS "CustZip",'
      '    T2.CUST_PH_HOME AS "CustPhHome",'
      '    T2.CUST_PH_BUSINESS AS "CustPhBussiness",'
      '    T2.CUST_PH_BEEP AS "CustPhBeep",'
      '    T2.CUST_PH_CELL AS "CustPhCell",'
      '    T2.CUST_FL_DRV_LIC AS "CustFlDrvLic",'
      '    T2.CUST_ID AS "CustID",'
      '    T2.CUST_ID_TYPE AS "CustIDType",'
      '    T2.CUST_ID_AGENCY_STATE AS "CustIDAgencyState",'
      '    T2.CUST_DOB AS "CustDOB",'
      '    T2.CUST_WEIGHT AS "CustWeight",'
      '    T2.CUST_HEIGHT AS "CustHeight",'
      '    T2.CUST_EYES AS "CustEyes",'
      '    T2.CUST_HAIR AS "CustHair",'
      '    T2.CUST_RACE AS "CustRace",'
      '    T2.CUST_GENDER AS "CustGender",'
      '    T3.INV_ITEM_COUNT AS "InvItemCount",'
      '    T2.CUST_PLACE_EMPLY AS "CustPlaceEmply",'
      '    T3.INV_ITEM_BRAND AS "InvItemBrand",'
      '    T3.MODEL_NUMBER AS "ModelNumber",'
      '    T3.SERIAL_NUMBER AS "SerialNumber",'
      '    T3.DESCRIPTION AS "Description",'
      '    T3.NOTE AS "Note",'
      '    T3.UNIT_COST AS "UnitCost",'
      '    T4.J_STYLE_DESC AS "JStyleDesc",'
      '    T5.J_METAL_DESC AS "JMetalDesc",'
      '    T3.KT AS "KT",'
      '    T3.WEIGHT AS "Weight",'
      '    T3.SIZE_LENGTH AS "SizeLength",'
      '    T3.GENDER AS "Gender"'
      'FROM TRANSACTIONS T1'
      '  join CUSTOMER T2 ON T1.CUST_NO = T2.CUST_NO'
      '  join INVENTORY_ITEMS T3 ON T3.TRANSACTION_NO = T1.TRANSACTION_NO'
      '  left outer join J_STYLES T4 ON T4.J_STYLE = T3.J_STYLE'
      '  left outer join J_METALS T5 ON T5.J_METAL = T3.J_METAL'
      'WHERE T1.TRAN_TYPE in ('#39'P'#39', '#39'U'#39') --<FILTER>'
      'ORDER BY T1.TRANSACTION_NO, T1.TRAN_TYPE, T3.INV_ITEM_NO'
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
    object qryGetDataToExpTranTicketNo: TWideStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryGetDataToExpTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryGetDataToExpInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryGetDataToExpTranDate: TDateField
      FieldName = 'TranDate'
    end
    object qryGetDataToExpClerkName: TWideStringField
      FieldName = 'ClerkName'
      Size = 50
    end
    object qryGetDataToExpTranVoided: TWideStringField
      FieldName = 'TranVoided'
      Size = 1
    end
    object qryGetDataToExpCustLast: TWideStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryGetDataToExpCustFirst: TWideStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryGetDataToExpCustMid: TWideStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryGetDataToExpCustAddr: TWideStringField
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryGetDataToExpCustCity: TWideStringField
      FieldName = 'CustCity'
      Size = 40
    end
    object qryGetDataToExpCustState: TWideStringField
      FieldName = 'CustState'
      Size = 2
    end
    object qryGetDataToExpCustZip: TWideStringField
      FieldName = 'CustZip'
      Size = 11
    end
    object qryGetDataToExpCustPhHome: TWideStringField
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryGetDataToExpCustPhBussiness: TWideStringField
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryGetDataToExpCustPhBeep: TWideStringField
      FieldName = 'CustPhBeep'
      Size = 14
    end
    object qryGetDataToExpCustPhCell: TWideStringField
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryGetDataToExpCustFlDrvLic: TWideStringField
      FieldName = 'CustFlDrvLic'
    end
    object qryGetDataToExpCustID: TWideStringField
      FieldName = 'CustID'
      Size = 25
    end
    object qryGetDataToExpCustIDType: TWideStringField
      FieldName = 'CustIDType'
    end
    object qryGetDataToExpCustIDAgencyState: TWideStringField
      FieldName = 'CustIDAgencyState'
      Size = 10
    end
    object qryGetDataToExpCustDOB: TDateField
      FieldName = 'CustDOB'
    end
    object qryGetDataToExpCustWeight: TFloatField
      FieldName = 'CustWeight'
    end
    object qryGetDataToExpCustHeight: TWideStringField
      FieldName = 'CustHeight'
      Size = 8
    end
    object qryGetDataToExpCustEyes: TWideStringField
      FieldName = 'CustEyes'
      Size = 5
    end
    object qryGetDataToExpCustHair: TWideStringField
      FieldName = 'CustHair'
      Size = 5
    end
    object qryGetDataToExpCustRace: TWideStringField
      FieldName = 'CustRace'
      Size = 1
    end
    object qryGetDataToExpCustGender: TWideStringField
      FieldName = 'CustGender'
      Size = 1
    end
    object qryGetDataToExpCustPlaceEmply: TWideStringField
      FieldName = 'CustPlaceEmply'
      Size = 30
    end
    object qryGetDataToExpInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryGetDataToExpInvItemBrand: TWideStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryGetDataToExpModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryGetDataToExpSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryGetDataToExpDescription: TWideStringField
      FieldName = 'Description'
      Size = 120
    end
    object qryGetDataToExpNote: TWideStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryGetDataToExpUnitCost: TFMTBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object qryGetDataToExpJStyleDesc: TWideStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryGetDataToExpJMetalDesc: TWideStringField
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
    object qryGetDataToExpGender: TWideStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryGetDataToExpAmountRedeemDefaultDate: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'AmountRedeemDefaultDate'
      Calculated = True
    end
    object qryGetDataToExpClientPhone: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'ClientPhone'
      Calculated = True
    end
    object qryGetDataToExpClientIdType: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'ClientIdType'
      Size = 25
      Calculated = True
    end
    object qryGetDataToExpClientIdState: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'ClientIdState'
      Size = 2
      Calculated = True
    end
    object qryGetDataToExpClientIdNumber: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'ClientIdNumber'
      Size = 50
      Calculated = True
    end
    object qryGetDataToExpStoneType1: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'StoneType1'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpJStoneDesc1: TWideStringField
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
    object qryGetDataToExpJShapeDesc1: TWideStringField
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
    object qryGetDataToExpStoneType2: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'StoneType2'
      Size = 30
      Calculated = True
    end
    object qryGetDataToExpJStoneDesc2: TWideStringField
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
    object qryGetDataToExpJShapeDesc2: TWideStringField
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
    object clnExpData_ClerkName: TWideStringField
      FieldName = 'ClerkName'
      Size = 50
    end
    object clnExpData_TranDate: TWideStringField
      FieldName = 'TranDate'
    end
    object clnExpData_TranVoided: TWideStringField
      FieldName = 'TranVoided'
      Size = 1
    end
    object clnExpData_CustLast: TWideStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object clnExpData_CustFirst: TWideStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object clnExpData_CustMid: TWideStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object clnExpData_CustAddr: TWideStringField
      FieldName = 'CustAddr'
      Size = 55
    end
    object clnExpData_CustCity: TWideStringField
      FieldName = 'CustCity'
      Size = 40
    end
    object clnExpData_CustState: TWideStringField
      FieldName = 'CustState'
      Size = 2
    end
    object clnExpData_CustZip: TWideStringField
      FieldName = 'CustZip'
      Size = 11
    end
    object clnExpData_CustDOB: TWideStringField
      FieldName = 'CustDOB'
    end
    object clnExpData_CustWeight: TFloatField
      FieldName = 'CustWeight'
    end
    object clnExpData_CustHeight: TWideStringField
      FieldName = 'CustHeight'
      Size = 8
    end
    object clnExpData_CustEyes: TWideStringField
      FieldName = 'CustEyes'
      Size = 5
    end
    object clnExpData_CustHair: TWideStringField
      FieldName = 'CustHair'
      Size = 5
    end
    object clnExpData_CustRace: TWideStringField
      FieldName = 'CustRace'
      Size = 1
    end
    object clnExpData_CustGender: TWideStringField
      FieldName = 'CustGender'
      Size = 1
    end
    object clnExpData_InvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object clnExpData_InvItemBrand: TWideStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object clnExpData_ModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object clnExpData_SerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object clnExpData_Description: TWideStringField
      FieldName = 'Description'
      Size = 120
    end
    object clnExpData_Note: TWideStringField
      FieldName = 'Note'
      Size = 80
    end
    object clnExpData_UnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object clnExpData_JStyleDesc: TWideStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object clnExpData_JMetalDesc: TWideStringField
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
    object clnExpData_Gender: TWideStringField
      FieldName = 'Gender'
      Size = 1
    end
  end
  object qryExportFileFormat: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select'
      '  ID as "ID",'
      '  DATA_FIELD_NAME as "DataFieldName",'
      '  DATA_FIELD_TYPE as "DataFieldType",'
      '  DATA_FIELD_MAX_SIZE as "DataFieldMaxSize",'
      '  DATA_FIELD_CAPTION as "DataFieldCaption",'
      '  DATA_FIELD_DESC as "DataFieldDesc"'
      'from EXPORT_FORMAT'
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
    object clnExportFileFormatDataFieldName: TWideStringField
      FieldName = 'DataFieldName'
      Size = 50
    end
    object clnExportFileFormatDataFieldType: TSmallintField
      FieldName = 'DataFieldType'
    end
    object clnExportFileFormatDataFieldMaxSize: TIntegerField
      FieldName = 'DataFieldMaxSize'
    end
    object clnExportFileFormatDataFieldCaption: TWideStringField
      FieldName = 'DataFieldCaption'
      Size = 50
    end
    object clnExportFileFormatDataFieldDesc: TWideStringField
      FieldName = 'DataFieldDesc'
      Size = 200
    end
  end
  object qryItemStones: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      
        'SELECT CAST(ROW_NUMBER() OVER (ORDER BY T1.INV_ITEM_NO, T1.STON' +
        'E_NO) AS INTEGER) as "No",'
      '  T1.INV_ITEM_NO as "InvItemNo",'
      '  T1.STONE_NO as "StoneNo",'
      '  T1.STONE_TYPE as "StoneType",'
      '  T2.J_STONE_DESC as "JStoneDesc",'
      '  T1.STONE_NUMBER as "StoneNumber",'
      '  T3.J_SHAPE_DESC as "JShapeDesc",'
      '  T1.CT as "CT"'
      'FROM STONES T1'
      '  join J_STONE_COLORS T2 on T1.STONE_COLOR = T2.J_STONE_COLOR'
      '  join J_STONE_SHAPES T3 on T1.STONE_SHAPE = T3.J_SHAPE'
      'where T1.INV_ITEM_NO = :InvItemNo'
      'order by T1.INV_ITEM_NO, T1.STONE_NO'
      '')
    Left = 253
    Top = 29
    ParamData = <
      item
        Name = 'INVITEMNO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryItemStonesNo: TIntegerField
      FieldName = 'No'
    end
    object qryItemStonesInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryItemStonesStoneNo: TIntegerField
      FieldName = 'StoneNo'
    end
    object qryItemStonesStoneType: TWideStringField
      FieldName = 'StoneType'
      Size = 30
    end
    object qryItemStonesJStoneDesc: TWideStringField
      FieldName = 'JStoneDesc'
      Size = 30
    end
    object qryItemStonesStoneNumber: TIntegerField
      FieldName = 'StoneNumber'
    end
    object qryItemStonesJShapeDesc: TWideStringField
      FieldName = 'JShapeDesc'
      Size = 30
    end
    object qryItemStonesCT: TFloatField
      FieldName = 'CT'
    end
  end
  object spCreateExpLog: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select EXPORT_LOG_ID as "ExportLogID"'
      'from SP_CREATE_EXPORT_LOG(:FileName)')
    Left = 253
    Top = 109
    ParamData = <
      item
        Name = 'FILENAME'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end>
  end
  object qryInsExpLogLine: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      
        'insert into EXPORT_LOG_FILE_DETAIL(EXPORT_LOG_ID, TRANSACTION_NO' +
        ', EXPORT_LINE, INV_ITEM_NO, ITEM_SEQ)'
      
        'values(:ExportLogID, :TransactionNo, :ExportLine, :InvItemNo, :I' +
        'temSeq)')
    Left = 252
    Top = 157
    ParamData = <
      item
        Name = 'EXPORTLOGID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TRANSACTIONNO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'EXPORTLINE'
        DataType = ftMemo
        ParamType = ptInput
      end
      item
        Name = 'INVITEMNO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITEMSEQ'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryUpdItemCount: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'update EXPORT_FILE_LOG set ITEM_COUNT = :ItemCount'
      'where EXPORT_LOG_ID = :ExportLogID'
      '')
    Left = 252
    Top = 213
    ParamData = <
      item
        Name = 'ITEMCOUNT'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'EXPORTLOGID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryRegenExportFile: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select'
      '  ID as "ID",'
      '  EXPORT_LOG_ID as "ExportLogID",'
      '  TRANSACTION_NO as "TransactionNo",'
      '  EXPORT_LINE as "ExportLine"'
      'from EXPORT_LOG_FILE_DETAIL'
      'where EXPORT_LOG_ID = :ExportLogID'
      '')
    Left = 401
    Top = 103
    ParamData = <
      item
        Name = 'EXPORTLOGID'
        DataType = ftInteger
        ParamType = ptInput
      end>
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
  object qryExpImgMarkAsSent: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      
        'update IMAGES_DATA set UPLOAD_TIME = CURRENT_TIMESTAMP, UPLOAD_F' +
        'ILE_NAME = :UploadFileName'
      'where IMAGES_DATA_NO = :ImagesDataNo'
      '')
    Left = 115
    Top = 292
    ParamData = <
      item
        Name = 'UPLOADFILENAME'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'IMAGESDATANO'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
