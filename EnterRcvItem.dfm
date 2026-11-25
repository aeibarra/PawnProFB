object frmEnterRcvItem: TfrmEnterRcvItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Received Item'
  ClientHeight = 640
  ClientWidth = 841
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 20
  object gbItem: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 6
    Width = 618
    Height = 308
    Caption = ' Item '
    TabOrder = 0
    object lblCategory: TLabel
      Left = 23
      Top = 64
      Width = 63
      Height = 20
      Caption = 'Category:'
    end
    object lblDescription: TLabel
      Left = 275
      Top = 64
      Width = 79
      Height = 20
      Caption = 'Description:'
    end
    object lblWeight: TLabel
      Left = 20
      Top = 121
      Width = 50
      Height = 20
      Caption = 'Weight:'
    end
    object lblWeightUnit: TLabel
      Left = 133
      Top = 121
      Width = 30
      Height = 20
      Caption = 'Unit:'
    end
    object lblKT: TLabel
      Left = 275
      Top = 121
      Width = 20
      Height = 20
      Caption = 'KT:'
    end
    object lblLength: TLabel
      Left = 391
      Top = 121
      Width = 48
      Height = 20
      Caption = 'Length:'
    end
    object lblCost: TLabel
      Left = 20
      Top = 240
      Width = 35
      Height = 20
      Caption = 'Cost:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPrice: TLabel
      Left = 142
      Top = 240
      Width = 38
      Height = 20
      Caption = 'Price:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 20
      Top = 179
      Width = 39
      Height = 20
      Caption = 'Brand'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 177
      Top = 179
      Width = 95
      Height = 20
      Caption = 'Serial Number'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 316
      Top = 179
      Width = 46
      Height = 20
      Caption = 'Model:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 461
      Top = 179
      Width = 51
      Height = 20
      Caption = 'Gender:'
      FocusControl = cbGender
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object RzLabel1: TRzLabel
      Left = 37
      Top = 27
      Width = 69
      Height = 20
      Caption = 'Quantity: '
      FocusControl = edCopies
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lkCategory: TDBLookupComboBox
      Left = 20
      Top = 87
      Width = 244
      Height = 28
      DataField = 'INV_CAT_NO'
      DataSource = dsItem
      KeyField = 'INV_CAT_NO'
      ListField = 'INV_CATEGORY'
      ListSource = dsCategories
      TabOrder = 1
    end
    object edDescription: TDBEdit
      Left = 275
      Top = 87
      Width = 316
      Height = 28
      DataField = 'DESCRIPTION'
      DataSource = dsItem
      TabOrder = 2
    end
    object edWeight: TRzDBNumericEdit
      Left = 20
      Top = 144
      Width = 100
      Height = 28
      DataSource = dsItem
      DataField = 'WEIGHT'
      Alignment = taLeftJustify
      TabOrder = 3
      IntegersOnly = False
      DisplayFormat = ',0.00##'
    end
    object lkWeightUnit: TDBLookupComboBox
      Left = 131
      Top = 144
      Width = 133
      Height = 28
      DataField = 'WEIGHT_UNIT'
      DataSource = dsItem
      KeyField = 'WeigthUnitValue'
      ListField = 'WeightUnit'
      ListSource = dsWeightUnits
      TabOrder = 4
    end
    object edKT: TDBEdit
      Left = 275
      Top = 144
      Width = 100
      Height = 28
      DataField = 'KT'
      DataSource = dsItem
      TabOrder = 5
    end
    object edLength: TDBEdit
      Left = 388
      Top = 144
      Width = 100
      Height = 28
      DataField = 'SIZE_LENGTH'
      DataSource = dsItem
      TabOrder = 6
    end
    object edCost: TRzDBNumericEdit
      Left = 20
      Top = 262
      Width = 100
      Height = 28
      DataSource = dsItem
      DataField = 'UNIT_COST'
      Alignment = taLeftJustify
      TabOrder = 11
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object edPrice: TRzDBNumericEdit
      Left = 142
      Top = 262
      Width = 100
      Height = 28
      DataSource = dsItem
      DataField = 'UNIT_PRICE'
      Alignment = taLeftJustify
      TabOrder = 12
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object cbBrand: TDBComboBox
      Left = 20
      Top = 202
      Width = 138
      Height = 28
      DataField = 'INV_ITEM_BRAND'
      DataSource = dsItem
      TabOrder = 7
    end
    object DBEdit7: TDBEdit
      Left = 172
      Top = 202
      Width = 132
      Height = 28
      DataField = 'SERIAL_NUMBER'
      DataSource = dsItem
      TabOrder = 8
    end
    object DBEdit10: TDBEdit
      Left = 314
      Top = 202
      Width = 137
      Height = 28
      DataField = 'MODEL_NUMBER'
      DataSource = dsItem
      TabOrder = 9
    end
    object cbGender: TRzDBComboBox
      Left = 460
      Top = 202
      Width = 131
      Height = 28
      DataField = 'GENDER'
      DataSource = dsItem
      Style = csDropDownList
      TabOrder = 10
      Items.Strings = (
        'Men'#39's'
        'Woman'#39's'
        'Not Applicable')
      Values.Strings = (
        'M'
        'W'
        'N')
    end
    object chkApplyToGroup: TCheckBox
      Left = 253
      Top = 258
      Width = 338
      Height = 35
      Caption = 'Apply these changes to all pieces of this group'
      Checked = True
      State = cbChecked
      TabOrder = 13
      Visible = False
    end
    object edCopies: TRzNumericEdit
      Left = 110
      Top = 26
      Width = 51
      Height = 28
      Hint = 'How many identical pieces to add: each gets its own barcode'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      CheckRange = True
      Max = 500.00000000000000000
      Min = 1.00000000000000000
      DisplayFormat = '0'
      Value = 1.00000000000000000
    end
  end
  object gbStones: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 315
    Width = 618
    Height = 244
    Caption = ' Stones '
    TabOrder = 1
    object pnStoneButtons: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 186
      Width = 608
      Height = 53
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnAddStone: TBitBtn
        Left = 8
        Top = 5
        Width = 100
        Height = 43
        Caption = '&Add'
        ImageIndex = 21
        ImageName = 'actItems'
        Images = DM.vilMain24
        TabOrder = 0
        OnClick = btnAddStoneClick
      end
      object btnEditStone: TBitBtn
        Left = 118
        Top = 5
        Width = 100
        Height = 43
        Caption = '&Edit'
        ImageIndex = 14
        ImageName = 'actEdit02'
        Images = DM.vilMain24
        TabOrder = 1
        OnClick = btnEditStoneClick
      end
      object btnRemoveStone: TRzBitBtn
        Left = 455
        Top = 0
        Width = 109
        Height = 43
        Caption = 'Remove'
        TabOrder = 2
        OnClick = btnRemoveStoneClick
        ImageIndex = 23
        Images = DM.vilMain24
      end
    end
    object dbgStones: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 608
      Height = 155
      Align = alClient
      DataSource = dsStones
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = btnEditStoneClick
      Columns = <
        item
          Expanded = False
          FieldName = 'STONE_NUMBER'
          Title.Caption = 'Stones'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cShape'
          Title.Caption = 'Shape'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cColor'
          Title.Caption = 'Color'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CT'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STONE_TYPE'
          Title.Caption = 'Type'
          Width = 150
          Visible = True
        end>
    end
  end
  object gbButtons: TGroupBox
    Left = 3
    Top = 563
    Width = 618
    Height = 66
    TabOrder = 2
    object btnCancel: TBitBtn
      Left = 457
      Top = 12
      Width = 109
      Height = 43
      ImageName = 'Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      Spacing = 7
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnSave: TRzBitBtn
      Left = 328
      Top = 12
      Width = 109
      Height = 43
      Caption = '&Save'
      TabOrder = 1
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
    end
  end
  object dsItem: TDataSource
    Left = 659
    Top = 24
  end
  object dsCategories: TDataSource
    Left = 659
    Top = 80
  end
  object dsWeightUnits: TDataSource
    Left = 659
    Top = 136
  end
  object dsStones: TDataSource
    DataSet = qryStones
    Left = 316
    Top = 429
  end
  object qryStones: TFDQuery
    OnCalcFields = qryStonesCalcFields
    OnNewRecord = qryStonesNewRecord
    CachedUpdates = True
    Connection = DM.ConnFB
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.UpdateTableName = 'STONES'
    UpdateOptions.KeyFields = 'STONE_NO'
    UpdateOptions.AutoIncFields = 'STONE_NO'
    SQL.Strings = (
      'SELECT *'
      'FROM STONES'
      'WHERE INV_ITEM_NO = :INV_ITEM_NO')
    Left = 317
    Top = 375
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
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryStonesINV_ITEM_NO: TIntegerField
      FieldName = 'INV_ITEM_NO'
      Origin = 'INV_ITEM_NO'
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
