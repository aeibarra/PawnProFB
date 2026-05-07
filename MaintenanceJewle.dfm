object frmMaintenanceJ: TfrmMaintenanceJ
  Left = 398
  Top = 131
  BorderStyle = bsDialog
  Caption = 'Maintenance'
  ClientHeight = 482
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 20
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 407
    Width = 493
    Height = 72
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 291
    DesignSize = (
      493
      72)
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
      Left = 391
      Top = 14
      Width = 89
      Height = 45
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object btnDelete: TBitBtn
      Left = 243
      Top = 15
      Width = 96
      Height = 45
      Caption = 'Delete'
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
      Spacing = 8
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 493
    Height = 398
    Align = alClient
    DataSource = dsMaintenace
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object dsMaintenace: TDataSource
    OnDataChange = dsMaintenaceDataChange
    Left = 67
    Top = 115
  end
  object qryTypes: TFDQuery
    OnNewRecord = qryNewRecord
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_TYPES'
    UpdateOptions.KeyFields = 'J_TYPE'
    SQL.Strings = (
      'SELECT J_TYPE, J_TYPE_DESC, CUST_FIELD'
      'FROM J_TYPES'
      'ORDER BY J_TYPE_DESC')
    Left = 44
    Top = 52
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
    object qryTypesCUST_FIELD: TBooleanField
      FieldName = 'CUST_FIELD'
      Origin = 'CUST_FIELD'
      Visible = False
    end
  end
  object qryStyles: TFDQuery
    OnNewRecord = qryNewRecord
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_STYLES'
    UpdateOptions.KeyFields = 'J_STYLE'
    SQL.Strings = (
      'SELECT J_STYLE, J_STYLE_DESC, CUST_FIELD'
      'FROM J_STYLES'
      'ORDER BY J_STYLE_DESC')
    Left = 118
    Top = 52
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
    object qryStylesCUST_FIELD: TBooleanField
      FieldName = 'CUST_FIELD'
      Origin = 'CUST_FIELD'
      Visible = False
    end
  end
  object qryMetal: TFDQuery
    OnNewRecord = qryNewRecord
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_METALS'
    UpdateOptions.KeyFields = 'J_METAL'
    SQL.Strings = (
      'SELECT J_METAL, J_METAL_DESC, CUST_FIELD'
      'FROM J_METALS'
      'ORDER BY J_METAL_DESC')
    Left = 189
    Top = 52
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
    object qryMetalCUST_FIELD: TBooleanField
      FieldName = 'CUST_FIELD'
      Origin = 'CUST_FIELD'
      Visible = False
    end
  end
  object qryStoneShapes: TFDQuery
    OnNewRecord = qryNewRecord
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_STONE_SHAPES'
    UpdateOptions.KeyFields = 'J_SHAPE'
    SQL.Strings = (
      'SELECT J_SHAPE, J_SHAPE_DESC, CUST_FIELD'
      'FROM J_STONE_SHAPES'
      'ORDER BY J_SHAPE_DESC')
    Left = 274
    Top = 52
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
    object qryStoneShapesCUST_FIELD: TBooleanField
      FieldName = 'CUST_FIELD'
      Origin = 'CUST_FIELD'
      Visible = False
    end
  end
  object qryStoneColors: TFDQuery
    OnNewRecord = qryNewRecord
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'J_STONE_COLORS'
    UpdateOptions.KeyFields = 'J_STONE_COLOR'
    SQL.Strings = (
      'SELECT J_STONE_COLOR, J_STONE_DESC, CUST_FIELD'
      'FROM J_STONE_COLORS'
      'ORDER BY J_STONE_DESC')
    Left = 376
    Top = 53
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
    object qryStoneColorsCUST_FIELD: TBooleanField
      FieldName = 'CUST_FIELD'
      Origin = 'CUST_FIELD'
      Visible = False
    end
  end
end
