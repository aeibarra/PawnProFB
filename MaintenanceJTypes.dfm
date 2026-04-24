object frmMaintenanceJType: TfrmMaintenanceJType
  Left = 497
  Top = 158
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  ClientHeight = 255
  ClientWidth = 286
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 286
    Height = 217
    Align = alClient
    DataSource = dsMaintenance
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 217
    Width = 286
    Height = 38
    Align = alBottom
    TabOrder = 1
    object btnAddCat: TBitBtn
      Left = 7
      Top = 11
      Width = 71
      Height = 23
      Caption = 'Add'
      TabOrder = 0
      OnClick = btnAddCatClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
    end
    object btnEditCat: TBitBtn
      Left = 82
      Top = 11
      Width = 71
      Height = 23
      Caption = 'Edit'
      TabOrder = 1
      OnClick = btnEditCatClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object btnClose: TBitBtn
      Left = 208
      Top = 11
      Width = 67
      Height = 23
      Cancel = True
      Caption = '&Close'
      TabOrder = 2
      OnClick = btnCloseClick
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777077
        777777000000777777777E07777777000000777777777E607777770000007777
        77777E66077777000000000000777E66600000000000777770888E6666077700
        0000777770888E60660777000000777770888E60660777000000777710888E60
        660777000000777791888E60660777000000111199188E666607770000009999
        99918E66660777000000999999988E66660777000000777799888E6666077700
        00007777908888E666077700000077777088888E660777000000777770888888
        E607770000007777700000000E0777000000}
    end
  end
  object qryBrands: TADODataSet
    Connection = DM.ConnDB
    CommandText = 'select  BrandNo, BrandName'#13#10'from Brands'#13#10'order by BrandName'
    Parameters = <>
    Left = 24
    Top = 16
    object qryBrandsBrandNo: TAutoIncField
      DisplayLabel = 'No'
      FieldName = 'BrandNo'
      ReadOnly = True
      Visible = False
    end
    object qryBrandsBrandName: TStringField
      DisplayLabel = 'Brand'
      DisplayWidth = 50
      FieldName = 'BrandName'
      Size = 30
    end
  end
  object dsMaintenance: TDataSource
    Left = 32
    Top = 96
  end
  object qryStoneTypes: TADODataSet
    Connection = DM.ConnDB
    CommandText = 
      'select  StoneTypeNo, StoneTypeDesc'#13#10'from StoneTypes'#13#10'order by St' +
      'oneTypeDesc'
    Parameters = <>
    Left = 136
    Top = 16
    object qryStoneTypesStoneTypeNo: TAutoIncField
      DisplayLabel = 'No'
      FieldName = 'StoneTypeNo'
      ReadOnly = True
      Visible = False
    end
    object qryStoneTypesStoneTypeDesc: TStringField
      DisplayLabel = 'Stone Type'
      DisplayWidth = 50
      FieldName = 'StoneTypeDesc'
      Size = 30
    end
  end
end
