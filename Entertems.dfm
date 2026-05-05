object frmEnterItems: TfrmEnterItems
  Left = 321
  Top = 98
  BorderStyle = bsDialog
  Caption = 'Pawn Item Information'
  ClientHeight = 786
  ClientWidth = 1186
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 17
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 585
    Width = 547
    Height = 70
    TabOrder = 2
    object btnCancel: TBitBtn
      Left = 413
      Top = 11
      Width = 106
      Height = 48
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
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnSave: TRzBitBtn
      Left = 280
      Top = 11
      Width = 106
      Height = 48
      Caption = '&Save'
      TabOrder = 1
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -5
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = -2
    Width = 547
    Height = 355
    Caption = 'Item'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 30
      Top = 81
      Width = 77
      Height = 17
      Caption = 'Item Barcode'
    end
    object Label2: TLabel
      Left = 30
      Top = 131
      Width = 63
      Height = 17
      Caption = 'Item Type:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 203
      Top = 131
      Width = 32
      Height = 17
      Caption = 'Style:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 371
      Top = 131
      Width = 37
      Height = 17
      Caption = 'Metal:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 248
      Top = 285
      Width = 38
      Height = 17
      Caption = 'Notes:'
    end
    object Label5: TLabel
      Left = 183
      Top = 81
      Width = 44
      Height = 17
      Caption = 'Weight'
      FocusControl = DBEdit4
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 371
      Top = 81
      Width = 15
      Height = 17
      Caption = 'KT'
      FocusControl = DBEdit5
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 452
      Top = 81
      Width = 69
      Height = 17
      Caption = 'Size Length'
      FocusControl = DBEdit6
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 120
      Top = 81
      Width = 51
      Height = 17
      Caption = 'Quantity:'
      FocusControl = edItemCount
    end
    object Label10: TLabel
      Left = 30
      Top = 285
      Width = 59
      Height = 17
      Caption = 'Unit Cost:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 136
      Top = 285
      Width = 58
      Height = 17
      Caption = 'Unit Price:'
    end
    object Label12: TLabel
      Left = 30
      Top = 27
      Width = 56
      Height = 17
      Caption = 'Category:'
    end
    object Label13: TLabel
      Left = 30
      Top = 182
      Width = 36
      Height = 17
      Caption = 'Brand'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 203
      Top = 182
      Width = 86
      Height = 17
      Caption = 'Serial Number'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 263
      Top = 27
      Width = 103
      Height = 17
      Caption = 'Item Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 30
      Top = 233
      Width = 148
      Height = 17
      Caption = 'Owner Applied Number:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 203
      Top = 233
      Width = 96
      Height = 17
      Caption = 'Model Number:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 255
      Top = 81
      Width = 73
      Height = 17
      Caption = 'Weight Unit'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 33
      Top = 100
      Width = 81
      Height = 25
      TabStop = False
      DataField = 'INV_ITEM_BARCODE'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 2
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 36
      Top = 151
      Width = 161
      Height = 25
      DataField = 'J_TYPE'
      DataSource = dsInvItems
      KeyField = 'J_TYPE'
      ListField = 'J_TYPE_DESC'
      ListSource = dsTypes
      TabOrder = 8
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 203
      Top = 150
      Width = 157
      Height = 25
      DataField = 'J_STYLE'
      DataSource = dsInvItems
      KeyField = 'J_STYLE'
      ListField = 'J_STYLE_DESC'
      ListSource = dsStyles
      TabOrder = 9
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 366
      Top = 151
      Width = 153
      Height = 25
      DataField = 'J_METAL'
      DataSource = dsInvItems
      KeyField = 'J_METAL'
      ListField = 'J_METAL_DESC'
      ListSource = dsMetal
      TabOrder = 10
    end
    object DBMemo1: TDBMemo
      Left = 241
      Top = 305
      Width = 276
      Height = 25
      DataField = 'NOTE'
      DataSource = dsInvItems
      TabOrder = 18
    end
    object DBEdit4: TDBEdit
      Left = 183
      Top = 100
      Width = 64
      Height = 25
      DataField = 'WEIGHT'
      DataSource = dsInvItems
      TabOrder = 4
    end
    object DBEdit5: TDBEdit
      Left = 371
      Top = 100
      Width = 70
      Height = 25
      DataField = 'KT'
      DataSource = dsInvItems
      TabOrder = 6
    end
    object DBEdit6: TDBEdit
      Left = 451
      Top = 100
      Width = 73
      Height = 25
      DataField = 'SIZE_LENGTH'
      DataSource = dsInvItems
      TabOrder = 7
    end
    object edItemCount: TDBEdit
      Left = 120
      Top = 100
      Width = 52
      Height = 25
      DataField = 'INV_ITEM_COUNT'
      DataSource = dsInvItems
      TabOrder = 3
    end
    object DBEdit2: TDBEdit
      Left = 30
      Top = 305
      Width = 97
      Height = 25
      DataField = 'UNIT_COST'
      DataSource = dsInvItems
      TabOrder = 16
    end
    object DBEdit3: TDBEdit
      Left = 136
      Top = 305
      Width = 97
      Height = 25
      DataField = 'UNIT_PRICE'
      DataSource = dsInvItems
      TabOrder = 17
    end
    object DBLookupComboBox4: TDBLookupComboBox
      Left = 30
      Top = 48
      Width = 227
      Height = 25
      DataField = 'INV_CAT_NO'
      DataSource = dsInvItems
      KeyField = 'INV_CAT_NO'
      ListField = 'INV_CATEGORY'
      ListSource = dsCategories
      TabOrder = 0
      TabStop = False
    end
    object cbBrand: TDBComboBox
      Left = 30
      Top = 202
      Width = 161
      Height = 25
      DataField = 'INV_ITEM_BRAND'
      DataSource = dsInvItems
      TabOrder = 11
    end
    object DBEdit7: TDBEdit
      Left = 203
      Top = 202
      Width = 157
      Height = 25
      DataField = 'SERIAL_NUMBER'
      DataSource = dsInvItems
      TabOrder = 12
    end
    object edItemDesc: TDBEdit
      Left = 263
      Top = 48
      Width = 261
      Height = 25
      DataField = 'DESCRIPTION'
      DataSource = dsInvItems
      TabOrder = 1
    end
    object DBEdit9: TDBEdit
      Left = 30
      Top = 253
      Width = 161
      Height = 25
      DataField = 'OWNER_APP_NUMBER'
      DataSource = dsInvItems
      TabOrder = 14
    end
    object DBEdit10: TDBEdit
      Left = 203
      Top = 253
      Width = 153
      Height = 25
      DataField = 'MODEL_NUMBER'
      DataSource = dsInvItems
      TabOrder = 15
    end
    object RzDBRadioGroup1: TRzDBRadioGroup
      Left = 371
      Top = 182
      Width = 153
      Height = 98
      DataField = 'GENDER'
      DataSource = dsInvItems
      Items.Strings = (
        'Men'#39's     '
        'Woman'#39's    '
        'Not Applicable')
      Values.Strings = (
        'M'
        'W'
        'N')
      Caption = 'Gender'
      Color = 15987699
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      StartXPos = 20
      StartYPos = 4
      TabOrder = 13
      TabStop = True
      VisualStyle = vsClassic
    end
    object cbWeightUnit: TDBLookupComboBox
      Left = 255
      Top = 100
      Width = 105
      Height = 25
      DataField = 'WEIGHT_UNIT'
      DataSource = dsInvItems
      KeyField = 'WeigthUnitValue'
      ListField = 'WeightUnit'
      ListSource = dsWeigthUnits
      TabOrder = 5
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 358
    Width = 547
    Height = 225
    Caption = 'Stones'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Panel9: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 168
      Width = 537
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btnAddStone: TBitBtn
        Left = 16
        Top = 2
        Width = 93
        Height = 47
        Caption = '&Add'
        ImageIndex = 21
        ImageName = 'actItems'
        Images = DM.vilMain
        TabOrder = 0
        OnClick = btnAddStoneClick
      end
      object btnEditStone: TBitBtn
        Left = 126
        Top = 2
        Width = 93
        Height = 47
        Caption = '&Edit'
        ImageIndex = 14
        ImageName = 'actEdit02'
        Images = DM.vilMain
        TabOrder = 1
        OnClick = btnEditStoneClick
      end
      object btnRemoveStone: TRzBitBtn
        Left = 395
        Top = 2
        Width = 119
        Height = 47
        Caption = 'Remove'
        TabOrder = 2
        OnClick = btnRemoveStoneClick
        ImageIndex = 23
        Images = DM.vilMain
        Margin = 10
        Spacing = 5
      end
    end
    object DBGrid2: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 22
      Width = 537
      Height = 140
      Align = alClient
      DataSource = dsStones
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'STONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = 'Stone Number'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 96
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cShape'
          Title.Alignment = taCenter
          Title.Caption = 'Shape'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 84
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cColor'
          Title.Alignment = taCenter
          Title.Caption = 'Color'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 89
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CT'
          Title.Alignment = taCenter
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 61
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'WT'
          Title.Alignment = taCenter
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Segoe UI Semibold'
          Title.Font.Style = [fsBold]
          Width = 66
          Visible = True
        end>
    end
  end
  object dsTypes: TDataSource
    DataSet = DM.clnJTypes
    Left = 715
    Top = 28
  end
  object dsStyles: TDataSource
    DataSet = DM.clnJStyles
    Left = 771
    Top = 28
  end
  object dsMetal: TDataSource
    DataSet = DM.clnJMetals
    Left = 827
    Top = 28
  end
  object qryCategories: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT INV_CAT_NO, INV_CATEGORY'
      'FROM INV_CATEGORIES'
      'ORDER BY INV_CATEGORY')
    Left = 716
    Top = 145
    object qryCategoriesINV_CAT_NO: TIntegerField
      FieldName = 'INV_CAT_NO'
      Origin = 'INV_CAT_NO'
      Required = True
    end
    object qryCategoriesINV_CATEGORY: TStringField
      FieldName = 'INV_CATEGORY'
      Origin = 'INV_CATEGORY'
      Size = 40
    end
  end
  object dsInvItems: TDataSource
    DataSet = frmClients.qryInvItems
    Left = 636
    Top = 25
  end
  object dsCategories: TDataSource
    DataSet = qryCategories
    Left = 716
    Top = 193
  end
  object qryBrands: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT DISTINCT INV_ITEM_BRAND'
      'FROM INVENTORY_ITEMS'
      'WHERE INV_ITEM_BRAND IS NOT NULL'
      'ORDER BY INV_ITEM_BRAND')
    Left = 716
    Top = 249
    object qryBrandsINV_ITEM_BRAND: TStringField
      FieldName = 'INV_ITEM_BRAND'
      Origin = 'INV_ITEM_BRAND'
      Size = 30
    end
  end
  object dsStones: TDataSource
    DataSet = qryStones
    Left = 594
    Top = 490
  end
  object clnWeigthUnits: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'WeigthUnitValue'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'WeightUnit'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 716
    Top = 320
    object clnWeigthUnitsWeigthUnitValue: TStringField
      FieldName = 'WeigthUnitValue'
      Size = 1
    end
    object clnWeigthUnitsWeightUnit: TStringField
      FieldName = 'WeightUnit'
      Size = 50
    end
  end
  object dsWeigthUnits: TDataSource
    DataSet = clnWeigthUnits
    Left = 714
    Top = 378
  end
  object updStones: TFDUpdateSQL
    Connection = DM.ConnFB
    InsertSQL.Strings = (
      'INSERT INTO STONES'
      '(INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, '
      '  CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT)'
      
        'VALUES (:NEW_INV_ITEM_NO, :NEW_STONE_NUMBER, :NEW_STONE_SHAPE, :' +
        'NEW_STONE_COLOR, '
      '  :NEW_CT, :NEW_WT, :NEW_STONE_TYPE, :NEW_STONE_WEIGHT_UNIT)'
      'RETURNING STONE_NO')
    ModifySQL.Strings = (
      'UPDATE STONES'
      
        'SET INV_ITEM_NO = :NEW_INV_ITEM_NO, STONE_NUMBER = :NEW_STONE_NU' +
        'MBER, '
      
        '  STONE_SHAPE = :NEW_STONE_SHAPE, STONE_COLOR = :NEW_STONE_COLOR' +
        ', '
      '  CT = :NEW_CT, WT = :NEW_WT, STONE_TYPE = :NEW_STONE_TYPE, '
      '  STONE_WEIGHT_UNIT = :NEW_STONE_WEIGHT_UNIT'
      
        'WHERE INV_ITEM_NO = :OLD_INV_ITEM_NO AND STONE_NUMBER = :OLD_STO' +
        'NE_NUMBER AND '
      
        '  STONE_SHAPE = :OLD_STONE_SHAPE AND STONE_COLOR = :OLD_STONE_CO' +
        'LOR AND '
      
        '  CT = :OLD_CT AND WT = :OLD_WT AND STONE_TYPE = :OLD_STONE_TYPE' +
        ' AND '
      '  STONE_WEIGHT_UNIT = :OLD_STONE_WEIGHT_UNIT'
      'RETURNING STONE_NO')
    DeleteSQL.Strings = (
      'DELETE FROM STONES'
      
        'WHERE INV_ITEM_NO = :OLD_INV_ITEM_NO AND STONE_NUMBER = :OLD_STO' +
        'NE_NUMBER AND '
      
        '  STONE_SHAPE = :OLD_STONE_SHAPE AND STONE_COLOR = :OLD_STONE_CO' +
        'LOR AND '
      
        '  CT = :OLD_CT AND WT = :OLD_WT AND STONE_TYPE = :OLD_STONE_TYPE' +
        ' AND '
      '  STONE_WEIGHT_UNIT = :OLD_STONE_WEIGHT_UNIT')
    UnlockSQL.Strings = (
      'SELECT *'
      'FROM STONES'
      'WHERE INV_ITEM_NO = :INV_ITEM_NO')
    FetchRowSQL.Strings = (
      
        'SELECT STONE_NO, INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_C' +
        'OLOR, '
      '  CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT'
      'FROM STONES'
      
        'WHERE INV_ITEM_NO = :OLD_INV_ITEM_NO AND STONE_NUMBER = :OLD_STO' +
        'NE_NUMBER AND '
      
        '  STONE_SHAPE = :OLD_STONE_SHAPE AND STONE_COLOR = :OLD_STONE_CO' +
        'LOR AND '
      
        '  CT = :OLD_CT AND WT = :OLD_WT AND STONE_TYPE = :OLD_STONE_TYPE' +
        ' AND '
      '  STONE_WEIGHT_UNIT = :OLD_STONE_WEIGHT_UNIT')
    Left = 592
    Top = 556
  end
  object qryStones: TFDQuery
    OnCalcFields = clnStonesCalcFields
    OnNewRecord = clnStonesNewRecord
    CachedUpdates = True
    Connection = DM.ConnFB
    UpdateObject = updStones
    SQL.Strings = (
      'SELECT *'
      'FROM STONES'
      'WHERE INV_ITEM_NO = :INV_ITEM_NO')
    Left = 589
    Top = 432
    ParamData = <
      item
        Name = 'INV_ITEM_NO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryStonescShape: TStringField
      FieldKind = fkCalculated
      FieldName = 'cShape'
      Size = 30
      Calculated = True
    end
    object qryStonescColor: TStringField
      FieldKind = fkCalculated
      FieldName = 'cColor'
      Size = 30
      Calculated = True
    end
    object qryStonesSTONE_NO: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'STONE_NO'
      Origin = 'STONE_NO'
    end
    object qryStonesINV_ITEM_NO: TIntegerField
      FieldName = 'INV_ITEM_NO'
      Origin = 'INV_ITEM_NO'
      Required = True
    end
    object qryStonesSTONE_NUMBER: TIntegerField
      FieldName = 'STONE_NUMBER'
      Origin = 'STONE_NUMBER'
      Required = True
    end
    object qryStonesSTONE_SHAPE: TStringField
      FieldName = 'STONE_SHAPE'
      Origin = 'STONE_SHAPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryStonesSTONE_COLOR: TStringField
      FieldName = 'STONE_COLOR'
      Origin = 'STONE_COLOR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryStonesCT: TFloatField
      FieldName = 'CT'
      Origin = 'CT'
    end
    object qryStonesWT: TFloatField
      FieldName = 'WT'
      Origin = 'WT'
    end
    object qryStonesSTONE_TYPE: TStringField
      FieldName = 'STONE_TYPE'
      Origin = 'STONE_TYPE'
      Size = 30
    end
    object qryStonesSTONE_WEIGHT_UNIT: TStringField
      FieldName = 'STONE_WEIGHT_UNIT'
      Origin = 'STONE_WEIGHT_UNIT'
      FixedChar = True
      Size = 1
    end
  end
end
