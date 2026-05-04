object frmEnterPawnStoneInfo: TfrmEnterPawnStoneInfo
  Left = 499
  Top = 97
  BorderStyle = bsDialog
  Caption = 'Pawn Stone Information'
  ClientHeight = 252
  ClientWidth = 957
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 21
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 4
    Width = 505
    Height = 152
    TabOrder = 0
    object Label5: TLabel
      Left = 22
      Top = 80
      Width = 99
      Height = 21
      Caption = 'Stone Shape:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 176
      Top = 80
      Width = 94
      Height = 21
      Caption = 'Stone Color:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 22
      Top = 17
      Width = 138
      Height = 21
      Caption = 'Number of Stones'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 176
      Top = 17
      Width = 23
      Height = 21
      Caption = 'CT:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 264
      Top = 17
      Width = 29
      Height = 21
      Caption = 'WT:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 316
      Top = 80
      Width = 78
      Height = 21
      Caption = 'Stone Type:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 362
      Top = 17
      Width = 93
      Height = 21
      Caption = 'Weight Unit'
      FocusControl = cbWeightUnit
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lkStoneShape: TDBLookupComboBox
      Left = 22
      Top = 104
      Width = 138
      Height = 29
      DataField = 'STONE_SHAPE'
      DataSource = frmEnterItems.dsStones
      KeyField = 'J_SHAPE'
      ListField = 'J_SHAPE_DESC'
      ListSource = dsStoneShapes
      TabOrder = 4
    end
    object lkStoneColor: TDBLookupComboBox
      Left = 176
      Top = 104
      Width = 127
      Height = 29
      DataField = 'STONE_COLOR'
      DataSource = frmEnterItems.dsStones
      KeyField = 'J_STONE_COLOR'
      ListField = 'J_STONE_DESC'
      ListSource = dsStoneColors
      TabOrder = 5
    end
    object edStoneNumber: TDBEdit
      Left = 22
      Top = 40
      Width = 138
      Height = 29
      DataField = 'STONE_NUMBER'
      DataSource = frmEnterItems.dsStones
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 176
      Top = 40
      Width = 72
      Height = 29
      DataField = 'CT'
      DataSource = frmEnterItems.dsStones
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 262
      Top = 40
      Width = 88
      Height = 29
      DataField = 'WT'
      DataSource = frmEnterItems.dsStones
      TabOrder = 2
    end
    object cbStoneType: TDBComboBox
      Left = 316
      Top = 104
      Width = 167
      Height = 29
      DataField = 'STONE_TYPE'
      DataSource = frmEnterItems.dsStones
      TabOrder = 6
    end
    object cbWeightUnit: TDBLookupComboBox
      Left = 362
      Top = 40
      Width = 121
      Height = 29
      DataField = 'STONE_WEIGHT_UNIT'
      DataSource = frmEnterItems.dsStones
      KeyField = 'WeigthUnitValue'
      ListField = 'WeightUnit'
      ListSource = dsWeigthUnits
      TabOrder = 3
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 161
    Width = 505
    Height = 77
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 269
      Top = 12
      Width = 106
      Height = 51
      Cancel = True
      Caption = '  &Cancel'
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
      Left = 138
      Top = 12
      Width = 106
      Height = 51
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Spacing = 0
    end
  end
  object dsStoneShapes: TDataSource
    Left = 731
    Top = 87
  end
  object qryStoneTypes: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT DISTINCT STONE_TYPE'
      'FROM STONES'
      'WHERE STONE_TYPE IS NOT NULL'
      'ORDER BY STONE_TYPE')
    Left = 522
    Top = 100
    object qryStoneTypesSTONE_TYPE: TStringField
      FieldName = 'STONE_TYPE'
      Origin = 'STONE_TYPE'
      Size = 30
    end
  end
  object dsStoneColors: TDataSource
    Left = 819
    Top = 87
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
    Left = 631
    Top = 33
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
    Left = 631
    Top = 87
  end
end
