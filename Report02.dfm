object frmReport02: TfrmReport02
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pawn list'
  ClientHeight = 453
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 21
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 418
    Height = 278
    TabOrder = 0
    object GroupBox3: TGroupBox
      Left = 59
      Top = 157
      Width = 290
      Height = 93
      TabOrder = 3
      object rbPawnList: TRadioButton
        Left = 19
        Top = 13
        Width = 161
        Height = 26
        Caption = 'List of New Pawns'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rbPawnWithPayments: TRadioButton
        Left = 19
        Top = 51
        Width = 161
        Height = 26
        Caption = 'List of Payments'
        TabOrder = 1
      end
    end
    object pnDateRange: TRzPanel
      Left = 54
      Top = 92
      Width = 295
      Height = 63
      BorderOuter = fsNone
      TabOrder = 2
      object RzLabel1: TRzLabel
        Left = 8
        Top = 3
        Width = 37
        Height = 21
        Caption = 'From'
      end
      object RzLabel2: TRzLabel
        Left = 160
        Top = 3
        Width = 15
        Height = 21
        Caption = 'To'
      end
      object edFrom: TRzDateTimeEdit
        Left = 8
        Top = 25
        Width = 123
        Height = 29
        EditType = etDate
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edTo: TRzDateTimeEdit
        Left = 160
        Top = 25
        Width = 123
        Height = 29
        EditType = etDate
        TabOrder = 1
      end
    end
    object rbTranStatusActive: TRzRadioButton
      Left = 59
      Top = 22
      Width = 159
      Height = 23
      AlignmentVertical = avCenter
      AutoSizeWidth = 159
      Caption = 'List of Active Pawns'
      TabOrder = 0
      OnClick = rbDateRangeClick
    end
    object rbDateRange: TRzRadioButton
      Left = 59
      Top = 58
      Width = 243
      Height = 44
      AlignmentVertical = avCenter
      AutoSizeWidth = 243
      Caption = 'All Pawns and Purchase in Date Range.'
      Checked = True
      TabOrder = 1
      TabStop = True
      WordWrap = True
      OnClick = rbDateRangeClick
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 4
    Top = 288
    Width = 418
    Height = 84
    TabOrder = 1
    DesignSize = (
      418
      84)
    object btnExit: TBitBtn
      Left = 301
      Top = 16
      Width = 103
      Height = 52
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 8
      TabOrder = 0
      OnClick = btnExitClick
    end
    object btnPreview: TRzBitBtn
      Left = 20
      Top = 16
      Width = 115
      Height = 52
      Caption = 'Preview'
      TabOrder = 1
      OnClick = btnPreviewClick
      ImageIndex = 30
      Images = DM.vilMain24
      Spacing = 0
    end
    object btnPrint: TRzBitBtn
      Left = 158
      Top = 16
      Width = 115
      Height = 52
      Caption = 'Print'
      TabOrder = 2
      OnClick = btnPrintClick
      ImageIndex = 0
      Images = DM.vilMain24
      Margin = 10
      Spacing = 0
    end
  end
  object qryPawnAndPurchases: TFDQuery
    OnCalcFields = qryPawnAndPurchasesCalcFields
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select T2.TRAN_STATUS as "TranStatus",'
      '  T1.CUST_FIRST as "CustFirst",'
      '  T1.CUST_MID as "CustMid",'
      '  T1.CUST_LAST as "CustLast",'
      '  T1.CUST_PH_CELL as "CustPhCell",'
      '  T2.TRAN_TICKET_NO as "TranTicketNo",'
      '  T2.TRAN_TYPE as "TranType",'
      '  T2.TRAN_PAWN_AMOUNT as "TranPawnAmount",'
      '  T2.TRAN_INTEREST as "TranInterest",'
      '  T2.PRINC_BALANCE as "PrincBalance",'
      '  T2.INTEREST_BALANCE as "InsterestBalance",'
      '  T2.TRAN_DATE as "TranDate",'
      '  T2.TRAN_TIME as "TranTime",'
      '  T2.TRAN_MATURITY as "TranMaturity",'
      '  T3.TRAN_TYPE_DESC as "TranTypeDesc"'
      'from CUSTOMER T1'
      'join TRANSACTIONS T2 on T1.CUST_NO = T2.CUST_NO'
      'join TRANSACTION_TYPES T3 on T2.TRAN_TYPE = T3.TRAN_TYPE'
      'where'
      '  T2.TRAN_TYPE in ('#39'P'#39','#39'U'#39')'
      ' --<PARAMS>'
      'order by T2.TRAN_TYPE, T2.TRAN_DATE, T2.TRAN_TIME'
      ''
      '')
    Left = 503
    Top = 23
    object qryPawnAndPurchasescFullName: TStringField
      FieldKind = fkCalculated
      FieldName = 'cFullName'
      Size = 120
      Calculated = True
    end
    object qryPawnAndPurchasesCustFirst: TWideStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryPawnAndPurchasesCustMid: TWideStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryPawnAndPurchasesCustLast: TWideStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryPawnAndPurchasesCustPhCell: TWideStringField
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryPawnAndPurchasesTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryPawnAndPurchasesTranType: TStringField
      FieldName = 'TranType'
      Size = 1
    end
    object qryPawnAndPurchasesTranPawnAmount: TFloatField
      FieldName = 'TranPawnAmount'
      currency = True
    end
    object qryPawnAndPurchasesTranInterest: TFloatField
      FieldName = 'TranInterest'
      currency = True
    end
    object qryPawnAndPurchasesPrincBalance: TFloatField
      FieldName = 'PrincBalance'
      currency = True
    end
    object qryPawnAndPurchasesInsterestBalance: TFloatField
      FieldName = 'InsterestBalance'
      currency = True
    end
    object qryPawnAndPurchasesTranDate: TDateField
      FieldName = 'TranDate'
    end
    object qryPawnAndPurchasesTranTime: TTimeField
      FieldName = 'TranTime'
    end
    object qryPawnAndPurchasesTranMaturity: TDateField
      FieldName = 'TranMaturity'
    end
    object qryPawnAndPurchasesTranTypeDesc: TStringField
      FieldName = 'TranTypeDesc'
    end
  end
  object dsPawnAndPurchases: TDataSource
    DataSet = qryPawnAndPurchases
    Left = 504
    Top = 75
  end
  object DBPPawnAndPurchases: TppDBPipeline
    DataSource = dsPawnAndPurchases
    OpenDataSource = False
    UserName = 'DBPPawnAndPurchases'
    Left = 639
    Top = 24
    object DBPPawnAndPurchasesppField1: TppField
      FieldAlias = 'cFullName'
      FieldName = 'cFullName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField2: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField3: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField4: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField5: TppField
      FieldAlias = 'CustPhCell'
      FieldName = 'CustPhCell'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField6: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField7: TppField
      FieldAlias = 'TranType'
      FieldName = 'TranType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField8: TppField
      FieldAlias = 'TranPawnAmount'
      FieldName = 'TranPawnAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField9: TppField
      FieldAlias = 'TranInterest'
      FieldName = 'TranInterest'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField10: TppField
      FieldAlias = 'PrincBalance'
      FieldName = 'PrincBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField11: TppField
      FieldAlias = 'InsterestBalance'
      FieldName = 'InsterestBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField12: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField13: TppField
      FieldAlias = 'TranTime'
      FieldName = 'TranTime'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField14: TppField
      FieldAlias = 'TranMaturity'
      FieldName = 'TranMaturity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPPawnAndPurchasesppField15: TppField
      FieldAlias = 'TranTypeDesc'
      FieldName = 'TranTypeDesc'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
  end
  object RepPawnAndPurchases: TppReport
    AutoStop = False
    DataPipeline = DBPPawnAndPurchases
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279400
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPageWidth
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 639
    Top = 75
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPPawnAndPurchases'
    object ppTitleBand1: TppTitleBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 17992
      mmPrintPosition = 0
      object lblRep1PawnAndPurchaseTitle: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblRep1PawnAndPurchaseTitle'
        Border.mmPadding = 0
        Caption = 'Pawn and Purchases'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 22
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 8731
        mmLeft = 71437
        mmTop = 794
        mmWidth = 60325
        BandType = 1
        LayerName = Foreground
      end
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable1'
        Border.mmPadding = 0
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3704
        mmLeft = 1852
        mmTop = 794
        mmWidth = 29898
        BandType = 1
        LayerName = Foreground
      end
      object ppSystemVariable2: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable2'
        Border.mmPadding = 0
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 188384
        mmTop = 794
        mmWidth = 14023
        BandType = 1
        LayerName = Foreground
      end
      object lblFromToDates: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblFromToDates'
        OnGetText = lblFromToDatesGetText
        Border.mmPadding = 0
        Caption = 'From 1-1-1 to 2-2-2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5027
        mmLeft = 84402
        mmTop = 10319
        mmWidth = 34132
        BandType = 1
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 4763
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        Border.mmPadding = 0
        DataField = 'cFullName'
        DataPipeline = DBPPawnAndPurchases
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 0
        mmTop = 265
        mmWidth = 47218
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPPawnAndPurchases
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 50536
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'TranPawnAmount'
        DataPipeline = DBPPawnAndPurchases
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 99748
        mmTop = 265
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'TranMaturity'
        DataPipeline = DBPPawnAndPurchases
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 118798
        mmTop = 265
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        Border.mmPadding = 0
        DataField = 'PrincBalance'
        DataPipeline = DBPPawnAndPurchases
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 157163
        mmTop = 0
        mmWidth = 21431
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText6'
        Border.mmPadding = 0
        DataField = 'InsterestBalance'
        DataPipeline = DBPPawnAndPurchases
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 183784
        mmTop = 60
        mmWidth = 16079
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText7'
        Border.mmPadding = 0
        DataField = 'TranInterest'
        DataPipeline = DBPPawnAndPurchases
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 138113
        mmTop = 265
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText14: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText14'
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPPawnAndPurchases
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnAndPurchases'
        mmHeight = 4498
        mmLeft = 70115
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'TranTypeDesc'
      DataPipeline = DBPPawnAndPurchases
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'DBPPawnAndPurchases'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 12965
        mmPrintPosition = 0
        object ppLabel2: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label2'
          Border.mmPadding = 0
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 0
          mmTop = 7408
          mmWidth = 8202
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine1: TppLine
          DesignLayer = ppDesignLayer1
          UserName = 'Line1'
          Border.mmPadding = 0
          ParentWidth = True
          Position = lpBottom
          Weight = 0.75000000000000000
          mmHeight = 3969
          mmLeft = 0
          mmTop = 8467
          mmWidth = 203200
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object lblTranType: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'lblTranType'
          OnGetText = lblTranTypeGetText
          Border.mmPadding = 0
          Caption = 'lblTranType'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 12
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 5027
          mmLeft = 1852
          mmTop = 265
          mmWidth = 21696
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel4: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label4'
          Border.mmPadding = 0
          Caption = 'Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 54769
          mmTop = 7144
          mmWidth = 6615
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel5: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label5'
          Border.mmPadding = 0
          Caption = 'Amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 104511
          mmTop = 7144
          mmWidth = 11113
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel6: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label6'
          Border.mmPadding = 0
          Caption = 'Maturity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 121973
          mmTop = 7144
          mmWidth = 12435
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel7: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label7'
          Border.mmPadding = 0
          Caption = 'Princ. Balance'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 159809
          mmTop = 7144
          mmWidth = 20108
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel8: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label8'
          Border.mmPadding = 0
          Caption = 'Int. Balance'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 185361
          mmTop = 7203
          mmWidth = 16669
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel9: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label9'
          Border.mmPadding = 0
          Caption = 'Interes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 142082
          mmTop = 7144
          mmWidth = 9790
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel16: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label16'
          Border.mmPadding = 0
          Caption = 'Ticket #'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 77258
          mmTop = 7144
          mmWidth = 11377
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 6350
        mmPrintPosition = 0
        object ppLine2: TppLine
          DesignLayer = ppDesignLayer1
          UserName = 'Line2'
          Border.mmPadding = 0
          Weight = 0.75000000000000000
          mmHeight = 3969
          mmLeft = 45508
          mmTop = 0
          mmWidth = 150548
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc1: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc1'
          Border.mmPadding = 0
          DataField = 'TranPawnAmount'
          DataPipeline = DBPPawnAndPurchases
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPPawnAndPurchases'
          mmHeight = 4498
          mmLeft = 84931
          mmTop = 1852
          mmWidth = 32015
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc2: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc2'
          Border.mmPadding = 0
          DataField = 'PrincBalance'
          DataPipeline = DBPPawnAndPurchases
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPPawnAndPurchases'
          mmHeight = 4498
          mmLeft = 157163
          mmTop = 1852
          mmWidth = 21431
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc3: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc3'
          Border.mmPadding = 0
          DataField = 'InsterestBalance'
          DataPipeline = DBPPawnAndPurchases
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPPawnAndPurchases'
          mmHeight = 4498
          mmLeft = 179490
          mmTop = 1852
          mmWidth = 20373
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object qryTranPayments: TFDQuery
    OnCalcFields = qryTranPaymentsCalcFields
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select T4.PAY_DATE as "PayDate",'
      '       T4.PAY_AMOUNT as "PayAmount",'
      '       T4.PAY_PRINCIPAL as "PayPrincipal",'
      '       T4.PAY_INTEREST as "PayInterest",'
      '       T1.CUST_FIRST as "CustFirst",'
      '       T1.CUST_MID as "CustMid",'
      '       T1.CUST_LAST as "CustLast",'
      '       T1.CUST_PH_CELL as "CustPhCell",'
      '       T2.TRAN_TICKET_NO as "TranTicketNo",'
      '       T2.TRAN_TYPE as "TranType",'
      '       T2.TRAN_PAWN_AMOUNT as "TranPawnAmount",'
      '       T2.TRAN_INTEREST as "TranInterest",'
      '       T2.PRINC_BALANCE as "PrincBalance",'
      '       T2.INTEREST_BALANCE as "InsterestBalance",'
      '       T2.TRAN_DATE as "TranDate",'
      '       T2.TRAN_TIME as "TranTime",'
      '       T2.TRAN_MATURITY as "TranMaturity",'
      '       T3.TRAN_TYPE_DESC as "TranTypeDesc"'
      'from CUSTOMER T1'
      '  join TRANSACTIONS T2 On T1.CUST_NO = T2.CUST_NO'
      '  join TRANSACTION_TYPES T3 ON T2.TRAN_TYPE = T3.TRAN_TYPE'
      '  join PAYMENTS T4 ON T4.TRANSACTION_NO = T2.TRANSACTION_NO'
      'where T2.TRAN_TYPE in ('#39'P'#39', '#39'U'#39')'
      ' --<PARAMS>'
      'order by T2.TRAN_TYPE, T2.TRAN_DATE, T2.TRAN_TIME')
    Left = 504
    Top = 131
    object qryTranPaymentscFullName: TStringField
      FieldKind = fkCalculated
      FieldName = 'cFullName'
      Size = 120
      Calculated = True
    end
    object qryTranPaymentsPayDate: TDateField
      FieldName = 'PayDate'
    end
    object qryTranPaymentsPayAmount: TFloatField
      FieldName = 'PayAmount'
    end
    object qryTranPaymentsPayPrincipal: TFloatField
      FieldName = 'PayPrincipal'
    end
    object qryTranPaymentsPayInterest: TFloatField
      FieldName = 'PayInterest'
    end
    object qryTranPaymentsCustFirst: TWideStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryTranPaymentsCustMid: TWideStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryTranPaymentsCustLast: TWideStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryTranPaymentsCustPhCell: TWideStringField
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryTranPaymentsTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryTranPaymentsTranType: TStringField
      FieldName = 'TranType'
      Size = 1
    end
    object qryTranPaymentsTranPawnAmount: TFloatField
      FieldName = 'TranPawnAmount'
    end
    object qryTranPaymentsTranInterest: TFloatField
      FieldName = 'TranInterest'
    end
    object qryTranPaymentsPrincBalance: TFloatField
      FieldName = 'PrincBalance'
    end
    object qryTranPaymentsInsterestBalance: TFloatField
      FieldName = 'InsterestBalance'
    end
    object qryTranPaymentsTranDate: TDateField
      FieldName = 'TranDate'
    end
    object qryTranPaymentsTranTime: TTimeField
      FieldName = 'TranTime'
    end
    object qryTranPaymentsTranMaturity: TDateField
      FieldName = 'TranMaturity'
    end
    object qryTranPaymentsTranTypeDesc: TStringField
      FieldName = 'TranTypeDesc'
    end
  end
  object dsTranPayments: TDataSource
    DataSet = qryTranPayments
    Left = 504
    Top = 185
  end
  object DBPTranPayments: TppDBPipeline
    DataSource = dsTranPayments
    OpenDataSource = False
    UserName = 'DBPTranPayments'
    Left = 640
    Top = 131
  end
  object RepTranPayments: TppReport
    AutoStop = False
    DataPipeline = DBPTranPayments
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279400
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPageWidth
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 640
    Top = 185
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPTranPayments'
    object ppTitleBand2: TppTitleBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 19050
      mmPrintPosition = 0
      object ppLabel10: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label10'
        Border.mmPadding = 0
        Caption = 'Payments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 22
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 8732
        mmLeft = 87313
        mmTop = 791
        mmWidth = 28839
        BandType = 1
        LayerName = Foreground1
      end
      object lblFromToDates2: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblFromToDates2'
        OnGetText = lblFromToDatesGetText
        Border.mmPadding = 0
        Caption = 'lblFromToDates2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5027
        mmLeft = 87577
        mmTop = 10316
        mmWidth = 28311
        BandType = 1
        LayerName = Foreground1
      end
      object ppSystemVariable3: TppSystemVariable
        DesignLayer = ppDesignLayer2
        UserName = 'SystemVariable3'
        Border.mmPadding = 0
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 0
        mmTop = 794
        mmWidth = 32544
        BandType = 1
        LayerName = Foreground1
      end
      object ppSystemVariable4: TppSystemVariable
        DesignLayer = ppDesignLayer2
        UserName = 'SystemVariable4'
        Border.mmPadding = 0
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 187855
        mmTop = 794
        mmWidth = 14023
        BandType = 1
        LayerName = Foreground1
      end
    end
    object ppDetailBand2: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'cFullName'
        DataPipeline = DBPTranPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPTranPayments'
        mmHeight = 4498
        mmLeft = 2117
        mmTop = 0
        mmWidth = 64558
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText9: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPTranPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPTranPayments'
        mmHeight = 4498
        mmLeft = 68527
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText10: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText10'
        Border.mmPadding = 0
        DataField = 'TranPawnAmount'
        DataPipeline = DBPTranPayments
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPTranPayments'
        mmHeight = 4498
        mmLeft = 88900
        mmTop = 0
        mmWidth = 15875
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText11: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText11'
        Border.mmPadding = 0
        DataField = 'PayAmount'
        DataPipeline = DBPTranPayments
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPTranPayments'
        mmHeight = 4498
        mmLeft = 110596
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText12: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText12'
        Border.mmPadding = 0
        DataField = 'PayPrincipal'
        DataPipeline = DBPTranPayments
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPTranPayments'
        mmHeight = 4498
        mmLeft = 135732
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText13: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText13'
        Border.mmPadding = 0
        DataField = 'PayInterest'
        DataPipeline = DBPTranPayments
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPTranPayments'
        mmHeight = 4498
        mmLeft = 157957
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground1
      end
    end
    object ppGroup2: TppGroup
      BreakName = 'TranTypeDesc'
      DataPipeline = DBPTranPayments
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      StartOnOddPage = False
      UserName = 'Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'DBPTranPayments'
      NewFile = False
      object ppGroupHeaderBand2: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 14023
        mmPrintPosition = 0
        object ppLabel3: TppLabel
          DesignLayer = ppDesignLayer2
          UserName = 'Label3'
          Border.mmPadding = 0
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 2117
          mmTop = 8996
          mmWidth = 8202
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLabel11: TppLabel
          DesignLayer = ppDesignLayer2
          UserName = 'Label11'
          Border.mmPadding = 0
          Caption = 'Ticket'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 68546
          mmTop = 8996
          mmWidth = 8996
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLabel12: TppLabel
          DesignLayer = ppDesignLayer2
          UserName = 'Label12'
          Border.mmPadding = 0
          Caption = 'Amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 93686
          mmTop = 8996
          mmWidth = 11113
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLine3: TppLine
          DesignLayer = ppDesignLayer2
          UserName = 'Line3'
          Border.mmPadding = 0
          ParentWidth = True
          Position = lpBottom
          Weight = 0.75000000000000000
          mmHeight = 3969
          mmLeft = 0
          mmTop = 10054
          mmWidth = 203200
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLabel13: TppLabel
          DesignLayer = ppDesignLayer2
          UserName = 'Label13'
          Border.mmPadding = 0
          Caption = 'Payment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 115641
          mmTop = 8996
          mmWidth = 12171
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLabel14: TppLabel
          DesignLayer = ppDesignLayer2
          UserName = 'Label14'
          Border.mmPadding = 0
          Caption = 'Principal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 140248
          mmTop = 8996
          mmWidth = 12700
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppLabel15: TppLabel
          DesignLayer = ppDesignLayer2
          UserName = 'Label15'
          Border.mmPadding = 0
          Caption = 'Interest'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 164325
          mmTop = 8996
          mmWidth = 10848
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppDBText15: TppDBText
          DesignLayer = ppDesignLayer2
          UserName = 'DBText15'
          Border.mmPadding = 0
          DataField = 'TranTypeDesc'
          DataPipeline = DBPTranPayments
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 12
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'DBPTranPayments'
          mmHeight = 5558
          mmLeft = 2117
          mmTop = 1322
          mmWidth = 42605
          BandType = 3
          GroupNo = 0
          LayerName = Foreground1
        end
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 8467
        mmPrintPosition = 0
        object ppLine4: TppLine
          DesignLayer = ppDesignLayer2
          UserName = 'Line4'
          Border.mmPadding = 0
          Weight = 0.75000000000000000
          mmHeight = 3969
          mmLeft = 85990
          mmTop = 0
          mmWidth = 95250
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppDBCalc4: TppDBCalc
          DesignLayer = ppDesignLayer2
          UserName = 'DBCalc4'
          Border.mmPadding = 0
          DataField = 'TranPawnAmount'
          DataPipeline = DBPTranPayments
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPTranPayments'
          mmHeight = 4498
          mmLeft = 87577
          mmTop = 1060
          mmWidth = 17198
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppDBCalc5: TppDBCalc
          DesignLayer = ppDesignLayer2
          UserName = 'DBCalc5'
          Border.mmPadding = 0
          DataField = 'PayAmount'
          DataPipeline = DBPTranPayments
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPTranPayments'
          mmHeight = 4498
          mmLeft = 110596
          mmTop = 1058
          mmWidth = 17198
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppDBCalc6: TppDBCalc
          DesignLayer = ppDesignLayer2
          UserName = 'DBCalc6'
          Border.mmPadding = 0
          DataField = 'PayPrincipal'
          DataPipeline = DBPTranPayments
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPTranPayments'
          mmHeight = 4498
          mmLeft = 135732
          mmTop = 1058
          mmWidth = 17198
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
        object ppDBCalc7: TppDBCalc
          DesignLayer = ppDesignLayer2
          UserName = 'DBCalc7'
          Border.mmPadding = 0
          DataField = 'PayInterest'
          DataPipeline = DBPTranPayments
          DisplayFormat = '$#,0.00;($#,0.00)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          ResetGroup = ppGroup2
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPTranPayments'
          mmHeight = 4498
          mmLeft = 157957
          mmTop = 1056
          mmWidth = 17198
          BandType = 5
          GroupNo = 0
          LayerName = Foreground1
        end
      end
    end
    object ppDesignLayers2: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'Foreground1'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
end
