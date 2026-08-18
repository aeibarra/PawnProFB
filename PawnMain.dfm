object frmPawnMain: TfrmPawnMain
  Left = 404
  Top = 100
  Anchors = [akTop, akRight]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pawn'
  ClientHeight = 412
  ClientWidth = 1536
  Color = clBtnFace
  Constraints.MinHeight = 133
  Constraints.MinWidth = 786
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ScreenSnap = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 17
  object pnlTabs: TPanel
    Left = 0
    Top = 0
    Width = 1536
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      1536
      43)
    object btnTabHome: TSpeedButton
      Left = 15
      Top = 15
      Width = 56
      Height = 20
      GroupIndex = 1
      Down = True
      Caption = 'Home'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnTabHomeClick
      OnMouseEnter = btnTabHomeMouseEnter
      OnMouseLeave = btnTabHomeMouseLeave
    end
    object btnTabReports: TSpeedButton
      Left = 157
      Top = 15
      Width = 56
      Height = 20
      GroupIndex = 1
      Caption = 'Reports'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnTabHomeClick
      OnMouseEnter = btnTabHomeMouseEnter
      OnMouseLeave = btnTabHomeMouseLeave
    end
    object btnTabSettings: TSpeedButton
      Left = 228
      Top = 15
      Width = 56
      Height = 20
      GroupIndex = 1
      Caption = 'Settings'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnTabHomeClick
      OnMouseEnter = btnTabHomeMouseEnter
      OnMouseLeave = btnTabHomeMouseLeave
    end
    object pbUnderTabs: TPaintBox
      Left = 0
      Top = 34
      Width = 417
      Height = 4
      OnPaint = pbUnderTabsPaint
    end
    object btnTabClient: TSpeedButton
      Left = 86
      Top = 15
      Width = 56
      Height = 20
      GroupIndex = 1
      Caption = 'Clients'
      Enabled = False
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnTabHomeClick
      OnMouseEnter = btnTabHomeMouseEnter
      OnMouseLeave = btnTabHomeMouseLeave
    end
    object btnTabAbout: TSpeedButton
      Left = 299
      Top = 15
      Width = 56
      Height = 20
      Caption = 'About'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnTabAboutClick
      OnMouseEnter = btnTabHomeMouseEnter
      OnMouseLeave = btnTabHomeMouseLeave
    end
    object btnExit: TSpeedButton
      Left = 363
      Top = 15
      Width = 56
      Height = 20
      Caption = 'E&xit'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnExitClick
      OnMouseEnter = btnTabHomeMouseEnter
      OnMouseLeave = btnTabHomeMouseLeave
    end
    object RichEditGLdPrice: TRichEdit
      Left = 807
      Top = 2
      Width = 654
      Height = 39
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      HideSelection = False
      Lines.Strings = (
        'RichEditGLdPrice')
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      Transparent = True
      Visible = False
    end
  end
  object pnHome: TRzPanel
    Left = 0
    Top = 43
    Width = 1536
    Height = 78
    Align = alTop
    BorderOuter = fsNone
    TabOrder = 1
    object btnClose: TRzToolButton
      Left = 1461
      Top = 0
      Width = 75
      Height = 78
      GradientColorStyle = gcsSystem
      ImageIndex = 2
      Images = DM.vilMain
      Layout = blGlyphTop
      ShowCaption = True
      Transparent = False
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnCloseClick
      ExplicitLeft = 1477
      ExplicitHeight = 77
    end
    object ToolBarHome: TRzToolbar
      Left = 0
      Top = 0
      Width = 1461
      Height = 78
      Align = alClient
      AutoResize = False
      AutoStyle = False
      Images = DM.vilMain
      TopMargin = 20
      RowHeight = 40
      ButtonLayout = blGlyphTop
      ButtonWidth = 60
      ButtonHeight = 40
      ShowButtonCaptions = True
      TextOptions = ttoShowTextLabels
      BorderInner = fsNone
      BorderOuter = fsNone
      BorderSides = []
      BorderWidth = 0
      Color = 15987699
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      GradientColorStyle = gcsCustom
      GradientColorStop = clWhite
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      UseDockManager = False
      VisualStyle = vsGradient
      ToolbarControls = (
        RzToolButton16
        RzToolButton17
        btnBackupDatabase
        RzToolButton19
        RzToolButton5
        btnTransactionList)
      object RzToolButton16: TRzToolButton
        AlignWithMargins = True
        Left = 4
        Top = 7
        Width = 110
        Height = 67
        Layout = blGlyphTop
        Spacing = 6
        UseToolbarButtonLayout = False
        UseToolbarButtonSize = False
        Action = actClientPawnAndPurchase
      end
      object RzToolButton17: TRzToolButton
        AlignWithMargins = True
        Left = 117
        Top = 7
        Width = 110
        Height = 67
        Layout = blGlyphTop
        Spacing = 6
        UseToolbarButtonSize = False
        Action = actLeadsOnlineExport
      end
      object btnBackupDatabase: TRzToolButton
        AlignWithMargins = True
        Left = 230
        Top = 7
        Width = 110
        Height = 67
        ImageIndex = 24
        Layout = blGlyphTop
        Spacing = 6
        UseToolbarButtonSize = False
        Caption = 'Backup Database'
        OnClick = actBackupExecute
      end
      object RzToolButton19: TRzToolButton
        AlignWithMargins = True
        Left = 343
        Top = 7
        Width = 110
        Height = 67
        Layout = blGlyphTop
        Spacing = 6
        UseToolbarButtonLayout = False
        UseToolbarButtonSize = False
        Action = actInventory
      end
      object RzToolButton5: TRzToolButton
        AlignWithMargins = True
        Left = 456
        Top = 7
        Width = 110
        Height = 67
        ImageIndex = 39
        Layout = blGlyphTop
        Spacing = 6
        UseToolbarButtonSize = False
        Caption = 'Items For Sale'
        Visible = False
      end
      object btnTransactionList: TRzToolButton
        Left = 569
        Top = 7
        Width = 110
        Height = 67
        ImageIndex = 40
        Layout = blGlyphTop
        UseToolbarButtonSize = False
        Caption = 'Transactions List'
        OnClick = btnTransactionListClick
      end
    end
  end
  object pnClients: TRzPanel
    Left = 0
    Top = 121
    Width = 1536
    Height = 78
    Align = alTop
    BorderOuter = fsNone
    TabOrder = 2
    Visible = False
    object RzToolButton1: TRzToolButton
      Left = 1461
      Top = 0
      Width = 75
      Height = 78
      GradientColorStyle = gcsSystem
      ImageIndex = 2
      Images = DM.vilMain
      Layout = blGlyphTop
      ShowCaption = True
      Transparent = False
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnCloseClick
      ExplicitLeft = 1477
      ExplicitHeight = 77
    end
    object ToolbarClients: TRzToolbar
      Left = 0
      Top = 0
      Width = 1461
      Height = 78
      Align = alClient
      AutoStyle = False
      Images = DM.vilMain
      TopMargin = 20
      RowHeight = 40
      ButtonLayout = blGlyphTop
      ButtonWidth = 60
      ButtonHeight = 40
      ShowButtonCaptions = True
      TextOptions = ttoShowTextLabels
      AutoSize = True
      BorderInner = fsNone
      BorderOuter = fsGroove
      BorderSides = []
      BorderWidth = 0
      Color = 15987699
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      GradientColorStyle = gcsCustom
      GradientColorStop = clWhite
      ParentDoubleBuffered = False
      ParentFont = False
      ShowDockClientCaptions = True
      Special = True
      TabOrder = 0
      VisualStyle = vsGradient
      ToolbarControls = (
        RzToolButton6
        RzToolButton7
        RzSpacer2
        RzToolButton8
        RzToolButton9
        RzSpacer3
        RzToolButton10
        RzToolButton11)
      object RzToolButton6: TRzToolButton
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 90
        Height = 76
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Action = frmClients.ActionAddClient
        ParentShowHint = False
        ShowHint = True
      end
      object RzToolButton7: TRzToolButton
        AlignWithMargins = True
        Left = 97
        Top = 2
        Width = 90
        Height = 76
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Action = frmClients.ActionEditClient
      end
      object RzSpacer2: TRzSpacer
        AlignWithMargins = True
        Left = 190
        Top = 9
        Width = 14
        Height = 62
        Grooved = True
        Orientation = orVertical
      end
      object RzToolButton8: TRzToolButton
        AlignWithMargins = True
        Left = 207
        Top = 2
        Width = 90
        Height = 76
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Action = frmClients.ActionAddTran
      end
      object RzToolButton9: TRzToolButton
        AlignWithMargins = True
        Left = 300
        Top = 2
        Width = 90
        Height = 76
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Action = frmClients.ActionEditTran
      end
      object RzSpacer3: TRzSpacer
        Left = 393
        Top = 9
        Height = 62
        Grooved = True
      end
      object RzToolButton10: TRzToolButton
        AlignWithMargins = True
        Left = 401
        Top = 2
        Width = 90
        Height = 76
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Action = frmClients.ActionAddPay
      end
      object RzToolButton11: TRzToolButton
        AlignWithMargins = True
        Left = 494
        Top = 2
        Width = 90
        Height = 76
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Action = frmClients.ActionEditPay
      end
    end
  end
  object pnReports: TRzPanel
    Left = 0
    Top = 199
    Width = 1536
    Height = 78
    Align = alTop
    BorderOuter = fsNone
    TabOrder = 3
    Visible = False
    object RzToolButton2: TRzToolButton
      Left = 1461
      Top = 0
      Width = 75
      Height = 78
      GradientColorStyle = gcsSystem
      ImageIndex = 2
      Images = DM.vilMain
      Layout = blGlyphTop
      ShowCaption = True
      Transparent = False
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnCloseClick
      ExplicitLeft = 1477
      ExplicitHeight = 77
    end
    object ToolbarReports: TRzToolbar
      Left = 0
      Top = 0
      Width = 1461
      Height = 78
      Align = alClient
      AutoStyle = False
      Images = DM.vilMain
      TopMargin = 18
      RowHeight = 40
      ButtonLayout = blGlyphTop
      ButtonWidth = 60
      ButtonHeight = 40
      ShowButtonCaptions = True
      TextOptions = ttoShowTextLabels
      AutoSize = True
      BorderInner = fsNone
      BorderOuter = fsGroove
      BorderSides = []
      BorderWidth = 0
      Color = 15987699
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      GradientColorStyle = gcsCustom
      GradientColorStop = clWhite
      ParentDoubleBuffered = False
      ParentFont = False
      ShowDockClientCaptions = True
      Special = True
      TabOrder = 0
      VisualStyle = vsGradient
      ToolbarControls = (
        RzToolButton12
        RzToolButton13
        RzToolButton14
        btnExportPawnData
        RzSpacer4
        btnQuickExport)
      object RzToolButton12: TRzToolButton
        AlignWithMargins = True
        Left = 4
        Top = 0
        Width = 110
        Height = 76
        ImageIndex = 40
        Images = DM.vilMain
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Client With Late payments'
        OnClick = Report1Click
      end
      object RzToolButton13: TRzToolButton
        AlignWithMargins = True
        Left = 117
        Top = 0
        Width = 110
        Height = 76
        ImageIndex = 34
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'List of Active Pawns && Payments'
        OnClick = ListofnewPawns1Click
      end
      object RzToolButton14: TRzToolButton
        AlignWithMargins = True
        Left = 230
        Top = 0
        Width = 110
        Height = 76
        ImageIndex = 34
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Purchase Transactions'
        OnClick = PurchaseTransactions1Click
      end
      object btnExportPawnData: TRzToolButton
        AlignWithMargins = True
        Left = 343
        Top = 0
        Width = 110
        Height = 76
        ImageIndex = 25
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Export Transaction Information'
        OnClick = ExportTransactionInformation1Click
      end
      object RzSpacer4: TRzSpacer
        Left = 456
        Top = 7
        Height = 62
        Grooved = True
      end
      object btnQuickExport: TRzToolButton
        Left = 464
        Top = 0
        Width = 110
        Height = 76
        ImageIndex = 25
        Layout = blGlyphTop
        UseToolbarButtonSize = False
        Caption = 'Quick Transaction and Items Export'
        OnClick = btnQuickExportClick
      end
    end
  end
  object pnSettings: TRzPanel
    Left = 0
    Top = 277
    Width = 1536
    Height = 78
    Align = alTop
    BorderOuter = fsNone
    TabOrder = 4
    Visible = False
    object RzToolButton3: TRzToolButton
      Left = 1461
      Top = 0
      Width = 75
      Height = 78
      GradientColorStyle = gcsSystem
      ImageIndex = 2
      Images = DM.vilMain
      Layout = blGlyphTop
      ShowCaption = True
      Transparent = False
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnCloseClick
      ExplicitLeft = 1477
      ExplicitHeight = 77
    end
    object ToolbarSettings: TRzToolbar
      Left = 0
      Top = 0
      Width = 1461
      Height = 78
      Align = alClient
      AutoStyle = False
      Images = DM.vilMain
      TopMargin = 18
      RowHeight = 40
      ButtonLayout = blGlyphTop
      ButtonWidth = 60
      ButtonHeight = 40
      ShowButtonCaptions = True
      TextOptions = ttoShowTextLabels
      AutoSize = True
      BorderInner = fsNone
      BorderOuter = fsGroove
      BorderSides = []
      BorderWidth = 0
      Color = 15987699
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      GradientColorStyle = gcsCustom
      GradientColorStop = clWhite
      ParentDoubleBuffered = False
      ParentFont = False
      ShowDockClientCaptions = True
      Special = True
      TabOrder = 0
      VisualStyle = vsGradient
      ToolbarControls = (
        btnSelectPrinters
        btnLeadsOnlineFTPParams
        btnDefaultMaturityMonth
        RzSpacer1
        btnShowGoldPrice
        RzSpacer5
        RzToolButton4
        RzToolButton20
        RzToolButton21
        RzToolButton22
        RzToolButton23
        RzSpacer6
        btnExportImages)
      object btnSelectPrinters: TRzToolButton
        AlignWithMargins = True
        Left = 4
        Top = 0
        Width = 90
        Height = 76
        ImageIndex = 0
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Select Report Printers'
        OnClick = btnSelectPrintersClick
      end
      object btnLeadsOnlineFTPParams: TRzToolButton
        AlignWithMargins = True
        Left = 97
        Top = 0
        Width = 90
        Height = 76
        ImageIndex = 41
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'LeadsOnline Parameters'
        OnClick = btnLeadsOnlineFTPParamsClick
      end
      object btnDefaultMaturityMonth: TRzToolButton
        AlignWithMargins = True
        Left = 190
        Top = 0
        Width = 90
        Height = 76
        ImageIndex = 37
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Pawn Defaults'
        OnClick = btnDefaultMaturityMonthClick
      end
      object RzSpacer1: TRzSpacer
        AlignWithMargins = True
        Left = 283
        Top = 7
        Width = 14
        Height = 62
        Grooved = True
        Orientation = orVertical
      end
      object RzToolButton4: TRzToolButton
        AlignWithMargins = True
        Left = 388
        Top = 0
        Width = 74
        Height = 76
        ImageIndex = 44
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Jewel Type'
        OnClick = Jewel1Click
      end
      object RzToolButton20: TRzToolButton
        AlignWithMargins = True
        Left = 465
        Top = 0
        Width = 74
        Height = 76
        ImageIndex = 38
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Jewel Style'
        OnClick = JewelType1Click
      end
      object RzToolButton21: TRzToolButton
        AlignWithMargins = True
        Left = 542
        Top = 0
        Width = 74
        Height = 76
        ImageIndex = 43
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Jewel Metal'
        OnClick = JewelStyle1Click
      end
      object RzToolButton22: TRzToolButton
        AlignWithMargins = True
        Left = 619
        Top = 0
        Width = 74
        Height = 76
        ImageIndex = 45
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Stone Shape'
        OnClick = JewelStoneShape1Click
      end
      object RzToolButton23: TRzToolButton
        AlignWithMargins = True
        Left = 696
        Top = 0
        Width = 74
        Height = 76
        ImageIndex = 42
        Layout = blGlyphTop
        Spacing = 1
        UseToolbarButtonSize = False
        Caption = 'Stone Color'
        OnClick = JewelStoneColor1Click
      end
      object btnShowGoldPrice: TRzToolButton
        Left = 300
        Top = 0
        Width = 74
        Height = 76
        AllowAllUp = True
        GroupIndex = 1
        Down = True
        DownIndex = 47
        ImageIndex = 46
        Layout = blGlyphTop
        UseToolbarButtonSize = False
        Caption = 'Show Gold Price'
        OnClick = btnShowGoldPriceClick
      end
      object RzSpacer5: TRzSpacer
        Left = 374
        Top = 7
        Width = 14
        Height = 62
        Grooved = True
      end
      object RzSpacer6: TRzSpacer
        Left = 773
        Top = 7
        Width = 14
        Height = 62
        Grooved = True
      end
      object btnExportImages: TRzToolButton
        Left = 787
        Top = 0
        Width = 82
        Height = 76
        ImageIndex = 49
        Images = DM.vilMain
        Layout = blGlyphTop
        UseToolbarButtonSize = False
        Caption = 'Export Images'
        OnClick = btnExportImagesClick
      end
    end
  end
  object ImagesNew: TImageList
    ColorDepth = cd32Bit
    Height = 32
    ShareImages = True
    Width = 50
    Left = 1281
    Top = 48
    Bitmap = {
      494C010107000800040032002000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000C800000040000000010020000000000000C8
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      000E000000230000002E00000031000000310000003100000031000000310000
      0031000000310000003100000031000000310000003100000031000000310000
      0031000000310000003100000031000000310000003100000031000000310000
      00310000002E000000230000000E000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000060000001E0001004300020051000100430000
      001F000000060000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000030000000B00000011010101180202
      021E040404280404042904040429070707360909093D0909093E0909093E0909
      093E0909093E0909093E0909093E0909093E0909093E0909093D070707370404
      042904040429040404280101011C01010118000000110000000A000000040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000040000
      001A0000004000000056353535BB7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D
      7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D
      7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF3535
      35BB00000056000000400000001A000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000003000000060000000B0000001000000014000000160000
      00160000001D0003016600391DC9008746FC00954FFF009451FF009550FF008B
      48FD013A1DCA0004016200000008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000101011524242479474747A95B5B5BBF6A6A6ACE767676DA7C7C
      7CDF898989EB898989EB898989EB939393F3969696F6989898F7989898F79898
      98F7989898F7989898F7989898F7989898F7989898F7969696F6929292F28B8B
      8BEC898989EB8A8A8AEA808080E17A7A7ADC6E6E6ED15E5E5EC2474747A92525
      257A010101160000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      000E00000023303030A97E7E7EFFDFDFDFFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFDFDFDFFF7E7E
      7EFF303030A9000000230000000E000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000070000
      0017000000300000004E0505057613141395202120AA282C29B8252B27BB1A1F
      1CBD014020DD00924BFF00904DFF00904EFF00904FFF009150FF009251FF0192
      51FF009250FF00944DFF01351AC3000000210000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000006060606330C0C0C483131318A3E3E3E9C4D4D4DAD4F4F
      4FAF5D5D5DBE646464C4636363C3646464C46F6F6FCF777777D6787878D77878
      78D7787878D7787878D7787878D7787878D7777777D6707070D0646464C46363
      63C3646464C45C5C5CBD2A2A2A832B2B2B8420202072181818630F0F0F4E0606
      0632000000070000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000066E532BFFB4B4B4FFBCA785FFB28D4DFFB28D4DFFB28C4DFFB28C
      4CFFB18C4CFFB18C4CFFB18B4BFFB18B4BFFB18B4BFFB18B4AFFB08B4AFFB08A
      4AFFB08A4AFFB08A49FFB08A49FFB08A49FFAF8949FFAF8948FFBAA581FFB4B4
      B4FF6E532BFF0000000600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000010000000C0000002D0101016B2D2D
      2CB58B8B89E5E7E8E7FFE6E9E6FFD5DBD7FFBCCAC0FFA1BBAAFF779683FF0D82
      47FF008E48FF008B48FF008944FF018C48FF058F4EFF079152FF099354FF0993
      54FF099153FF079253FF029250FF015B2EE20000002200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000025252572C6C6C6FFC5C5C5FFC5C5C5FFC5C5
      C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5
      C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC5C5C5FFC8C8C6FFCACAC7FFC5C5
      C5FFC5C5C5FFC6C6C6FF3B3B3B8F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006E542BFF87693BFF987843FFB38E4EFFB38D4EFFB38D4EFFB28D
      4DFFB28D4DFFB28C4DFFB28C4CFFB28C4CFFB18C4CFFB18B4BFFB18B4BFFB18B
      4BFFB18B4AFFB08B4AFFB08A4AFFB08A4AFFB08A49FFB08A49FF96743EFF8366
      36FF6E542BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000020000001C0101016D474645D7B7B6B2FFD7D5
      D1FFECECEBFFEEEEEEFFE4E7E4FFD0D9D3FFB4C8BCFF92AE9DFF197D4BFF0089
      43FF008842FF00843FFF028743FF006429FF004912FF004F16FF005017FF0268
      2FFF0B9758FF0B9455FF0A9455FF059451FF023F22CB00000008000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000545454A4C3C3C3FFC3C3C3FFC3C3C3FFC3C3
      C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
      C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC6C6C3FFA2A2B7FF8C8CAFFFD3D3
      C8FFC3C3C3FFC3C3C3FF6E6E6EBE000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006F542BFF876A3CFF997944FFB48E50FFB48E4FFFB38E4FFFB38E
      4FFFB38D4EFFB38D4EFFB28D4DFFB28D4DFFB28C4DFFB28C4CFFB28C4CFFB18C
      4CFFB18B4BFFB18B4BFFB18B4BFFB18B4AFFB08B4AFFB08A4AFF96743FFF8466
      36FF6F542BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000010000001B0C0C0C9391918EFE999895FFB3B2AEFFD8D7
      D3FFF2F2F1FFF4F5F5FFE9EDEAFFD2DDD6FFB2CDBDFF589172FF00873FFF0086
      40FF00823BFF038643FF068F4EFF047035FF00571EFF005F24FF006024FF0576
      3CFF10A364FF0D9C5EFF0D985AFF0B9657FF059754FF0007046D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000525252A2C2C2C2FFC2C2C2FFC2C2C2FFC2C2
      C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC3C3C2FFC3C3C3FFC3C3
      C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFCACAC5FF8787ADFF000078FF4A4A
      9BFFCFCFC5FFC8C8C4FF6C6C6CBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006F552BFF886B3DFF9A7A45FFB58F51FFB48F51FFB48F50FFB48F
      50FFB48E4FFFB38E4FFFB38E4FFFB38D4EFFB38D4EFFB28D4DFFB28D4DFFB28C
      4DFFB28C4CFFB28C4CFFB18C4CFFB18B4BFFB18B4BFFB18B4BFF977540FF8467
      37FF6F552BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000601010160989896FF9B9B98FF999895FFB5B4B0FFDCDB
      D7FFF8F8F6FFFAFAFAFFEDF1EFFFD4E1D8FFADC7B7FF14834BFF00843EFF0082
      3CFF018642FF068F4EFF0D9A5CFF077B41FF006429FF006B2FFF016E30FF0985
      48FF17B075FF13A96BFF10A163FF0E9A5CFF0A9657FF055330DA000000050000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000525252A2C3C3C3FFC3C3C3FFC3C3C3FFC3C3
      C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFCDCDC7FFC6C6C4FFC7C7
      C4FFC7C7C4FFC7C7C4FFC7C7C4FFC7C7C4FFCDCDC6FF8C8CB2FF010186FF0303
      86FF0D0D89FFA6A6BAFF70706CBB000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000070552BFF886C3EFF9B7A46FFB59052FFB59052FFB59051FFB58F
      51FFB48F51FFB99861FFCDBEA5FFEEECE9FFFFFFFFFFFCFCFCFFFBFBFBFFDED7
      CCFFC0A87EFFB49052FFB28C4DFFB28C4CFFB28C4CFFB18C4CFF977540FF8567
      38FF70552BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000071616169FA2A2A0FFA5A4A2FF9C9B97FFB6B6B1FFDEDE
      DAFFFBFCFAFFFDFDFEFFEEF1EFFFD0E1D8FF95B1A1FF00843EFF00833DFF0085
      3FFF068F4FFF0E9C60FF19AA71FF108F55FF04793CFF078243FF078344FF1597
      5CFF2ABD8AFF1EB47CFF15AD70FF10A164FF0C995BFF0A9B5AFF000000290000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000545454A2C8C8C8FFC8C8C8FFC8C8C8FFC8C8
      C8FFC8C8C8FFC8C8C8FFC8C8C8FFC8C8C8FFD2D2CBFF5555A4FF000086FF0000
      89FF000089FF000089FF000089FF000089FF000089FF03038BFF0E0E8FFF0E0E
      8FFF0B0B8DFF000088FF34346DD2000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000071562BFF896C3FFF9C7B47FFB69154FFB69153FFB69153FFB590
      52FFBA9B67FFE5E0DAFFFFFFFFFFEAE8E4FFD3C7B3FFD1C3ADFFDAD1C4FFF4F4
      F2FFFBFBFBFFD5CAB9FFB69359FFB28D4EFFB28D4DFFB28C4DFF977641FF8568
      39FF71562BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000214141495AAA8A7FFABA9A9FF9B9A96FFB4B4B0FFD3D3
      CFFFCACDCAFFA7B1ABFF809889FF638E76FF3F8161FF00843CFF008640FF0492
      52FF10A268FF20B07BFF32C090FF22A770FF129655FF179F5DFF179F5DFF2AAE
      74FF49CEA3FF37C393FF24B983FF18AD73FF0F9F62FF0A9858FF000503590000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000555555A2C9C9C9FFC9C9C9FFC9C9C9FFC9C9
      C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FFD6D6CDFF4747A3FF080892FF0E0E
      94FF0E0E94FF0E0E94FF0E0E94FF0E0E94FF0E0E94FF0E0E94FF0E0E94FF0E0E
      94FF0E0E94FF0E0E94FF080892FF080874E30000032700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000072562BFF8A6D40FF9C7C48FFB79255FFB79254FFB79254FFB691
      54FFBFA475FFE4E0D9FFD1C4AEFFB69154FFB59051FFB58F51FFB48F51FFBA9B
      66FFDFD9CFFFFFFFFFFFD3C7B4FFB48F52FFB38D4EFFB38D4EFF977742FF8569
      39FF72562BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000016161582A9A7A7FFA9A9A7FFA2A19FFF999997FF8C8D
      8AFFA3A6A3FFBBC1BCFFC7D5CDFFC1D9CBFF62A485FF008741FF009755FF0CA4
      6BFF21AD7CFF39C094FF4FCEA6FF3ABC88FF27B072FF2EBA81FF2EBC83FF43C5
      94FF69D9B6FF51CDA3FF38BF8EFF23B681FF17AA70FF0D9E5FFF000906680000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000575757A2CDCDCDFFCDCDCDFFCDCDCDFFCDCD
      CDFFCDCDCDFFCDCDCDFFCDCDCDFFCDCDCDFFD9D9D0FF4B4BA8FF0A0A95FF1111
      97FF111197FF111197FF111197FF111197FF111197FF111197FF111197FF1111
      97FF111197FF111197FF111197FF111197FF111197FF0404257E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073572BFF8B6E41FF9D7D4AFFB89356FFB89356FFB79355FFB792
      55FFB79255FFB79254FFB69154FFB69153FFB69153FFB69052FFB99A64FFB895
      5BFFB58F51FFE2DDD5FFF7F6F6FFBEA274FFB48E4FFFB38E4FFF987843FF8669
      3AFF73572BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F1F1E7E9B9B99FF8E8C8CFF7E7D7BFFA3A29DFFD1D1
      CDFFE8EAE7FFEAEEEBFFDCE5DFFFC5DACCFF6CAA8FFF009857FF01A468FF17B6
      83FF1A9865FF0A8844FF18A35CFF28B577FF37C28DFF3FCA9AFF41CEA2FF3BCB
      9BFF2CBB82FF18A15AFF249F65FF32C18FFF1FB179FF13A96DFF0108055E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000575757A2D0D0D0FFD0D0D0FFD0D0D0FFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFDCDCD3FF4B4BACFF0B0B9BFF1212
      9DFF12129DFF12129DFF12129DFF12129DFF12129DFF12129DFF12129DFF1212
      9DFF12129DFF12129DFF12129DFF12129DFF12129DFF12129CFF0A0A6ED70000
      021F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073572BFF8B6F42FF9D7E4BFFB99458FFB99457FFBA975DFFC1A7
      7BFFB89356FFB79355FFB79255FFB79255FFB79254FFBA9962FFE5DDD1FFC1A8
      7CFFB69052FFBA9B66FFF7F7F6FFD8CFC0FFB48F51FFB48F50FF997944FF8769
      3CFF73572BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E1E1D7F797876FF868582FF979793FFB3B2AEFFD6D5
      D0FFF0F1EEFFF1F4F2FFE4ECE7FFCADED2FF8DB39FFF00A86CFF01B179FF21C0
      92FF43D0A9FF3EBB8AFF1DAB69FF32BE87FF3FCB9BFF47D2A8FF4AD7AFFF46D4
      ACFF35C694FF50C69AFF63D8B5FF3CC696FF25B582FF1AB278FF000201340000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000595959A2D1D1D1FFD1D1D1FFD1D1D1FFD1D1
      D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFDEDED5FF4E4EB0FF0A0AA0FF1111
      A2FF1111A2FF1111A2FF1111A2FF1111A2FF1111A2FF1111A2FF1111A2FF1111
      A2FF1111A2FF1111A2FF1111A2FF1111A2FF1111A1FF0B0B9DFF2A2AB1FF0909
      206A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000074582BFF8B6F43FF9E804CFFBA9559FFBC9B65FFD4C8B5FFF6F5
      F4FFCAB696FFB89457FFB89356FFB89356FFB9975DFFE6DFD3FFD4C8B5FFBA99
      62FFB69154FFB69153FFDED7CCFFF5F4F3FFB59052FFB59052FF9A7A45FF886A
      3CFF74582BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F1F1E7F8C8C8AFF999896FF999894FFB5B4B0FFDBDA
      D6FFF6F7F5FFF8F9F9FFECF0EDFFD0E0D6FFAAC5B3FF0DAC7DFF00BB87FF24C7
      9CFF49D2ADFF6BDDBEFF5FCFA9FF30C18BFF43D0A5FF4DD7B1FF50DAB4FF42D4
      ABFF71DABAFF94E7D1FF6AD9B7FF43C99DFF2AB987FF1D8963EB000000040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000595959A2D5D5D5FFD5D5D5FFD5D5D5FFD5D5
      D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFE1E1D8FF5050B4FF0D0DA5FF1414
      A7FF1414A7FF1414A7FF1414A7FF1414A7FF1414A7FF1414A7FF1414A7FF1414
      A7FF1414A7FF1414A7FF1414A7FF1111A5FF1010A4FF3838A5EB0202062F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000075592BFF8C7044FF9F804DFFBB965BFFE0D4C1FFF8F8F7FFFFFF
      FFFFE8E5E0FFDBCAAEFFB99458FFB99457FFE5DDD1FFEAE5DDFFBC9C65FFB893
      56FFB79255FFB79255FFCFC0A8FFFBFBFBFFB69153FFB69153FF9B7A46FF886B
      3DFF75592BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E1D1D7C9D9C9AFFA3A2A0FF9B9A97FFB6B5B1FFDEDE
      DAFFFBFBFAFFFCFDFDFFECF1EEFFCCDED4FFA9C9B6FF4AAE8FFF00C390FF22CC
      A1FF4CD4B1FF6DDCBFFF8DE5D0FF7BDEC1FF3ED2A6FF55DAB5FF4FD8B2FF88E4
      CAFFADEEDEFF91E6CEFF6CDAB8FF46CA9FFF2BBE8CFF07191386000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005B5B5BA2D7D7D7FFD7D7D7FFD7D7D7FFD7D7
      D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFE3E3D9FF4E4EB7FF0B0BA7FF1212
      A9FF1212A9FF1212A9FF1212A9FF1212A9FF1212A9FF1212A9FF1414AAFF1414
      AAFF1414AAFF1414AAFF0E0EA7FF2828B7FF1C1C4B9D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000076592CFF8D7145FFA0814EFFBC975CFFC3A97EFFE1DCD4FFF8F8
      F8FFCBBA9CFFBFA16FFFBA9559FFBA9559FFEAE5DDFFD3C6B2FFB99457FFB894
      57FFB89357FFB89356FFD0C2AAFFFBFBFBFFB79255FFB79254FF9B7A47FF886C
      3EFF76592CFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002120207FA5A4A3FFAAAAA8FF9C9B97FFB3B3AFFFD6D5
      D0FFD8DAD7FFBABFBCFF97A49DFF759181FF5B866FFF4B775DFF05B892FF10CE
      A4FF46D6B3FF6BDDC0FF8AE5CEFFA3ECDBFF8EE7D0FF42D6AFFF92E7D0FFB8F1
      E2FFA4ECD9FF8AE4CBFF66D7B5FF42C89CFF288E6CE80000000D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005B5B5BA2D9D9D9FFD9D9D9FFD9D9D9FFD9D9
      D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFE2E2DAFF6B6BC9FF2323BEFF2929
      BFFF2929BFFF2929BFFF2929BFFF2929BFFF2A2AC0FF2525BBFF1414AEFF1717
      B0FF1414AEFF0C0CADFF3838B5F304040C400000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000785A2CFF8E7246FFA18250FFBC985DFFBC985DFFCAB695FFFBFB
      FBFFCBB99BFFBB975BFFBB965BFFBA965AFFE6E0D5FFCFBEA5FFBA9559FFB995
      58FFB99458FFB99457FFDFDAD0FFF5F5F4FFB89356FFB89356FF9C7B48FF896C
      3FFF785A2CFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000020201F7EA7A7A5FFA7A7A5FF999895FF9B9A98FF7C7C
      7CFF838481FF9A9C99FFA9B1ACFFADBAB2FFA2BAABFF8EB49DFF649D83FF01CE
      A7FF31D6B2FF61DDBFFF82E4CCFF99E9D6FFA9EEDFFFA8EDDDFFB2F0E2FFA8ED
      DCFF98E9D4FF7CDFC3FF58D1ACFF3CB992F90102023700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005C5C5CA2DBDBDBFFDBDBDBFFDBDBDBFFDBDB
      DBFFDBDBDBFFDBDBDBFFDBDBDBFFDBDBDBFFDCDCDBFFD7D7D9FFBEBED8FFC2C2
      D8FFC2C2D8FFC2C2D8FFC2C2D8FFC2C2D8FFC7C7D9FF9292D1FF0C0CB2FF1010
      B2FF1B1BBCFF7979D5FF707072B9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000795B2DFF8E7248FFA28351FFBD995FFFBD995EFFC3A779FFFCFC
      FCFFE1DCD3FFBC985DFFBC975CFFBB975CFFE5DDD1FFCDBB9FFFBA965AFFBA96
      5AFFBA9559FFC1A373FFF8F8F7FFD9D0C1FFB99458FFB89457FF9D7C4AFF8A6D
      40FF795B2DFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F1F1F7E9B9A99FF8F8F8DFF71716FFF8B8986FFC8C7
      C4FFEAEAE8FFEBECEBFFE3E5E3FFD1D8D3FFB6C7BCFF9AB6A5FF7EA58EFF5A96
      7BFF15CEAEFF42DCBCFF6EE1C7FF8AE6D1FF99EAD8FFA2ECDBFFA2EBDAFF97E8
      D4FF84E1C8FF61D8B4FF52C6A3FF09100D6C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005D5D5DA2DDDDDDFFDDDDDDFFDDDDDDFFDDDD
      DDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDEDEDDFFE0E0DDFFE0E0
      DDFFE0E0DDFFE0E0DDFFE0E0DDFFE0E0DDFFE6E6DEFFA5A5D3FF0202B4FF3A3A
      CDFFB1B1DAFFECECDEFF7B7B7BBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007A5C2DFF8F7348FFA28352FFBE9A60FFBE9A60FFC09C65FFD9D0
      C1FFFDFDFDFFD0C2AAFFBC985DFFBC985DFFD0C1A8FFCBB899FFBB975CFFBB97
      5BFFBB965BFFE6E3DDFFF7F6F6FFC2A77BFFBA9559FFB99558FF9D7D4BFF8B6E
      42FF7A5C2DFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001D1D1C7F747472FF757472FF979691FFB3B2AEFFD5D4
      D0FFEEEFEDFFF2F2F1FFE9EAE9FFD8DBD8FFC0C9C2FFA5B6ABFF8AA694FF749A
      83FF699277FF55B8A1FF56DABFFF64E1C5FF77E4CCFF81E5CDFF80E3CBFF73DF
      C3FF6BD4B7FF66AA93FF617568FF0C0E0D5C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005E5E5EA2DFDFDFFFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFE3E3DFFFAEAEDBFF5E5ED5FFDBDB
      DDFFE6E6DFFFDFDFDFFF7C7C7CBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B5D2EFF8F7449FFA38453FFBF9B61FFBF9B61FFBE9B61FFC2A4
      73FFEAE7E2FFFCFCFCFFD4C7B2FFBE9A61FFBE9B63FFBF9A63FFBC985DFFC2A7
      79FFE5E0DAFFFFFFFFFFD6CAB8FFBC975EFFBB965AFFBA965AFF9E7E4CFF8B6F
      42FF7B5D2EFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001D1D1D7F81807DFF979694FF989793FFB4B3AFFFDBD9
      D5FFF6F5F4FFF8F8F8FFEFEFEFFFDDDFDDFFC7CBC7FFAEB7B0FF97A69AFF829A
      8AFF7A9B87FF93B19EFFB8CABEFFC0DBD3FFB1DBCFFF9ED3C4FF98CAB9FF96BA
      AAFF94AA9AFF8DA192FF6D7D72FF0F100F5D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005E5E5EA2E1E1E1FFE1E1E1FFE1E1E1FFE1E1
      E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1
      E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE5E5E1FFEBEBE1FFE2E2
      E1FFE1E1E1FFE1E1E1FF7D7D7DBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007C5F2FFF90754AFFA38554FFC09C63FFC09C62FFBF9B62FFBF9B
      61FFC5A87BFFE6E3DDFFFFFFFFFFEEECEAFFD8CEBDFFD4C6B1FFE1DBD2FFF7F7
      F6FFFBFBFBFFD7CDBCFFBE9D67FFBC975CFFBB975CFFBB975BFF9F804DFF8C6F
      43FF7C5F2FFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001C1C1C7C9A9A98FFA0A09DFF9B9A96FFB6B5B1FFDEDD
      D8FFFAFAF8FFFDFDFDFFF3F3F3FFE0E1E0FFCBCBC9FFB2B6B1FF9DA49DFF8B97
      8EFF88998CFFA1B4A8FFCEDCD4FFF1F5F2FFF5F6F5FFDFE8E3FFC7D6CCFFB1C3
      B6FFA4B4A9FF95A197FF7E8680FF0E0F0E5C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000606060A2E3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FF7E7E7EBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007D6031FF91754BFFA48655FFC19D64FFC09D64FFC09C63FFC09C
      63FFC09C62FFC2A270FFD2C2AAFFEDEBE8FFFFFFFFFFFDFDFDFFFBFBFBFFDFD9
      CEFFC7B08BFFBE9B63FFBD995EFFBD985EFFBC985DFFBC985DFFA0804EFF8C70
      45FF7D6031FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002120207FA3A3A1FFA8A7A5FF9B9C97FFB6B5B0FFDEDD
      D9FFFCFCFAFFF5F5F5FFE3E3E2FFD8D8D6FFD1D1CFFFCECFCDFFCFD1CEFFD0D3
      D0FFD0D5D1FFD3D8D5FFDFE4E1FFEDF0EEFFF4F6F5FFE6EAE7FFCED6D1FFB9C2
      BBFFADB2ADFF9CA19BFF838681FF0F100F5D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000606060A2E3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FF7F7F7FBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000806133FF91754CFFA58656FFC19E65FFC19D65FFC19D64FFC19D
      64FFC09D64FFC09C63FFC09C63FFC09C62FFBF9C62FFBF9B62FFBF9B61FFBF9B
      61FFBE9A60FFBE9A60FFBE9A5FFFBD995FFFBD995FFFBD995EFFA18150FF8D71
      45FF806133FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000020201F7EA7A7A5FFABAAA9FFA09E9BFFC4C3C0FFD6D5
      D3FFC8C8C6FFC5C3C0FFCAC7C4FFCBCAC6FFCECDCAFFD2D1CEFFD5D4D1FFD7D7
      D4FFD9D9D6FFDBDCD8FFDBDDDAFFDEE0DDFFDEE1DFFFE4E6E3FFE2E4E2FFCDD0
      CCFFB1B2B0FF9EA09BFF858682FF10100F5D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000616161A2E6E6E6FFE6E6E6FFE6E6E6FFE6E6
      E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6
      E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6
      E6FFE6E6E6FFE6E6E6FF7F7F7FBC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000816335FF91764DFFA58758FFC29F66FFC29E66FFC29E65FFC19E
      65FFC19E65FFC19D64FFC19D64FFC09D64FFC09C63FFC09C63FFC09C62FFBF9C
      62FFBF9B62FFBF9B61FFBF9B61FFBE9A60FFBE9A60FFBE9A5FFFA18251FF8E72
      47FF816335FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000020201F7EA4A3A1FFB6B6B4FFBEBDBAFFB8B7B3FFB6B4
      B0FFBBB9B6FFC0BEBBFFC5C3BFFFCBC9C5FFCECBC9FFD1CECDFFD4D3CEFFD6D4
      D3FFD7D6D6FFDBDAD6FFDCDCD9FFDCDCDBFFDEDDDAFFDDDEDBFFDEDEDCFFE1E1
      DFFFD8D8D6FFADADAAFF848481FF10100F5D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000626262A2E6E6E6FFE6E6E6FFE6E6E6FFE6E6
      E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6
      E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6
      E6FFE6E6E6FFE6E6E6FF808080BC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000826537FF92774EFFA68858FFC39F67FFC29F67FFC29F67FFC29F
      66FFC29E66FFC29E66FFC19E65FFC19E65FFC19D64FFC19D64FFC09D64FFC09C
      63FFC09C63FFC09C62FFBF9C62FFBF9B62FFBF9B61FFBF9B61FFA28352FF8E72
      48FF826537FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000020201F7FA8A7A6FFADABA7FFAAA8A3FFAFADA9FFB5B3
      AFFFBAB8B4FFBDBBB9FFC3C1BCFFC8C6C2FFCCCBC7FFCECECBFFD2CFCEFFD5D4
      D1FFD7D6D4FFD9D6D6FFDAD9D7FFDCDAD6FFDDDBD9FFDDDCDAFFDEDDDBFFDFDE
      DCFFDFDFDCFFD5D4D2FD9E9D99FF1010105D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000626262A2E9E9E9FFE9E9E9FFE9E9E9FFE9E9
      E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9
      E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9
      E9FFE9E9E9FFE9E9E9FF818181BC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084673AFF896F49FF7E6743FF7E6743FF7E6743FF7E6743FF7E67
      43FF7D6743FF7D6743FF7D6742FF7D6642FF7D6642FF7D6641FF7D6641FF7D65
      41FF7D6541FF7C6541FF7C6540FF7C6540FF7C653FFF7B653FFF7B643FFF856B
      43FF84673AFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002626257FA09D99FFA4A29DFFAAA6A3FFAEACA6FFB1AF
      ABFFB7B5B1FFBABAB6FFC0BDB9FFC3C3BFFFCAC8C4FFCECCC9FFCFCFCCFFD3D2
      CFFFD5D4D1FFD5D5D1FFD6D6D4FFD7D6D5FFDAD7D6FFDBD8D7FFDCDBD8FFDBDC
      D9FFDDDBDAFFDFDEDCFFC8C8C6FF1414145D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000626262A2EAEAEAFFEAEAEAFFEAEAEAFFEAEA
      EAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEA
      EAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEA
      EAFFEAEAEAFFEAEAEAFF828282BC000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000917B5BFF6B573AFFDFDFDFFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFDFDFDFFF6855
      36FF917B5BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002727267E9C9A94FFA3A19CFFA6A59FFFACA8A5FFB0AE
      AAFFB3B1ADFFB9B7B3FFBCBAB8FFC2C0BBFFC5C3C1FFCBC9C4FFCECDCAFFD0CF
      CCFFD2CFCEFFD4D2CFFFD5D2CFFFD6D5D2FFD7D6D3FFD8D5D4FFD9D6D5FFDAD7
      D5FFDBDAD6FFDCDBD8FFD3D2D0FF1615155C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363A2EBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFF0F0F0FFF5F5F5FFF5F5
      F5FFF5F5F5FFF6F6F6FF8A8A8AC1000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A29B8FFFD3D3D3FFDFDFDFFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFDFDFDFFFD3D3
      D3FFA29B8FFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000A0A0A409C9A96FFA29E99FFA4A39FFFAAA6A3FFAEAC
      A6FFB1B0ACFFB7B3AFFFBBB9B5FFBFBDB8FFC3C1BCFFC7C5C2FFCBC9C5FFCDCC
      C8FFCFCDCBFFCFCFCCFFD0D0CDFFD3D1CDFFD4D1CEFFD5D4D1FFD6D5D1FFD7D6
      D4FFD7D7D5FFDAD9D8FFC0BFBCFF020202210000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363A2ECECECFFECECECFFECECECFFECEC
      ECFFECECECFFECECECFFECECECFFECECECFFECECECFFECECECFFECECECFFECEC
      ECFFECECECFFECECECFFECECECFFECECECFFF1F1F1FFB1B1B1FF757575FF7878
      78FF777777FF717171FF0F0F0F51000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ACACACFFD3D3D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3D3
      D3FFACACACFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000036363591A09E9AFFA39F9BFFA7A6A0FFACAA
      A4FFAFAEAAFFB3B2AEFFB9B5B1FFBBB9B7FFC0BEBAFFC3C1BCFFC6C4C0FFC9C5
      C3FFCBC9C4FFCDCBC8FFCECCC9FFCECCCBFFCFCFCCFFD0CFCCFFD3D0CFFFD4D3
      D0FFD8D5D2FFC8C7C4FF201F1F6F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363A2EBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEB
      EBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFF5F5F5FF7D7D7DFF747474FF6F6F
      6FFF646464FF0909094F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ACACACFFF0F0F0FFD2D2D2FFD2D2D2FFC7C7C7FFD2D2D2FFD2D2
      D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2
      D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFF0F0
      F0FFACACACFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001818175E9C9B98F0A6A39FFFA8A5
      A1FFAEABA7FFB1AFABFFB6B4B0FFBAB8B2FFBCBAB7FFBDBBB9FFC1BFBAFFC2C1
      BCFFC4C2C0FFC8C6C1FFCAC8C4FFCCCAC6FFCDCAC7FFCECDCAFFCFCECBFFCDCA
      C9FF949392E50D0D0D4800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363A2EDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFF7F7F7FF767676FF666666FF5C5C
      5CFF0808084F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003B3B3B96AEAEAEFFD2D2D2FFC7C7C7FF17F7FFFFC7C7C7FFD2D2
      D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2
      D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFAEAE
      AEFF3B3B3B960000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000021E1E1D647473
      72C6BDBAB7FFB7B4B2FFAFAEAAFFB3B1ADFFB7B4B0FFB9B7B2FFBBB9B6FFBDBB
      B8FFBFBDBAFFC1BFBCFFC3C1BEFFC5C2BFFFCAC9C6FFC8C7C3FF696967BD1515
      1457000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000646464A2ECECECFFECECECFFECECECFFECEC
      ECFFECECECFFECECECFFECECECFFECECECFFECECECFFECECECFFECECECFFECEC
      ECFFECECECFFECECECFFECECECFFECECECFFF9F9F9FF666666FF515151FF0707
      074F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003B3B3B96AFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAF
      AFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAF
      AFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFF3B3B
      3B96000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000070F0F0E442D2D2C754C4C4B9B6A6968B9797977C8888786D58A89
      86D5797976C76A6A69B94B4B4A9A292929720D0D0D4100000004000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005D5D5D9CEFEFEFFFEFEFEFFFEFEFEFFFEFEF
      EFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEF
      EFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFEFEFEFF4E4E4EFF0606064F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000001010113505050955656569A5656569A5656
      569A5656569A5656569A5656569A5656569A5656569A5656569A5656569A5656
      569A5656569A5656569A5656569A5656569A5858589D0B0B0B4F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B0E117E343F4DCF343F
      4DCF343F4DCF343F4DCF343F4DCF343E4CCF353F4ECF353F4ECF353F4ECF353F
      4ECF353F4ECF343E4CCF353F4ECF353F4ECF353F4ECF353F4ECF343E4DCE343E
      4DCE343D4CCE343E4DCE343E4DCE343E4DCE343E4DCE343E4DCE36404FCF343E
      4DCE343E4DCE343E4DCE343E4DCE343E4DCE080A0C6E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000051000000D0000000FD000000BD00000012000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013161877B4C2D4FF95A3
      B3FF95A3B3FF95A3B3FF96A3B3FF94A1B1FF96A3B3FF96A3B3FF96A4B3FF97A4
      B4FF97A4B4FF93A0B0FF96A3B3FF97A4B4FF97A4B4FF97A5B4FF98A5B5FF98A6
      B5FF93A1B1FF98A6B5FF99A6B5FF99A6B5FF99A6B5FF99A6B5FF96A3B3FF99A7
      B6FF9AA7B6FF9AA7B6FF9AA8B7FFBAC7D9FF17191C7200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000007D100E0CFE564B40FF6B5C4DFF302922FF000000CC000000120000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000010101221214166A1518
      1A6F15181A6F15181A6F15181A6F15181A6F16181A6F16181A6F16181A6F1618
      1A6F16181A6F16181A6F16181A6F15181A6F15181A6F15181A6F15181A6F1518
      1A6F15181A6F1417186E0505063F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000050404
      0454060606620000000500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000001185919EE44857
      63FF3F4E59FF44535EFF3E4C57FF374550FF374450FF374550FF374450FF3745
      50FF374550FF374550FF374550FF374450FF374450FF374550FF394853FF3A49
      54FF3A4954FF394854FF394853FF394853FF394753FF384753FF384752FF4353
      5EFF455460FF3A4954FF44525FFF8D99A7E60000000D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0050110E0CFE7D7062FF918374FF8D8072FF837465FF38312AFF000000CC0000
      0011000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000203032D889BA6F3ABC4D1FFACC5
      D2FFADC6D3FFADC7D3FFAEC7D4FFAFC8D4FFAFC8D4FFAFC8D5FFAFC8D5FFB0C9
      D5FFAFC8D5FFAFC8D5FFAFC8D5FFAFC8D4FFAEC7D4FFAEC7D4FFADC6D3FFACC6
      D2FFACC5D2FFABC4D1FFA3BBC7FF2A2E32B20000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000010101013620201FC2494A
      4DFF3E4042FF191817C500000035000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000101213678493
      A1FF6F8191FFAEC2D5FF8C9FB5FF708495FF708495FF708495FF708495FF7184
      95FF718495FF708495FF708495FF708495FF708495FF708495FF586B89FF4759
      7DFF8F9599FF8F9599FF8F9598FF8F9598FF8F9598FF2F4673FF778A9BFFA0B3
      C9FFAEC1D4FF4F5F6CFF748492FF1E2023690000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00CF564B3FFF908373FFA69B8FFFABA095FFA3988DFF948779FF3F3831FF0000
      00CC000000120000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000282D3091ADC6D3FFAEC7D3FFAFC8
      D4FFAFC8D5FFB0C9D5FFB1CAD6FFB1CAD6FFB2CBD6FFB2CBD7FFB2CBD7FFB2CB
      D7FFB2CBD7FFB2CBD7FFB2CBD7FFB1CAD6FFB1CAD6FFB0C9D6FFB0C9D5FFAFC8
      D4FFAEC7D4FFADC6D3FFACC5D2FF92A6B1FF0505063F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000001A1616159E4A4A4CFC3E4053FF2B33
      65FF394D81FF393F4FFF313130F80808078D0000001400000001000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000075E66
      72D1738495FFA6B8CDFF97AAC1FF99ACC3FF95A9C1FF8BA7B9FF8CA6BAFF95A9
      C1FF95A9C1FF95A9C1FF96A9C1FF96AAC1FF96AAC1FF96AAC1FF778EB9FF4F68
      A8FFBBB4BCFFBCB6BDFFBCB6BDFFBCB5BDFFBDB8BEFF2A4C9EFFA7BCD1FF9EB0
      C7FFA5B6CCFF556472FF78838FDA000000050000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FD6A5B4CFF8D7E71FFAA9F94FFC0B7AFFFC1B9B1FFB6ADA3FFA3978AFF433D
      36FF000000CC0000001200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000363C409FAFC8D5FFB0C9D5FFB1CA
      D6FFB2CBD7FFB3CCD7FFB3CCD8FFB4CDD8FFB4CDD9FFB5CDD9FFB5CED9FFB5CE
      D9FFB5CED9FFB5CED9FFB4CDD9FFB4CDD8FFB4CDD8FFB3CCD8FFB2CBD7FFB2CB
      D6FFB1CAD6FFB0C9D5FFAFC8D4FF97ABB6FF0C0D0E5700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000081010107A464645F2434655FF2D3563FF1E2D86FF1E2F
      95FF3E66CBFF3452A1FF313D61FF32353CFF1D1C1ADC01010150000000060000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000090A
      0B478D9CADEFA6B8CDFF8C9FBCFF547CA2FF528792FF52808CFF458184FF5489
      94FF548793FF558A96FF558996FF568A97FF568C99FF578D9AFF4678A9FF4661
      A1FF7A687CFF7C6A7EFF7B697DFF79677BFF807486FF2B51A4FF6183BBFF9EB0
      C7FFA5B6CCFF616D79CF0D0E0F47000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00BF322A23FF827364FFA2978BFFC1B9B0FFD6D1CBFFD5CFC9FFC5BCB4FFAB9F
      93FF453E37FF000000CC00000012000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000363D419FB2CBD7FFB3CCD7FFB3CB
      D7FFB4CDD8FFB5CED9FFB6CFDAFFB7CFDAFFB7D0DBFFB7D0DBFFB8D0DBFFB8D0
      DBFFB8D0DBFFB7D0DBFFB7D0DBFFB7D0DAFFB6CFDAFFB6CFDAFFB5CED9FFB4CD
      D8FFAFC7D2FFB2CBD7FFB1CAD6FF99ADB8FF0C0D0E5700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0001090908583C3D3CDF465253FF3A5D70FF283C96FF2036AEFF2438ACFF3143
      B3FF577EE3FF3C63C7FF2F50AEFF2B3C73FF31302CFF292824F90000003F0000
      000F000000010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000292D327FA6B8CCFF8295B7FF10567BFF1B6349FF25564EFF26574FFF2563
      58FF29615BFF306569FF305A61FF1E6553FF235E4FFF1B6D51FF147491FF4663
      A3FF695C6AFF665667FF655667FF645465FF716776FF2550A7FF1746A1FF9EB0
      C7FFA7B8CCFF0A0B0C3F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0014000000D03A332BFF938678FFB5ABA2FFD4CEC8FFE7E4E1FFE0DBD7FFC8C0
      B8FFABA094FF453E37FF000000CC000000120000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001616156000000000373E419FACBFC6FFB5CED9FFB0C8
      D2FF8FA1A8FF8E9EA6FF8F9FA6FF8F9FA7FF8F9FA6FF909FA6FF909FA7FF90A0
      A7FF90A0A7FF909FA7FF909FA6FF909FA6FF8F9FA6FF8F9FA6FF8E9EA5FF8E9E
      A6FF9DB2BBFFB5CED9FFB4CDD8FF9BAFBAFF0C0E0E5700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000030303383031
      2FC64A5655FF37555CFF2E677CFF418AB7FF314FC9FF3650CEFF344BC7FF3146
      BEFF5D85E8FF4F75DBFF4163C5FF2D479BFD161513C404040472010101480000
      002A0000000E0000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000011131551B7CADDFF6680B3FF1F4B94FF7A6D91FF8361B2FF6A57A5FF7754
      AFFF8456B4FF9257C0FF8C6CAAFF7360AAFF7C6EA9FF817494FF3E609BFF5571
      AFFFB0ADB0FFC6C3C6FFC6C3C6FFC6C3C5FFC7C6C8FF2752A9FF1047AAFF91A5
      C5FFB5C8DBFF0000001100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000014000000D0413A32FFA29588FFC3BBB3FFDFDAD6FFEBE9E6FFE0DB
      D7FFC8C0B8FFABA093FF453E37FF000000CC0000001100000000000000000000
      0028000000670000008F000000A2000000A10000008C000000600000001F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E1F1D70545552AE6E726FD28E9898FFB8D1DBFFB6CE
      D8FFB1C8D2FFB9D1DCFFBBD4DEFFBCD4DEFFBCD5DFFFBDD5DFFFBDD5DFFFBDD5
      DFFFBDD5DFFFBDD5DFFFBCD5DFFFBCD5DFFFBCD4DEFFBBD4DEFFB8D0DAFFB0C7
      D1FFADC4CDFFB7D0DBFFB6CFDAFF9DB1BBFF0B0D105700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000101011E222321A6515E52FE3E5F
      61FF306D7CFF2B7995FF3583A1FF4D9FCBFF4162D8FF3C59D5FF3751D0FF324A
      C8FF5E86E7FF4E75DAFF486ACDFF3B55A9F50101014E00000038000000240000
      00150000000B0000000300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0C3FAFC2D6FF617AB0FF254DA3FF88798AFF857289FF665D6FFF7472
      7EFF685C6FFF6A5E71FF7C7C88FF5A797AFF6E6B7AFF796B7EFF425F9EFF4865
      A4FF856F81FF665466FF5F4E5FFF5D4C5DFF6C606FFF2955ABFF1248AAFF8B9F
      C1FFACC0D4FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000014000000D0463F37FFAA9E91FFC7BFB7FFDFDBD6FFEBE9
      E6FFE0DCD7FFC8C0B8FFA99E91FF423B33FF000000B900000060000000D0100E
      0CFF352F29FF4E453CFF5A5045FF594F45FF4C443AFF322C26FF0C0A09FE0000
      00C4000000500000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000042423FA812121153484D4EAE8F9796FFB9D0DAFFB7CE
      D8FF9BAEB6FF93A4ABFF92A2A9FF92A2A9FF93A2A9FF93A2A9FF93A2A9FF93A2
      A9FF93A2A9FF93A2A9FF93A2A9FF92A2A9FF92A1A8FF92A2A8FF93A4ABFF9AAC
      B3FFA8BDC6FFBAD2DDFFB9D1DCFF9FB3BDFF224CA8E93166E7F4000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000D161615854C554BF6405E44FF3B7150FF358A
      98FF398EA3FF3D8FA8FF4290AAFF4DA1CAFF4365D4FF3E5ED3FF3956D1FF354F
      CEFF5D84E7FF4D74D9FF4769CCFF3F5CB8FC0000002C0000001B0000000E0000
      0006000000010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0C3FA9BCD1FF5F79AEFF244DA5FF978D95FF978A94FF938690FF938A
      91FF867B85FF897E88FF9C9199FF92858EFF8A7E89FF877D87FF4763A1FF4966
      A5FF7A6172FF846A7AFF7A6373FF665160FF7A6977FF2755ACFF1048ABFF889C
      BEFFA8BBD1FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000015000000D0484139FFAA9E92FFC7BFB7FFDFDB
      D6FFEBE9E6FFD8D2CCFFABA095FF7B6F62FF000000FF24201CFF6B6054FF9687
      76FFADA295FFBFB6ACFFC5BDB5FFC5BDB5FFBDB4AAFFAB9F92FF938473FF6359
      4EFF1B1815FF000000BC0000001D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000C2E2E2C7F868A88DBADBFC6FFBDD5DFFFB9D1
      DAFFABC0C8FFB4CAD3FFBAD1DAFFBFD7E0FFC2DAE3FFC2DAE3FFC2DBE3FFC2DB
      E4FFC2DBE4FFC2DAE3FFC2DAE3FFC1DAE3FFBDD5DEFFB9D0D9FFB2C8D1FFAABF
      C7FFABC1C9FFBCD5DFFFBBD4DEFFA1B5BEFF255ACCFF3470FDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000020C0C0C644D4942E6486752FF2F5C3FFF234A30FF488A66FF479D
      A9FF4598A7FF4090A4FF428EA4FF4DA1C8FF4366CEFF3F60CDFF3B59CCFF3652
      CBFF5B83E5FF4C72D8FF4668CBFF405DBBFF0000001E00000007000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0C3F8B9DB2FF3E517BFF1B3A7DFF50444FFF493946FF493946FF5449
      54FF473744FF483845FF524752FF4A3A46FF4E3F4DFF3F3340FF2D4170FF354A
      79FF463745FF513F4DFF4E3F4CFF54414FFF4F4450FF1B3F85FF0B337DFF5C6C
      8BFF9EB1C7FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000014000000D0484139FFAA9E92FFC7BF
      B7FFE3DFDBFFE2DFDBFFD7D2CCFFB1A69BFF6E6458FF9D9082FFC0B9B0FFC5BE
      B2FFC8BEAAFFCBC2AFFFD0C7B5FFCFC6B4FFCBC1AEFFC7BDA9FFC4BDB3FFBEB5
      ACFF998C7CFF504840FF010100E8000000340000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F403DA2000000103B40419F9CA7A8FFBFD8E1FFBED6
      DFFFAABFC6FFA1B3BAFF9CADB3FF98A8AFFF96A5ACFF96A5ABFF96A5ACFF96A5
      ABFF96A5ABFF96A5ABFF96A5ABFF96A5ABFF99A9AFFF9CADB4FFA2B4BBFFA8BC
      C3FFB3C9D2FFBFD7E1FFBDD6E0FFA3B7C0FF265BCDFF3470FDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000505
      05423E3C37D0675C45FF736138FF29563BFF2C533AFF345A41FF509470FF479D
      AAFF4394A2FF3F8D9CFF418B9DFF4BA0C7FF4265C7FF3F60C4FF3B5AC3FF3754
      C3FF5880E2FF4B71D7FF4567C9FF3F5CBAFF0000011900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0C3F76879CFF2A3784FF112180FF505064FF504F64FF1F1B5EFF2220
      6DFF626374FF696B7DFF313384FF2E2C75FF717587FF646579FF131E8DFF1D28
      8DFF6A6F83FF585870FF171578FF262161FF606377FF3C5387FF061B8AFF3844
      8BFF8EA0B5FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000014000000D0484139FFACA1
      95FFC0B8AFFFD6D0CAFFE4E0DDFFA99D90FFB1A69AFFC2BAADFFC1B08AFFDECE
      A7FFE7DBBDFFEAE0C8FFECE3CEFFECE3CDFFEADFC6FFE6D9BAFFDCCBA2FFBEAE
      8AFFC3BCB1FFABA093FF6B6157FF030302ED0000002B00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000021222177575853AC838682DFABBABEFFC2DAE3FFBBD3
      DBFFA4B7BEFFADC2C9FFB4C9D0FFB8CED6FFBDD3DAFFBED5DCFFBED5DCFFC2D9
      E1FFC3DAE2FFBFD6DDFFBED4DCFFBCD2D9FFB8CDD5FFB2C7CEFFADC1C9FFA8BB
      C3FFA8BCC3FFC1D9E3FFC0D8E2FFA5B9C1FF265BCDFF3470FDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000010101262B2A29B26761
      4DFE816D3BFF926A30FFA28241FF3D6C4FFF3C684CFF396248FF519873FF46A0
      ACFF4295A2FF3E8A98FF3F8797FF4A9FC6FF4062C1FF3D5EBDFF3A59BBFF3754
      B9FF557BDEFF4970D5FF4466C8FF3D5BB9FF0101032500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0C3F8798ACFF070EA0FF050B96FF6A769CFF7382A0FF070D99FF080E
      9EFF90A1B9FF96A7C2FF212BB9FF242EB6FF96A6BEFF8391BAFF0007ACFF161E
      ACFF8D9DB6FF707DB2FF0209A2FF19219BFF7382A1FF59669EFF050B98FF1922
      9AFF9DB1C5FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000015000000D04B45
      3EFF867A6EFFB0A599FFAEA397FFB6ABA1FFBAAE95FFCCB57BFFDBC895FFE2D3
      A7FFE8DCB7FFECE1C2FFEDE4C9FFEDE4C8FFEBE0C0FFE6DAB3FFE0D1A3FFD9C5
      91FFC7B077FFBDB39FFFB0A599FF645C53FF000000D70000000A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000272826823A3A38925D6360C3898D8AFFC3DBE3FFC4DD
      E5FFB9CFD7FFB0C4CBFFABBEC4FFA7B9BFFFA4B5BBFFA3B3B9FFA2B3B9FF9FAE
      B4FF9EAEB4FFA2B2B8FFA2B3B9FFA4B5BBFFA7B9BFFFACBEC5FFAFC3CAFFB3C8
      CFFFBFD6DEFFC4DCE4FFC2DAE3FFA7BBC3FF275BCDFF3471FDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001919178A4A4841FC9A89
      49FFCEAE50FFC49D4CFFB79E53FF49825FFF437757FF3F6E51FF549F78FF47A8
      B3FF439AA7FF3E8D9BFF3E8796FF489EC5FF3D5DBEFF3B5AB8FF3856B4FF3552
      B1FF5278DBFF486ED4FF4264C6FF3C59B8FF0203063200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0C3F9CAEC1FF0E56DCFF0054EBFFB4D4F3FFD0E8F6FF1163EFFF045C
      F0FFD1EAFAFFD2EBFBFF045EF3FF1268F4FFD7EEFCFFBDDDFBFF035EF3FF2877
      F4FFD5EDFAFFA5CCF8FF035BF0FF327AF0FFD0E8F6FF95BEF3FF0155EBFF2C6A
      D9FFAABED1FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000140000
      00B7000000FB665D54FFAFA498FFB8AD94FFCCB26EFFD8C386FFE0D09AFFE7DA
      ABFFECE1B8FFEFE5C1FFF0E8C6FFF0E7C6FFEEE4C0FFEBDFB5FFE5D7A7FFDECD
      95FFD6BF82FFC7AD6BFFBBB19EFFAB9F93FF393430FF00000083000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000606052E5E6364BAC2D9E1FFC7DFE7FFBFD6
      DDFF9DAEB4FFA8BBC0FFB1C5CBFFB3C7CDFFB4C8CEFFB9CED4FFBACED5FFBACF
      D5FFBACFD5FFB9CED4FFB9CED4FFB4C8CEFFB3C7CDFFB2C5CCFFADC0C6FFA1B2
      B8FFA6B9BFFFC6DEE6FFC4DDE5FFA9BDC4FF275CCEFF3471FDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010101219A8F
      4FD8EBD36DFFDBBD5FFFC1B260FF559B71FF4E8E67FF48835EFF58A982FF4BB4
      BEFF45A5B1FF4096A3FF3F8D9CFF489DC6FF3A59BEFF3856B7FF3653B1FF334F
      ABFF4F74D8FF476DD2FF4163C5FF3B58B6FF03040A3F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0D3FABBFD1FF256AD9FF005DF5FF9CC8FCFFDAF2FFFF2B7AF7FF005D
      F5FFC0E0FDFFDAF2FFFF0C65F6FF0661F5FFDAF2FFFFC1E1FDFF005DF5FF2B7A
      F7FFDAF2FFFF9CC7FCFF005DF5FF478EF8FFDAF2FFFF81B5FBFF005DF5FF518C
      E2FFACC0D3FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00240C0B0AFBA19589FFBBB2A5FFC1A65FFFD3BB74FFDDCA8AFFE5D59CFFEADD
      AAFFEEE3B4FFEFE5BBFFF0E7BEFFF0E7BDFFEFE5BAFFEDE1B3FFE9DBA7FFE3D2
      98FFDBC786FFD1B871FFBCA360FFBBB3A9FF958B7EFF030302F1000000100000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D44469FC7E0E8FFC9E1E9FFCAE2
      EAFFC9E0E7FFBED4DAFFB6CAD0FFB5C8CEFFB5C7CEFFB0C2C8FFB0C2C8FFB0C1
      C7FFB0C1C7FFAFC1C7FFB0C2C8FFB4C7CDFFB4C7CDFFB4C8CEFFB8CCD3FFC2D9
      E0FFCAE2E9FFC8E0E8FFC7DFE7FFABBEC6FF1A3353B0132E519B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A2A0
      6ECDFAF296FFEEDB77FFCAC36EFF65B58AFF5DA97DFF559C72FF5FB58DFF53C2
      CBFF4CB4BDFF45A4AFFF439AA7FF489EC8FF3958C1FF3754B9FF3451B1FF324D
      AAFF4C70D5FF456BD1FF4062C3FF3956B5FF04070F4D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0D3FAFC3D5FF467AD2FF0157F2FF79ADF9FFDAF2FFFF498BF6FF0157
      F2FFA7CEFBFFDAF2FFFF1E6CF3FF0157F2FFD3EDFEFFC5E3FDFF0157F2FF2D77
      F4FFDAF2FFFF92BEFAFF0157F2FF5B98F7FFDAF2FFFF649EF7FF0157F2FF75A1
      DFFFADC1D4FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00844E4943FFB8AEA3FFB3A06EFFCCB161FFD7C076FFE0CE89FFE6D798FFEADC
      A3FFECDFAAFFEDE1AEFFEDE2B0FFEDE2B0FFEDE1AEFFECDFA9FFE9DBA1FFE5D5
      95FFDECB86FFD5BD72FFCAAE5EFFB4A47BFFB4A99EFF3A3632FF000000650000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D44469FCAE2E9FFCBE3EAFFC4DB
      E1FF9EAFB3FFA0B0B5FFABBCC2FFB4C7CCFFB7CAD0FFB8CBD0FFB8CCD1FFB9CC
      D1FFB9CCD1FFB8CBD1FFB7CBD0FFB7CACFFFB6C9CFFFAEC0C6FFA5B6BBFF9BAB
      B0FFAABDC2FFCBE3EAFFC9E1E9FF9CCEB1FF188A10DB319F2DE0000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BBBB
      8EDBFFFFBAFFFFFEB0FFDEE69BFF85D9B2FF6FC298FF65B58AFF67C198FF5DD0
      D6FF55C3CCFF4DB5BEFF4AAAB5FF49A1CBFF3B5CC9FF3756BFFF3451B5FF314C
      ACFF496DD4FF436ACFFF3E60C1FF3855B3FF0609155A00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0D3FB0C4D6FF5C83C7FF0151EEFF5691F4FFDAF2FFFF669DF6FF0151
      EEFF8DB9F9FFDAF2FFFF3074F1FF0151EEFFC6E3FDFFCAE6FDFF0151EEFF2E72
      F1FFDAF2FFFF88B5F8FF0151EEFF6EA3F6FFDAF2FFFF4685F3FF0151EEFF8CA8
      D2FFADC1D5FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00CD8A8177FFB7AEA3FFBC9F4DFFCFB460FFD9C373FFE1CE84FFE6D590FFE8D9
      98FFE9DB9DFFEADCA1FFEADDA3FFEADDA3FFEADCA0FFE9DA9DFFE8D897FFE5D4
      8EFFE0CC81FFD7C070FFCDB15DFFB59A50FFBBB2A8FF736C65FF000000AF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E44479FCCE4EBFFCEE5ECFFCFE7
      EDFFD0E8EEFFCEE6ECFFC5DBE0FFBDD1D6FFBACED3FFBACDD2FFB9CCD1FFBACD
      D2FFBACDD2FFB9CCD1FFB9CCD2FFBACDD2FFBACDD2FFC0D4DAFFC8DEE4FFCFE7
      EEFFCEE6EDFFCDE5ECFFCBE3EAFF96D6A8FF15C500FF3ECF32FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6D5
      B1EBFBF8BFFFF1E792FFDEE394FFB2FEE5FFA4F7D6FF8DE1BBFF74CEA8FF67D9
      DFFF61D2D8FF58C5CDFF54BCC5FF4CA6CEFF3F64D1FF3B5DC8FF3655BDFF324F
      B3FF466BD3FF4268CEFF3C5EC0FF3653B2FF080C1A6700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0B0D3FB1C5D7FF6382BEFF014BE8FF3572E9FFD5EDF9FF83AFF6FF014B
      E9FF74A4F5FFDAF2FFFF417DF0FF014BE9FFB9D9FBFFCFEAFEFF014BE9FF2E6E
      EEFFDAF2FFFF7EACF6FF014BE9FF80ADF5FFD5ECF9FF2767E7FF024BE5FF90A6
      C7FFAEC2D5FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000040302
      02FAB0A69CFFB2A489FFC3A449FFD0B55CFFDAC36DFFE0CD7BFFE4D285FFE5D4
      8BFFE6D690FFE7D793FFE7D895FFE7D895FFE7D793FFE6D690FFE5D48BFFE3D1
      84FFDFCB79FFD8C06BFFCEB35AFFC1A247FFB1A695FF9E958CFF000000E00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F45489FCEE6EDFFD0E8EEFFC8DE
      E4FFA2B2B6FFA0B0B4FFA2B2B7FFABBCC1FFB2C4C9FFB8CAD0FFBACDD2FFBACD
      D2FFBACDD2FFBACDD2FFBACCD1FFB5C7CCFFAEBFC4FFA6B6BBFF9FAEB3FF9EAE
      B2FFADC0C5FFCFE7EDFFCDE5ECFF98D8A9FF14C600FF3ECF32FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001A19
      1254767041B5E1D476FBE1E39CFFCBFFFBFFBFFFF3FFB2FEE7FF8DDFBFFF8EF8
      F9FF7AE9EDFF66D6DCFF61CDD4FF4FAAD1FF4670D8FF4068D1FF3B5FC8FF3656
      BDFF466CD3FF4067CCFF3B5DBEFF3452B0FF0A0F227500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0C0D3FB2C5D8FF6785BAFF0444D4FF1D4AAEFFADBEC5FF9ABEF3FF0146
      E5FF5D90F0FFDAF2FFFF5086EEFF0146E5FFAFD0F9FFD3EDFEFF0146E5FF306C
      EAFFDAF2FFFF74A2F2FF0146E5FF8FB5F1FFACBDC4FF1243AEFF0745CCFF91A6
      C7FFAFC3D6FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000001B1211
      10FFBAB1A7FFB09E74FFC4A546FFD0B557FFD9C166FFDECA71FFE1CD79FFE2CF
      7EFFE3D183FFE4D286FFE4D387FFE4D287FFE4D285FFE3D183FFE2CF7DFFE1CD
      78FFDEC870FFD7BE63FFCEB253FFC2A242FFAFA182FFB4ABA1FF020202FB0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F46489FD0E8EEFFD2EAF0FFD4EB
      F1FFD5EDF2FFD6EEF3FFD6EDF2FFCEE3E8FFC7DCE0FFC2D6DAFFC0D4D7FFC0D3
      D7FFC0D3D7FFBFD3D7FFC0D4D7FFC3D8DCFFC9DEE3FFD0E6EBFFD6EDF3FFD4EC
      F2FFD3EBF0FFD1E9EFFFCFE7EEFF99D9ABFF14C600FF3ECF32FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000010100174B4E3D94DFFFFFFFD6FFFEFFCCFFFCFFA1E7D0FFA4FF
      FFFF9CFFFFFF93FCFDFF84EEF2FF54B1D4FF4D7DDFFF4875DAFF436CD2FF3C62
      C9FF486FD6FF3F65CAFF395BBDFF3350AEFF0C12298100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0C0D3FB2C6D8FF6785B9FF1C4FB9FF707C72FF7D8A7BFF81A2D3FF0A46
      D1FF3C6ED6FF9EBEE1FF4878D7FF0643CEFF79A1DDFF9ABBE1FF0845CFFF2D62
      D5FFA3C2E4FF5584DDFF0947D7FF789BCDFF828B75FF677779FF194FBBFF91A7
      C7FFAFC4D6FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000211514
      13FFBFB6ACFFAE9C6FFFC8AB50FFD3B85EFFDAC36BFFDFCB75FFE1CD7AFFE1CE
      7CFFE2CE7CFFE1CE7AFFE1CD79FFE1CD79FFE1CD78FFE0CC75FFDFCA71FFDEC8
      6CFFDBC464FFD5BB59FFCCAF4AFFC09F3AFFAE9E7AFFBCB3AAFF040404FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004046489FD2EAF0FFD4ECF1FFCDE3
      E8FFA5B5B8FFA3B3B7FFA4B3B7FFA4B3B6FFA9B9BDFFAEBFC3FFB3C4C8FFB4C4
      C8FFB4C4C8FFB3C4C8FFB1C1C5FFACBCC0FFA5B4B8FFA2B1B5FFA2B1B5FFA1B1
      B5FFB1C3C8FFD3EBF1FFD1E9EFFF9BDBACFF14C600FF3ECF32FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001A1C1B57EEFFFFFFDAFBF5FFB9F0DEFFA2ECD5FFB2FF
      FFFFABFFFFFFA4FFFFFFA3FEFFFF62C0DFFF70A7FAFF5E92EDFF4D7DDEFF4571
      D4FF4B74D9FF3D64C9FF385ABBFF314FADFF0D15328F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0C0D3FB3C7D9FF6887BAFF1D5EBDFF2F66ABFF2057A0FF1E64C1FF1E64
      C2FF1E64C2FF1E64C2FF1E64C2FF1F64C2FF1F64C2FF1F65C2FF1F65C3FF1F65
      C3FF1F65C3FF1F66C4FF1F66C5FF1E64C2FF295793FF2667BAFF1A5ABDFF91A8
      C8FFAFC4D7FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000016100F
      0FFFC4BBB2FFAD9B73FFCDB15EFFD5BD69FFDCC774FFE1CE7CFFE3D082FFE3D2
      86FFE4D389FFE5D38AFFE4D389FFE3D183FFE1CE7AFFDFCA70FFDCC565FFDBC3
      5FFFD8BE58FFD2B64DFFC9AA40FFBD9A32FFAD9E80FFBBB3ABFF010101F70000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004047499FD4ECF2FFD6EEF3FFD8EF
      F4FFDAF1F6FFDBF3F7FFDDF4F8FFDEF5F9FFD8EFF2FFD4E9EDFFD0E5E8FFD0E5
      E8FFD0E5E8FFCFE4E8FFD0E6E9FFD5EBEEFFDAF1F5FFDCF3F7FFDBF2F6FFD9F0
      F5FFD7EFF4FFD5EDF2FFD3EBF1FF9CDCADFF14C600FF3ECF32FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000607072C5C7A6FB890DABDFA96E3C7FF9DE8D2FFBCFF
      FFFFB7FFFFFFB2FFFFFFB3FFFFFF67C6DFFF84BFFFFF7CB6FFFF74ACFEFF6397
      F1FF5480DFFF3C62C7FF3658BAFF304DABFF0F193B9C00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0C0D3FB4C8DAFF6988BBFF2063C3FF2C6CBDFF5D7170FF226AC9FF226B
      CAFF226BCAFF216AC8FF226AC9FF236CCAFF256CCAFF256DCBFF256ECBFF246D
      CAFF236CCAFF236CCAFF226CCBFF266BC2FF63756DFF2168C8FF1C5CC0FF92A8
      C8FFB0C5D8FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010101
      01F3BDB5AEFFAD9F88FFCDB364FFD8C176FFDECA7EFFE2D086FFE5D38AFFE5D4
      8DFFE6D590FFE6D691FFE6D692FFE6D692FFE6D691FFE6D58FFFE5D48BFFE2CF
      7EFFDCC66CFFD3B856FFC6A63BFFB79429FFB1A698FFA7A19AFF000000D70000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000505052F000000134147489FD3E8ECFFD8EFF3FFD0E6
      EBFFA8B8BBFFA7B7B9FFA7B6B9FFA7B6B9FFA7B5B8FFA6B5B8FFA8B7BBFFABBA
      BDFFABBABDFFABB9BDFFA6B5B8FFA5B4B7FFA5B4B7FFA5B4B7FFA4B4B7FFA4B4
      B7FFB4C6CAFFD7EFF4FFD5EDF2FFA9D3BEFF1E6213BD235C19AF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000001011517241F695A897DC8C3FF
      FFFFBFFFFFFFBBFFFFFFBFFFFFFF6CCCDFFF91D1FFFF8BC9FFFF84C0FFFF7CB6
      FFFF6493E6FF3A61C6FF3557B8FF2E4CAAFF121D44A900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000A0C0D3FACC0D2FF728BB4FF28529AFF28559BFF29559BFF28549BFF2855
      9CFF28549BFF28549BFF28549BFF28559BFF28549BFF28549BFF28549BFF2855
      9BFF28549BFF28549BFF28549BFF28559BFF28549BFF27549BFF264E99FF94AA
      C5FFABBFD2FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00BD938E89FFBCB3A9FFBDA55FFFDBC786FFE0CE8CFFE4D391FFE7D795FFE8D8
      98FFE8D99AFFE8DA9BFFE8DA9BFFE8DA9BFFE8D99BFFE8D999FFE8D898FFE6D6
      95FFE3D390FFDFCD8BFFDAC584FFB59D5CFFC2B9B0FF7A7672FF0000009F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000809083E525451B4686D6CC5939995FFCADEE1FFDCF3
      F8FFDEF5F9FFE0F7FAFFE1F8FCFFE2F9FCFFE3FAFDFFE3FAFDFFE0F6F9FFDDF3
      F6FFDDF3F6FFDDF3F6FFE2F9FCFFE2F9FCFFE2F9FCFFE1F8FBFFDFF6FAFFDDF4
      F8FFDBF3F7FFD9F1F5FFD7EFF4FFB7C1C6FF714842C9664136B9000000050000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000090C0C3BC7FF
      FFFFC4FFFFFFC2FEFFFFC0FEFEFF79D9E8FF9CDEFFFF96D8FFFF91D1FFFF8BC9
      FFFF6D9DE6FF395FC4FF3355B7FF2D4AA9FF142150B700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000181B1D61A6BCCDFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BB
      CCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BB
      CCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BBCCFFA4BB
      CCFFA4BACCFF0203032100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      006E4E4C4AFFCFC8C0FFA99567FFDCCA91FFE3D39BFFE6D89FFFE9DBA2FFEADD
      A5FFEBDEA6FFEBDEA7FFEBDEA8FFEBDEA8FFEBDEA7FFEBDEA6FFEADDA4FFE8DA
      A2FFE6D79FFFE2D29BFFD9C68AFFA99773FFD1CAC3FF353432FF000000500000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001414145E2D2D2C82636867B9B4C1C0FFC5D7D9FFD5EB
      EEFFABBBBDFFAABABCFFA9B8BBFFA8B7BAFFA7B6B9FFA7B5B9FFA7B5B8FFA6B4
      B8FFA6B4B7FFA6B5B8FFA6B4B8FFA7B5B8FFA7B6B9FFA8B6B9FFA7B6B9FFA7B6
      B9FFB7CACDFFDBF2F7FFD9F0F5FFB8BDC2FFCC6C6CFFD47470FF000000070000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000A0E0E3DC9FF
      FFFFB3FAFBFF96F1F2FF82E9EBFF8BE7F0FFA3E5FFFFA0E2FFFF9BDDFFFF96D8
      FFFF75A6E8FF385EC3FF3254B6FF2C49A7FF16255AC400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005C6A74C2A4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BA
      CCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BA
      CCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BACCFFA4BA
      CCFFA4BACCFF343B408D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0012060605F4C4BFB9FFBDB4AAFFBBA464FFE6D9AEFFE9DDB1FFEBE0B3FFEDE2
      B5FFEEE3B6FFEEE4B7FFEFE4B7FFEFE4B7FFEEE4B7FFEEE3B6FFEDE1B4FFEBDF
      B3FFE9DCB0FFE6D8ACFFB49D61FFC5BDB4FFB1ACA7FF000000E3000000050000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000101011B2F2F2E86979A96E1B4BFBDFFD5EBEFFFE0F7
      FBFFE2F9FCFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE2F9FCFFE1F8
      FBFFDFF6FAFFDDF4F8FFDAF2F6FFB9BEC2FFCC6B6BFFD57671FF000000010000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000010112233C
      3D834D999BD56DDADEFE6FDCE0FF83E0EAFFA8E8FFFFA6E7FFFFA2E5FFFF9FE1
      FFFF7DAFE9FF375DC2FF3153B4FF2B48A6FF182966D100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000069747CBBC4DCE9FFC4DAE7FFCBE2EDFFCBE2EDFFCBE2EDFFCBE2EDFFCBE2
      EDFFCBE2EDFFCBE2EDFFCBE2EDFFCBE2EDFFCBE2EDFFCBE2EDFFCBE2EDFFCBE2
      EDFFCBE2EDFFCBE2EDFFCCE1ECFFCCE1ECFFCCE1ECFFCCE1ECFFC8DEE9FFC3DA
      E7FFBFD4E0FB383E418800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000965C5955FFDBD5D0FFAFA28CFFC8B275FFEDE4C5FFEFE6C7FFF0E8
      C8FFF1E9C9FFF2E9CAFFF2EACAFFF2EACAFFF1E9CAFFF1E9C9FFF0E8C8FFEFE6
      C7FFEDE3C4FFC0AA6CFFB6AB9CFFDBD6D0FF43413EFF00000078000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010100F553C3E3B9C565C5BB59AA19DFFCDE1E2FFD8ED
      F0FFADBDBFFFAABABCFFA9B8BBFFA8B7BAFFA8B6B9FFA7B5B8FFA6B4B7FFA6B4
      B8FFA7B5B8FFA5B4B7FFA6B4B8FFA7B5B8FFA7B6B9FFA8B7B9FFA8B7BAFFA9B8
      BBFFBACCCEFFDEF5F9FFDCF3F7FFBABFC3FFCC6B6BFFD57772FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000002040426152B2D77426B73B6ABE7FFFFA9E7FFFFA7E7FFFFA5E6
      FFFF83B5EAFF365CC1FF3052B4FF2A47A5FF1A2D72DE00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000004131718515F6D74B1B3C6D5FE84929EFF788891FF75848CFF7888
      91FF75848CFF788891FF788891FF788791FF788791FF788791FF788791FF7887
      91FF788791FF788790FF788790FF788791FF788790FF818F9BFFB0C3D0FC515E
      63A2030404230000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000019030202EEA7A19CFFDDD8D4FFB0A38DFFBDA76BFFEFE7CEFFF5F0
      DFFFF6F1DFFFF6F1E0FFF6F1E0FFF6F1E0FFF6F1DFFFF6F0DFFFF5F0DFFFECE3
      C7FFB6A064FFB7AB9BFFDFDAD6FF918C86FF000000DE0000000A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010100F542C2C2A817A7E7CCABAC7C6FFD1E4E6FFE2F9
      FCFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE2F9FCFFE0F7FAFFDDF4F8FFBBC0C4FFCC6A6AFFCB726DF9000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000012191C58ACE4FFFFABE5FFFFAAE6FFFFA8E6
      FFFF87B9EAFF355CC0FF2F51B3FF2946A4FF1D3280EC00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B0D0E3E72828AC595A8B5E088999DE4889A
      9EE491A4AAE898ADB7E098ADB7E098ADB7E098ADB7E098ADB7E098ADB7E098AC
      B6E098ACB6E098ACB6E098ACB6E098ACB6E0A0B5C1E9606D75B60506072D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000057141311FDBCB6B0FFE3E0DCFFC4BCB2FFA6905EFFCAB7
      83FFEBE2C5FFFAF8F2FFFCFBF8FFFCFBF8FFFAF7F0FFE9DEBEFFC5B27CFFA691
      64FFCAC3BBFFE4E0DCFFACA7A1FF0B0A09F90000003D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000C474845A4989A96E1A8B0ACFFD1E5E7FFE3FA
      FDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE2F9FCFFE1F8FBFFDEF5F9FFBBC0C4FFCC6A6AFFC7716DF7000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000013191D58ACDFFFFFACE1FFFFAFE6FFFFA7E0
      FDFF82B8F1FF497BD9FF3459BCFF2845A4FF20388EF900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000708073C0B0B
      0A4B090909430000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000076171614FEABA59FFFE5E2DFFFE4E0DDFFC7BF
      B6FFAF9F80FFA68F5BFFA8905AFFA7905AFFA6905DFFB1A287FFCBC4BCFFE6E2
      DFFFE5E1DEFF9F9A94FF0F0E0DFB000000590000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002124247AE0F7FBFFE2F9FCFFE3FA
      FDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FAFDFFE3FA
      FDFFE3FAFDFFE2F9FCFFDFF6FAFFB6BBBFFF683938BF894F4CCD000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001115195395C5F5FE7BAEEFFF5E94E7FF4E86
      E2FF518BE2FF538FE3FF5794E6FF4C81DAFF3457AEF800000006000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000E0000
      0006000000100000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000060070606F46A6561FFD3CEC9FFE8E5
      E2FFECEAE7FFECEAE7FFECE9E7FFECE9E7FFECEAE7FFECEAE7FFE9E6E3FFD0CC
      C7FF605C58FF030202EC0000004A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000C555C5EBCD0E4E7FFD6EB
      EEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EB
      EEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EBEEFFD6EB
      EEFFD6EBEEFFD4E9ECFFB8C9CDFF373B3CAE0000000100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000101021D0B1120641E325EAB3A62
      B6EF3F6BC8FB2B477FC915223A88060910470000000B00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000025000000B0121110FD5E5B
      57FFA3A09CFFD3D0CDFFE8E6E4FFE7E5E3FFD2CFCDFFA09D9BFF585654FF0C0C
      0BFA000000A00000001900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000020202260606
      063F0606063F060606420808094D0B0C0D570F10115F10111166101112671011
      126710111267101011670F1011650E10105F0C0C0D580808094F060606440506
      063F0606063F0606063F03030431000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00030000000D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000280000
      0080000000C1000000EB050505FE040404FD000000E7000000BA000000760000
      001E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000C8000000400000000100010000000000000700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'CSV File (*.csv)|*.csv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 1193
    Top = 45
  end
  object qryAllData: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select'
      '  T1.CUST_NO AS "Custno",'
      '  T2.TRAN_TICKET_NO AS "CustTicketNo",'
      '  T1.CUST_LAST AS "CustLast",'
      '  T1.CUST_FIRST AS "CustFirst",'
      '  T1.CUST_MID AS "CustMid",'
      '  T1.CUST_DOB AS "CustDOB",'
      '  T1.CUST_GENDER AS "CustGender",'
      '  T1.CUST_RACE AS "CustRace",'
      '  T1.CUST_HAIR AS "CustHair",'
      '  T1.CUST_EYES AS "CustEyes",'
      '  T1.CUST_MARK AS "CustMark",'
      '  T1.CUST_WEIGHT AS "CustWeight",'
      '  T1.CUST_HEIGHT AS "CustHeight",'
      '  T1.CUST_ADDR AS "CustAddr",'
      '  T1.CUST_APT AS "CustApt",'
      '  T1.CUST_CITY AS "CustCity",'
      '  T1.CUST_STATE AS "CustState",'
      '  T1.CUST_ZIP AS "CustZip",'
      '  T1.CUST_PLACE_EMPLY AS "CustPlaceEmply",'
      '  T1.CUST_FL_DRV_LIC AS "CustFlDrvLic",'
      '  T1.CUST_ID AS "CustID",'
      '  T1.CUST_ID_TYPE AS "CustIDType",'
      '  T1.CUST_ID_AGENCY_STATE AS "CustIDAgencyState",'
      '  T1.CUST_PH_HOME AS "CustPhHome",'
      '  T1.CUST_PH_BUSINESS AS "CustPhBussiness",'
      '  T1.CUST_PH_BEEP AS "CustPhBeep",'
      '  T1.CUST_PH_CELL AS "CustPhCell",'
      '  T1.CUST_COMMENT AS "CustComment",'
      '  T2.TRANSACTION_NO AS "TransactionNo",'
      '  T2.CUST_NO AS "CustNo_1",'
      '  T2.TRAN_DATE AS "TranDate",'
      '  T2.TRAN_TICKET_NO AS "TranTicketNo",'
      '  T2.TRAN_COMMENT AS "TranComment",'
      '  T2.TRAN_MATURITY AS "TranMaturity",'
      '  T2.TRAN_TYPE AS "TranType",'
      '  T2.TRAN_STATUS AS "TranStatus",'
      '  T2.TRAN_VOID_DATE AS "TranVoidDate",'
      '  T2.TRAN_PAWN_AMOUNT AS "TranPawnAmount",'
      '  T2.TRAN_INTEREST AS "TranInterest",'
      '  T2.PRINC_BALANCE AS "PrincBalance",'
      '  T2.INTEREST_BALANCE AS "InsterestBalance",'
      '  T2.TRAN_TIME AS "TranTime",'
      '  T3.INV_ITEM_NO AS "InvItemNo",'
      '  T3.INV_ITEM_BARCODE AS "InvItemBarcode",'
      '  T3.INV_CAT_NO AS "InvCatNo",'
      '  T3.J_TYPE AS "JType",'
      '  T3.J_STYLE AS "JStyle",'
      '  T3.J_METAL AS "JMetal",'
      '  T3.INV_ITEM_COUNT AS "InvItemCount",'
      '  T3.NOTE AS "Note",'
      '  T3.SIZE_LENGTH AS "SizeLength",'
      '  T3.WEIGHT AS "Weight",'
      '  T3.KT AS "KT",'
      '  T3.CREATED AS "Created",'
      '  T3.UNIT_COST AS "UnitCost",'
      '  T3.UNIT_PRICE AS "UnitPrice",'
      '  T3.INV_ITEM_STATUS AS "InvItemStatus",'
      '  T3.TRANSACTION_NO AS "TransactionNo_1",'
      '  T3.INV_ORIGINAL_ITEM_NO AS "InvOriginalItemNo",'
      '  T3.INV_ITEM_BRAND AS "InvItemBrand",'
      '  T3.SERIAL_NUMBER AS "SerialNumber",'
      '  T3.OWNER_APP_NUMBER AS "OwnerAppNumber",'
      '  T3.MODEL_NUMBER AS "ModelNumber",'
      '  T3.GENDER AS "Gender",'
      '  T3.DESCRIPTION AS "Description"'
      'from CUSTOMER T1'
      '  join TRANSACTIONS T2 on T1.CUST_NO = T2.CUST_NO'
      
        '  left outer join INVENTORY_ITEMS T3 on T2.TRANSACTION_NO = T3.T' +
        'RANSACTION_NO'
      'order by T2.TRAN_DATE, T2.TRAN_TIME')
    Left = 925
    Top = 152
    object qryAllDataCustno: TIntegerField
      Tag = 1
      FieldName = 'Custno'
    end
    object qryAllDataCustTicketNo: TWideStringField
      Tag = 1
      FieldName = 'CustTicketNo'
      Size = 15
    end
    object qryAllDataCustLast: TWideStringField
      Tag = 1
      FieldName = 'CustLast'
      Size = 35
    end
    object qryAllDataCustFirst: TWideStringField
      Tag = 1
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryAllDataCustMid: TWideStringField
      Tag = 1
      FieldName = 'CustMid'
      Size = 1
    end
    object qryAllDataCustDOB: TDateField
      Tag = 1
      FieldName = 'CustDOB'
    end
    object qryAllDataCustGender: TWideStringField
      Tag = 1
      FieldName = 'CustGender'
      Size = 1
    end
    object qryAllDataCustRace: TWideStringField
      Tag = 1
      FieldName = 'CustRace'
      Size = 1
    end
    object qryAllDataCustHair: TWideStringField
      Tag = 1
      FieldName = 'CustHair'
      Size = 5
    end
    object qryAllDataCustEyes: TWideStringField
      Tag = 1
      FieldName = 'CustEyes'
      Size = 5
    end
    object qryAllDataCustMark: TWideStringField
      Tag = 1
      FieldName = 'CustMark'
      Size = 10
    end
    object qryAllDataCustWeight: TFloatField
      Tag = 1
      FieldName = 'CustWeight'
    end
    object qryAllDataCustHeight: TWideStringField
      Tag = 1
      FieldName = 'CustHeight'
      Size = 8
    end
    object qryAllDataCustAddr: TWideStringField
      Tag = 1
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryAllDataCustApt: TWideStringField
      Tag = 1
      FieldName = 'CustApt'
      Size = 5
    end
    object qryAllDataCustCity: TWideStringField
      Tag = 1
      FieldName = 'CustCity'
      Size = 40
    end
    object qryAllDataCustState: TWideStringField
      Tag = 1
      FieldName = 'CustState'
      Size = 2
    end
    object qryAllDataCustZip: TWideStringField
      Tag = 1
      FieldName = 'CustZip'
      Size = 11
    end
    object qryAllDataCustPlaceEmply: TWideStringField
      Tag = 1
      FieldName = 'CustPlaceEmply'
      Size = 30
    end
    object qryAllDataCustFlDrvLic: TWideStringField
      Tag = 1
      FieldName = 'CustFlDrvLic'
    end
    object qryAllDataCustID: TWideStringField
      Tag = 1
      FieldName = 'CustID'
      Size = 25
    end
    object qryAllDataCustIDType: TWideStringField
      Tag = 1
      FieldName = 'CustIDType'
    end
    object qryAllDataCustIDAgencyState: TWideStringField
      Tag = 1
      FieldName = 'CustIDAgencyState'
      Size = 10
    end
    object qryAllDataCustPhHome: TWideStringField
      Tag = 1
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryAllDataCustPhBussiness: TWideStringField
      Tag = 1
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryAllDataCustPhBeep: TWideStringField
      Tag = 1
      FieldName = 'CustPhBeep'
      Size = 14
    end
    object qryAllDataCustPhCell: TWideStringField
      Tag = 1
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryAllDataCustComment: TMemoField
      Tag = 1
      FieldName = 'CustComment'
      BlobType = ftMemo
    end
    object qryAllDataTransactionNo: TIntegerField
      Tag = 1
      FieldName = 'TransactionNo'
    end
    object qryAllDataCustNo_1: TIntegerField
      Tag = 1
      FieldName = 'CustNo_1'
    end
    object qryAllDataTranDate: TDateField
      Tag = 1
      FieldName = 'TranDate'
    end
    object qryAllDataTranTicketNo: TWideStringField
      Tag = 1
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryAllDataTranComment: TMemoField
      Tag = 1
      FieldName = 'TranComment'
      BlobType = ftMemo
    end
    object qryAllDataTranMaturity: TDateField
      Tag = 1
      FieldName = 'TranMaturity'
    end
    object qryAllDataTranType: TWideStringField
      Tag = 1
      FieldName = 'TranType'
      Size = 1
    end
    object qryAllDataTranStatus: TWideStringField
      Tag = 1
      FieldName = 'TranStatus'
      Size = 1
    end
    object qryAllDataTranVoidDate: TSQLTimeStampField
      Tag = 1
      FieldName = 'TranVoidDate'
    end
    object qryAllDataTranPawnAmount: TFloatField
      Tag = 1
      FieldName = 'TranPawnAmount'
    end
    object qryAllDataTranInterest: TFloatField
      Tag = 1
      FieldName = 'TranInterest'
    end
    object qryAllDataPrincBalance: TFloatField
      Tag = 1
      FieldName = 'PrincBalance'
    end
    object qryAllDataInsterestBalance: TFloatField
      Tag = 1
      FieldName = 'InsterestBalance'
    end
    object qryAllDataTranTime: TTimeField
      Tag = 1
      FieldName = 'TranTime'
    end
    object qryAllDataInvItemNo: TIntegerField
      Tag = 1
      FieldName = 'InvItemNo'
    end
    object qryAllDataInvItemBarcode: TWideStringField
      Tag = 1
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryAllDataInvCatNo: TIntegerField
      Tag = 1
      FieldName = 'InvCatNo'
    end
    object qryAllDataJType: TWideStringField
      Tag = 1
      FieldName = 'JType'
      Size = 1
    end
    object qryAllDataJStyle: TWideStringField
      Tag = 1
      FieldName = 'JStyle'
      Size = 1
    end
    object qryAllDataJMetal: TWideStringField
      Tag = 1
      FieldName = 'JMetal'
      Size = 1
    end
    object qryAllDataInvItemCount: TIntegerField
      Tag = 1
      FieldName = 'InvItemCount'
    end
    object qryAllDataNote: TWideStringField
      Tag = 1
      FieldName = 'Note'
      Size = 80
    end
    object qryAllDataSizeLength: TFloatField
      Tag = 1
      FieldName = 'SizeLength'
    end
    object qryAllDataWeight: TFloatField
      Tag = 1
      FieldName = 'Weight'
    end
    object qryAllDataKT: TFloatField
      Tag = 1
      FieldName = 'KT'
    end
    object qryAllDataCreated: TSQLTimeStampField
      Tag = 1
      FieldName = 'Created'
    end
    object qryAllDataUnitCost: TFMTBCDField
      Tag = 1
      FieldName = 'UnitCost'
      Precision = 19
    end
    object qryAllDataUnitPrice: TFMTBCDField
      Tag = 1
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object qryAllDataInvItemStatus: TWideStringField
      Tag = 1
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryAllDataTransactionNo_1: TIntegerField
      Tag = 1
      FieldName = 'TransactionNo_1'
    end
    object qryAllDataInvOriginalItemNo: TIntegerField
      Tag = 1
      FieldName = 'InvOriginalItemNo'
    end
    object qryAllDataInvItemBrand: TWideStringField
      Tag = 1
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryAllDataSerialNumber: TWideStringField
      Tag = 1
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryAllDataOwnerAppNumber: TWideStringField
      Tag = 1
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryAllDataModelNumber: TWideStringField
      Tag = 1
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryAllDataGender: TWideStringField
      Tag = 1
      FieldName = 'Gender'
      Size = 1
    end
    object qryAllDataDescription: TWideStringField
      Tag = 1
      FieldName = 'Description'
      Size = 120
    end
  end
  object ActionListMainForm: TActionList
    Images = DM.vilMain
    Left = 1044
    Top = 44
    object actClientPawnAndPurchase: TAction
      Caption = 'Pawn && Purchases'
      ImageIndex = 28
      ImageName = 'actCashOnHand'
      OnExecute = actClientPawnAndPurchaseExecute
    end
    object actInventory: TAction
      Caption = 'Active Items List'
      ImageIndex = 29
      ImageName = 'actActiveIventory'
      OnExecute = actInventoryExecute
    end
    object actLeadsOnlineExport: TAction
      Caption = 'LeadsOnline Export'
      ImageIndex = 41
      ImageName = 'LeadsOnline Logo'
      OnExecute = actLeadsOnlineExportExecute
    end
    object actBackup: TAction
      Caption = 'Backup Database'
      ImageIndex = 24
      ImageName = 'actBackupDB'
      OnExecute = actBackupExecute
    end
  end
  object Timer15Min: TTimer
    Enabled = False
    Interval = 900000
    OnTimer = Timer15MinTimer
    Left = 782
    Top = 38
  end
end
