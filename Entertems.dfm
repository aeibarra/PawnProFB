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
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 20
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 631
    Width = 591
    Height = 70
    TabOrder = 2
    object btnCancel: TBitBtn
      Left = 455
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
      Left = 322
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
    Width = 596
    Height = 378
    Caption = 'Item'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 33
      Top = 83
      Width = 89
      Height = 20
      Caption = 'Item Barcode'
    end
    object Label2: TLabel
      Left = 33
      Top = 139
      Width = 74
      Height = 20
      Caption = 'Item Type:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 220
      Top = 139
      Width = 38
      Height = 20
      Caption = 'Style:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 396
      Top = 139
      Width = 44
      Height = 20
      Caption = 'Metal:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 246
      Top = 311
      Width = 42
      Height = 20
      Caption = 'Notes:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 202
      Top = 84
      Width = 51
      Height = 20
      Caption = 'Weight'
      FocusControl = DBEdit4
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 402
      Top = 83
      Width = 19
      Height = 20
      Caption = 'KT'
      FocusControl = DBEdit5
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 474
      Top = 83
      Width = 80
      Height = 20
      Caption = 'Size Length'
      FocusControl = DBEdit6
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 131
      Top = 83
      Width = 59
      Height = 20
      Caption = 'Quantity:'
      FocusControl = edItemCount
    end
    object Label10: TLabel
      Left = 30
      Top = 311
      Width = 69
      Height = 20
      Caption = 'Unit Cost:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 139
      Top = 311
      Width = 66
      Height = 20
      Caption = 'Unit Price:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 33
      Top = 27
      Width = 63
      Height = 20
      Caption = 'Category:'
    end
    object Label13: TLabel
      Left = 33
      Top = 196
      Width = 42
      Height = 20
      Caption = 'Brand'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 220
      Top = 196
      Width = 100
      Height = 20
      Caption = 'Serial Number'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 289
      Top = 27
      Width = 121
      Height = 20
      Caption = 'Item Description:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 30
      Top = 254
      Width = 171
      Height = 20
      Caption = 'Owner Applied Number:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 220
      Top = 254
      Width = 111
      Height = 20
      Caption = 'Model Number:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 280
      Top = 83
      Width = 85
      Height = 20
      Caption = 'Weight Unit'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 30
      Top = 105
      Width = 94
      Height = 28
      TabStop = False
      DataField = 'INV_ITEM_BARCODE'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 2
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 33
      Top = 162
      Width = 176
      Height = 28
      DataField = 'J_TYPE'
      DataSource = dsInvItems
      KeyField = 'J_TYPE'
      ListField = 'J_TYPE_DESC'
      ListSource = dsTypes
      TabOrder = 8
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 215
      Top = 160
      Width = 166
      Height = 28
      DataField = 'J_STYLE'
      DataSource = dsInvItems
      KeyField = 'J_STYLE'
      ListField = 'J_STYLE_DESC'
      ListSource = dsStyles
      TabOrder = 9
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 387
      Top = 161
      Width = 169
      Height = 28
      DataField = 'J_METAL'
      DataSource = dsInvItems
      KeyField = 'J_METAL'
      ListField = 'J_METAL_DESC'
      ListSource = dsMetal
      TabOrder = 10
    end
    object DBMemo1: TDBMemo
      Left = 240
      Top = 333
      Width = 314
      Height = 28
      DataField = 'NOTE'
      DataSource = dsInvItems
      TabOrder = 18
    end
    object DBEdit4: TDBEdit
      Left = 198
      Top = 105
      Width = 70
      Height = 28
      DataField = 'WEIGHT'
      DataSource = dsInvItems
      TabOrder = 4
    end
    object DBEdit5: TDBEdit
      Left = 397
      Top = 105
      Width = 67
      Height = 28
      DataField = 'KT'
      DataSource = dsInvItems
      TabOrder = 6
    end
    object DBEdit6: TDBEdit
      Left = 471
      Top = 105
      Width = 85
      Height = 28
      DataField = 'SIZE_LENGTH'
      DataSource = dsInvItems
      TabOrder = 7
    end
    object edItemCount: TDBEdit
      Left = 131
      Top = 105
      Width = 60
      Height = 28
      DataField = 'INV_ITEM_COUNT'
      DataSource = dsInvItems
      TabOrder = 3
    end
    object DBEdit2: TDBEdit
      Left = 30
      Top = 333
      Width = 99
      Height = 28
      DataField = 'UNIT_COST'
      DataSource = dsInvItems
      TabOrder = 16
    end
    object DBEdit3: TDBEdit
      Left = 135
      Top = 333
      Width = 99
      Height = 28
      DataField = 'UNIT_PRICE'
      DataSource = dsInvItems
      TabOrder = 17
    end
    object DBLookupComboBox4: TDBLookupComboBox
      Left = 30
      Top = 50
      Width = 244
      Height = 28
      DataField = 'INV_CAT_NO'
      DataSource = dsInvItems
      KeyField = 'INV_CAT_NO'
      ListField = 'INV_CATEGORY'
      ListSource = dsCategories
      TabOrder = 0
      TabStop = False
    end
    object cbBrand: TDBComboBox
      Left = 33
      Top = 219
      Width = 176
      Height = 28
      DataField = 'INV_ITEM_BRAND'
      DataSource = dsInvItems
      TabOrder = 11
    end
    object DBEdit7: TDBEdit
      Left = 215
      Top = 219
      Width = 166
      Height = 28
      DataField = 'SERIAL_NUMBER'
      DataSource = dsInvItems
      TabOrder = 12
    end
    object edItemDesc: TDBEdit
      Left = 285
      Top = 50
      Width = 271
      Height = 28
      DataField = 'DESCRIPTION'
      DataSource = dsInvItems
      TabOrder = 1
    end
    object DBEdit9: TDBEdit
      Left = 30
      Top = 276
      Width = 176
      Height = 28
      DataField = 'OWNER_APP_NUMBER'
      DataSource = dsInvItems
      TabOrder = 14
    end
    object DBEdit10: TDBEdit
      Left = 215
      Top = 276
      Width = 166
      Height = 28
      DataField = 'MODEL_NUMBER'
      DataSource = dsInvItems
      TabOrder = 15
    end
    object RzDBRadioGroup1: TRzDBRadioGroup
      Left = 387
      Top = 194
      Width = 169
      Height = 113
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
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      StartXPos = 20
      StartYPos = 4
      TabOrder = 13
      TabStop = True
      VisualStyle = vsClassic
    end
    object cbWeightUnit: TDBLookupComboBox
      Left = 275
      Top = 105
      Width = 116
      Height = 28
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
    Top = 379
    Width = 596
    Height = 246
    Caption = 'Stones'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Panel9: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 180
      Width = 586
      Height = 61
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 181
      ExplicitWidth = 603
      object btnAddStone: TBitBtn
        Left = 18
        Top = 5
        Width = 100
        Height = 48
        Caption = '&Add'
        ImageIndex = 21
        ImageName = 'actItems'
        Images = DM.vilMain
        TabOrder = 0
        OnClick = btnAddStoneClick
      end
      object btnEditStone: TBitBtn
        Left = 128
        Top = 5
        Width = 100
        Height = 48
        Caption = '&Edit'
        ImageIndex = 14
        ImageName = 'actEdit02'
        Images = DM.vilMain
        TabOrder = 1
        OnClick = btnEditStoneClick
      end
      object btnRemoveStone: TRzBitBtn
        Left = 431
        Top = 5
        Width = 126
        Height = 48
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
      Top = 25
      Width = 586
      Height = 149
      Align = alClient
      DataSource = dsStones
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
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
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 120
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
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 113
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
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 125
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CT'
          Title.Alignment = taCenter
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 81
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'WT'
          Title.Alignment = taCenter
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 93
          Visible = True
        end>
    end
  end
  object dsTypes: TDataSource
    DataSet = DM.clnJTypes
    Left = 796
    Top = 27
  end
  object dsStyles: TDataSource
    DataSet = DM.clnJStyles
    Left = 852
    Top = 27
  end
  object dsMetal: TDataSource
    DataSet = DM.clnJMetals
    Left = 908
    Top = 27
  end
  object dsInvItems: TDataSource
    DataSet = frmClients.qryInvItems
    Left = 717
    Top = 27
  end
  object dsCategories: TDataSource
    DataSet = DM.clnInventoryCategories
    Left = 717
    Top = 105
  end
  object dsStones: TDataSource
    DataSet = qryStones
    Left = 722
    Top = 262
  end
  object dsWeigthUnits: TDataSource
    DataSet = DM.clnWeigthUnits
    Left = 803
    Top = 105
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
    Left = 720
    Top = 328
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
    Left = 717
    Top = 204
    ParamData = <
      item
        Name = 'INV_ITEM_NO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryStonescShape: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cShape'
      Size = 30
      Calculated = True
    end
    object qryStonescColor: TWideStringField
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
    object qryStonesSTONE_SHAPE: TWideStringField
      FieldName = 'STONE_SHAPE'
      Origin = 'STONE_SHAPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryStonesSTONE_COLOR: TWideStringField
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
    object qryStonesSTONE_TYPE: TWideStringField
      FieldName = 'STONE_TYPE'
      Origin = 'STONE_TYPE'
      Size = 30
    end
    object qryStonesSTONE_WEIGHT_UNIT: TWideStringField
      FieldName = 'STONE_WEIGHT_UNIT'
      Origin = 'STONE_WEIGHT_UNIT'
      FixedChar = True
      Size = 1
    end
  end
end
