object frmMaintenanceJ: TfrmMaintenanceJ
  Left = 398
  Top = 131
  BorderStyle = bsDialog
  Caption = 'Maintenance'
  ClientHeight = 366
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 17
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 291
    Width = 356
    Height = 72
    Align = alBottom
    TabOrder = 0
    object btnAddCat: TBitBtn
      Left = 17
      Top = 15
      Width = 88
      Height = 45
      Caption = 'Add'
      ImageIndex = 15
      ImageName = 'actAddFld01'
      Images = DM.vilMain24
      TabOrder = 0
      OnClick = btnAddCatClick
    end
    object btnEditCat: TBitBtn
      Left = 123
      Top = 15
      Width = 88
      Height = 45
      Caption = 'Edit'
      ImageIndex = 13
      ImageName = 'actEdit01'
      Images = DM.vilMain24
      TabOrder = 1
      OnClick = btnEditCatClick
    end
    object btnClose: TBitBtn
      Left = 248
      Top = 15
      Width = 96
      Height = 45
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 2
      OnClick = btnCloseClick
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 356
    Height = 282
    Align = alClient
    DataSource = dsMaintenace
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object dsMaintenace: TDataSource
    Left = 70
    Top = 157
  end
  object qryTypes: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_TYPES'
    UpdateOptions.KeyFields = 'J_TYPE'
    SQL.Strings = (
      'SELECT J_TYPE, J_TYPE_DESC'
      'FROM J_TYPES'
      'ORDER BY J_TYPE_DESC')
    Left = 100
    Top = 16
    object qryTypesJ_TYPE: TStringField
      DisplayLabel = 'Type'
      FieldName = 'J_TYPE'
      Size = 1
    end
    object qryTypesJ_TYPE_DESC: TStringField
      DisplayLabel = 'Description'
      FieldName = 'J_TYPE_DESC'
      Size = 30
    end
  end
  object qryStyles: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_STYLES'
    UpdateOptions.KeyFields = 'J_STYLE'
    SQL.Strings = (
      'SELECT J_STYLE, J_STYLE_DESC'
      'FROM J_STYLES'
      'ORDER BY J_STYLE_DESC')
    Left = 156
    Top = 16
    object qryStylesJ_STYLE: TStringField
      DisplayLabel = 'Style'
      FieldName = 'J_STYLE'
      Size = 1
    end
    object qryStylesJ_STYLE_DESC: TStringField
      DisplayLabel = 'Description'
      FieldName = 'J_STYLE_DESC'
      Size = 30
    end
  end
  object qryMetal: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_METALS'
    UpdateOptions.KeyFields = 'J_METAL'
    SQL.Strings = (
      'SELECT J_METAL, J_METAL_DESC'
      'FROM J_METALS'
      'ORDER BY J_METAL_DESC')
    Left = 212
    Top = 16
    object qryMetalJ_METAL: TStringField
      DisplayLabel = 'Metal'
      FieldName = 'J_METAL'
      Size = 1
    end
    object qryMetalJ_METAL_DESC: TStringField
      DisplayLabel = 'Description'
      FieldName = 'J_METAL_DESC'
      Size = 30
    end
  end
  object qryStoneShapes: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_STONE_SHAPES'
    UpdateOptions.KeyFields = 'J_SHAPE'
    SQL.Strings = (
      'SELECT J_SHAPE, J_SHAPE_DESC'
      'FROM J_STONE_SHAPES'
      'ORDER BY J_SHAPE_DESC')
    Left = 284
    Top = 16
    object qryStoneShapesJ_SHAPE: TStringField
      DisplayLabel = 'Shape'
      FieldName = 'J_SHAPE'
      Size = 1
    end
    object qryStoneShapesJ_SHAPE_DESC: TStringField
      DisplayLabel = 'Description'
      FieldName = 'J_SHAPE_DESC'
      Size = 30
    end
  end
  object qryStoneColors: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_STONE_COLORS'
    UpdateOptions.KeyFields = 'J_STONE_COLOR'
    SQL.Strings = (
      'SELECT J_STONE_COLOR, J_STONE_DESC'
      'FROM J_STONE_COLORS'
      'ORDER BY J_STONE_DESC')
    Left = 100
    Top = 72
    object qryStoneColorsJ_STONE_COLOR: TStringField
      DisplayLabel = 'Stone Color'
      FieldName = 'J_STONE_COLOR'
      Size = 1
    end
    object qryStoneColorsJ_STONE_DESC: TStringField
      DisplayLabel = 'Description'
      FieldName = 'J_STONE_DESC'
      Size = 30
    end
  end
end
