object frmEditInvItem: TfrmEditInvItem
  Left = 257
  Top = 120
  BorderStyle = bsDialog
  Caption = 'Inventory Item'
  ClientHeight = 329
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 291
    Width = 553
    Height = 38
    Align = alBottom
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 281
      Top = 9
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TBitBtn
      Left = 198
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Save'
      Default = True
      Glyph.Data = {
        B6010000424DB60100000000000076000000280000001E000000140000000100
        0400000000004001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777770077777777777777777777777777777700778888888888
        888888777887777777007C0008888888000008779087777777007C444FFFFFFF
        444408791087777777007C444F08FFFF444408911088888887007C444F08FFFF
        444409111000000087007C444F08FFFF444491111111111087007C444FFFFFFF
        444911111111111087007C4444444444449111111111111087007C4444444444
        449911111111111087007C4444444444444991111111111087007C44FFFFFFFF
        F44499111111111077007C44FFFFFFFFF44409911099999977007C44F0000F00
        F44408991077777777007C44FFFFFFFFF44408799077777777007C44F00F0000
        F44408779977777777007CCC888888888CCCC777777777777700777777777777
        7777777777777777770077777777777777777777777777777700}
      TabOrder = 0
      OnClick = btnSaveClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 553
    Height = 291
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 73
      Height = 15
      Caption = 'Item Barcode:'
    end
    object Label2: TLabel
      Left = 16
      Top = 99
      Width = 28
      Height = 15
      Caption = 'Type:'
    end
    object Label3: TLabel
      Left = 136
      Top = 98
      Width = 28
      Height = 15
      Caption = 'Style:'
    end
    object Label4: TLabel
      Left = 256
      Top = 99
      Width = 33
      Height = 15
      Caption = 'Metal:'
    end
    object Label7: TLabel
      Left = 16
      Top = 227
      Width = 34
      Height = 15
      Caption = 'Notes:'
    end
    object Label5: TLabel
      Left = 168
      Top = 56
      Width = 38
      Height = 15
      Caption = 'Weight'
      FocusControl = DBEdit4
    end
    object Label6: TLabel
      Left = 232
      Top = 56
      Width = 14
      Height = 15
      Caption = 'KT'
      FocusControl = DBEdit5
    end
    object Label8: TLabel
      Left = 296
      Top = 56
      Width = 60
      Height = 15
      Caption = 'Size Length'
      FocusControl = DBEdit6
    end
    object Label9: TLabel
      Left = 96
      Top = 56
      Width = 49
      Height = 15
      Caption = 'Quantity:'
      FocusControl = edItemCount
    end
    object Label10: TLabel
      Left = 16
      Top = 184
      Width = 52
      Height = 15
      Caption = 'Unit Cost:'
    end
    object Label11: TLabel
      Left = 96
      Top = 184
      Width = 54
      Height = 15
      Caption = 'Unit Price:'
    end
    object Label12: TLabel
      Left = 16
      Top = 16
      Width = 51
      Height = 15
      Caption = 'Category:'
    end
    object Label13: TLabel
      Left = 16
      Top = 140
      Width = 31
      Height = 15
      Caption = 'Brand'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 72
      Width = 73
      Height = 23
      DataField = 'InvItemBarcode'
      DataSource = dsInvItems
      TabOrder = 1
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 16
      Top = 113
      Width = 112
      Height = 23
      DataField = 'JType'
      DataSource = dsInvItems
      KeyField = 'J_TYPE'
      ListField = 'J_TYPE_DESC'
      ListSource = dsTypes
      TabOrder = 6
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 132
      Top = 113
      Width = 112
      Height = 23
      DataField = 'JStyle'
      DataSource = dsInvItems
      KeyField = 'J_STYLE'
      ListField = 'J_STYLE_DESC'
      ListSource = dsStyles
      TabOrder = 7
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 249
      Top = 113
      Width = 112
      Height = 23
      DataField = 'JMetal'
      DataSource = dsInvItems
      KeyField = 'J_METAL'
      ListField = 'J_METAL_DESC'
      ListSource = dsMetal
      TabOrder = 8
    end
    object DBMemo1: TDBMemo
      Left = 16
      Top = 241
      Width = 345
      Height = 47
      DataField = 'Note'
      DataSource = dsInvItems
      TabOrder = 11
    end
    object DBEdit4: TDBEdit
      Left = 168
      Top = 72
      Width = 57
      Height = 23
      DataField = 'Weight'
      DataSource = dsInvItems
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 232
      Top = 72
      Width = 57
      Height = 23
      DataField = 'KT'
      DataSource = dsInvItems
      TabOrder = 4
    end
    object DBEdit6: TDBEdit
      Left = 296
      Top = 72
      Width = 65
      Height = 23
      DataField = 'SizeLength'
      DataSource = dsInvItems
      TabOrder = 5
    end
    object edItemCount: TDBEdit
      Left = 96
      Top = 72
      Width = 65
      Height = 23
      DataField = 'InvItemCount'
      DataSource = dsInvItems
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 200
      Width = 73
      Height = 23
      DataField = 'UnitCost'
      DataSource = dsInvItems
      TabOrder = 9
    end
    object DBEdit3: TDBEdit
      Left = 96
      Top = 200
      Width = 73
      Height = 23
      DataField = 'UnitPrice'
      DataSource = dsInvItems
      TabOrder = 10
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 208
      Top = 141
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
      TabOrder = 12
      Values.Strings = (
        'P'
        'S'
        'C'
        'R')
    end
    object DBLookupComboBox4: TDBLookupComboBox
      Left = 16
      Top = 32
      Width = 145
      Height = 23
      DataField = 'InvCatNo'
      DataSource = dsInvItems
      KeyField = 'INV_CAT_NO'
      ListField = 'INV_CATEGORY'
      ListSource = dsCategories
      TabOrder = 0
    end
    object cbBrand: TDBComboBox
      Left = 16
      Top = 154
      Width = 154
      Height = 23
      DataField = 'InvItemBrand'
      DataSource = dsInvItems
      TabOrder = 13
    end
  end
  object dsTypes: TDataSource
    Left = 392
    Top = 64
  end
  object dsStyles: TDataSource
    Left = 448
    Top = 64
  end
  object dsMetal: TDataSource
    Left = 504
    Top = 64
  end
  object dsInvItems: TDataSource
    DataSet = frmClients.qryInvItems
    Left = 472
    Top = 136
  end
  object dsCategories: TDataSource
    DataSet = qryCategories
    Left = 400
    Top = 184
  end
  object qryCategories: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT INV_CAT_NO, INV_CATEGORY'
      'FROM INV_CATEGORIES'
      'ORDER BY INV_CATEGORY')
    Left = 400
    Top = 136
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
  object qryBrands: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT DISTINCT INV_ITEM_BRAND'
      'FROM INVENTORY_ITEMS'
      'WHERE INV_ITEM_BRAND IS NOT NULL'
      'ORDER BY INV_ITEM_BRAND')
    Left = 400
    Top = 240
    object qryBrandsINV_ITEM_BRAND: TStringField
      FieldName = 'INV_ITEM_BRAND'
      Origin = 'INV_ITEM_BRAND'
      Size = 30
    end
  end
end
