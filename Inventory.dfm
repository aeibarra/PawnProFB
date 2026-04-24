object frmInventory: TfrmInventory
  Left = 350
  Top = 116
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Inventory'
  ClientHeight = 720
  ClientWidth = 1359
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 17
  object Splitter1: TSplitter
    Left = 193
    Top = 0
    Width = 8
    Height = 653
    Beveled = True
    Visible = False
    ExplicitLeft = 187
    ExplicitHeight = 417
  end
  object gbBottom: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 656
    Width = 1353
    Height = 61
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1353
      61)
    object SpeedButton1: TSpeedButton
      Left = 32
      Top = 24
      Width = 23
      Height = 22
      Caption = '...'
      Visible = False
      OnClick = SpeedButton1Click
    end
    object btnClose: TBitBtn
      Left = 1237
      Top = 11
      Width = 100
      Height = 41
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object Panel1: TPanel
    Left = 201
    Top = 0
    Width = 1158
    Height = 653
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnTop: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1152
      Height = 65
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 15
        Top = 6
        Width = 335
        Height = 56
        Caption = 'Item Status'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object chkSale: TCheckBox
          Left = 22
          Top = 26
          Width = 81
          Height = 17
          Caption = ' For Sale'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = chkSaleClick
        end
        object chkPawn: TCheckBox
          Left = 113
          Top = 26
          Width = 79
          Height = 17
          Caption = ' Pawned'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = chkSaleClick
        end
        object CheckBox1: TCheckBox
          Left = 208
          Top = 26
          Width = 79
          Height = 17
          Caption = 'Layaway'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkSaleClick
        end
      end
      object btnSearch: TRzBitBtn
        Left = 368
        Top = 19
        Width = 105
        Height = 39
        Default = True
        Caption = '&Search'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnSearchClick
        ImageIndex = 5
        Images = DM.vilMain24
        Margin = 5
        Spacing = -10
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 71
      Width = 1158
      Height = 437
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel5'
      TabOrder = 1
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1152
        Height = 385
        Align = alClient
        DataSource = dsInvItems
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = btnEditItemClick
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'InvItemBarcode'
            Title.Alignment = taCenter
            Title.Caption = 'Barcode'
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'InvItemCount'
            Title.Caption = 'Quantity'
            Width = 51
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Description'
            Width = 231
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Weight'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TotalWeight'
            Title.Caption = 'Total Weight'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SizeLength'
            Title.Caption = 'Length'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JStyleDesc'
            Title.Caption = 'Style'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JTypeDesc'
            Title.Caption = 'Type'
            Width = 84
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JMetalDesc'
            Title.Caption = 'Metal'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'StatusDesc'
            Title.Caption = 'Status'
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Note'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Created'
            Visible = True
          end>
      end
      object Panel7: TPanel
        Left = 0
        Top = 391
        Width = 1158
        Height = 46
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          1158
          46)
        object lblTotals: TLabel
          Left = 23
          Top = 15
          Width = 77
          Height = 17
          Caption = 'Total Items: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnAddItem: TBitBtn
          Left = 393
          Top = 21
          Width = 75
          Height = 23
          Caption = 'Add'
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
          TabOrder = 1
          Visible = False
          OnClick = btnAddItemClick
        end
        object btnEditItem: TBitBtn
          Left = 511
          Top = 17
          Width = 75
          Height = 23
          Caption = 'Edit'
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
          TabOrder = 2
          Visible = False
          OnClick = btnEditItemClick
        end
        object btnPrintLabel: TRzBitBtn
          Left = 818
          Top = 4
          Width = 145
          Height = 40
          Anchors = [akTop, akRight]
          Caption = 'Print Labels'
          TabOrder = 0
          OnClick = btnPrintLabelClick
          ImageIndex = 0
          Images = DM.vilMain24
          Margin = 10
          Spacing = 0
        end
        object btnPrintOneLabel: TRzBitBtn
          Left = 999
          Top = 4
          Width = 145
          Height = 40
          Anchors = [akTop, akRight]
          Caption = 'Print One Label'
          TabOrder = 3
          OnClick = btnPrintOneLabelClick
          ImageIndex = 0
          Images = DM.vilMain24
          Margin = 10
          Spacing = -2
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 508
      Width = 1158
      Height = 145
      Align = alBottom
      Caption = 'Stones'
      TabOrder = 2
      object Panel9: TPanel
        Left = 2
        Top = 117
        Width = 1154
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
        object btnAddStone: TBitBtn
          Left = 8
          Top = 1
          Width = 75
          Height = 23
          Caption = 'Add'
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
          TabOrder = 0
          OnClick = btnAddStoneClick
        end
        object btnEditStone: TBitBtn
          Left = 88
          Top = 1
          Width = 75
          Height = 23
          Caption = 'Edit'
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
          TabOrder = 1
          OnClick = btnEditStoneClick
        end
        object BitBtn2: TBitBtn
          Left = 200
          Top = 2
          Width = 75
          Height = 23
          Caption = 'Remove'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
            305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
            005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
            B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
            B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
            B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
            B0557777FF577777F7F500000E055550805577777F7555575755500000555555
            05555777775555557F5555000555555505555577755555557555}
          NumGlyphs = 2
          TabOrder = 2
        end
      end
      object DBGrid2: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 22
        Width = 1148
        Height = 92
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = btnEditStoneClick
        Columns = <
          item
            Expanded = False
            FieldName = 'StoneNumber'
            Title.Caption = 'Stone Number'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cShape'
            Title.Caption = 'Shape'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cColor'
            Title.Caption = 'Color'
            Width = 58
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CT'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'WT'
            Visible = True
          end>
      end
    end
  end
  object pnCategories: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 187
    Height = 647
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object Panel4: TPanel
      Left = 0
      Top = 619
      Width = 187
      Height = 28
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object btnAddCat: TBitBtn
        Left = 14
        Top = 5
        Width = 75
        Height = 23
        Caption = 'Add'
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
        TabOrder = 0
        OnClick = btnAddCatClick
      end
      object btnEditCat: TBitBtn
        Left = 94
        Top = 5
        Width = 75
        Height = 23
        Caption = 'Edit'
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
        TabOrder = 1
        OnClick = btnEditCatClick
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 187
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Item Categories'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object chkTree: TRzCheckTree
      AlignWithMargins = True
      Left = 3
      Top = 29
      Width = 181
      Height = 587
      Align = alClient
      Indent = 19
      SelectionPen.Color = clBtnShadow
      StateImages = chkTree.CheckImages
      TabOrder = 2
    end
  end
  object dsCategories: TDataSource
    DataSet = qryCategories
    Left = 48
    Top = 152
  end
  object dsInvItems: TDataSource
    DataSet = qryInvItems
    Left = 259
    Top = 184
  end
  object qryCategories: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select null as C, 0 as InvCatNo, '#39'Categories'#39' as InvCategory'
      'union'
      'SELECT 0, *'
      'FROM InvCategories'
      'ORDER BY 1, 2')
    Left = 48
    Top = 95
    object qryCategoriesC: TSmallintField
      FieldName = 'C'
      ReadOnly = True
    end
    object qryCategoriesInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
      ReadOnly = True
    end
    object qryCategoriesInvCategory: TStringField
      FieldName = 'InvCategory'
      ReadOnly = True
      Size = 40
    end
  end
  object qryInvItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Filtered = True
    OnCalcFields = qryInvItemsCalcFields
    OnFilterRecord = qryInvItemsFilterRecord
    OnNewRecord = qryInvItemsNewRecord
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '    ii.InvItemNo,'
      '    ii.InvItemBarcode,'
      '    ii.InvCatNo,'
      '    ii.JType,'
      '    ii.JStyle,'
      '    ii.JMetal,'
      '    ii.InvItemCount,'
      '    ii.Note,'
      '    ii.SizeLength,'
      '    ii.Weight,'
      '    ii.KT,'
      '    ii.Created,'
      '    ii.UnitCost,'
      '    ii.UnitPrice,'
      '    ii.InvItemStatus,'
      '    ii.TransactionNo,'
      '    ii.InvOriginalItemNo,'
      '    ii.InvItemBrand,'
      '    ii.OwnerAppNumber,'
      '    ii.ModelNumber,'
      '    ii.SerialNumber,'
      '    ii.Gender,'
      '    ii.Description,'
      '    (ii.InvItemCount * IsNull(ii.Weight, 0)) as TotalWeight,'
      '    jt.JTypeDesc,'
      '    js.JStyleDesc,'
      '    jm.JMetalDesc,'
      '    ist.StatusDesc'
      'FROM InventoryItems ii'
      'LEFT JOIN JTypes jt ON ii.JType = jt.JType'
      'LEFT JOIN JStyles js ON ii.JStyle = js.JStyle'
      'LEFT JOIN JMetals jm ON ii.JMetal = jm.JMetal'
      'LEFT JOIN ItemStatus ist ON ii.InvItemStatus = ist.Status'
      ' --<PARAMS>'
      '')
    Left = 259
    Top = 119
    object qryInvItemsInvItemNo: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'InvItemNo'
    end
    object qryInvItemsInvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryInvItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object qryInvItemsJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryInvItemsJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryInvItemsJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryInvItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryInvItemsNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryInvItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryInvItemsWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryInvItemsKT: TFloatField
      FieldName = 'KT'
    end
    object qryInvItemsCreated: TDateTimeField
      FieldName = 'Created'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object qryInvItemsUnitCost: TBCDField
      FieldName = 'UnitCost'
      currency = True
      Precision = 19
    end
    object qryInvItemsUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      currency = True
      Precision = 19
    end
    object qryInvItemsInvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryInvItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryInvItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object qryInvItemsInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryInvItemsOwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryInvItemsModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryInvItemsSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryInvItemsGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryInvItemsDescription: TStringField
      FieldName = 'Description'
      Size = 120
    end
    object qryInvItemsJTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object qryInvItemsJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryInvItemsJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
    object qryInvItemsStatusDesc: TStringField
      FieldName = 'StatusDesc'
      Size = 30
    end
    object qryInvItemsTotalWeight: TFloatField
      FieldName = 'TotalWeight'
    end
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 908
    Top = 29
  end
end
