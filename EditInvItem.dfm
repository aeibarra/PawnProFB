object frmEditInvItem: TfrmEditInvItem
  Left = 257
  Top = 120
  BorderStyle = bsDialog
  Caption = 'Inventory Item'
  ClientHeight = 329
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
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
      NumGlyphs = 2
    end
    object btnSave: TBitBtn
      Left = 198
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Save'
      Default = True
      TabOrder = 0
      OnClick = btnSaveClick
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
      Width = 66
      Height = 13
      Caption = 'Item Barcode:'
    end
    object Label2: TLabel
      Left = 16
      Top = 99
      Width = 27
      Height = 13
      Caption = 'Type:'
    end
    object Label3: TLabel
      Left = 136
      Top = 98
      Width = 26
      Height = 13
      Caption = 'Style:'
    end
    object Label4: TLabel
      Left = 256
      Top = 99
      Width = 29
      Height = 13
      Caption = 'Metal:'
    end
    object Label7: TLabel
      Left = 16
      Top = 227
      Width = 31
      Height = 13
      Caption = 'Notes:'
    end
    object Label5: TLabel
      Left = 168
      Top = 56
      Width = 34
      Height = 13
      Caption = 'Weight'
      FocusControl = DBEdit4
    end
    object Label6: TLabel
      Left = 232
      Top = 56
      Width = 14
      Height = 13
      Caption = 'KT'
      FocusControl = DBEdit5
    end
    object Label8: TLabel
      Left = 296
      Top = 56
      Width = 56
      Height = 13
      Caption = 'Size Length'
      FocusControl = DBEdit6
    end
    object Label9: TLabel
      Left = 96
      Top = 56
      Width = 42
      Height = 13
      Caption = 'Quantity:'
      FocusControl = edItemCount
    end
    object Label10: TLabel
      Left = 16
      Top = 184
      Width = 46
      Height = 13
      Caption = 'Unit Cost:'
    end
    object Label11: TLabel
      Left = 96
      Top = 184
      Width = 49
      Height = 13
      Caption = 'Unit Price:'
    end
    object Label12: TLabel
      Left = 16
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Category:'
    end
    object Label13: TLabel
      Left = 16
      Top = 140
      Width = 28
      Height = 13
      Caption = 'Brand'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 72
      Width = 73
      Height = 21
      DataField = 'InvItemBarcode'
      DataSource = dsInvItems
      TabOrder = 1
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 16
      Top = 113
      Width = 112
      Height = 21
      DataField = 'JType'
      DataSource = dsInvItems
      KeyField = 'JType'
      ListField = 'JTypeDesc'
      ListSource = dsTypes
      TabOrder = 6
    end
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 132
      Top = 113
      Width = 112
      Height = 21
      DataField = 'JStyle'
      DataSource = dsInvItems
      KeyField = 'JStyle'
      ListField = 'JStyleDesc'
      ListSource = dsStyles
      TabOrder = 7
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 249
      Top = 113
      Width = 112
      Height = 21
      DataField = 'JMetal'
      DataSource = dsInvItems
      KeyField = 'JMetal'
      ListField = 'JMetalDesc'
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
      Height = 21
      DataField = 'Weight'
      DataSource = dsInvItems
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 232
      Top = 72
      Width = 57
      Height = 21
      DataField = 'KT'
      DataSource = dsInvItems
      TabOrder = 4
    end
    object DBEdit6: TDBEdit
      Left = 296
      Top = 72
      Width = 65
      Height = 21
      DataField = 'SizeLength'
      DataSource = dsInvItems
      TabOrder = 5
    end
    object edItemCount: TDBEdit
      Left = 96
      Top = 72
      Width = 65
      Height = 21
      DataField = 'InvItemCount'
      DataSource = dsInvItems
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 200
      Width = 73
      Height = 21
      DataField = 'UnitCost'
      DataSource = dsInvItems
      TabOrder = 9
    end
    object DBEdit3: TDBEdit
      Left = 96
      Top = 200
      Width = 73
      Height = 21
      DataField = 'UnitPrice'
      DataSource = dsInvItems
      TabOrder = 10
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 208
      Top = 144
      Width = 129
      Height = 91
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
      Height = 21
      DataField = 'InvCatNo'
      DataSource = dsInvItems
      KeyField = 'InvCatNo'
      ListField = 'InvCategory'
      ListSource = dsCategories
      TabOrder = 0
    end
    object cbBrand: TDBComboBox
      Left = 16
      Top = 154
      Width = 154
      Height = 21
      DataField = 'InvItemBrand'
      DataSource = dsInvItems
      ItemHeight = 13
      TabOrder = 13
    end
  end
  object dsTypes: TDataSource
    DataSet = qryTypes
    Left = 392
    Top = 64
  end
  object dsStyles: TDataSource
    DataSet = qryStyles
    Left = 448
    Top = 64
  end
  object dsMetal: TDataSource
    DataSet = qryMetal
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
  object qryMetal: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JMetal, JMetalDesc'
      'FROM JMetals')
    Left = 504
    Top = 16
    object qryMetalJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryMetalJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object qryCategories: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM InvCategories'
      'ORDER BY InvCategory')
    Left = 400
    Top = 136
    object qryCategoriesInvCatNo: TAutoIncField
      FieldName = 'InvCatNo'
      ReadOnly = True
    end
    object qryCategoriesInvCategory: TStringField
      FieldName = 'InvCategory'
      Size = 40
    end
  end
  object qryStyles: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JStyle, JStyleDesc'
      'FROM JStyles')
    Left = 448
    Top = 16
    object qryStylesJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryStylesJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
  end
  object qryTypes: TADOQuery
    Connection = DM.ConnDB
    Parameters = <>
    SQL.Strings = (
      'SELECT JType,  JTypeDesc'
      'FROM JTypes')
    Left = 392
    Top = 16
    object qryTypesJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryTypesJTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
  end
  object qryBrands: TADODataSet
    Connection = DM.ConnDB
    CommandText = 
      'select distinct InvItemBrand'#13#10'from InventoryItems'#13#10'order by InvI' +
      'temBrand'
    Parameters = <>
    Left = 400
    Top = 240
    object qryBrandsInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
  end
end
