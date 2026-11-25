object frmSellItems: TfrmSellItems
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Sell Items'
  ClientHeight = 716
  ClientWidth = 1296
  Color = clBtnFace
  Constraints.MaxHeight = 755
  Constraints.MaxWidth = 1312
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 20
  object pnFind: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1290
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1290
      54)
    object lblFind: TLabel
      Left = 14
      Top = 23
      Width = 192
      Height = 20
      Caption = 'Scan barcode or type to find:'
    end
    object edFind: TEdit
      Left = 236
      Top = 19
      Width = 226
      Height = 28
      TabOrder = 0
      TextHint = 'Barcode or description'
      OnKeyPress = edFindKeyPress
    end
    object btnFind: TRzBitBtn
      Left = 473
      Top = 12
      Width = 105
      Height = 40
      Caption = '&Find'
      TabOrder = 1
      OnClick = btnFindClick
      ImageIndex = 5
      Images = DM.vilMain24
      Margin = 5
      Spacing = -10
    end
    object btnClose: TBitBtn
      Left = 1187
      Top = 11
      Width = 92
      Height = 43
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Exit'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 2
      TabStop = False
      OnClick = btnCloseClick
    end
  end
  object pnLists: TPanel
    Left = 0
    Top = 60
    Width = 1296
    Height = 656
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object gbForSale: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 590
      Height = 650
      Align = alLeft
      Caption = 'Items For Sale'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object gridForSale: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 25
        Width = 580
        Height = 570
        Align = alClient
        DataSource = dsForSale
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = gridForSaleDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'INV_ITEM_BARCODE'
            Title.Caption = 'Barcode'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INV_ITEM_COUNT'
            Title.Caption = 'Qty'
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRIPTION'
            Title.Caption = 'Description'
            Width = 215
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'J_TYPE_DESC'
            Title.Caption = 'Type'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'J_METAL_DESC'
            Title.Caption = 'Metal'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIT_PRICE'
            Title.Caption = 'Price'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIT_COST'
            Title.Caption = 'Cost'
            Width = 70
            Visible = True
          end>
      end
      object pnForSaleButtons: TPanel
        Left = 2
        Top = 598
        Width = 586
        Height = 50
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblForSaleCount: TLabel
          Left = 10
          Top = 16
          Width = 115
          Height = 20
          Caption = '0 item(s) For Sale'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object btnAddToSale: TRzBitBtn
          Left = 436
          Top = 5
          Width = 140
          Height = 40
          Caption = 'Add to Sale'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnAddToSaleClick
          ImageIndex = 8
          Images = DM.vilMain24
          Margin = 8
        end
      end
    end
    object Panel1: TPanel
      Left = 596
      Top = 0
      Width = 700
      Height = 656
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnSaleStrip: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 48
        Height = 650
        Align = alLeft
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object lblSaleCount: TLabel
          Left = 1
          Top = 55
          Width = 48
          Height = 21
          Hint = 'Items in this sale'
          Alignment = taCenter
          AutoSize = False
          Caption = '0'
          Font.Charset = ANSI_CHARSET
          Font.Color = clHighlight
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object btnToggleSale: TRzToolButton
          Left = 2
          Top = 8
          Width = 48
          Height = 48
          Hint = 'Go to the lines of this sale'
          ImageIndex = 58
          Images = DM.vilMain
          UseToolbarButtonSize = False
          Caption = 'Sales'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnToggleSaleClick
        end
        object btnSaleItem: TRzToolButton
          Left = 5
          Top = 132
          Width = 40
          Height = 40
          Hint = 'Add the selected item to this sale'
          ImageIndex = 59
          Images = DM.vilMain24
          UseToolbarButtonSize = False
          Caption = 'Sales'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnAddToSaleClick
        end
        object btnBackToStock: TRzToolButton
          Left = 5
          Top = 210
          Width = 40
          Height = 40
          Hint = 'Put the selected sale item back to stock'
          ImageIndex = 60
          Images = DM.vilMain24
          UseToolbarButtonSize = False
          Caption = 'Sales'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnRemoveFromSaleClick
        end
      end
      object gbThisSale: TGroupBox
        AlignWithMargins = True
        Left = 57
        Top = 3
        Width = 640
        Height = 650
        Align = alClient
        Caption = 'This Sale'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object gridSale: TDBGrid
          AlignWithMargins = True
          Left = 5
          Top = 25
          Width = 630
          Height = 356
          Align = alClient
          DataSource = dsSale
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'INV_ITEM_BARCODE'
              ReadOnly = True
              Title.Caption = 'Barcode'
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
              FieldName = 'INV_ITEM_COUNT'
              ReadOnly = True
              Title.Caption = 'Qty'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRIPTION'
              ReadOnly = True
              Title.Caption = 'Description'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 246
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UNIT_COST'
              ReadOnly = True
              Title.Caption = 'Cost'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 83
              Visible = True
            end
            item
              Color = clInfoBk
              Expanded = False
              FieldName = 'SALE_PRICE'
              Title.Caption = 'Sale Price'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -15
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = [fsBold]
              Width = 94
              Visible = True
            end>
        end
        object pnSaleButtons: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 387
          Width = 630
          Height = 46
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object lblDiscount: TLabel
            Left = 14
            Top = 13
            Width = 61
            Height = 20
            Caption = 'Discount:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object btnRemoveFromSale: TRzBitBtn
            Left = 481
            Top = 3
            Width = 140
            Height = 40
            Caption = 'Remove'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnRemoveFromSaleClick
            ImageIndex = 22
            Images = DM.vilMain24
            Margin = 8
          end
          object edDiscount: TRzNumericEdit
            Left = 83
            Top = 9
            Width = 90
            Height = 28
            Hint = 'Discount for the whole sale, taken before tax'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnChange = DiscountChange
            IntegersOnly = False
            DisplayFormat = ',0.00;(,0.00)'
          end
          object cbDiscountType: TComboBox
            Left = 185
            Top = 9
            Width = 100
            Height = 28
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 2
            Text = '$ Amount'
            OnChange = DiscountChange
            Items.Strings = (
              '$ Amount'
              '% Percent')
          end
        end
        object pnSaleTotals: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 439
          Width = 630
          Height = 206
          Align = alBottom
          BevelEdges = [beTop]
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowCaption = False
          TabOrder = 2
          object lblSoldDate: TLabel
            Left = 12
            Top = 14
            Width = 67
            Height = 20
            Caption = 'Sold date:'
          end
          object lblSubtotalCaption: TLabel
            Left = 357
            Top = 14
            Width = 61
            Height = 21
            Caption = 'Subtotal:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblSubtotal: TLabel
            Left = 437
            Top = 14
            Width = 120
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblDiscountCaption: TLabel
            Left = 357
            Top = 38
            Width = 64
            Height = 21
            Caption = 'Discount:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblDiscountAmt: TLabel
            Left = 437
            Top = 38
            Width = 120
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblTaxCaption: TLabel
            Left = 357
            Top = 62
            Width = 60
            Height = 21
            Caption = 'Tax (0%):'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblTax: TLabel
            Left = 437
            Top = 62
            Width = 120
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblTotalCaption: TLabel
            Left = 357
            Top = 95
            Width = 48
            Height = 25
            Caption = 'Total:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTotal: TLabel
            Left = 437
            Top = 95
            Width = 120
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblRcptNo: TLabel
            Left = 156
            Top = 38
            Width = 77
            Height = 20
            Caption = 'Receipt No.'
          end
          object edSoldDate: TRzDateTimeEdit
            Left = 12
            Top = 37
            Width = 120
            Height = 28
            TabStop = False
            EditType = etDate
            TabOrder = 3
          end
          object btnNewSale: TRzBitBtn
            Left = 11
            Top = 142
            Width = 180
            Height = 50
            Hint = 'Clear the completed sale and start the next one'
            Caption = 'New Sale / Clear'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = btnNewSaleClick
            ImageIndex = 48
            Images = DM.vilMain24
            Margin = 8
          end
          object btnCompleteSale: TRzBitBtn
            Left = 354
            Top = 142
            Width = 211
            Height = 50
            Caption = 'Complete Sale'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = btnCompleteSaleClick
            ImageIndex = 28
            Images = DM.vilMain24
            Margin = 8
          end
          object btnPrintSalesReceipt: TRzBitBtn
            Left = 578
            Top = 142
            Width = 49
            Height = 50
            Hint = 'Print Sales Receipt'
            HotTrack = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnPrintSalesReceiptClick
            ImageIndex = 65
            Images = DM.vilMain24
            Spacing = 0
          end
        end
      end
    end
  end
  object qryForSale: TFDQuery
    Connection = DM.ConnFB
    Left = 96
    Top = 180
  end
  object dsForSale: TDataSource
    DataSet = qryForSale
    OnDataChange = dsForSaleDataChange
    Left = 176
    Top = 180
  end
  object clnSale: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 891
    Top = 149
  end
  object dsSale: TDataSource
    DataSet = clnSale
    Left = 893
    Top = 207
  end
end
