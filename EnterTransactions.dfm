object frmEnterTransaction: TfrmEnterTransaction
  Left = 744
  Top = 59
  BorderStyle = bsDialog
  Caption = 'Pawn information'
  ClientHeight = 650
  ClientWidth = 954
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 20
  object gbBottom: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 541
    Width = 745
    Height = 63
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 346
      Top = 12
      Width = 106
      Height = 39
      Cancel = True
      Caption = ' &Cancel'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
        7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
        1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
        A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
        00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
        4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
        A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
        3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
        FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
        90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
        21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
        4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
        9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
        B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
        76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
        AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
        CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
        00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
        BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
        C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TRzBitBtn
      Left = 212
      Top = 12
      Width = 106
      Height = 39
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = 0
    end
  end
  object gbTop: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 0
    Width = 745
    Height = 535
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 70
      Height = 20
      Caption = 'Pawn Date'
    end
    object Label2: TLabel
      Left = 139
      Top = 20
      Width = 63
      Height = 20
      Caption = 'Ticket No'
    end
    object Label3: TLabel
      Left = 19
      Top = 139
      Width = 65
      Height = 20
      Caption = 'Comment'
    end
    object Label4: TLabel
      Left = 344
      Top = 20
      Width = 91
      Height = 20
      Caption = 'Maturity Date'
    end
    object Label5: TLabel
      Left = 16
      Top = 73
      Width = 91
      Height = 20
      Caption = 'Pawn Amount'
    end
    object Label6: TLabel
      Left = 230
      Top = 20
      Width = 65
      Height = 20
      Caption = 'Interest %'
    end
    object Label7: TLabel
      Left = 228
      Top = 73
      Width = 91
      Height = 20
      Caption = 'Princ. Balance'
    end
    object Label8: TLabel
      Left = 344
      Top = 73
      Width = 111
      Height = 20
      Caption = 'Insterest Balance'
    end
    object btnGetPawnAddingAllItemCost: TRzToolButton
      Left = 137
      Top = 86
      Width = 51
      Height = 48
      Hint = 'Calculate Pawn Amount adding all items cost.'
      Flat = False
      ImageIndex = 20
      Images = DM.vilMain
      ParentShowHint = False
      ShowHint = True
      OnClick = btnGetPawnAddingAllItemCostClick
    end
    object lblItemsWithNoCost: TRzLabel
      Left = 138
      Top = 128
      Width = 112
      Height = 15
      Caption = 'lblItemsWithNoCost'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblUnderAge: TLabel
      Left = 128
      Top = 4
      Width = 186
      Height = 14
      Caption = 'Warning!!! Client is under Age'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edMemoComment: TDBMemo
      Left = 15
      Top = 163
      Width = 443
      Height = 75
      DataField = 'TranComment'
      DataSource = DM.DSTransactions
      ScrollBars = ssVertical
      TabOrder = 7
    end
    object edTicketNo: TDBEdit
      Left = 139
      Top = 42
      Width = 79
      Height = 28
      DataField = 'TranTicketNo'
      DataSource = DM.DSTransactions
      TabOrder = 1
    end
    object edPawnAmount: TDBEdit
      Left = 15
      Top = 95
      Width = 106
      Height = 28
      DataField = 'TranPawnAmount'
      DataSource = DM.DSTransactions
      TabOrder = 2
      OnExit = edPawnAmountExit
    end
    object edPrincBalance: TDBEdit
      Left = 228
      Top = 95
      Width = 94
      Height = 28
      DataField = 'PrincBalance'
      DataSource = DM.DSTransactions
      TabOrder = 6
    end
    object edInterest: TDBEdit
      Left = 228
      Top = 42
      Width = 60
      Height = 28
      DataField = 'TranInterest'
      DataSource = DM.DSTransactions
      TabOrder = 3
      OnChange = edInterestChange
      OnExit = edInterestExit
    end
    object DBEdit1: TDBEdit
      Left = 344
      Top = 95
      Width = 114
      Height = 28
      DataField = 'InsterestBalance'
      DataSource = DM.DSTransactions
      TabOrder = 8
    end
    object pnSelectItemsToCopy: TPanel
      Left = 2
      Top = 244
      Width = 741
      Height = 289
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 9
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 245
        Width = 735
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnCheckAll: TButton
          Left = 11
          Top = 2
          Width = 86
          Height = 32
          Caption = 'Check all'
          TabOrder = 0
          OnClick = btnCheckAllClick
        end
        object btnClearAll: TButton
          Left = 113
          Top = 2
          Width = 86
          Height = 32
          Caption = 'Clear all'
          TabOrder = 1
          OnClick = btnClearAllClick
        end
        object chkShowOnlyInTran: TCheckBox
          Left = 246
          Top = 9
          Width = 364
          Height = 17
          Caption = 'Show items only for the transaction you were before'
          TabOrder = 2
          OnClick = chkShowOnlyInTranClick
        end
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 735
        Height = 35
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label9: TLabel
          Left = 14
          Top = 16
          Width = 39
          Height = 20
          Caption = 'Items:'
        end
        object SpeedButton2: TSpeedButton
          Left = 480
          Top = 4
          Width = 130
          Height = 28
          Caption = 'View a large grid'
          OnClick = SpeedButton2Click
        end
      end
      object dbGridItems: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 44
        Width = 735
        Height = 195
        Align = alClient
        DataSource = dsInvItems
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = dbGridItemsCellClick
        OnDrawColumnCell = dbGridItemsDrawColumnCell
        OnTitleClick = dbGridItemsTitleClick
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = 'X'
            Width = 28
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'InvCategory'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Title.Caption = 'Category type'
            Width = 146
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Description'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Width = 178
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Weight'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SizeLength'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Title.Caption = 'Length'
            Width = 59
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JStyleDesc'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Title.Caption = 'Style'
            Width = 54
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JTypeDesc'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Title.Caption = 'Type'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JMetalDesc'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Title.Caption = 'Metal'
            Width = 100
            Visible = True
          end>
      end
    end
    object edPawnTranDate: TRzDBDateTimeEdit
      Left = 17
      Top = 41
      Width = 106
      Height = 28
      DataSource = DM.DSTransactions
      DataField = 'TranDate'
      TabOrder = 0
      EditType = etDate
    end
    object edMaturityDate: TRzDBDateTimeEdit
      Left = 344
      Top = 42
      Width = 116
      Height = 28
      DataSource = DM.DSTransactions
      DataField = 'TranMaturity'
      TabOrder = 5
      EditType = etDate
    end
    object RzMenuButton1: TRzMenuButton
      Left = 294
      Top = 41
      Width = 37
      Height = 28
      Caption = '...'
      TabOrder = 4
      DropDownMenu = PopupMenu1
    end
  end
  object qryNextTicket: TADODataSet
    Connection = DM.ConnDB
    CommandText = 'select  *'#13#10'from TableKeys'#13#10'where TableName = '#39'PawnTicketNo'#39
    Parameters = <>
    Left = 850
    Top = 77
    object qryNextTicketTableName: TStringField
      FieldName = 'TableName'
      Size = 15
    end
    object qryNextTicketLastKey: TIntegerField
      FieldName = 'LastKey'
    end
  end
  object qryInvItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'CustNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT DISTINCT  T2.*, T3.InvCategory, JStyleDesc, JTypeDesc, JM' +
        'etalDesc'
      'FROM Transactions T1 '
      '  JOIN InventoryItems T2 ON T1.TransactionNo = T2.TransactionNo'
      
        '  left outer join InvCategories as T3 on T3.InvCatNo = T2.InvCat' +
        'No'
      '  left outer join JStyles as T4 on T4.JStyle = T2.JStyle'
      '  left outer join JTypes as T5 on T5.JType = T2.JType'
      '  left outer join JMetals as T6 on T6.JMetal = T2.JMetal'
      'WHERE CustNo = :CustNo and TranStatus = '#39'A'#39' and TranType = '#39'P'#39
      
        '   and T2.TransactionNo = IsNull(:TransactionNo, T2.TransactionN' +
        'o)'
      
        'ORDER BY T2.Description, T2.Weight, T2.SizeLength, T4.JStyleDesc' +
        ','
      '         T5.JTypeDesc, T6.JMetalDesc, T2.InvItemNo DESC'
      '')
    Left = 765
    Top = 288
    object qryInvItemsInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryInvItemsInvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryInvItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object qryInvItemsJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryInvItemsJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryInvItemsJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryInvItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryInvItemsNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryInvItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryInvItemsWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryInvItemsKT: TFloatField
      FieldName = 'KT'
    end
    object qryInvItemsCreated: TDateTimeField
      FieldName = 'Created'
    end
    object qryInvItemsUnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object qryInvItemsUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object qryInvItemsInvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryInvItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryInvItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object qryInvItemsInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryInvItemsOwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryInvItemsModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryInvItemsSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryInvItemsGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryInvItemsDescription: TStringField
      FieldName = 'Description'
      Size = 40
    end
    object qryInvItemsInvCategory: TStringField
      FieldName = 'InvCategory'
      Size = 40
    end
    object qryInvItemsJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryInvItemsJTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object qryInvItemsJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object dsInvItems: TDataSource
    DataSet = clnItemsToSelect
    Left = 855
    Top = 428
  end
  object qryTypes: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JType,  JTypeDesc'
      'FROM JTypes')
    Left = 741
    Top = 3
    object qryTypesJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryTypesJTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
  end
  object qryStyles: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JStyle, JStyleDesc'
      'FROM JStyles')
    Left = 855
    Top = 268
    object qryStylesJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryStylesJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
  end
  object qryMetal: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JMetal, JMetalDesc'
      'FROM JMetals')
    Left = 855
    Top = 316
    object qryMetalJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryMetalJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object qryCategories: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM InvCategories'
      'ORDER BY InvCategory')
    Left = 741
    Top = 51
    object qryCategoriesInvCatNo: TAutoIncField
      FieldName = 'InvCatNo'
      ReadOnly = True
    end
    object qryCategoriesInvCategory: TStringField
      FieldName = 'InvCategory'
      Size = 40
    end
  end
  object qryInsItems: TADOQuery
    Connection = DM.ConnDB
    Parameters = <
      item
        Name = 'InvItemNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'InvItemBarcode'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'InvCatNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'JType'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'JStyle'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'JMetal'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'InvItemCount'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'Note'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'SizeLength'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'Weight'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'KT'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'InvItemStatus'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'InvItemBrand'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'SerialNumber'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'OwnerAppNumber'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'ModelNumber'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'Description'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'Gender'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO InventoryItems (InvItemNo, TransactionNo, InvItemBar' +
        'code, InvCatNo, JType, JStyle, JMetal, InvItemCount, '
      
        '                            Note, SizeLength, Weight, KT, InvIte' +
        'mStatus, InvItemBrand, SerialNumber,'
      
        '                            OwnerAppNumber, ModelNumber, Descrip' +
        'tion, Gender)'
      
        '                     Values(:InvItemNo, :TransactionNo, :InvItem' +
        'Barcode, :InvCatNo, :JType, :JStyle, :JMetal, :InvItemCount,'
      
        '                            :Note, :SizeLength, :Weight, :KT, :I' +
        'nvItemStatus, :InvItemBrand, :SerialNumber,'
      
        '                            :OwnerAppNumber, :ModelNumber, :Desc' +
        'ription, :Gender)')
    Left = 822
    Top = 182
  end
  object qryInvItems__: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryInvItems__CalcFields
    Parameters = <
      item
        Name = 'CustNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 255
        Size = 10
        Value = 416
      end>
    SQL.Strings = (
      'exec sps_CustItemsToCopy :CustNo'
      ''
      '/*'
      'select distinct T2.*'
      'from Transactions T1, InventoryItems T2'
      'where T1.CustNo = CustNo and T1.TransactionNo = T2.TransactionNo'
      'SELECT *'
      'FROM InventoryItems '
      'WHERE TransactionNo = TransactionNo'
      '*/')
    Left = 741
    Top = 111
    object qryInvItems__InvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryInvItems__InvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryInvItems__InvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object qryInvItems__JType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryInvItems__JStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryInvItems__JMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryInvItems__InvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryInvItems__Note: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryInvItems__SizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryInvItems__Weight: TFloatField
      FieldName = 'Weight'
    end
    object qryInvItems__KT: TFloatField
      FieldName = 'KT'
    end
    object qryInvItems__Created: TDateTimeField
      FieldName = 'Created'
    end
    object qryInvItems__UnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object qryInvItems__UnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object qryInvItems__InvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryInvItems__TransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryInvItems__InvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object qryInvItems__InvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryInvItems__OwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryInvItems__ModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryInvItems__SerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryInvItems__Gender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryInvItems__Description: TStringField
      FieldName = 'Description'
      Size = 40
    end
    object qryInvItems__InvCategory: TStringField
      FieldName = 'InvCategory'
      Size = 40
    end
    object qryInvItems__JStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryInvItems__JTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object qryInvItems__JMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 124
    object First1: TMenuItem
      Caption = 'Calculate interest base on Principal and interest balance'
      OnClick = First1Click
    end
    object Second1: TMenuItem
      Caption = 'Recalc interest balance on new interest'
      OnClick = Second1Click
    end
  end
  object PropertyStore: TRzPropertyStore
    Properties = <
      item
        Component = chkShowOnlyInTran
        PropertyName = 'Checked'
      end>
    RegIniFile = DM.RegIniFile
    Left = 891
    Top = 13
  end
  object clnItemsToSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 855
    Top = 376
    object clnItemsToSelectInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object clnItemsToSelectInvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object clnItemsToSelectInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object clnItemsToSelectInvCategory: TStringField
      FieldName = 'InvCategory'
      Size = 40
    end
    object clnItemsToSelectJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object clnItemsToSelectJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object clnItemsToSelectJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object clnItemsToSelectInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object clnItemsToSelectSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object clnItemsToSelectNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object clnItemsToSelectWeight: TFloatField
      FieldName = 'Weight'
    end
    object clnItemsToSelectKT: TFloatField
      FieldName = 'KT'
    end
    object clnItemsToSelectCreated: TDateTimeField
      FieldName = 'Created'
    end
    object clnItemsToSelectUnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object clnItemsToSelectUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object clnItemsToSelectInvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object clnItemsToSelectTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object clnItemsToSelectInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object clnItemsToSelectInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object clnItemsToSelectSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object clnItemsToSelectOwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object clnItemsToSelectModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object clnItemsToSelectGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object clnItemsToSelectDescription: TStringField
      FieldName = 'Description'
      Size = 40
    end
    object clnItemsToSelectJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object clnItemsToSelectJTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object clnItemsToSelectJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
end
