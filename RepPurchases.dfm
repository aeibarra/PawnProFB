object frmRepPurchases: TfrmRepPurchases
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Report Purchases'
  ClientHeight = 181
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 20
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 373
    Height = 90
    TabOrder = 0
    object Label1: TLabel
      Left = 50
      Top = 21
      Width = 37
      Height = 20
      Caption = 'From:'
    end
    object Label2: TLabel
      Left = 193
      Top = 21
      Width = 19
      Height = 20
      Caption = 'To:'
    end
    object edFrom: TRzDateTimeEdit
      Left = 50
      Top = 40
      Width = 114
      Height = 28
      EditType = etDate
      TabOrder = 0
    end
    object edTo: TRzDateTimeEdit
      Left = 193
      Top = 40
      Width = 114
      Height = 28
      EditType = etDate
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 99
    Width = 373
    Height = 74
    TabOrder = 1
    DesignSize = (
      373
      74)
    object btnExit: TBitBtn
      Left = 268
      Top = 14
      Width = 91
      Height = 45
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'E&xit'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 2
      TabOrder = 2
      OnClick = btnExitClick
    end
    object btnPreview: TRzBitBtn
      Left = 15
      Top = 13
      Width = 105
      Height = 45
      Caption = 'Preview'
      TabOrder = 0
      OnClick = btnPreviewClick
      ImageIndex = 30
      Images = DM.vilMain24
      Spacing = 0
    end
    object btnPrint: TRzBitBtn
      Left = 144
      Top = 14
      Width = 105
      Height = 45
      Caption = 'Print'
      ParentColor = True
      TabOrder = 1
      OnClick = btnPrintClick
      ImageIndex = 0
      Images = DM.vilMain24
      Margin = 10
    end
  end
  object qryPruchases: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select'
      '  TRAN_DATE as "TranDate",'
      '  TRAN_TICKET_NO as "TranTicketNo",'
      '  TRAN_PAWN_AMOUNT as "PurchaseAmount",'
      
        '  (select SUM(WEIGHT) from INVENTORY_ITEMS T01 where T01.TRANSAC' +
        'TION_NO = T.TRANSACTION_NO) as "TotalPNWt"'
      'from TRANSACTIONS T'
      'where TRAN_TYPE = '#39'U'#39' and TRAN_DATE between :FDate and :TDate'
      'order by TRAN_DATE, TRANSACTION_NO')
    Left = 398
    Top = 15
    ParamData = <
      item
        Name = 'FDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end
      item
        Name = 'TDate'
        DataType = ftDate
        ParamType = ptInput
        Value = 42005d
      end>
    object qryPruchasesTranDate: TDateField
      FieldName = 'TranDate'
    end
    object qryPruchasesTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryPruchasesPurchaseAmount: TFloatField
      FieldName = 'PurchaseAmount'
    end
    object qryPruchasesTotalPNWt: TFloatField
      FieldName = 'TotalPNWt'
    end
  end
  object dsPruchases: TDataSource
    DataSet = qryPruchases
    Left = 398
    Top = 63
  end
  object DBPPruchases: TppDBPipeline
    DataSource = dsPruchases
    OpenDataSource = False
    UserName = 'DBPPruchases'
    Left = 484
    Top = 17
    object DBPPruchasesppField1: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPPruchasesppField2: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPPruchasesppField3: TppField
      FieldAlias = 'PurchaseAmount'
      FieldName = 'PurchaseAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPPruchasesppField4: TppField
      FieldAlias = 'TotalPNWt'
      FieldName = 'TotalPNWt'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
  end
  object RepPruchases: TppReport
    AutoStop = False
    DataPipeline = DBPPruchases
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
    PrinterSetup.mmPaperHeight = 279401
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
    Left = 484
    Top = 66
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPPruchases'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 27781
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        Border.mmPadding = 0
        Caption = 'Purchases'
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
        mmLeft = 86784
        mmTop = 794
        mmWidth = 29633
        BandType = 0
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
        BandType = 0
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
        BandType = 0
        LayerName = Foreground
      end
      object lblFromToDates1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblFromToDates1'
        OnGetText = lblFromToDates1GetText
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
        BandType = 0
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
        mmTop = 23813
        mmWidth = 203200
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        Border.mmPadding = 0
        Caption = 'Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 17727
        mmTop = 21696
        mmWidth = 6615
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label3'
        Border.mmPadding = 0
        Caption = 'Ticket No.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 45508
        mmTop = 21696
        mmWidth = 15081
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label4'
        Border.mmPadding = 0
        Caption = 'Amount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 85196
        mmTop = 21696
        mmWidth = 11377
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label5'
        Border.mmPadding = 0
        Caption = 'PNWt.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 116681
        mmTop = 21696
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPPruchases
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPruchases'
        mmHeight = 4498
        mmLeft = 13494
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPPruchases
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPruchases'
        mmHeight = 4498
        mmLeft = 41804
        mmTop = 0
        mmWidth = 24077
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'PurchaseAmount'
        DataPipeline = DBPPruchases
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPruchases'
        mmHeight = 4498
        mmLeft = 71967
        mmTop = 0
        mmWidth = 24606
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'TotalPNWt'
        DataPipeline = DBPPruchases
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPruchases'
        mmHeight = 4498
        mmLeft = 104246
        mmTop = 0
        mmWidth = 21167
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 14817
      mmPrintPosition = 0
      object ppLine2: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line2'
        Border.mmPadding = 0
        ParentWidth = True
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 0
        mmWidth = 203200
        BandType = 7
        LayerName = Foreground
      end
      object DBCalcTotalAmount: TppDBCalc
        DesignLayer = ppDesignLayer1
        UserName = 'DBCalcTotalAmount'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'PurchaseAmount'
        DataPipeline = DBPPruchases
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPruchases'
        mmHeight = 3969
        mmLeft = 63765
        mmTop = 1852
        mmWidth = 32808
        BandType = 7
        LayerName = Foreground
      end
      object DBCalcTotalPNWt: TppDBCalc
        DesignLayer = ppDesignLayer1
        UserName = 'DBCalcTotalPNWt'
        Border.mmPadding = 0
        DataField = 'TotalPNWt'
        DataPipeline = DBPPruchases
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPruchases'
        mmHeight = 4498
        mmLeft = 99748
        mmTop = 1852
        mmWidth = 25665
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label6'
        OnGetText = ppLabel6GetText
        Border.mmPadding = 0
        Caption = 'Label6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 133879
        mmTop = 1852
        mmWidth = 9260
        BandType = 7
        LayerName = Foreground
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
end
