object frmSellItems: TfrmSellItems
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Sell Items'
  ClientHeight = 640
  ClientWidth = 1180
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 20
  object pnFind: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1174
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblFind: TLabel
      Left = 14
      Top = 17
      Width = 210
      Height = 20
      Caption = 'Scan barcode or type to find:'
    end
    object edFind: TEdit
      Left = 236
      Top = 13
      Width = 300
      Height = 28
      TabOrder = 0
      TextHint = 'Barcode or description'
      OnKeyPress = edFindKeyPress
    end
    object btnFind: TRzBitBtn
      Left = 550
      Top = 7
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
  end
  object pnLists: TPanel
    Left = 0
    Top = 60
    Width = 1180
    Height = 480
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object gbForSale: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 590
      Height = 474
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
        Height = 394
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
            Width = 150
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
            FieldName = 'UNIT_COST'
            Title.Caption = 'Cost'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIT_PRICE'
            Title.Caption = 'Price'
            Width = 70
            Visible = True
          end>
      end
      object pnForSaleButtons: TPanel
        Left = 2
        Top = 422
        Width = 586
        Height = 50
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblForSaleCount: TLabel
          Left = 10
          Top = 16
          Width = 120
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
          Spacing = 4
        end
      end
    end
    object gbThisSale: TGroupBox
      AlignWithMargins = True
      Left = 599
      Top = 3
      Width = 578
      Height = 474
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
        Width = 568
        Height = 394
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
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INV_ITEM_COUNT'
            ReadOnly = True
            Title.Caption = 'Qty'
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRIPTION'
            ReadOnly = True
            Title.Caption = 'Description'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIT_COST'
            ReadOnly = True
            Title.Caption = 'Cost'
            Width = 80
            Visible = True
          end
          item
            Color = clInfoBk
            Expanded = False
            FieldName = 'SALE_PRICE'
            Title.Caption = 'Sale Price'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 90
            Visible = True
          end>
      end
      object pnSaleButtons: TPanel
        Left = 2
        Top = 422
        Width = 574
        Height = 50
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblPriceHint: TLabel
          Left = 10
          Top = 16
          Width = 260
          Height = 20
          Caption = 'Type the Sale Price (discounts here).'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGrayText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object btnRemoveFromSale: TRzBitBtn
          Left = 424
          Top = 5
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
          Spacing = 4
        end
      end
    end
  end
  object gbTotals: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 543
    Width = 1174
    Height = 94
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      1174
      94)
    object lblSoldDate: TLabel
      Left = 16
      Top = 37
      Width = 70
      Height = 20
      Caption = 'Sold date:'
    end
    object lblSubtotalCaption: TLabel
      Left = 300
      Top = 14
      Width = 65
      Height = 20
      Caption = 'Subtotal:'
    end
    object lblSubtotal: TLabel
      Left = 380
      Top = 14
      Width = 120
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = '$0.00'
    end
    object lblTaxCaption: TLabel
      Left = 300
      Top = 38
      Width = 70
      Height = 20
      Caption = 'Tax (0%):'
    end
    object lblTax: TLabel
      Left = 380
      Top = 38
      Width = 120
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = '$0.00'
    end
    object lblTotalCaption: TLabel
      Left = 300
      Top = 62
      Width = 41
      Height = 21
      Caption = 'Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 380
      Top = 62
      Width = 120
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      Caption = '$0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edSoldDate: TRzDateTimeEdit
      Left = 96
      Top = 33
      Width = 120
      Height = 28
      EditType = etDate
      TabOrder = 0
    end
    object btnCompleteSale: TRzBitBtn
      Left = 850
      Top = 22
      Width = 170
      Height = 50
      Anchors = [akTop, akRight]
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
      Spacing = 4
    end
    object btnClose: TBitBtn
      Left = 1040
      Top = 22
      Width = 115
      Height = 50
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 2
      OnClick = btnCloseClick
    end
  end
  object qryForSale: TFDQuery
    Connection = DM.ConnFB
    Left = 96
    Top = 180
  end
  object dsForSale: TDataSource
    DataSet = qryForSale
    Left = 176
    Top = 180
  end
  object clnSale: TFDMemTable
    BeforeInsert = clnSaleBeforeInsert
    AfterPost = clnSaleAfterChange
    AfterDelete = clnSaleAfterChange
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 696
    Top = 180
  end
  object dsSale: TDataSource
    DataSet = clnSale
    Left = 776
    Top = 180
  end
end
