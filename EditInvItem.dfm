object frmEditInvItem: TfrmEditInvItem
  Left = 257
  Top = 120
  BorderStyle = bsDialog
  Caption = 'Inventory Item'
  ClientHeight = 491
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 17
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 400
    Width = 423
    Height = 66
    TabOrder = 1
    object btnSave: TRzBitBtn
      Left = 121
      Top = 11
      Width = 113
      Height = 42
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -5
    end
    object btnCancel: TBitBtn
      Left = 246
      Top = 11
      Width = 113
      Height = 42
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
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 423
    Height = 393
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 63
      Width = 80
      Height = 17
      Caption = 'Item Barcode:'
    end
    object Label2: TLabel
      Left = 16
      Top = 110
      Width = 30
      Height = 17
      Caption = 'Type:'
    end
    object Label3: TLabel
      Left = 143
      Top = 109
      Width = 30
      Height = 17
      Caption = 'Style:'
    end
    object Label4: TLabel
      Left = 256
      Top = 110
      Width = 36
      Height = 17
      Caption = 'Metal:'
    end
    object Label7: TLabel
      Left = 16
      Top = 305
      Width = 38
      Height = 17
      Caption = 'Notes:'
    end
    object Label5: TLabel
      Left = 181
      Top = 63
      Width = 40
      Height = 17
      Caption = 'Weight'
      FocusControl = DBEdit4
    end
    object Label6: TLabel
      Left = 245
      Top = 63
      Width = 15
      Height = 17
      Caption = 'KT'
      FocusControl = DBEdit5
    end
    object Label8: TLabel
      Left = 309
      Top = 63
      Width = 66
      Height = 17
      Caption = 'Size Length'
      FocusControl = DBEdit6
    end
    object Label9: TLabel
      Left = 109
      Top = 63
      Width = 51
      Height = 17
      Caption = 'Quantity:'
      FocusControl = edItemCount
    end
    object Label10: TLabel
      Left = 16
      Top = 206
      Width = 56
      Height = 17
      Caption = 'Unit Cost:'
    end
    object Label11: TLabel
      Left = 96
      Top = 206
      Width = 58
      Height = 17
      Caption = 'Unit Price:'
    end
    object Label12: TLabel
      Left = 16
      Top = 16
      Width = 56
      Height = 17
      Caption = 'Category:'
    end
    object lblDescription: TLabel
      Left = 16
      Top = 255
      Width = 69
      Height = 17
      Caption = 'Description:'
      FocusControl = edDescription
    end
    object Label13: TLabel
      Left = 16
      Top = 156
      Width = 34
      Height = 17
      Caption = 'Brand'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 81
      Width = 82
      Height = 25
      TabStop = False
      Color = clBtnFace
      DataField = 'InvItemBarcode'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 1
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 16
      Top = 129
      Width = 112
      Height = 25
      Color = clBtnFace
      DataField = 'JType'
      DataSource = dsInvItems
      KeyField = 'J_TYPE'
      ListField = 'J_TYPE_DESC'
      ListSource = dsTypes
      ReadOnly = True
      TabOrder = 6
      TabStop = False
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 139
      Top = 129
      Width = 112
      Height = 25
      Color = clBtnFace
      DataField = 'JStyle'
      DataSource = dsInvItems
      KeyField = 'J_STYLE'
      ListField = 'J_STYLE_DESC'
      ListSource = dsStyles
      ReadOnly = True
      TabOrder = 7
      TabStop = False
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 262
      Top = 129
      Width = 112
      Height = 25
      Color = clBtnFace
      DataField = 'JMetal'
      DataSource = dsInvItems
      KeyField = 'J_METAL'
      ListField = 'J_METAL_DESC'
      ListSource = dsMetal
      ReadOnly = True
      TabOrder = 8
      TabStop = False
    end
    object DBMemo1: TDBMemo
      Left = 16
      Top = 324
      Width = 345
      Height = 56
      DataField = 'Note'
      DataSource = dsInvItems
      TabOrder = 14
    end
    object DBEdit4: TDBEdit
      Left = 181
      Top = 81
      Width = 57
      Height = 25
      TabStop = False
      Color = clBtnFace
      DataField = 'Weight'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 245
      Top = 81
      Width = 57
      Height = 25
      TabStop = False
      Color = clBtnFace
      DataField = 'KT'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 4
    end
    object DBEdit6: TDBEdit
      Left = 309
      Top = 81
      Width = 65
      Height = 25
      TabStop = False
      Color = clBtnFace
      DataField = 'SizeLength'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 5
    end
    object edItemCount: TDBEdit
      Left = 109
      Top = 81
      Width = 65
      Height = 25
      DataField = 'InvItemCount'
      DataSource = dsInvItems
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 226
      Width = 73
      Height = 25
      TabStop = False
      Color = clBtnFace
      DataField = 'UnitCost'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 9
    end
    object DBEdit3: TDBEdit
      Left = 96
      Top = 226
      Width = 73
      Height = 25
      DataField = 'UnitPrice'
      DataSource = dsInvItems
      TabOrder = 10
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 208
      Top = 163
      Width = 129
      Height = 95
      Caption = 'Status'
      DataField = 'InvItemStatus'
      DataSource = dsInvItems
      Items.Strings = (
        'Pawn'
        'Sale'
        'Scrap'
        'Redeem')
      ReadOnly = True
      TabOrder = 12
      Values.Strings = (
        'P'
        'S'
        'C'
        'R')
    end
    object DBLookupComboBox4: TDBLookupComboBox
      Left = 16
      Top = 35
      Width = 286
      Height = 25
      Color = clBtnFace
      DataField = 'InvCatNo'
      DataSource = dsInvItems
      KeyField = 'INV_CAT_NO'
      ListField = 'INV_CATEGORY'
      ListSource = dsCategories
      ReadOnly = True
      TabOrder = 0
      TabStop = False
    end
    object edDescription: TDBEdit
      Left = 16
      Top = 274
      Width = 345
      Height = 25
      DataField = 'Description'
      DataSource = dsInvItems
      TabOrder = 11
    end
    object cbBrand: TDBComboBox
      Left = 16
      Top = 176
      Width = 154
      Height = 25
      Color = clBtnFace
      DataField = 'InvItemBrand'
      DataSource = dsInvItems
      ReadOnly = True
      TabOrder = 13
      TabStop = False
    end
  end
  object dsTypes: TDataSource
    Left = 474
    Top = 32
  end
  object dsStyles: TDataSource
    Left = 530
    Top = 32
  end
  object dsMetal: TDataSource
    Left = 586
    Top = 32
  end
  object dsInvItems: TDataSource
    Left = 554
    Top = 104
  end
  object dsCategories: TDataSource
    DataSet = qryCategories
    Left = 482
    Top = 152
  end
  object qryCategories: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT INV_CAT_NO, INV_CATEGORY'
      'FROM INV_CATEGORIES'
      'ORDER BY INV_CATEGORY')
    Left = 482
    Top = 104
    object qryCategoriesINV_CAT_NO: TIntegerField
      FieldName = 'INV_CAT_NO'
      Origin = 'INV_CAT_NO'
      Required = True
    end
    object qryCategoriesINV_CATEGORY: TWideStringField
      FieldName = 'INV_CATEGORY'
      Origin = 'INV_CATEGORY'
      Size = 40
    end
  end
  object qryBrands: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT DISTINCT INV_ITEM_BRAND'
      'FROM INVENTORY_ITEMS'
      'WHERE INV_ITEM_BRAND IS NOT NULL'
      'ORDER BY INV_ITEM_BRAND')
    Left = 482
    Top = 208
    object qryBrandsINV_ITEM_BRAND: TWideStringField
      FieldName = 'INV_ITEM_BRAND'
      Origin = 'INV_ITEM_BRAND'
      Size = 30
    end
  end
end
