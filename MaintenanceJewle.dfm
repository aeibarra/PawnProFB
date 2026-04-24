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
    Left = 295
    Top = 115
  end
  object qryTypes: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT JType,  JTypeDesc'
      'FROM JTypes')
    Left = 100
    Top = 16
    object qryTypesJType: TStringField
      DisplayLabel = 'Type'
      FieldName = 'JType'
      Size = 1
    end
    object qryTypesJTypeDesc: TStringField
      DisplayLabel = 'Description'
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
    Left = 156
    Top = 16
    object qryStylesJStyle: TStringField
      DisplayLabel = 'Style'
      FieldName = 'JStyle'
      Size = 1
    end
    object qryStylesJStyleDesc: TStringField
      DisplayLabel = 'Description'
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
    Left = 212
    Top = 16
    object qryMetalJMetal: TStringField
      DisplayLabel = 'Metal'
      FieldName = 'JMetal'
      Size = 1
    end
    object qryMetalJMetalDesc: TStringField
      DisplayLabel = 'Description'
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object qryStoneShapes: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JShape, JShapeDesc'
      'FROM JStoneShapes')
    Left = 284
    Top = 16
    object qryStoneShapesJShape: TStringField
      DisplayLabel = 'Shape'
      FieldName = 'JShape'
      Size = 1
    end
    object qryStoneShapesJShapeDesc: TStringField
      DisplayLabel = 'Description'
      FieldName = 'JShapeDesc'
      Size = 30
    end
  end
  object qryStoneColors: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JStoneColor, JStoneDesc'
      'FROM JStoneColors')
    Left = 100
    Top = 72
    object qryStoneColorsJStoneColor: TStringField
      DisplayLabel = 'Stone Color'
      FieldName = 'JStoneColor'
      Size = 1
    end
    object qryStoneColorsJStoneDesc: TStringField
      DisplayLabel = 'Description'
      FieldName = 'JStoneDesc'
      Size = 30
    end
  end
end
