object frmReportExportTransactions: TfrmReportExportTransactions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export Transaction Information'
  ClientHeight = 310
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 17
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 6
    Width = 457
    Height = 194
    TabOrder = 0
    object Label1: TLabel
      Left = 39
      Top = 17
      Width = 30
      Height = 16
      Caption = 'From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 185
      Top = 17
      Width = 15
      Height = 16
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edFrom: TRzDateTimeEdit
      Left = 39
      Top = 36
      Width = 106
      Height = 24
      EditType = etDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edTo: TRzDateTimeEdit
      Left = 185
      Top = 36
      Width = 106
      Height = 24
      EditType = etDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object GroupBox3: TGroupBox
      Left = 26
      Top = 71
      Width = 399
      Height = 111
      TabOrder = 2
      object rbTransactionsOnly: TRadioButton
        Left = 16
        Top = 16
        Width = 220
        Height = 17
        Caption = 'Transactions Only'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object rbTransactionsAndItems: TRadioButton
        Left = 16
        Top = 47
        Width = 234
        Height = 17
        Caption = 'Transactions and Items Descriptions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object rbClientInfoAndItems: TRadioButton
        Left = 16
        Top = 78
        Width = 377
        Height = 17
        Caption = 'Client Information and Transactions and Items Descriptions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 206
    Width = 457
    Height = 67
    TabOrder = 1
    DesignSize = (
      457
      67)
    object btnExit: TBitBtn
      Left = 337
      Top = 7
      Width = 109
      Height = 52
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain
      ModalResult = 8
      TabOrder = 0
      OnClick = btnExitClick
    end
    object btnExport: TRzBitBtn
      Left = 27
      Top = 7
      Width = 159
      Height = 52
      Caption = 'Export to CSV'
      TabOrder = 1
      OnClick = btnExportClick
      ImageIndex = 25
      Images = DM.vilMain
      Spacing = 0
    end
  end
  object qryTransactionsOnly: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select T2.TRAN_TICKET_NO as "TranTicketNo",'
      '       T2.TRAN_DATE as "TranDate",'
      '       (case T2.TRAN_TYPE '
      '           when '#39'P'#39' then '#39'Pawn'#39' '
      '           when '#39'U'#39' then '#39'Purchase'#39' '
      '           else '#39#39
      '        end) as "TransactionDesc",'
      '       T2.TRAN_MATURITY as "TranMaturity",'
      '       T2.TRAN_PAWN_AMOUNT as "TranAmount"'
      'from CUSTOMER T1'
      '  join TRANSACTIONS T2 on T1.CUST_NO = T2.CUST_NO'
      'where T2.TRAN_DATE between :FDate and :TDate'
      'order by T2.TRAN_DATE, T2.TRANSACTION_NO')
    Left = 517
    Top = 27
    ParamData = <
      item
        Name = 'FDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end
      item
        Name = 'TDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end>
    object qryTransactionsOnlyTranTicketNo: TStringField
      Tag = 1
      DisplayLabel = 'Ticket No'
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryTransactionsOnlyTranDate: TDateField
      Tag = 1
      DisplayLabel = 'Date'
      FieldName = 'TranDate'
    end
    object qryTransactionsOnlyTransactionDesc: TWideStringField
      Tag = 1
      DisplayLabel = 'Transaction Type'
      FieldName = 'TransactionDesc'
      Size = 8
    end
    object qryTransactionsOnlyTranMaturity: TDateField
      Tag = 1
      DisplayLabel = 'Maturity'
      FieldName = 'TranMaturity'
    end
    object qryTransactionsOnlyTranAmount: TFloatField
      Tag = 1
      DisplayLabel = 'Amount'
      FieldName = 'TranAmount'
    end
  end
  object qryTransactionsAndItems: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select T2.TRAN_TICKET_NO as "TranTicketNo",'
      '       T2.TRAN_DATE as "TranDate",'
      '       (case T2.TRAN_TYPE'
      '           when '#39'P'#39' then '#39'Pawn'#39
      '           when '#39'U'#39' then '#39'Purchase'#39
      '           else '#39#39
      '        end) as "TransactionDesc",'
      '       T2.TRAN_MATURITY as "TranMaturity",'
      '       T2.TRAN_PAWN_AMOUNT as "TranAmount",'
      '       T3.DESCRIPTION as "Description",'
      '       T3.WEIGHT as "Weight",'
      '       T3.SIZE_LENGTH as "SizeLength",'
      '       T4.J_TYPE_DESC as "JTypeDesc",'
      '       T5.J_STYLE_DESC as "JStyleDesc",'
      '       T6.J_METAL_DESC as "JMetalDesc"'
      'from CUSTOMER T1'
      '  join TRANSACTIONS T2 on T1.CUST_NO = T2.CUST_NO'
      
        '  left outer join INVENTORY_ITEMS T3 on T3.TRANSACTION_NO = T2.T' +
        'RANSACTION_NO'
      '  left outer join J_TYPES T4 on T4.J_TYPE = T3.J_TYPE'
      '  left outer join J_STYLES T5 on T5.J_STYLE = T3.J_STYLE'
      '  left outer join J_METALS T6 on T6.J_METAL = T3.J_METAL'
      'where T2.TRAN_DATE between :FDate and :TDate'
      'order by T2.TRAN_DATE, T2.TRANSACTION_NO')
    Left = 519
    Top = 80
    ParamData = <
      item
        Name = 'FDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end
      item
        Name = 'TDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end>
    object qryTransactionsAndItemsTranTicketNo: TStringField
      Tag = 1
      DisplayLabel = 'Ticket No'
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryTransactionsAndItemsTranDate: TDateField
      Tag = 1
      DisplayLabel = 'Date'
      FieldName = 'TranDate'
    end
    object qryTransactionsAndItemsTransactionDesc: TWideStringField
      Tag = 1
      DisplayLabel = 'Transaction Type'
      FieldName = 'TransactionDesc'
      Size = 8
    end
    object qryTransactionsAndItemsTranMaturity: TDateField
      Tag = 1
      DisplayLabel = 'Maturity'
      FieldName = 'TranMaturity'
    end
    object qryTransactionsAndItemsTranAmount: TFloatField
      Tag = 1
      DisplayLabel = 'Amount'
      FieldName = 'TranAmount'
    end
    object qryTransactionsAndItemsDescription: TStringField
      Tag = 1
      FieldName = 'Description'
      Size = 120
    end
    object qryTransactionsAndItemsWeight: TFloatField
      Tag = 1
      FieldName = 'Weight'
    end
    object qryTransactionsAndItemsSizeLength: TFloatField
      Tag = 1
      DisplayLabel = 'Length'
      FieldName = 'SizeLength'
    end
    object qryTransactionsAndItemsJTypeDesc: TStringField
      Tag = 1
      DisplayLabel = 'J. Type'
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object qryTransactionsAndItemsJStyleDesc: TStringField
      Tag = 1
      DisplayLabel = 'J. Style'
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryTransactionsAndItemsJMetalDesc: TStringField
      Tag = 1
      DisplayLabel = 'J. Metal'
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'CSV File (*.csv)|*.csv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 414
    Top = 14
  end
  object qryClientTranscItems: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select DISTINCT '
      '       T1.CUST_LAST as "CustLast",'
      '       T1.CUST_FIRST as "CustFirst",'
      '       T1.CUST_MID as "CustMid",'
      '       T1.CUST_DOB as "CustDOB",'
      '       T1.CUST_GENDER as "CustGender",'
      '       T1.CUST_RACE as "CustRace",'
      '       T1.CUST_HAIR as "CustHair",'
      '       T1.CUST_EYES as "CustEyes",'
      '       T1.CUST_MARK as "CustMark",'
      '       T1.CUST_WEIGHT as "CustWeight",'
      '       T1.CUST_HEIGHT as "CustHeight",'
      '       T1.CUST_ADDR as "CustAddr",'
      '       T1.CUST_APT as "CustApt",'
      '       T1.CUST_CITY as "CustCity",'
      '       T1.CUST_STATE as "CustState",'
      '       T1.CUST_ZIP as "CustZip",'
      '       T1.CUST_PLACE_EMPLY as "CustPlaceEmply",'
      '       T1.CUST_PH_HOME as "CustPhHome",'
      '       T1.CUST_PH_BUSINESS as "CustPhBussiness",'
      '       T1.CUST_PH_CELL as "CustPhCell",'
      '       T2.TRAN_TICKET_NO as "TranTicketNo",'
      '       T2.TRAN_DATE as "TranDate",'
      '       T2.TRANSACTION_NO as "TransactionNo", '
      '       (case T2.TRAN_TYPE'
      '           when '#39'P'#39' then '#39'Pawn'#39
      '           when '#39'U'#39' then '#39'Purchase'#39
      '           else '#39#39
      '        end) as "TransactionDesc",'
      '       T2.TRAN_MATURITY as "TranMaturity",'
      '       T2.TRAN_PAWN_AMOUNT as "TranAmount",'
      '       T3.DESCRIPTION as "Description",'
      '       T3.WEIGHT as "Weight",'
      '       T3.SIZE_LENGTH as "SizeLength",'
      '       T4.J_TYPE_DESC as "JTypeDesc",'
      '       T5.J_STYLE_DESC as "JStyleDesc",'
      '       T6.J_METAL_DESC as "JMetalDesc"'
      'from CUSTOMER T1'
      '  join TRANSACTIONS T2 on T1.CUST_NO = T2.CUST_NO'
      
        '  left outer join INVENTORY_ITEMS T3 on T3.TRANSACTION_NO = T2.T' +
        'RANSACTION_NO'
      '  left outer join J_TYPES T4 on T4.J_TYPE = T3.J_TYPE'
      '  left outer join J_STYLES T5 on T5.J_STYLE = T3.J_STYLE'
      '  left outer join J_METALS T6 on T6.J_METAL = T3.J_METAL'
      'where T2.TRAN_DATE between :FDate and :TDate'
      'order by "TranDate", "TransactionNo"')
    Left = 520
    Top = 128
    ParamData = <
      item
        Name = 'FDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end
      item
        Name = 'TDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 47484d
      end>
    object qryClientTranscItemsCustLast: TWideStringField
      Tag = 1
      DisplayLabel = 'LastName'
      FieldName = 'CustLast'
      Size = 35
    end
    object qryClientTranscItemsCustFirst: TWideStringField
      Tag = 1
      DisplayLabel = 'FirstName'
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryClientTranscItemsCustMid: TWideStringField
      Tag = 1
      DisplayLabel = 'MiddleName'
      FieldName = 'CustMid'
      Size = 1
    end
    object qryClientTranscItemsCustDOB: TDateField
      Tag = 1
      DisplayLabel = 'ClientDOB'
      FieldName = 'CustDOB'
    end
    object qryClientTranscItemsCustGender: TWideStringField
      Tag = 1
      DisplayLabel = 'Gender'
      FieldName = 'CustGender'
      Size = 1
    end
    object qryClientTranscItemsCustRace: TWideStringField
      Tag = 1
      DisplayLabel = 'Race'
      FieldName = 'CustRace'
      Size = 1
    end
    object qryClientTranscItemsCustHair: TWideStringField
      Tag = 1
      DisplayLabel = 'Hair'
      FieldName = 'CustHair'
      Size = 5
    end
    object qryClientTranscItemsCustEyes: TWideStringField
      Tag = 1
      DisplayLabel = 'Eyes'
      FieldName = 'CustEyes'
      Size = 5
    end
    object qryClientTranscItemsCustMark: TWideStringField
      Tag = 1
      DisplayLabel = 'Mark'
      FieldName = 'CustMark'
      Size = 10
    end
    object qryClientTranscItemsCustWeight: TFloatField
      Tag = 1
      DisplayLabel = 'Weight'
      FieldName = 'CustWeight'
    end
    object qryClientTranscItemsCustHeight: TWideStringField
      Tag = 1
      DisplayLabel = 'Height'
      FieldName = 'CustHeight'
      Size = 8
    end
    object qryClientTranscItemsCustAddr: TWideStringField
      Tag = 1
      DisplayLabel = 'Client Address'
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryClientTranscItemsCustApt: TWideStringField
      Tag = 1
      DisplayLabel = 'Client Apt'
      FieldName = 'CustApt'
      Size = 5
    end
    object qryClientTranscItemsCustCity: TWideStringField
      Tag = 1
      DisplayLabel = 'City'
      FieldName = 'CustCity'
      Size = 40
    end
    object qryClientTranscItemsCustState: TWideStringField
      Tag = 1
      DisplayLabel = 'State'
      FieldName = 'CustState'
      Size = 2
    end
    object qryClientTranscItemsCustZip: TWideStringField
      Tag = 1
      DisplayLabel = 'Zip'
      FieldName = 'CustZip'
      Size = 11
    end
    object qryClientTranscItemsCustPlaceEmply: TWideStringField
      Tag = 1
      DisplayLabel = 'Place of Employment'
      FieldName = 'CustPlaceEmply'
      Size = 30
    end
    object qryClientTranscItemsCustPhHome: TWideStringField
      Tag = 1
      DisplayLabel = 'Client Phone Home'
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryClientTranscItemsCustPhBussiness: TWideStringField
      Tag = 1
      DisplayLabel = 'Client Phone Bussiness'
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryClientTranscItemsCustPhCell: TWideStringField
      Tag = 1
      DisplayLabel = 'Client Phone Cell'
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryClientTranscItemsTransactionNo: TIntegerField
      Tag = 1
      FieldName = 'TransactionNo'
    end
    object qryClientTranscItemsTranTicketNo: TStringField
      Tag = 1
      DisplayLabel = 'Ticket No'
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryClientTranscItemsTranDate: TDateField
      Tag = 1
      DisplayLabel = 'Date'
      FieldName = 'TranDate'
    end
    object qryClientTranscItemsTransactionDesc: TWideStringField
      Tag = 1
      DisplayLabel = 'Transaction Type'
      FieldName = 'TransactionDesc'
      Size = 8
    end
    object qryClientTranscItemsTranMaturity: TDateField
      Tag = 1
      DisplayLabel = 'Maturity'
      FieldName = 'TranMaturity'
    end
    object qryClientTranscItemsTranAmount: TFloatField
      Tag = 1
      DisplayLabel = 'Amount'
      FieldName = 'TranAmount'
    end
    object qryClientTranscItemsDescription: TStringField
      Tag = 1
      FieldName = 'Description'
      Size = 120
    end
    object qryClientTranscItemsWeight: TFloatField
      Tag = 1
      FieldName = 'Weight'
    end
    object qryClientTranscItemsSizeLength: TFloatField
      Tag = 1
      DisplayLabel = 'Length'
      FieldName = 'SizeLength'
    end
    object qryClientTranscItemsJTypeDesc: TStringField
      Tag = 1
      DisplayLabel = 'J. Type'
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object qryClientTranscItemsJStyleDesc: TStringField
      Tag = 1
      DisplayLabel = 'J. Style'
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryClientTranscItemsJMetalDesc: TStringField
      Tag = 1
      DisplayLabel = 'J. Metal'
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
end
