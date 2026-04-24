object frmChangePawnItemsStatus: TfrmChangePawnItemsStatus
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Change Pawn & Item Status'
  ClientHeight = 604
  ClientWidth = 1161
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 541
    Width = 1155
    Height = 60
    Align = alBottom
    TabOrder = 2
    ExplicitWidth = 1024
    DesignSize = (
      1155
      60)
    object btnExit: TBitBtn
      Left = 1047
      Top = 11
      Width = 98
      Height = 41
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFAFAFAC8C8C8A2A2A29E9E9E194788205BACA2B8D6FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDEDEDEBCBCBCB4B4B4B0B0B0ADADAD184583215DB02059AAA8BD
        DAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFF5F5F5D5D5D5CBCBCBC7C7C7C3C3C3C0C0C0BCBCBC184380
        225EB1215DB02B62AECFDAE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFEFEFEF1F1F1E4E4E4DFDFDFDBDBDBD7D7D7D3D3D3D0
        D0D0CCCCCC19437D2460B2215DB0215DB02D62ADD4DFEDFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF225FB2F8F8F8ECECECE2E2E2DADA
        DAD2D2D2CBCBCBC4C4C4BDBDBD19427C2762B3215EB1215EB1215EB125579E22
        5FB2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2461B4F9F9F9
        EFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CBCBCBC5C5C51B437B2A67B72462B52462
        B52462B51C4E982461B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00730085
        CE852158A3F9F9F9EFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CBCBCBC5C5C51C447B
        2E6CBB2666B92666B92666B91D519B2664B7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF007300009900127755E8E9EAEFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CB
        CBCBC5C5C51B41763271C0296ABD296ABD296ABD1F549E2766B9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF00730066C76B00990078C37AEFEFEFE6E6E6DFDF
        DFD8D8D8D1D1D1CBCBCBC5C5C54659733676C42B6EC12B6EC12B6EC12158A154
        739C00730000730000730000730000730000730000730062C5665DC362009900
        7CC57CE6E6E6DFDFDFD8D8D8D1D1D1CBCBCBC5C5C55865772F5D984A6D982D71
        C42D71C4225AA47F7E7E00730077D07E73CE796FCB746AC97066C76B62C5665D
        C36242B84652BD5500990078C278DFDFDFD8D8D8D1D1D1CBCBCBC5C5C5768494
        427CC15D738E2F74C82F74C8245DA72B6CC000730073CE7953C25A45BC4C40B9
        463BB64035B43A2FB1342AAE2E2DAF3049B94C00990074BE74D8D8D8D1D1D1CB
        CBCBC5C5C54161894182CF3177CB3177CB3177CB265FAA2C6EC10073006FCB74
        4EBF5540B9463BB64035B43A2FB1342AAE2E25AC2830AF335EC16080CD810099
        0070B970D1D1D1CBCBCBC5C5C5234B7F4486D2337ACD337ACD337ACD2761AC2D
        6FC300730072CC776DCA725DC36154BF5950BE554EBC514EBB5155BD5764C366
        7CCC7D00990074BE74D8D8D8D1D1D1CBCBCBC5C5C5244C80478AD5347CD0347C
        D0347CD02863AE2E71C50073006FCA7386D28983D18782D08580CF837FCE827E
        CD806CC66D7BCC7D00990078C278DFDFDFD8D8D8D1D1D1CBCBCBC5C5C5254D81
        4A8DD7367ED2367ED2367ED22964B02F72C60073000099000099000099000099
        000099000099007FCD807ECC7F0099007CC57CE6E6E6DFDFDFD8D8D8D1D1D1CB
        CBCBC5C5C5264E824D90DA3780D43780D43780D42A66B22F73C7FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0073007FCD7F00990082CB82EFEFEFE6E6E6DFDF
        DFD8D8D8D1D1D1CBCBCBC5C5C5274F825093DC3882D63882D63882D62B68B330
        74C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0073000099001A8769F9F9F9
        EFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CBCBCBC5C5C529528577B1E83984D73984
        D73984D72C69B4587AA3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00730085
        CE853176CAF9F9F9EFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CBCBCBC5C5C5639BD1
        5FA0E06CA9E63F88DA3A85D92C6AB67F7E7EFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF3176CAF9F9F9EFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CB
        CBCBC5C5C5BEBEBE749FC95195D873AEE73E88DA2C6BB73176CAFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3277CBF9F9F9EFEFEFE6E6E6DFDF
        DFD8D8D8D1D1D1CBCBCBC5C5C5BEBEBEB8B8B88BA5BD4D91D264A4E23674BC32
        77CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3277CBF9F9F9
        EFEFEFE6E6E6DFDFDFD8D8D8D1D1D1CBCBCBC5C5C5BEBEBEB8B8B8B2B2B29AA6
        B2528EC74B8BCC3277CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF3277CB3277CB3277CB3277CB3277CB3277CB3277CB3277CB3277CB3277CB
        3277CB3277CB3277CB3277CB3277CB3277CBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ModalResult = 2
      TabOrder = 0
      OnClick = btnExitClick
      ExplicitLeft = 916
    end
    object btnSave: TRzBitBtn
      Left = 29
      Top = 11
      Width = 98
      Height = 41
      Caption = '&Save'
      TabOrder = 1
      OnClick = btnSaveClick
      ImageIndex = 5
      Images = DM.ImageListBtn
      Margin = 10
      Spacing = -5
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 87
    Width = 1155
    Height = 448
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 1024
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 394
      Width = 1145
      Height = 49
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 1014
      object Label4: TLabel
        Left = 24
        Top = 17
        Width = 224
        Height = 20
        Caption = 'Change Selected Items Status to: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbItemStatusToSet: TRzComboBox
        Left = 255
        Top = 14
        Width = 145
        Height = 28
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object dbGridItems: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 1145
      Height = 363
      Align = alClient
      DataSource = frmClients.dsInvItems
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = dbGridItemsCellClick
      OnDrawColumnCell = dbGridItemsDrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'X'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 27
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'InvItemBarcode'
          Title.Caption = 'Barcode'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'InvItemCount'
          Title.Caption = 'Quantity'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UnitCost'
          Title.Caption = 'Cost'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Weight'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cTotalWeight'
          Title.Caption = 'Total weight'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Description'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SizeLength'
          Title.Caption = 'Length'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 51
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cStyle'
          Title.Caption = 'Style'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cType'
          Title.Caption = 'Type'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cMetal'
          Title.Caption = 'Metal'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cStatus'
          Title.Caption = 'Status'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Note'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Created'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -15
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = []
          Visible = True
        end>
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1155
    Height = 78
    Align = alTop
    Caption = 'Pawn'
    TabOrder = 0
    ExplicitWidth = 1024
    object Label1: TLabel
      Left = 48
      Top = 22
      Width = 35
      Height = 20
      Caption = 'Date:'
    end
    object Label2: TLabel
      Left = 154
      Top = 22
      Width = 69
      Height = 20
      Caption = 'Ticket No.:'
    end
    object Label3: TLabel
      Left = 245
      Top = 22
      Width = 56
      Height = 20
      Caption = 'Amount:'
    end
    object Label5: TLabel
      Left = 353
      Top = 22
      Width = 81
      Height = 20
      Caption = 'Pawn Status:'
    end
    object DBEdit2: TDBEdit
      Left = 154
      Top = 41
      Width = 71
      Height = 28
      DataField = 'TranTicketNo'
      DataSource = DM.DSTransactions
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      Left = 48
      Top = 41
      Width = 89
      Height = 28
      DataField = 'TranDate'
      DataSource = DM.DSTransactions
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 245
      Top = 41
      Width = 89
      Height = 28
      DataField = 'TranPawnAmount'
      DataSource = DM.DSTransactions
      ReadOnly = True
      TabOrder = 2
    end
    object cbPawnStatus: TRzComboBox
      Left = 353
      Top = 41
      Width = 145
      Height = 28
      Style = csDropDownList
      FrameColor = clBtnHighlight
      FrameHotColor = clWhite
      FrameHotStyle = fsFlat
      ReadOnlyColor = clWhite
      TabOrder = 3
    end
  end
end
