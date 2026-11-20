object frmInventory: TfrmInventory
  Left = 350
  Top = 116
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Items'
  ClientHeight = 720
  ClientWidth = 1791
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
  object gbBottom: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 656
    Width = 1785
    Height = 61
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1785
      61)
    object btnClose: TBitBtn
      Left = 1669
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
    Left = 202
    Top = 0
    Width = 936
    Height = 653
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnTop: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 930
      Height = 65
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object gbItemStatus: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 5
        Width = 378
        Height = 56
        Caption = 'Item Status'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object chkSale: TCheckBox
          Left = 26
          Top = 26
          Width = 81
          Height = 17
          Caption = ' For Sale'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 0
        end
        object chkPawn: TCheckBox
          Left = 113
          Top = 26
          Width = 79
          Height = 17
          Caption = ' Pawned'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 1
        end
        object CheckBox1: TCheckBox
          Left = 204
          Top = 26
          Width = 79
          Height = 17
          Caption = 'Layaway'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 2
        end
        object chkSold: TCheckBox
          Left = 296
          Top = 26
          Width = 64
          Height = 17
          Caption = 'Sold'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
      object gbBarcode: TGroupBox
        AlignWithMargins = True
        Left = 406
        Top = 6
        Width = 165
        Height = 56
        Caption = 'Barcode'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object edBarcode: TEdit
          Left = 12
          Top = 22
          Width = 141
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'Scan or type'
        end
      end
      object btnSearch: TRzBitBtn
        Left = 589
        Top = 14
        Width = 108
        Height = 44
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
      Width = 936
      Height = 437
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel5'
      TabOrder = 1
      object dbgItems: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 930
        Height = 385
        Align = alClient
        DataSource = dsInvItems
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDrawColumnCell = dbgItemsDrawColumnCell
        OnDblClick = dbgItemsDblClick
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
            FieldName = 'UnitPrice'
            Title.Alignment = taRightJustify
            Title.Caption = 'Unit Price'
            Width = 75
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
            FieldName = 'StatusDate'
            Title.Caption = 'Status Date'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DaysInStatus'
            Title.Alignment = taRightJustify
            Title.Caption = 'Days'
            Width = 48
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
        Width = 936
        Height = 46
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
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
        object btnUndoSale: TRzBitBtn
          Left = 256
          Top = 4
          Width = 145
          Height = 40
          Caption = 'Undo Sale'
          TabOrder = 0
          Visible = False
          OnClick = btnUndoSaleClick
          ImageIndex = 51
          Images = DM.vilMain24
          Margin = 10
          Spacing = 0
        end
        object btnSellItems: TRzBitBtn
          Left = 409
          Top = 4
          Width = 145
          Height = 40
          Caption = 'Sell Items'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          Visible = False
          OnClick = btnSellItemsClick
          ImageIndex = 48
          Images = DM.vilMain24
          Margin = 10
          Spacing = 0
        end
        object btnPrintLabel: TRzBitBtn
          Left = 579
          Top = 4
          Width = 145
          Height = 40
          Caption = 'Print Labels'
          TabOrder = 2
          ImageIndex = 0
          Images = DM.vilMain24
          Margin = 10
          Spacing = 0
        end
        object btnPrintOneLabel: TRzBitBtn
          Left = 760
          Top = 4
          Width = 145
          Height = 40
          Caption = 'Print One Label'
          TabOrder = 3
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
      Width = 936
      Height = 145
      Align = alBottom
      Caption = 'Stones'
      TabOrder = 2
      object dbGridStones: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 22
        Width = 926
        Height = 118
        Align = alClient
        DataSource = dsStones
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
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
  object pnCategories: TRzSizePanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 196
    Height = 647
    Hint = 'Items Categories'
    HotSpotVisible = True
    SizeBarWidth = 9
    TabOrder = 2
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 186
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
      Width = 180
      Height = 615
      Align = alClient
      Indent = 19
      SelectionPen.Color = clBtnShadow
      StateImages = chkTree.CheckImages
      TabOrder = 0
    end
  end
  object pnSales: TSplitView
    Left = 1138
    Top = 0
    Width = 653
    Height = 653
    AnimationStep = 140
    BevelEdges = [beLeft]
    BevelKind = bkFlat
    CloseStyle = svcCompact
    OpenedWidth = 653
    Placement = svpRight
    TabOrder = 3
    OnClosing = pnSalesSliding
    OnOpened = pnSalesOpened
    OnOpening = pnSalesSliding
    object pnSaleStrip: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 48
      Height = 647
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object lblSaleCount: TLabel
        Left = 0
        Top = 52
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
        Hint = 'Show / hide This Sale'
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
        OnClick = btnSaleItemClick
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
        Visible = False
        OnClick = btnBackToStockClick
      end
    end
    object gbThisSale: TGroupBox
      Left = 54
      Top = 0
      Width = 597
      Height = 653
      Align = alClient
      Caption = 'This Sale'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnSaleButtons: TPanel
        Left = 2
        Top = 438
        Width = 593
        Height = 46
        Align = alBottom
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        DesignSize = (
          593
          46)
        object lblDiscount: TLabel
          Left = 8
          Top = 13
          Width = 53
          Height = 17
          Caption = 'Discount:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object edDiscount: TRzNumericEdit
          Left = 72
          Top = 9
          Width = 90
          Height = 25
          Hint = 'Discount for the whole sale, taken before tax'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = DiscountChange
          IntegersOnly = False
          DisplayFormat = ',0.00;(,0.00)'
        end
        object cbDiscountType: TComboBox
          Left = 166
          Top = 9
          Width = 110
          Height = 25
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = '$ Amount'
          OnChange = DiscountChange
          Items.Strings = (
            '$ Amount'
            '% Percent')
        end
        object btnRemoveFromSale: TRzBitBtn
          Left = 463
          Top = 4
          Width = 122
          Height = 38
          Anchors = [akTop, akRight]
          Caption = 'Remove'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnBackToStockClick
          ImageIndex = 22
          Images = DM.vilMain24
          Margin = 8
        end
      end
      object pnSaleTotals: TPanel
        Left = 2
        Top = 484
        Width = 593
        Height = 167
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
        TabOrder = 1
        DesignSize = (
          593
          165)
        object lblSoldDate: TLabel
          Left = 8
          Top = 12
          Width = 67
          Height = 20
          Caption = 'Sold date:'
        end
        object lblSubtotalCaption: TLabel
          Left = 383
          Top = 12
          Width = 59
          Height = 20
          Anchors = [akTop, akRight]
          Caption = 'Subtotal:'
          ExplicitLeft = 288
        end
        object lblSubtotal: TLabel
          Left = 465
          Top = 12
          Width = 120
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '$0.00'
          ExplicitLeft = 370
        end
        object lblDiscountCaption: TLabel
          Left = 383
          Top = 36
          Width = 61
          Height = 20
          Anchors = [akTop, akRight]
          Caption = 'Discount:'
        end
        object lblDiscountAmt: TLabel
          Left = 465
          Top = 36
          Width = 120
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '$0.00'
        end
        object lblTaxCaption: TLabel
          Left = 383
          Top = 60
          Width = 58
          Height = 20
          Anchors = [akTop, akRight]
          Caption = 'Tax (0%):'
          ExplicitLeft = 288
        end
        object lblTax: TLabel
          Left = 465
          Top = 60
          Width = 120
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '$0.00'
          ExplicitLeft = 370
        end
        object lblTotalCaption: TLabel
          Left = 383
          Top = 88
          Width = 48
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Total:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 288
        end
        object lblTotal: TLabel
          Left = 445
          Top = 88
          Width = 140
          Height = 25
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = '$0.00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 350
        end
        object edSoldDate: TRzDateTimeEdit
          Left = 8
          Top = 36
          Width = 130
          Height = 28
          EditType = etDate
          TabOrder = 0
        end
        object btnCompleteSale: TRzBitBtn
          Left = 12
          Top = 119
          Width = 575
          Height = 42
          Anchors = [akLeft, akTop, akRight]
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
      end
      object Panel2: TPanel
        Left = 2
        Top = 22
        Width = 593
        Height = 416
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 593
          Height = 40
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblRcptNo: TLabel
            Left = 284
            Top = 9
            Width = 79
            Height = 20
            Caption = 'Receipt No.'
          end
          object btnNewSaleClearOldSale: TRzBitBtn
            Left = 81
            Top = -2
            Width = 180
            Height = 40
            Caption = 'New Sale / Clear'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnNewSaleClearOldSaleClick
            ImageIndex = 48
            Images = DM.vilMain24
            Margin = 8
          end
        end
        object gridSale: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 43
          Width = 587
          Height = 370
          Align = alClient
          DataSource = dsSale
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit]
          ParentFont = False
          TabOrder = 1
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
              Width = 75
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
              Width = 170
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UNIT_COST'
              ReadOnly = True
              Title.Caption = 'Cost'
              Width = 70
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
              Width = 85
              Visible = True
            end>
        end
      end
    end
  end
  object dsCategories: TDataSource
    DataSet = qryCategories
    Left = 48
    Top = 152
  end
  object dsInvItems: TDataSource
    DataSet = qryInvItems
    OnDataChange = dsInvItemsDataChange
    Left = 259
    Top = 184
  end
  object dsStones: TDataSource
    DataSet = qryStones
    Left = 352
    Top = 184
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
    Left = 1240
    Top = 184
  end
  object dsSale: TDataSource
    DataSet = clnSale
    Left = 1320
    Top = 184
  end
  object qryCategories: TFDQuery
    Connection = DM.ConnFB
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.UpdateTableName = 'INV_CATEGORIES'
    UpdateOptions.KeyFields = 'InvCatNo'
    UpdateOptions.AutoIncFields = 'InvCatNo'
    SQL.Strings = (
      'SELECT INV_CAT_NO AS "InvCatNo",'
      '       INV_CATEGORY AS "InvCategory"'
      'FROM INV_CATEGORIES'
      'ORDER BY INV_CATEGORY')
    Left = 48
    Top = 95
    object qryCategoriesInvCatNo: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'InvCatNo'
      Origin = 'INV_CAT_NO'
      Required = True
    end
    object qryCategoriesInvCategory: TWideStringField
      FieldName = 'InvCategory'
      Origin = 'INV_CATEGORY'
      Size = 40
    end
  end
  object qryInvItems: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.UpdateTableName = 'INVENTORY_ITEMS'
    UpdateOptions.KeyFields = 'InvItemNo'
    UpdateOptions.AutoIncFields = 'InvItemNo'
    SQL.Strings = (
      'SELECT'
      '    ii.INV_ITEM_NO AS "InvItemNo",'
      '    ii.INV_ITEM_BARCODE AS "InvItemBarcode",'
      '    ii.INV_CAT_NO AS "InvCatNo",'
      '    ii.J_TYPE AS "JType",'
      '    ii.J_STYLE AS "JStyle",'
      '    ii.J_METAL AS "JMetal",'
      '    ii.INV_ITEM_COUNT AS "InvItemCount",'
      '    ii.NOTE AS "Note",'
      '    ii.SIZE_LENGTH AS "SizeLength",'
      '    ii.WEIGHT AS "Weight",'
      '    ii.WEIGHT_UNIT AS "WeightUnit",'
      '    ii.KT AS "KT",'
      '    ii.CREATED AS "Created",'
      '    ii.UNIT_COST AS "UnitCost",'
      '    ii.UNIT_PRICE AS "UnitPrice",'
      '    ii.INV_ITEM_STATUS AS "InvItemStatus",'
      '    ii.TRANSACTION_NO AS "TransactionNo",'
      '    ii.INV_ORIGINAL_ITEM_NO AS "InvOriginalItemNo",'
      '    ii.INV_ITEM_BRAND AS "InvItemBrand",'
      '    ii.OWNER_APP_NUMBER AS "OwnerAppNumber",'
      '    ii.MODEL_NUMBER AS "ModelNumber",'
      '    ii.SERIAL_NUMBER AS "SerialNumber",'
      '    ii.GENDER AS "Gender",'
      '    ii.DESCRIPTION AS "Description",'
      
        '    (ii.INV_ITEM_COUNT * COALESCE(ii.WEIGHT, 0)) AS "TotalWeight' +
        '",'
      '    jt.J_TYPE_DESC AS "JTypeDesc",'
      '    js.J_STYLE_DESC AS "JStyleDesc",'
      '    jm.J_METAL_DESC AS "JMetalDesc",'
      '    ist.STATUS_DESC AS "StatusDesc",'
      '    CASE ii.INV_ITEM_STATUS'
      '      WHEN '#39'P'#39' THEN ii.PAWNED_DATE'
      '      WHEN '#39'L'#39' THEN ii.LAYAWAY_DATE'
      '      WHEN '#39'D'#39' THEN ii.SOLD_DATE'
      '      WHEN '#39'R'#39' THEN ii.REDEEMED_DATE'
      '      WHEN '#39'C'#39' THEN ii.MELTED_DATE'
      '      WHEN '#39'S'#39' THEN COALESCE(ii.FORSALE_DATE, ii.PURCHASE_DATE)'
      '    END AS "StatusDate",'
      '    CAST(DATEDIFF(DAY FROM'
      '      CASE ii.INV_ITEM_STATUS'
      '        WHEN '#39'P'#39' THEN ii.PAWNED_DATE'
      '        WHEN '#39'L'#39' THEN ii.LAYAWAY_DATE'
      '        WHEN '#39'D'#39' THEN ii.SOLD_DATE'
      '        WHEN '#39'R'#39' THEN ii.REDEEMED_DATE'
      '        WHEN '#39'C'#39' THEN ii.MELTED_DATE'
      
        '        WHEN '#39'S'#39' THEN COALESCE(ii.FORSALE_DATE, ii.PURCHASE_DATE' +
        ')'
      '      END TO CURRENT_DATE) AS INTEGER) AS "DaysInStatus",'
      '    ii.PAWNED_DATE AS "PawnedDate",'
      '    ii.PURCHASE_DATE AS "PurchaseDate",'
      '    ii.LAYAWAY_DATE AS "LayawayDate",'
      '    ii.FORSALE_DATE AS "ForSaleDate",'
      '    ii.REDEEMED_DATE AS "RedeemedDate",'
      '    ii.DEFAULTED_DATE AS "DefaultedDate",'
      '    ii.MELTED_DATE AS "MeltedDate",'
      '    ii.SOLD_DATE AS "SoldDate"'
      'FROM INVENTORY_ITEMS ii'
      'LEFT JOIN J_TYPES jt ON ii.J_TYPE = jt.J_TYPE'
      'LEFT JOIN J_STYLES js ON ii.J_STYLE = js.J_STYLE'
      'LEFT JOIN J_METALS jm ON ii.J_METAL = jm.J_METAL'
      'LEFT JOIN ITEM_STATUS ist ON ii.INV_ITEM_STATUS = ist.STATUS'
      ' --<PARAMS>'
      '')
    Left = 259
    Top = 119
    object qryInvItemsInvItemNo: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'InvItemNo'
      Origin = 'INV_ITEM_NO'
    end
    object qryInvItemsInvItemBarcode: TWideStringField
      FieldName = 'InvItemBarcode'
      Origin = 'INV_ITEM_BARCODE'
      Size = 30
    end
    object qryInvItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
      Origin = 'INV_CAT_NO'
    end
    object qryInvItemsJType: TWideStringField
      FieldName = 'JType'
      Origin = 'J_TYPE'
      Size = 1
    end
    object qryInvItemsJStyle: TWideStringField
      FieldName = 'JStyle'
      Origin = 'J_STYLE'
      Size = 1
    end
    object qryInvItemsJMetal: TWideStringField
      FieldName = 'JMetal'
      Origin = 'J_METAL'
      Size = 1
    end
    object qryInvItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
      Origin = 'INV_ITEM_COUNT'
    end
    object qryInvItemsNote: TWideStringField
      FieldName = 'Note'
      Origin = 'NOTE'
      Size = 80
    end
    object qryInvItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
      Origin = 'SIZE_LENGTH'
    end
    object qryInvItemsWeight: TFloatField
      FieldName = 'Weight'
      Origin = 'WEIGHT'
    end
    object qryInvItemsWeightUnit: TWideStringField
      FieldName = 'WeightUnit'
      Origin = 'WEIGHT_UNIT'
      Size = 1
    end
    object qryInvItemsKT: TFloatField
      FieldName = 'KT'
      Origin = 'KT'
    end
    object qryInvItemsCreated: TSQLTimeStampField
      FieldName = 'Created'
      Origin = 'CREATED'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object qryInvItemsUnitCost: TFMTBCDField
      FieldName = 'UnitCost'
      Origin = 'UNIT_COST'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryInvItemsUnitPrice: TFMTBCDField
      FieldName = 'UnitPrice'
      Origin = 'UNIT_PRICE'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryInvItemsInvItemStatus: TWideStringField
      FieldName = 'InvItemStatus'
      Origin = 'INV_ITEM_STATUS'
      Size = 1
    end
    object qryInvItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
      Origin = 'TRANSACTION_NO'
    end
    object qryInvItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
      Origin = 'INV_ORIGINAL_ITEM_NO'
    end
    object qryInvItemsInvItemBrand: TWideStringField
      FieldName = 'InvItemBrand'
      Origin = 'INV_ITEM_BRAND'
      Size = 30
    end
    object qryInvItemsOwnerAppNumber: TWideStringField
      FieldName = 'OwnerAppNumber'
      Origin = 'OWNER_APP_NUMBER'
      Size = 40
    end
    object qryInvItemsModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Origin = 'MODEL_NUMBER'
      Size = 40
    end
    object qryInvItemsSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Origin = 'SERIAL_NUMBER'
      Size = 40
    end
    object qryInvItemsGender: TWideStringField
      FieldName = 'Gender'
      Origin = 'GENDER'
      Size = 1
    end
    object qryInvItemsDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'DESCRIPTION'
      Size = 120
    end
    object qryInvItemsJTypeDesc: TWideStringField
      FieldName = 'JTypeDesc'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qryInvItemsJStyleDesc: TWideStringField
      FieldName = 'JStyleDesc'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qryInvItemsJMetalDesc: TWideStringField
      FieldName = 'JMetalDesc'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qryInvItemsStatusDesc: TWideStringField
      FieldName = 'StatusDesc'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qryInvItemsTotalWeight: TFloatField
      FieldName = 'TotalWeight'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsStatusDate: TDateField
      FieldName = 'StatusDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsDaysInStatus: TIntegerField
      FieldName = 'DaysInStatus'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsPawnedDate: TDateField
      FieldName = 'PawnedDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsPurchaseDate: TDateField
      FieldName = 'PurchaseDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsLayawayDate: TDateField
      FieldName = 'LayawayDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsForSaleDate: TDateField
      FieldName = 'ForSaleDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsRedeemedDate: TDateField
      FieldName = 'RedeemedDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsDefaultedDate: TDateField
      FieldName = 'DefaultedDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsMeltedDate: TDateField
      FieldName = 'MeltedDate'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryInvItemsSoldDate: TDateField
      FieldName = 'SoldDate'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object qryStones: TFDQuery
    MasterSource = dsInvItems
    MasterFields = 'InvItemNo'
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT'
      '  s.STONE_NO AS "StoneNo",'
      '  s.INV_ITEM_NO AS "InvItemNo",'
      '  s.STONE_NUMBER AS "StoneNumber",'
      '  s.STONE_SHAPE AS "StoneShape",'
      '  s.STONE_COLOR AS "StoneColor",'
      '  ss.J_SHAPE_DESC AS "cShape",'
      '  sc.J_STONE_DESC AS "cColor",'
      '  s.CT,'
      '  s.WT,'
      '  s.STONE_TYPE AS "StoneType",'
      '  s.STONE_WEIGHT_UNIT AS "StoneWeightUnit"'
      'FROM STONES s'
      'LEFT JOIN J_STONE_SHAPES ss ON ss.J_SHAPE = s.STONE_SHAPE'
      'LEFT JOIN J_STONE_COLORS sc ON sc.J_STONE_COLOR = s.STONE_COLOR'
      'WHERE s.INV_ITEM_NO = :InvItemNo'
      'ORDER BY s.STONE_NUMBER')
    Left = 352
    Top = 119
    ParamData = <
      item
        Name = 'InvItemNo'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 771
    Top = 127
  end
end
