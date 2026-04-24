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
  object qryTransactionsOnly: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'FDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 42005d
      end
      item
        Name = 'TDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 42005d
      end>
    SQL.Strings = (
      'select T2.TranTicketNo, T2.TranDate,'
      '       (case T2.TranType '
      '           when '#39'P'#39' then '#39'Pawn'#39' '
      '           when '#39'U'#39' then '#39'Purchase'#39' '
      '           else '#39#39
      '        end) as TransactionDesc,'
      '       T2.TranMaturity,'
      '       T2.TranPawnAmount as TranAmount'
      'from Customer T1'
      '  join Transactions T2 on T1.Custno = T2.CustNo'
      'where T2.TranDate BETWEEN :FDate and :TDate'
      'order by T2.TranDate, TransactionNo')
    Left = 517
    Top = 27
    object qryTransactionsOnlyTranTicketNo: TStringField
      Tag = 1
      DisplayLabel = 'Ticket No'
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryTransactionsOnlyTranDate: TDateTimeField
      Tag = 1
      DisplayLabel = 'Date'
      FieldName = 'TranDate'
    end
    object qryTransactionsOnlyTransactionDesc: TStringField
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
  object qryTransactionsAndItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'FDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 42005d
      end
      item
        Name = 'TDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 42005d
      end>
    SQL.Strings = (
      'select T2.TranTicketNo, T2.TranDate,'
      '       (case T2.TranType'
      '           when '#39'P'#39' then '#39'Pawn'#39
      '           when '#39'U'#39' then '#39'Purchase'#39
      '           else '#39#39
      '        end) as TransactionDesc,'
      '       T2.TranMaturity,'
      '       T2.TranPawnAmount as TranAmount,'
      
        '       T3.Description, T3.Weight, T3.SizeLength,T4.JTypeDesc, T5' +
        '.JStyleDesc, T6.JMetalDesc'
      'from Customer T1'
      '  join Transactions T2 on T1.Custno = T2.CustNo'
      
        '  left outer join InventoryItems T3 on T3.TransactionNo = T2.Tra' +
        'nsactionNo'
      '  left outer join JTypes T4 on T4.JType = T3.JType'
      '  left outer join JStyles T5 on T5.JStyle = T3.JStyle'
      '  left outer join JMetals T6 on T6.JMetal = T3.JMetal'
      'where T2.TranDate BETWEEN :FDate and :TDate'
      'order by T2.TranDate, T2.TransactionNo')
    Left = 519
    Top = 80
    object qryTransactionsAndItemsTranTicketNo: TStringField
      Tag = 1
      DisplayLabel = 'Ticket No'
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryTransactionsAndItemsTranDate: TDateTimeField
      Tag = 1
      DisplayLabel = 'Date'
      FieldName = 'TranDate'
    end
    object qryTransactionsAndItemsTransactionDesc: TStringField
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
  object qryClientTranscItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'FDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 42005d
      end
      item
        Name = 'TDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 47484d
      end>
    SQL.Strings = (
      'select DISTINCT '
      
        '       CustLast, CustFirst, CustMid, CustDOB, CustGender, CustRa' +
        'ce, CustHair, CustEyes, CustMark, CustWeight, CustHeight, CustAd' +
        'dr, '
      
        '       CustApt, CustCity, CustState, CustZip, CustPlaceEmply, Cu' +
        'stPhHome, CustPhBussiness, CustPhCell,'
      '       T2.TranTicketNo, T2.TranDate, T2.TransactionNo, '
      '       (case T2.TranType'
      '           when '#39'P'#39' then '#39'Pawn'#39
      '           when '#39'U'#39' then '#39'Purchase'#39
      '           else '#39#39
      '        end) as TransactionDesc,'
      '       T2.TranMaturity,'
      '       T2.TranPawnAmount as TranAmount,'
      
        '       T3.Description, T3.Weight, T3.SizeLength,T4.JTypeDesc, T5' +
        '.JStyleDesc, T6.JMetalDesc'
      'from Customer T1'
      '  join Transactions T2 on T1.Custno = T2.CustNo'
      
        '  left outer join InventoryItems T3 on T3.TransactionNo = T2.Tra' +
        'nsactionNo'
      '  left outer join JTypes T4 on T4.JType = T3.JType'
      '  left outer join JStyles T5 on T5.JStyle = T3.JStyle'
      '  left outer join JMetals T6 on T6.JMetal = T3.JMetal'
      'where T2.TranDate BETWEEN :FDate and :TDate'
      'order by T2.TranDate, T2.TransactionNo')
    Left = 520
    Top = 128
    object qryClientTranscItemsCustLast: TStringField
      Tag = 1
      DisplayLabel = 'LastName'
      FieldName = 'CustLast'
      Size = 35
    end
    object qryClientTranscItemsCustFirst: TStringField
      Tag = 1
      DisplayLabel = 'FirstName'
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryClientTranscItemsCustMid: TStringField
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
    object qryClientTranscItemsCustGender: TStringField
      Tag = 1
      DisplayLabel = 'Gender'
      FieldName = 'CustGender'
      Size = 1
    end
    object qryClientTranscItemsCustRace: TStringField
      Tag = 1
      DisplayLabel = 'Race'
      FieldName = 'CustRace'
      Size = 1
    end
    object qryClientTranscItemsCustHair: TStringField
      Tag = 1
      DisplayLabel = 'Hair'
      FieldName = 'CustHair'
      Size = 5
    end
    object qryClientTranscItemsCustEyes: TStringField
      Tag = 1
      DisplayLabel = 'Eyes'
      FieldName = 'CustEyes'
      Size = 5
    end
    object qryClientTranscItemsCustMark: TStringField
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
    object qryClientTranscItemsCustHeight: TStringField
      Tag = 1
      DisplayLabel = 'Height'
      FieldName = 'CustHeight'
      Size = 8
    end
    object qryClientTranscItemsCustAddr: TStringField
      Tag = 1
      DisplayLabel = 'Client Address'
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryClientTranscItemsCustApt: TStringField
      Tag = 1
      DisplayLabel = 'Client Apt'
      FieldName = 'CustApt'
      Size = 5
    end
    object qryClientTranscItemsCustCity: TStringField
      Tag = 1
      DisplayLabel = 'City'
      FieldName = 'CustCity'
      Size = 40
    end
    object qryClientTranscItemsCustState: TStringField
      Tag = 1
      DisplayLabel = 'State'
      FieldName = 'CustState'
      Size = 2
    end
    object qryClientTranscItemsCustZip: TStringField
      Tag = 1
      DisplayLabel = 'Zip'
      FieldName = 'CustZip'
      Size = 11
    end
    object qryClientTranscItemsCustPlaceEmply: TStringField
      Tag = 1
      DisplayLabel = 'Place of Employment'
      FieldName = 'CustPlaceEmply'
      Size = 30
    end
    object qryClientTranscItemsCustPhHome: TStringField
      Tag = 1
      DisplayLabel = 'Client Phone Home'
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryClientTranscItemsCustPhBussiness: TStringField
      Tag = 1
      DisplayLabel = 'Client Phone Bussiness'
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryClientTranscItemsCustPhCell: TStringField
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
    object qryClientTranscItemsTranDate: TDateTimeField
      Tag = 1
      DisplayLabel = 'Date'
      FieldName = 'TranDate'
    end
    object qryClientTranscItemsTransactionDesc: TStringField
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
