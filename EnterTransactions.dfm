object frmEnterTransaction: TfrmEnterTransaction
  Left = 744
  Top = 59
  BorderStyle = bsDialog
  Caption = 'Pawn information'
  ClientHeight = 650
  ClientWidth = 1189
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
      DataField = 'TRAN_COMMENT'
      DataSource = DM.DSTransactions
      ScrollBars = ssVertical
      TabOrder = 7
    end
    object edTicketNo: TDBEdit
      Left = 139
      Top = 42
      Width = 79
      Height = 28
      DataField = 'TRAN_TICKET_NO'
      DataSource = DM.DSTransactions
      TabOrder = 1
    end
    object edPawnAmount: TDBEdit
      Left = 15
      Top = 95
      Width = 106
      Height = 28
      DataField = 'TRAN_PAWN_AMOUNT'
      DataSource = DM.DSTransactions
      TabOrder = 2
      OnExit = edPawnAmountExit
    end
    object edPrincBalance: TDBEdit
      Left = 228
      Top = 95
      Width = 94
      Height = 28
      DataField = 'PRINC_BALANCE'
      DataSource = DM.DSTransactions
      TabOrder = 6
    end
    object edInterest: TDBEdit
      Left = 228
      Top = 42
      Width = 60
      Height = 28
      DataField = 'TRAN_INTEREST'
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
      DataField = 'INTEREST_BALANCE'
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
        DesignSize = (
          735
          35)
        object Label9: TLabel
          Left = 14
          Top = 16
          Width = 39
          Height = 20
          Caption = 'Items:'
        end
        object btnViewInLargeGrid: TRzToolButton
          Left = 569
          Top = 7
          Width = 159
          Flat = False
          ShowCaption = True
          UseToolbarShowCaption = False
          Anchors = [akTop, akRight, akBottom]
          Caption = 'View in Large Grid'
          OnClick = btnViewInLargeGridClick
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
            FieldName = 'INV_CATEGORY'
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
            FieldName = 'DESCRIPTION'
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
            FieldName = 'WEIGHT'
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
            FieldName = 'SIZE_LENGTH'
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
            FieldName = 'J_STYLE_DESC'
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
            FieldName = 'J_TYPE_DESC'
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
            FieldName = 'J_METAL_DESC'
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
      DataField = 'TRAN_DATE'
      TabOrder = 0
      EditType = etDate
    end
    object edMaturityDate: TRzDBDateTimeEdit
      Left = 344
      Top = 42
      Width = 116
      Height = 28
      DataSource = DM.DSTransactions
      DataField = 'TRAN_MATURITY'
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
  object dsInvItems: TDataSource
    DataSet = clnItemsToSelect
    Left = 549
    Top = 446
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
    Left = 586
    Top = 103
  end
  object clnItemsToSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 550
    Top = 390
    object clnItemsToSelectInvItemNo: TIntegerField
      FieldName = 'INV_ITEM_NO'
    end
    object clnItemsToSelectInvItemBarcode: TStringField
      FieldName = 'INV_ITEM_BARCODE'
      Size = 30
    end
    object clnItemsToSelectInvCatNo: TIntegerField
      FieldName = 'INV_CAT_NO'
    end
    object clnItemsToSelectInvCategory: TStringField
      FieldName = 'INV_CATEGORY'
      Size = 40
    end
    object clnItemsToSelectJType: TStringField
      FieldName = 'J_TYPE'
      Size = 1
    end
    object clnItemsToSelectJStyle: TStringField
      FieldName = 'J_STYLE'
      Size = 1
    end
    object clnItemsToSelectJMetal: TStringField
      FieldName = 'J_METAL'
      Size = 1
    end
    object clnItemsToSelectInvItemCount: TIntegerField
      FieldName = 'INV_ITEM_COUNT'
    end
    object clnItemsToSelectSizeLength: TFloatField
      FieldName = 'SIZE_LENGTH'
    end
    object clnItemsToSelectNote: TStringField
      FieldName = 'NOTE'
      Size = 80
    end
    object clnItemsToSelectWeight: TFloatField
      FieldName = 'WEIGHT'
    end
    object clnItemsToSelectKT: TFloatField
      FieldName = 'KT'
    end
    object clnItemsToSelectCreated: TDateTimeField
      FieldName = 'CREATED'
    end
    object clnItemsToSelectUnitCost: TBCDField
      FieldName = 'UNIT_COST'
      Precision = 19
    end
    object clnItemsToSelectUnitPrice: TBCDField
      FieldName = 'UNIT_PRICE'
      Precision = 19
    end
    object clnItemsToSelectInvItemStatus: TStringField
      FieldName = 'INV_ITEM_STATUS'
      Size = 1
    end
    object clnItemsToSelectTransactionNo: TIntegerField
      FieldName = 'TRANSACTION_NO'
    end
    object clnItemsToSelectInvOriginalItemNo: TIntegerField
      FieldName = 'INV_ORIGINAL_ITEM_NO'
    end
    object clnItemsToSelectInvItemBrand: TStringField
      FieldName = 'INV_ITEM_BRAND'
      Size = 30
    end
    object clnItemsToSelectSerialNumber: TStringField
      FieldName = 'SERIAL_NUMBER'
      Size = 40
    end
    object clnItemsToSelectOwnerAppNumber: TStringField
      FieldName = 'OWNER_APP_NUMBER'
      Size = 40
    end
    object clnItemsToSelectModelNumber: TStringField
      FieldName = 'MODEL_NUMBER'
      Size = 40
    end
    object clnItemsToSelectGender: TStringField
      FieldName = 'GENDER'
      Size = 1
    end
    object clnItemsToSelectDescription: TStringField
      FieldName = 'DESCRIPTION'
      Size = 40
    end
    object clnItemsToSelectJStyleDesc: TStringField
      FieldName = 'J_STYLE_DESC'
      Size = 30
    end
    object clnItemsToSelectJTypeDesc: TStringField
      FieldName = 'J_TYPE_DESC'
      Size = 30
    end
    object clnItemsToSelectJMetalDesc: TStringField
      FieldName = 'J_METAL_DESC'
      Size = 30
    end
  end
  object qryInvItems: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (

        'SELECT DISTINCT T2.*, T3.INV_CATEGORY, T4.J_STYLE_DESC, T5.J_TYP' +
        'E_DESC, T6.J_METAL_DESC'
      'FROM TRANSACTIONS T1'

        '  JOIN INVENTORY_ITEMS T2 ON T1.TRANSACTION_NO = T2.TRANSACTION_' +
        'NO'

        '  LEFT OUTER JOIN INV_CATEGORIES T3 ON T3.INV_CAT_NO = T2.INV_CA' +
        'T_NO'
      '  LEFT OUTER JOIN J_STYLES T4 ON T4.J_STYLE = T2.J_STYLE'
      '  LEFT OUTER JOIN J_TYPES T5 ON T5.J_TYPE = T2.J_TYPE'
      '  LEFT OUTER JOIN J_METALS T6 ON T6.J_METAL = T2.J_METAL'
      'WHERE T1.CUST_NO = :CUST_NO'
      '  AND T1.TRAN_STATUS = '#39'A'#39
      '  AND T1.TRAN_TYPE = '#39'P'#39

        '  AND T2.TRANSACTION_NO = COALESCE(:TRANSACTION_NO, T2.TRANSACTI' +
        'ON_NO)'
      'ORDER BY T2.DESCRIPTION, T2.WEIGHT, T2.SIZE_LENGTH,'
      '         T4.J_STYLE_DESC, T5.J_TYPE_DESC, T6.J_METAL_DESC,'
      '         T2.INV_ITEM_NO DESC')
    Left = 411
    Top = 391
    ParamData = <
      item
        Name = 'CUST_NO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TRANSACTION_NO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryInvItemsINV_ITEM_NO: TIntegerField
      FieldName = 'INV_ITEM_NO'
      Origin = 'INV_ITEM_NO'
      Required = True
    end
    object qryInvItemsINV_ITEM_BARCODE: TStringField
      FieldName = 'INV_ITEM_BARCODE'
      Origin = 'INV_ITEM_BARCODE'
      Size = 30
    end
    object qryInvItemsINV_CAT_NO: TIntegerField
      FieldName = 'INV_CAT_NO'
      Origin = 'INV_CAT_NO'
      Required = True
    end
    object qryInvItemsJ_TYPE: TStringField
      FieldName = 'J_TYPE'
      Origin = 'J_TYPE'
      FixedChar = True
      Size = 1
    end
    object qryInvItemsJ_STYLE: TStringField
      FieldName = 'J_STYLE'
      Origin = 'J_STYLE'
      FixedChar = True
      Size = 1
    end
    object qryInvItemsJ_METAL: TStringField
      FieldName = 'J_METAL'
      Origin = 'J_METAL'
      FixedChar = True
      Size = 1
    end
    object qryInvItemsINV_ITEM_COUNT: TIntegerField
      FieldName = 'INV_ITEM_COUNT'
      Origin = 'INV_ITEM_COUNT'
    end
    object qryInvItemsNOTE: TStringField
      FieldName = 'NOTE'
      Origin = 'NOTE'
      Size = 80
    end
    object qryInvItemsSIZE_LENGTH: TFloatField
      FieldName = 'SIZE_LENGTH'
      Origin = 'SIZE_LENGTH'
    end
    object qryInvItemsWEIGHT: TFloatField
      FieldName = 'WEIGHT'
      Origin = 'WEIGHT'
    end
    object qryInvItemsKT: TFloatField
      FieldName = 'KT'
      Origin = 'KT'
    end
    object qryInvItemsCREATED: TSQLTimeStampField
      FieldName = 'CREATED'
      Origin = 'CREATED'
    end
    object qryInvItemsUNIT_COST: TFMTBCDField
      FieldName = 'UNIT_COST'
      Origin = 'UNIT_COST'
      Precision = 18
      Size = 2
    end
    object qryInvItemsUNIT_PRICE: TFMTBCDField
      FieldName = 'UNIT_PRICE'
      Origin = 'UNIT_PRICE'
      Precision = 18
      Size = 2
    end
    object qryInvItemsINV_ITEM_STATUS: TStringField
      FieldName = 'INV_ITEM_STATUS'
      Origin = 'INV_ITEM_STATUS'
      FixedChar = True
      Size = 1
    end
    object qryInvItemsTRANSACTION_NO: TIntegerField
      FieldName = 'TRANSACTION_NO'
      Origin = 'TRANSACTION_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryInvItemsINV_ORIGINAL_ITEM_NO: TIntegerField
      FieldName = 'INV_ORIGINAL_ITEM_NO'
      Origin = 'INV_ORIGINAL_ITEM_NO'
    end
    object qryInvItemsINV_ITEM_BRAND: TStringField
      FieldName = 'INV_ITEM_BRAND'
      Origin = 'INV_ITEM_BRAND'
      Size = 30
    end
    object qryInvItemsSERIAL_NUMBER: TStringField
      FieldName = 'SERIAL_NUMBER'
      Origin = 'SERIAL_NUMBER'
      Size = 40
    end
    object qryInvItemsOWNER_APP_NUMBER: TStringField
      FieldName = 'OWNER_APP_NUMBER'
      Origin = 'OWNER_APP_NUMBER'
      Size = 40
    end
    object qryInvItemsMODEL_NUMBER: TStringField
      FieldName = 'MODEL_NUMBER'
      Origin = 'MODEL_NUMBER'
      Size = 40
    end
    object qryInvItemsGENDER: TStringField
      FieldName = 'GENDER'
      Origin = 'GENDER'
      FixedChar = True
      Size = 1
    end
    object qryInvItemsDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Origin = 'DESCRIPTION'
      Size = 120
    end
    object qryInvItemsWEIGHT_UNIT: TStringField
      FieldName = 'WEIGHT_UNIT'
      Origin = 'WEIGHT_UNIT'
      FixedChar = True
      Size = 1
    end
    object qryInvItemsPAWNED_DATE: TDateField
      FieldName = 'PAWNED_DATE'
      Origin = 'PAWNED_DATE'
    end
    object qryInvItemsPURCHASE_DATE: TDateField
      FieldName = 'PURCHASE_DATE'
      Origin = 'PURCHASE_DATE'
    end
    object qryInvItemsREDEEMED_DATE: TDateField
      FieldName = 'REDEEMED_DATE'
      Origin = 'REDEEMED_DATE'
    end
    object qryInvItemsDEFAULTED_DATE: TDateField
      FieldName = 'DEFAULTED_DATE'
      Origin = 'DEFAULTED_DATE'
    end
    object qryInvItemsMELTED_DATE: TDateField
      FieldName = 'MELTED_DATE'
      Origin = 'MELTED_DATE'
    end
    object qryInvItemsFORSALE_DATE: TDateField
      FieldName = 'FORSALE_DATE'
      Origin = 'FORSALE_DATE'
    end
    object qryInvItemsSOLD_DATE: TDateField
      FieldName = 'SOLD_DATE'
      Origin = 'SOLD_DATE'
    end
    object qryInvItemsLAYAWAY_DATE: TDateField
      FieldName = 'LAYAWAY_DATE'
      Origin = 'LAYAWAY_DATE'
    end
    object qryInvItemsINV_CATEGORY: TStringField
      FieldName = 'INV_CATEGORY'
      Origin = 'INV_CATEGORY'
      Size = 40
    end
    object qryInvItemsJ_STYLE_DESC: TStringField
      FieldName = 'J_STYLE_DESC'
      Origin = 'J_STYLE_DESC'
      Size = 30
    end
    object qryInvItemsJ_TYPE_DESC: TStringField
      FieldName = 'J_TYPE_DESC'
      Origin = 'J_TYPE_DESC'
      Size = 30
    end
    object qryInvItemsJ_METAL_DESC: TStringField
      FieldName = 'J_METAL_DESC'
      Origin = 'J_METAL_DESC'
      Size = 30
    end
  end
  object qryInsItems: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (

        'INSERT INTO INVENTORY_ITEMS (TRANSACTION_NO, INV_CAT_NO,'

        '                             J_TYPE, J_STYLE, J_METAL, INV_ITEM_' +
        'COUNT,'

        '                             NOTE, SIZE_LENGTH, WEIGHT, KT, INV_' +
        'ITEM_STATUS, INV_ITEM_BRAND, SERIAL_NUMBER,'

        '                             OWNER_APP_NUMBER, MODEL_NUMBER, DES' +
        'CRIPTION, GENDER)'

        '                     VALUES (:TRANSACTION_NO, :INV_CAT_NO,'

        '                             :J_TYPE, :J_STYLE, :J_METAL, :INV_I' +
        'TEM_COUNT,'

        '                             :NOTE, :SIZE_LENGTH, :WEIGHT, :KT, ' +
        ':INV_ITEM_STATUS, :INV_ITEM_BRAND, :SERIAL_NUMBER,'

        '                             :OWNER_APP_NUMBER, :MODEL_NUMBER, :' +
        'DESCRIPTION, :GENDER)'
        '                     RETURNING INV_ITEM_NO')
    Left = 813
    Top = 381
    ParamData = <
      item
        Name = 'TRANSACTION_NO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'INV_CAT_NO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'J_TYPE'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'J_STYLE'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'J_METAL'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'INV_ITEM_COUNT'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'NOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 80
      end
      item
        Name = 'SIZE_LENGTH'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'WEIGHT'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'KT'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'INV_ITEM_STATUS'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'INV_ITEM_BRAND'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end
      item
        Name = 'SERIAL_NUMBER'
        DataType = ftString
        ParamType = ptInput
        Size = 40
      end
      item
        Name = 'OWNER_APP_NUMBER'
        DataType = ftString
        ParamType = ptInput
        Size = 40
      end
      item
        Name = 'MODEL_NUMBER'
        DataType = ftString
        ParamType = ptInput
        Size = 40
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        ParamType = ptInput
        Size = 120
      end
      item
        Name = 'GENDER'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 1
      end>
  end
  object qryNextTicket: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'TABLE_KEYS'
    UpdateOptions.KeyFields = 'TABLE_NAME'
    SQL.Strings = (
      'SELECT TABLE_NAME, LAST_KEY'
      'FROM TABLE_KEYS'
      'WHERE TABLE_NAME = '#39'PawnTicketNo'#39';')
    Left = 843
    Top = 49
    object qryNextTicketTABLE_NAME: TStringField
      FieldName = 'TABLE_NAME'
      Origin = 'TABLE_NAME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 15
    end
    object qryNextTicketLAST_KEY: TIntegerField
      FieldName = 'LAST_KEY'
      Origin = 'LAST_KEY'
      Required = True
    end
  end
end
