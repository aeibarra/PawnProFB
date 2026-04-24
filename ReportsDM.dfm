object DMReports: TDMReports
  Height = 411
  Width = 1064
  object qryPrnPayReceipt: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryPrnPayReceiptCalcFields
    Parameters = <
      item
        Name = 'PaymentNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT T1.TransactionNo, T1.PayDate, T1.PayAmount, T1.PayInteres' +
        't, T1.PayPrincipal,'
      
        '     T2.TranDate, T2.TranPawnAmount, T2.TranTicketNo, T1.PrincBa' +
        'lance,'
      
        '     T3.CustFirst, T3.CustMid, T3.CustLast, T3.CustPhCell, T3.Cu' +
        'stPhHome, T3.CustPhBussiness,'
      
        '     T3.CustFlDrvLic, T3.CustIDType, T3.CustID, T3.CustIDAgencyS' +
        'tate'
      'FROM Payments T1'
      '  JOIN Transactions T2 ON T1.TransactionNo = T2.TransactionNo'
      '  JOIN Customer T3 ON T3.Custno = T2.CustNo'
      'WHERE PaymentNo = :PaymentNo')
    Left = 38
    Top = 16
    object qryPrnPayReceiptcFullName: TStringField
      FieldKind = fkCalculated
      FieldName = 'cFullName'
      Size = 128
      Calculated = True
    end
    object qryPrnPayReceiptcCustomerPhones: TStringField
      FieldKind = fkCalculated
      FieldName = 'cCustomerPhones'
      Size = 50
      Calculated = True
    end
    object qryPrnPayReceiptcCustId: TStringField
      FieldKind = fkCalculated
      FieldName = 'cCustId'
      Size = 128
      Calculated = True
    end
    object qryPrnPayReceiptcDueDate: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'cDueDate'
      Calculated = True
    end
    object qryPrnPayReceiptTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryPrnPayReceiptPayDate: TDateField
      FieldName = 'PayDate'
    end
    object qryPrnPayReceiptPayAmount: TFloatField
      FieldName = 'PayAmount'
    end
    object qryPrnPayReceiptPayInterest: TFloatField
      FieldName = 'PayInterest'
    end
    object qryPrnPayReceiptPayPrincipal: TFloatField
      FieldName = 'PayPrincipal'
    end
    object qryPrnPayReceiptTranDate: TDateField
      FieldName = 'TranDate'
    end
    object qryPrnPayReceiptTranPawnAmount: TFloatField
      FieldName = 'TranPawnAmount'
    end
    object qryPrnPayReceiptTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryPrnPayReceiptPrincBalance: TFloatField
      FieldName = 'PrincBalance'
    end
    object qryPrnPayReceiptCustFirst: TStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryPrnPayReceiptCustMid: TStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryPrnPayReceiptCustLast: TStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryPrnPayReceiptCustPhCell: TStringField
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryPrnPayReceiptCustPhHome: TStringField
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryPrnPayReceiptCustPhBussiness: TStringField
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryPrnPayReceiptCustFlDrvLic: TStringField
      FieldName = 'CustFlDrvLic'
    end
    object qryPrnPayReceiptCustIDType: TStringField
      FieldName = 'CustIDType'
    end
    object qryPrnPayReceiptCustID: TStringField
      FieldName = 'CustID'
      Size = 25
    end
    object qryPrnPayReceiptCustIDAgencyState: TStringField
      FieldName = 'CustIDAgencyState'
      Size = 10
    end
  end
  object dsPrnPayReceipt: TDataSource
    DataSet = qryPrnPayReceipt
    Left = 38
    Top = 74
  end
  object plPrnPayReceipt: TppDBPipeline
    DataSource = dsPrnPayReceipt
    OpenDataSource = False
    UserName = 'plPrnPayReceipt'
    Left = 141
    Top = 16
    object plPrnPayReceiptppField1: TppField
      FieldAlias = 'cFullName'
      FieldName = 'cFullName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField2: TppField
      FieldAlias = 'cCustomerPhones'
      FieldName = 'cCustomerPhones'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField3: TppField
      FieldAlias = 'cCustId'
      FieldName = 'cCustId'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField4: TppField
      FieldAlias = 'cDueDate'
      FieldName = 'cDueDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField5: TppField
      FieldAlias = 'TransactionNo'
      FieldName = 'TransactionNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField6: TppField
      FieldAlias = 'PayDate'
      FieldName = 'PayDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField7: TppField
      FieldAlias = 'PayAmount'
      FieldName = 'PayAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField8: TppField
      FieldAlias = 'PayInterest'
      FieldName = 'PayInterest'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField9: TppField
      FieldAlias = 'PayPrincipal'
      FieldName = 'PayPrincipal'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField10: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField11: TppField
      FieldAlias = 'TranPawnAmount'
      FieldName = 'TranPawnAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField12: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField13: TppField
      FieldAlias = 'PrincBalance'
      FieldName = 'PrincBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField14: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField15: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField16: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField17: TppField
      FieldAlias = 'CustPhCell'
      FieldName = 'CustPhCell'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField18: TppField
      FieldAlias = 'CustPhHome'
      FieldName = 'CustPhHome'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField19: TppField
      FieldAlias = 'CustPhBussiness'
      FieldName = 'CustPhBussiness'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField20: TppField
      FieldAlias = 'CustFlDrvLic'
      FieldName = 'CustFlDrvLic'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField21: TppField
      FieldAlias = 'CustIDType'
      FieldName = 'CustIDType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField22: TppField
      FieldAlias = 'CustID'
      FieldName = 'CustID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object plPrnPayReceiptppField23: TppField
      FieldAlias = 'CustIDAgencyState'
      FieldName = 'CustIDAgencyState'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
  end
  object RepPrintPayReceipt: TppReport
    AutoStop = False
    DataPipeline = dbpTranItems
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
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
    Left = 248
    Top = 16
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'dbpTranItems'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 50800
      mmPrintPosition = 0
      object ppDBText139: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreName'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4763
        mmLeft = 10848
        mmTop = 6085
        mmWidth = 56885
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText140: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreAddr'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4497
        mmLeft = 20373
        mmTop = 11113
        mmWidth = 38100
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText141: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreCityStZIP'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4498
        mmLeft = 25400
        mmTop = 15875
        mmWidth = 28311
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText142: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePhone'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4498
        mmLeft = 27252
        mmTop = 20902
        mmWidth = 23813
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText156: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText41'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Storenumber'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4498
        mmLeft = 38629
        mmTop = 25929
        mmWidth = 794
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cFullName'
        DataPipeline = plPrnPayReceipt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4763
        mmLeft = 82815
        mmTop = 6085
        mmWidth = 19579
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText6'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cCustomerPhones'
        DataPipeline = plPrnPayReceipt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4762
        mmLeft = 82815
        mmTop = 10848
        mmWidth = 34131
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText7'
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = plPrnPayReceipt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4498
        mmLeft = 177944
        mmTop = 5992
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        Border.mmPadding = 0
        Caption = '#:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4498
        mmLeft = 174900
        mmTop = 5992
        mmWidth = 3175
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText8'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cCustId'
        DataPipeline = plPrnPayReceipt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4762
        mmLeft = 82815
        mmTop = 16140
        mmWidth = 13758
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line1'
        Border.mmPadding = 0
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 2381
        mmLeft = 23019
        mmTop = 48419
        mmWidth = 137319
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        Border.mmPadding = 0
        Caption = 'Qty'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 25135
        mmTop = 46038
        mmWidth = 5556
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label3'
        Border.mmPadding = 0
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 40329
        mmTop = 46038
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label4'
        Border.mmPadding = 0
        Caption = 'KT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 90223
        mmTop = 46038
        mmWidth = 4233
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label5'
        Border.mmPadding = 0
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 118269
        mmTop = 45773
        mmWidth = 10848
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText12: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText16'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'PayDate'
        DataPipeline = plPrnPayReceipt
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4497
        mmLeft = 174890
        mmTop = 11113
        mmWidth = 14817
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'InvItemCount'
        DataPipeline = dbpTranItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpTranItems'
        mmHeight = 4233
        mmLeft = 26190
        mmTop = 0
        mmWidth = 4498
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText10'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Description'
        DataPipeline = dbpTranItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpTranItems'
        mmHeight = 4233
        mmLeft = 40325
        mmTop = 0
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText11'
        Border.mmPadding = 0
        DataField = 'KT'
        DataPipeline = dbpTranItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'dbpTranItems'
        mmHeight = 4498
        mmLeft = 88897
        mmTop = 0
        mmWidth = 7938
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText12'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Weight'
        DataPipeline = dbpTranItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpTranItems'
        mmHeight = 4233
        mmLeft = 119059
        mmTop = 0
        mmWidth = 10848
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText13'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'WUnit'
        DataPipeline = dbpTranItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpTranItems'
        mmHeight = 4233
        mmLeft = 132553
        mmTop = 0
        mmWidth = 9525
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppPageSummaryBand1: TppPageSummaryBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 79904
      mmPrintPosition = 0
      object ppMemo1: TppMemo
        DesignLayer = ppDesignLayer1
        UserName = 'Memo1'
        Border.mmPadding = 0
        Caption = 'Memo1'
        CharWrap = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Lines.Strings = (
          
            'Pawner hereby certifies that he or she is legally empowered to s' +
            'ell or dispose of the above property and that said property is f' +
            'ree and clear of all liens and encumbrances. Pawner will be resp' +
            'onsible for any legal fees incurred by purchaser resulting from ' +
            'this transaction.')
        RemoveEmptyLines = False
        TabStopPositions.Strings = (
          '0')
        Transparent = True
        mmHeight = 13229
        mmLeft = 6615
        mmTop = 6879
        mmWidth = 191823
        BandType = 11
        LayerName = Foreground
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
      object ppMemo2: TppMemo
        DesignLayer = ppDesignLayer1
        UserName = 'Memo2'
        Border.mmPadding = 0
        Caption = 'Memo2'
        CharWrap = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Lines.Strings = (
          
            'PLEASE READ: 1, the undersigned pawner, have carefully read the ' +
            'terms and conditions of this pawn and agree to them.')
        RemoveEmptyLines = False
        Transparent = True
        mmHeight = 5821
        mmLeft = 6615
        mmTop = 46028
        mmWidth = 191823
        BandType = 11
        LayerName = Foreground
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
      object ppLabel8: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label8'
        Border.mmPadding = 0
        Caption = 'Amount paid:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 11642
        mmTop = 27781
        mmWidth = 20373
        BandType = 11
        LayerName = Foreground
      end
      object ppDBText10: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText14'
        Border.mmPadding = 0
        DataField = 'PayAmount'
        DataPipeline = plPrnPayReceipt
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4498
        mmLeft = 40664
        mmTop = 27781
        mmWidth = 17198
        BandType = 11
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label9'
        Border.mmPadding = 0
        Caption = 'Due Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 89429
        mmTop = 27781
        mmWidth = 15346
        BandType = 11
        LayerName = Foreground
      end
      object ppDBText11: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText15'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cDueDate'
        DataPipeline = plPrnPayReceipt
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4234
        mmLeft = 105304
        mmTop = 27781
        mmWidth = 15082
        BandType = 11
        LayerName = Foreground
      end
      object ppLine2: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line2'
        Border.mmPadding = 0
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 1852
        mmLeft = 8996
        mmTop = 65078
        mmWidth = 78052
        BandType = 11
        LayerName = Foreground
      end
      object ppLine3: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line3'
        Border.mmPadding = 0
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 1852
        mmLeft = 93927
        mmTop = 65078
        mmWidth = 78052
        BandType = 11
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label6'
        Border.mmPadding = 0
        Caption = 'Pawner'#39's Signature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 33602
        mmTop = 68253
        mmWidth = 29369
        BandType = 11
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label7'
        Border.mmPadding = 0
        Caption = 'Pawner'#39's Signature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 118269
        mmTop = 68253
        mmWidth = 29369
        BandType = 11
        LayerName = Foreground
      end
      object ppLabel36: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label101'
        Border.mmPadding = 0
        Caption = 'Principal Balance:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4233
        mmLeft = 11642
        mmTop = 33867
        mmWidth = 27781
        BandType = 11
        LayerName = Foreground
      end
      object ppDBText40: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText40'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'PrincBalance'
        DataPipeline = plPrnPayReceipt
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'plPrnPayReceipt'
        mmHeight = 4233
        mmLeft = 40664
        mmTop = 33867
        mmWidth = 20373
        BandType = 11
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
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
  object DBPStoreInfo: TppDBPipeline
    DataSource = DM.DSStore
    OpenDataSource = False
    UserName = 'DBPStoreInfo'
    Left = 141
    Top = 74
    object DBPStoreInfoppField1: TppField
      FieldAlias = 'cCity'
      FieldName = 'cCity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField2: TppField
      FieldAlias = 'cState'
      FieldName = 'cState'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField3: TppField
      FieldAlias = 'cZIp'
      FieldName = 'cZIp'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField4: TppField
      FieldAlias = 'StoreNo'
      FieldName = 'StoreNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField5: TppField
      FieldAlias = 'StoreName'
      FieldName = 'StoreName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField6: TppField
      FieldAlias = 'StoreAddr'
      FieldName = 'StoreAddr'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField7: TppField
      FieldAlias = 'StoreCityStZIP'
      FieldName = 'StoreCityStZIP'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField8: TppField
      FieldAlias = 'StorePhone'
      FieldName = 'StorePhone'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField9: TppField
      FieldAlias = 'StorePoliceID'
      FieldName = 'StorePoliceID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField10: TppField
      FieldAlias = 'StoreAdjTopMarg'
      FieldName = 'StoreAdjTopMarg'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField11: TppField
      FieldAlias = 'Storenumber'
      FieldName = 'Storenumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField12: TppField
      FieldAlias = 'StoreAdjDetailHeight'
      FieldName = 'StoreAdjDetailHeight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField13: TppField
      FieldAlias = 'StoreAdjFooterHeight'
      FieldName = 'StoreAdjFooterHeight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField14: TppField
      FieldAlias = 'InterestCalcMethod'
      FieldName = 'InterestCalcMethod'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField15: TppField
      FieldAlias = 'PoliceReportToPrint'
      FieldName = 'PoliceReportToPrint'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField16: TppField
      FieldAlias = 'PoliceReportLaserCopies'
      FieldName = 'PoliceReportLaserCopies'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField17: TppField
      FieldAlias = 'DefaultMaturityMonths'
      FieldName = 'DefaultMaturityMonths'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField18: TppField
      FieldAlias = 'PawnDefaultMonths'
      FieldName = 'PawnDefaultMonths'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField19: TppField
      FieldAlias = 'LeadsStoreId'
      FieldName = 'LeadsStoreId'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField20: TppField
      FieldAlias = 'LeadsOnlineFTPAddress'
      FieldName = 'LeadsOnlineFTPAddress'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField21: TppField
      FieldAlias = 'LeadsOnlineUserName'
      FieldName = 'LeadsOnlineUserName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField22: TppField
      FieldAlias = 'LeadsOnlinePassword'
      FieldName = 'LeadsOnlinePassword'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField23: TppField
      FieldAlias = 'FTPPassive'
      FieldName = 'FTPPassive'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField24: TppField
      FieldAlias = 'PawnDateCalculationBase'
      FieldName = 'PawnDateCalculationBase'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField25: TppField
      FieldAlias = 'DefaultWeightMeasureUnit'
      FieldName = 'DefaultWeightMeasureUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField26: TppField
      FieldAlias = 'SalesTaxPerc'
      FieldName = 'SalesTaxPerc'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 25
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField27: TppField
      FieldAlias = 'DefaultPawnInterestRate'
      FieldName = 'DefaultPawnInterestRate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 26
      Searchable = False
      Sortable = False
    end
  end
  object qryTranItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'PaymentNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'SELECT T4.InvItemCount, T4.Description,T4.KT, T4.Weight,'
      '    cast('
      '        (case'
      '           when T4.WeightUnit is NULL then '#39'dwt'#39
      '           when T4.WeightUnit = '#39'P'#39' then '#39'dwt'#39
      '           when T4.WeightUnit = '#39'G'#39' then '#39'g'#39
      '         end)'
      '      as varchar(10)) as WUnit'
      'FROM Payments T1 '
      '  JOIN Transactions T2 ON T1.TransactionNo = T2.TransactionNo'
      '  JOIN Customer T3 ON T3.Custno = T2.CustNo'
      '  JOIN InventoryItems T4 ON T4.TransactionNo = T2.TransactionNo'
      'WHERE PaymentNo = :PaymentNo'
      '')
    Left = 38
    Top = 136
    object qryTranItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryTranItemsDescription: TStringField
      FieldName = 'Description'
      Size = 40
    end
    object qryTranItemsKT: TFloatField
      FieldName = 'KT'
    end
    object qryTranItemsWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryTranItemsWUnit: TStringField
      FieldName = 'WUnit'
      Size = 10
    end
  end
  object dsTranItems: TDataSource
    DataSet = qryTranItems
    Left = 38
    Top = 184
  end
  object dbpTranItems: TppDBPipeline
    DataSource = dsTranItems
    OpenDataSource = False
    UserName = 'dbpTranItems'
    Left = 141
    Top = 136
    object dbpTranItemsppField1: TppField
      FieldAlias = 'InvItemCount'
      FieldName = 'InvItemCount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object dbpTranItemsppField2: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object dbpTranItemsppField3: TppField
      FieldAlias = 'KT'
      FieldName = 'KT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object dbpTranItemsppField4: TppField
      FieldAlias = 'Weight'
      FieldName = 'Weight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object dbpTranItemsppField5: TppField
      FieldAlias = 'WUnit'
      FieldName = 'WUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
  end
  object rptEnvelopeItemLabel: TppReport
    AutoStop = False
    DataPipeline = dbpEnvelopeItemLabel
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Labels'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Custom'
    PrinterSetup.PrinterName = 'LBP6230dw'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 0
    PrinterSetup.mmMarginLeft = 0
    PrinterSetup.mmMarginRight = 0
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 30480
    PrinterSetup.mmPaperWidth = 88900
    PrinterSetup.PaperSize = 256
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Printer'
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
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    ShowPrintDialog = False
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
    Left = 141
    Top = 296
    Version = '23.02'
    mmColumnWidth = 88900
    DataPipelineName = 'dbpEnvelopeItemLabel'
    object ppDetailBand2: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 28310
      mmPrintPosition = 0
      object ppDBText13: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText1'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cFullName'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3440
        mmLeft = 3175
        mmTop = 3175
        mmWidth = 13229
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText14: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText2'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 5027
        mmLeft = 3175
        mmTop = 19670
        mmWidth = 22754
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText15: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText3'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = dbpEnvelopeItemLabel
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3969
        mmLeft = 43921
        mmTop = 3086
        mmWidth = 13229
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText16: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText4'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Weight'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3704
        mmLeft = 48419
        mmTop = 15514
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText17: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText17'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Description'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Calibri'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3440
        mmLeft = 3175
        mmTop = 7408
        mmWidth = 14552
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText18: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText18'
        Border.mmPadding = 0
        DataField = 'TranType'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        VerticalAlignment = avBottom
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3704
        mmLeft = 53975
        mmTop = 7321
        mmWidth = 3175
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText19: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText19'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'SizeLength'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3704
        mmLeft = 33602
        mmTop = 11680
        mmWidth = 14288
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText20: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText20'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cKT'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3704
        mmLeft = 52123
        mmTop = 11680
        mmWidth = 5027
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText21: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText21'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Qty'
        DataPipeline = dbpEnvelopeItemLabel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpEnvelopeItemLabel'
        mmHeight = 3704
        mmLeft = 9446
        mmTop = 15085
        mmWidth = 4498
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel10: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label10'
        Border.mmPadding = 0
        Caption = 'Qty.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 3703
        mmTop = 14909
        mmWidth = 5115
        BandType = 4
        LayerName = Foreground1
      end
      object lblItemPos: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblItemPos'
        Border.mmPadding = 0
        Caption = 'ItemPos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4234
        mmLeft = 28166
        mmTop = 20066
        mmWidth = 12700
        BandType = 4
        LayerName = Foreground1
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
  object dbpEnvelopeItemLabel: TppDBPipeline
    DataSource = dsInvItem
    OpenDataSource = False
    UserName = 'dbpEnvelopeItemLabel'
    Left = 141
    Top = 248
    object dbpEnvelopeItemLabelppField1: TppField
      FieldAlias = 'cFullName'
      FieldName = 'cFullName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField2: TppField
      FieldAlias = 'cKT'
      FieldName = 'cKT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField3: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField4: TppField
      FieldAlias = 'Weight'
      FieldName = 'Weight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField5: TppField
      FieldAlias = 'KT'
      FieldName = 'KT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField6: TppField
      FieldAlias = 'SizeLength'
      FieldName = 'SizeLength'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField7: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField8: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField9: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField10: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField11: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField12: TppField
      FieldAlias = 'TranType'
      FieldName = 'TranType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object dbpEnvelopeItemLabelppField13: TppField
      FieldAlias = 'Qty'
      FieldName = 'Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
  end
  object qryInvItem: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryInvItemCalcFields
    Parameters = <
      item
        Name = 'InvItemNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'select I.Description, I.Weight, I.KT, I.SizeLength, T.TranDate, ' +
        'T.TranTicketNo, C.CustFirst, C.CustMid, C.CustLast, T.TranType, ' +
        'I.InvItemCount as Qty'
      'from InventoryItems I'
      '  join Transactions T ON T.TransactionNo = I.TransactionNo'
      '  join Customer C ON C.Custno = T.CustNo'
      'where InvItemNo = :InvItemNo'
      '')
    Left = 38
    Top = 248
    object qryInvItemcFullName: TStringField
      FieldKind = fkCalculated
      FieldName = 'cFullName'
      Size = 120
      Calculated = True
    end
    object qryInvItemcKT: TStringField
      FieldKind = fkCalculated
      FieldName = 'cKT'
      Calculated = True
    end
    object qryInvItemDescription: TStringField
      FieldName = 'Description'
      Size = 40
    end
    object qryInvItemWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryInvItemKT: TFloatField
      FieldName = 'KT'
    end
    object qryInvItemSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryInvItemTranDate: TDateField
      FieldName = 'TranDate'
    end
    object qryInvItemTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryInvItemCustFirst: TStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryInvItemCustMid: TStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryInvItemCustLast: TStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryInvItemTranType: TStringField
      FieldName = 'TranType'
      Size = 1
    end
    object qryInvItemQty: TIntegerField
      FieldName = 'Qty'
    end
  end
  object dsInvItem: TDataSource
    DataSet = qryInvItem
    Left = 38
    Top = 296
  end
  object dbpLayawayInfo: TppDBPipeline
    DataSource = dsLayawayRcpt
    OpenDataSource = False
    UserName = 'dbpLayawayInfo'
    Left = 703
    Top = 16
    object dbpLayawayInfoppField1: TppField
      FieldAlias = 'cCustName'
      FieldName = 'cCustName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField2: TppField
      FieldAlias = 'cFPhone'
      FieldName = 'cFPhone'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField3: TppField
      FieldAlias = 'cWeightUnit'
      FieldName = 'cWeightUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField4: TppField
      FieldAlias = 'cSalesTax'
      FieldName = 'cSalesTax'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField5: TppField
      FieldAlias = 'cTotalItemCost'
      FieldName = 'cTotalItemCost'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField6: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField7: TppField
      FieldAlias = 'TranMaturity'
      FieldName = 'TranMaturity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField8: TppField
      FieldAlias = 'TranPawnAmount'
      FieldName = 'TranPawnAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField9: TppField
      FieldAlias = 'TranSalesTax'
      FieldName = 'TranSalesTax'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField10: TppField
      FieldAlias = 'TotalAmount'
      FieldName = 'TotalAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField11: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField12: TppField
      FieldAlias = 'CustNo'
      FieldName = 'CustNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField13: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField14: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField15: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField16: TppField
      FieldAlias = 'CustAddr'
      FieldName = 'CustAddr'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField17: TppField
      FieldAlias = 'CustApt'
      FieldName = 'CustApt'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField18: TppField
      FieldAlias = 'CustCity'
      FieldName = 'CustCity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField19: TppField
      FieldAlias = 'CustState'
      FieldName = 'CustState'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField20: TppField
      FieldAlias = 'CustZip'
      FieldName = 'CustZip'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField21: TppField
      FieldAlias = 'CustPhoneNumber'
      FieldName = 'CustPhoneNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField22: TppField
      FieldAlias = 'ItemDescription'
      FieldName = 'ItemDescription'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField23: TppField
      FieldAlias = 'Weight'
      FieldName = 'Weight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField24: TppField
      FieldAlias = 'WeightUnit'
      FieldName = 'WeightUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object dbpLayawayInfoppField25: TppField
      FieldAlias = 'UnitPrice'
      FieldName = 'UnitPrice'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
  end
  object RepLayawayRcpt: TppReport
    AutoStop = False
    DataPipeline = dbpLayawayInfo
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
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
    Left = 812
    Top = 16
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'dbpLayawayInfo'
    object ppHeaderBand2: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 80169
      mmPrintPosition = 0
      object ppLabel11: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label11'
        Border.mmPadding = 0
        Caption = 'LAYAWAY'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5821
        mmLeft = 89341
        mmTop = 529
        mmWidth = 24871
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText22: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText22'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 5027
        mmLeft = 154517
        mmTop = 15346
        mmWidth = 29369
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText23: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText23'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranMaturity'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 8731
        mmTop = 17727
        mmWidth = 22490
        BandType = 0
        LayerName = Foreground2
      end
      object ppLine4: TppLine
        DesignLayer = ppDesignLayer3
        UserName = 'Line4'
        Border.mmPadding = 0
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 4988
        mmTop = 22049
        mmWidth = 29976
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel12: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label12'
        Border.mmPadding = 0
        Caption = 'Date Wanted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4762
        mmLeft = 7805
        mmTop = 22410
        mmWidth = 24342
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel13: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label13'
        Border.mmPadding = 0
        Caption = 'Date Received'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4762
        mmLeft = 6218
        mmTop = 35190
        mmWidth = 27517
        BandType = 0
        LayerName = Foreground2
      end
      object ppLine5: TppLine
        DesignLayer = ppDesignLayer3
        UserName = 'Line5'
        Border.mmPadding = 0
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 4988
        mmTop = 34564
        mmWidth = 29976
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText24: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText24'
        Border.mmPadding = 0
        DataField = 'StoreName'
        DataPipeline = dbpStore
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'dbpStore'
        mmHeight = 5821
        mmLeft = 36160
        mmTop = 9260
        mmWidth = 131586
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText25: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText25'
        Border.mmPadding = 0
        DataField = 'StorePhone'
        DataPipeline = dbpStore
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'dbpStore'
        mmHeight = 4763
        mmLeft = 77611
        mmTop = 15436
        mmWidth = 48154
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText26: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText26'
        Border.mmPadding = 0
        DataField = 'StoreAddr'
        DataPipeline = dbpStore
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'dbpStore'
        mmHeight = 4763
        mmLeft = 36248
        mmTop = 20638
        mmWidth = 131498
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText27: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText27'
        Border.mmPadding = 0
        DataField = 'StoreCityStZIP'
        DataPipeline = dbpStore
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'dbpStore'
        mmHeight = 4763
        mmLeft = 36248
        mmTop = 25313
        mmWidth = 131498
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel14: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label14'
        Border.mmPadding = 0
        Caption = 'Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4763
        mmLeft = 2910
        mmTop = 47335
        mmWidth = 12171
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel15: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label15'
        Border.mmPadding = 0
        Caption = 'Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4763
        mmLeft = 2910
        mmTop = 52009
        mmWidth = 15611
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel16: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label16'
        Border.mmPadding = 0
        Caption = 'Telephone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4762
        mmLeft = 2734
        mmTop = 57212
        mmWidth = 20371
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText28: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText28'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cCustName'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4762
        mmLeft = 24342
        mmTop = 47427
        mmWidth = 21696
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText29: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText29'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustAddr'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4762
        mmLeft = 24342
        mmTop = 52719
        mmWidth = 17462
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText30: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText30'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cFPhone'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4762
        mmLeft = 24342
        mmTop = 57415
        mmWidth = 16668
        BandType = 0
        LayerName = Foreground2
      end
      object ppLine6: TppLine
        DesignLayer = ppDesignLayer3
        UserName = 'Line6'
        Border.mmPadding = 0
        ParentWidth = True
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 76067
        mmWidth = 203200
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel17: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label17'
        Border.mmPadding = 0
        Caption = 'Item'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 5027
        mmLeft = 3440
        mmTop = 74480
        mmWidth = 8466
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel18: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label18'
        Border.mmPadding = 0
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4763
        mmLeft = 71702
        mmTop = 74480
        mmWidth = 12965
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel19: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label19'
        Border.mmPadding = 0
        Caption = 'Price'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4762
        mmLeft = 117979
        mmTop = 74480
        mmWidth = 9789
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel20: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label20'
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'NO DEVOLUCIONES - NO REFUNDS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4762
        mmLeft = 67381
        mmTop = 30340
        mmWidth = 68792
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel21: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label21'
        Border.mmPadding = 0
        Caption = 'Tax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4763
        mmLeft = 146673
        mmTop = 74480
        mmWidth = 6614
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel22: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label22'
        Border.mmPadding = 0
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4762
        mmLeft = 170920
        mmTop = 74480
        mmWidth = 8996
        BandType = 0
        LayerName = Foreground2
      end
      object ppLine8: TppLine
        DesignLayer = ppDesignLayer3
        UserName = 'Line8'
        Border.mmPadding = 0
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 147814
        mmTop = 58097
        mmWidth = 55386
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel23: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label23'
        Border.mmPadding = 0
        Caption = 'Sign / Firma:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4762
        mmLeft = 123561
        mmTop = 57304
        mmWidth = 23548
        BandType = 0
        LayerName = Foreground2
      end
      object lbPrnRcvDate: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lbPrnRcvDate'
        OnGetText = lbPrnRcvDateGetText
        Border.mmPadding = 0
        Caption = 'lbPrnRcvDate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4763
        mmLeft = 7144
        mmTop = 30427
        mmWidth = 25400
        BandType = 0
        LayerName = Foreground2
      end
    end
    object ppDetailBand3: TppDetailBand
      Border.mmPadding = 0
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object ppDBText31: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText31'
        Border.mmPadding = 0
        DataField = 'ItemDescription'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 3440
        mmTop = 529
        mmWidth = 61913
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText32: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText32'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Weight'
        DataPipeline = dbpLayawayInfo
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 67203
        mmTop = 529
        mmWidth = 12965
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText33: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText33'
        Border.mmPadding = 0
        DataField = 'cWeightUnit'
        DataPipeline = dbpLayawayInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 80875
        mmTop = 529
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText34: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText34'
        Border.mmPadding = 0
        DataField = 'UnitPrice'
        DataPipeline = dbpLayawayInfo
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 113042
        mmTop = 529
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText35: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText35'
        Border.mmPadding = 0
        DataField = 'cSalesTax'
        DataPipeline = dbpLayawayInfo
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 143404
        mmTop = 529
        mmWidth = 13053
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText36: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText36'
        Border.mmPadding = 0
        DataField = 'cTotalItemCost'
        DataPipeline = dbpLayawayInfo
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'dbpLayawayInfo'
        mmHeight = 4763
        mmLeft = 163248
        mmTop = 529
        mmWidth = 19050
        BandType = 4
        LayerName = Foreground2
      end
    end
    object ppFooterBand2: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 6350
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer3
        UserName = 'SystemVariable1'
        Border.mmPadding = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsItalic]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 183621
        mmTop = 1058
        mmWidth = 18786
        BandType = 8
        LayerName = Foreground2
      end
      object ppLine10: TppLine
        DesignLayer = ppDesignLayer3
        UserName = 'Line10'
        Border.mmPadding = 0
        ParentWidth = True
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 91
        mmWidth = 203200
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel35: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label35'
        Border.mmPadding = 0
        Caption = 'Printed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 166423
        mmTop = 1058
        mmWidth = 13494
        BandType = 8
        LayerName = Foreground2
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Border.mmPadding = 0
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 34925
      mmPrintPosition = 0
      object ppShape1: TppShape
        DesignLayer = ppDesignLayer3
        UserName = 'Shape1'
        mmHeight = 23635
        mmLeft = 56621
        mmTop = 3874
        mmWidth = 81315
        BandType = 7
        LayerName = Foreground2
      end
      object ppLabel24: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label24'
        Border.mmPadding = 0
        Caption = 'Subtotal:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 80698
        mmTop = 4930
        mmWidth = 16140
        BandType = 7
        LayerName = Foreground2
      end
      object ppLabel25: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label25'
        Border.mmPadding = 0
        Caption = 'Sales Tax:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 77523
        mmTop = 10222
        mmWidth = 19315
        BandType = 7
        LayerName = Foreground2
      end
      object ppLabel26: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label26'
        Border.mmPadding = 0
        Caption = 'LAYAWAY TOTAL:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 61648
        mmTop = 15514
        mmWidth = 35190
        BandType = 7
        LayerName = Foreground2
      end
      object lblLayawaySubTotal: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblLayawaySubTotal'
        OnGetText = lblLayawaySubTotalGetText
        Border.mmPadding = 0
        Caption = 'lblLayawaySubTotal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 110331
        mmTop = 4930
        mmWidth = 19844
        BandType = 7
        LayerName = Foreground2
      end
      object ppLabel27: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label27'
        OnGetText = ppLabel27GetText
        Border.mmPadding = 0
        Caption = 'lblLatawayTotalTax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 109802
        mmTop = 10222
        mmWidth = 20373
        BandType = 7
        LayerName = Foreground2
      end
      object lblLayawayTotal: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblLayawayTotal'
        OnGetText = lblLayawayTotalGetText
        Border.mmPadding = 0
        Caption = 'lblLayawayTotal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4763
        mmLeft = 101071
        mmTop = 15514
        mmWidth = 29104
        BandType = 7
        LayerName = Foreground2
      end
      object ppLabel28: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label28'
        Border.mmPadding = 0
        Caption = 'Balance Due:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 69586
        mmTop = 20805
        mmWidth = 27252
        BandType = 7
        LayerName = Foreground2
      end
      object lblLayawayBalance: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblLayawayBalance'
        OnGetText = lblLayawayBalanceGetText
        Border.mmPadding = 0
        Caption = 'lblLayawayBalance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5027
        mmLeft = 101071
        mmTop = 20805
        mmWidth = 29104
        BandType = 7
        LayerName = Foreground2
      end
      object ppSubReportPayments: TppSubReport
        DesignLayer = ppDesignLayer3
        UserName = 'SubReportPayments'
        ExpandAll = False
        KeepTogether = True
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'dbpLayawayPayments'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 29898
        mmWidth = 203200
        BandType = 7
        LayerName = Foreground2
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = dbpLayawayPayments
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
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
          Version = '23.02'
          mmColumnWidth = 0
          DataPipelineName = 'dbpLayawayPayments'
          object ppTitleBand1: TppTitleBand
            Border.mmPadding = 0
            mmBottomOffset = 0
            mmHeight = 10319
            mmPrintPosition = 0
            object ppLabel29: TppLabel
              DesignLayer = ppDesignLayer4
              UserName = 'Label29'
              Border.mmPadding = 0
              Caption = 'Date'
              Color = clBlack
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = []
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              Transparent = True
              mmHeight = 5820
              mmLeft = 49477
              mmTop = 4498
              mmWidth = 10584
              BandType = 1
              LayerName = Foreground3
            end
            object ppLabel30: TppLabel
              DesignLayer = ppDesignLayer4
              UserName = 'Label30'
              Border.mmPadding = 0
              Caption = 'Payment'
              Color = clBlack
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = []
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              Transparent = True
              mmHeight = 5820
              mmLeft = 90223
              mmTop = 4498
              mmWidth = 19579
              BandType = 1
              LayerName = Foreground3
            end
            object ppLabel31: TppLabel
              DesignLayer = ppDesignLayer4
              UserName = 'Label31'
              Border.mmPadding = 0
              Caption = 'Balance'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = []
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              Transparent = True
              mmHeight = 5820
              mmLeft = 137054
              mmTop = 4498
              mmWidth = 17992
              BandType = 1
              LayerName = Foreground3
            end
            object ppLine11: TppLine
              DesignLayer = ppDesignLayer4
              UserName = 'Line11'
              Border.mmPadding = 0
              Position = lpBottom
              Weight = 0.75000000000000000
              mmHeight = 3969
              mmLeft = 36160
              mmTop = 6350
              mmWidth = 125589
              BandType = 1
              LayerName = Foreground3
            end
          end
          object ppDetailBand4: TppDetailBand
            Border.mmPadding = 0
            mmBottomOffset = 0
            mmHeight = 7408
            mmPrintPosition = 0
            object ppDBText37: TppDBText
              DesignLayer = ppDesignLayer4
              UserName = 'DBText37'
              AutoSize = True
              Border.mmPadding = 0
              DataField = 'PayDate'
              DataPipeline = dbpLayawayPayments
              DisplayFormat = 'mm/dd/yyyy'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = []
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'dbpLayawayPayments'
              mmHeight = 5821
              mmLeft = 44360
              mmTop = 706
              mmWidth = 19050
              BandType = 4
              LayerName = Foreground3
            end
            object ppDBText38: TppDBText
              DesignLayer = ppDesignLayer4
              UserName = 'DBText38'
              AutoSize = True
              Border.mmPadding = 0
              DataField = 'PayAmount'
              DataPipeline = dbpLayawayPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'dbpLayawayPayments'
              mmHeight = 5821
              mmLeft = 81756
              mmTop = 794
              mmWidth = 25665
              BandType = 4
              LayerName = Foreground3
            end
            object ppDBText39: TppDBText
              DesignLayer = ppDesignLayer4
              UserName = 'DBText39'
              AutoSize = True
              Border.mmPadding = 0
              DataField = 'PrincBalance'
              DataPipeline = dbpLayawayPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'dbpLayawayPayments'
              mmHeight = 5821
              mmLeft = 124435
              mmTop = 704
              mmWidth = 29369
              BandType = 4
              LayerName = Foreground3
            end
          end
          object ppSummaryBand2: TppSummaryBand
            Border.mmPadding = 0
            mmBottomOffset = 0
            mmHeight = 15081
            mmPrintPosition = 0
            object ppLine9: TppLine
              DesignLayer = ppDesignLayer4
              UserName = 'Line9'
              Border.mmPadding = 0
              Weight = 0.75000000000000000
              mmHeight = 3969
              mmLeft = 36336
              mmTop = 529
              mmWidth = 125413
              BandType = 7
              LayerName = Foreground3
            end
            object ppDBCalc1: TppDBCalc
              DesignLayer = ppDesignLayer4
              UserName = 'DBCalc1'
              AutoSize = True
              Border.mmPadding = 0
              DataField = 'PayAmount'
              DataPipeline = dbpLayawayPayments
              DisplayFormat = '$#,0.00;-$#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'dbpLayawayPayments'
              mmHeight = 5821
              mmLeft = 64823
              mmTop = 2117
              mmWidth = 42598
              BandType = 7
              LayerName = Foreground3
            end
            object ppLabel32: TppLabel
              DesignLayer = ppDesignLayer4
              UserName = 'Label32'
              Border.mmPadding = 0
              Caption = 'Balance Due:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = [fsBold]
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 5821
              mmLeft = 44450
              mmTop = 9260
              mmWidth = 32808
              BandType = 7
              LayerName = Foreground3
            end
            object ppLabel33: TppLabel
              DesignLayer = ppDesignLayer4
              UserName = 'lblLayawayBalance1'
              OnGetText = lblLayawayBalanceGetText
              Border.mmPadding = 0
              Caption = 'lblLayawayBalance'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = [fsBold]
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 5821
              mmLeft = 59796
              mmTop = 9260
              mmWidth = 47360
              BandType = 7
              LayerName = Foreground3
            end
            object ppLabel34: TppLabel
              DesignLayer = ppDesignLayer4
              UserName = 'Label34'
              Border.mmPadding = 0
              Caption = 'Total Payments'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 14
              Font.Style = [fsBold]
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 5821
              mmLeft = 39158
              mmTop = 2117
              mmWidth = 38100
              BandType = 7
              LayerName = Foreground3
            end
          end
          object ppDesignLayers4: TppDesignLayers
            object ppDesignLayer4: TppDesignLayer
              UserName = 'Foreground3'
              LayerType = ltBanded
              Index = 0
            end
          end
        end
      end
      object ppLine7: TppLine
        DesignLayer = ppDesignLayer3
        UserName = 'Line7'
        Border.mmPadding = 0
        ParentWidth = True
        Weight = 0.75000000000000000
        mmHeight = 3175
        mmLeft = 0
        mmTop = -87
        mmWidth = 203200
        BandType = 7
        LayerName = Foreground2
      end
    end
    object ppDesignLayers3: TppDesignLayers
      object ppDesignLayer3: TppDesignLayer
        UserName = 'Foreground2'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList3: TppParameterList
    end
  end
  object dbpStore: TppDBPipeline
    DataSource = DM.DSStore
    OpenDataSource = False
    UserName = 'dbpStore'
    Left = 703
    Top = 77
  end
  object qryLayawayRcpt: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryLayawayRcptCalcFields
    Parameters = <
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'select t.TranDate, t.TranMaturity, t.TranPawnAmount, t.TranSales' +
        'Tax, (IsNull(t.TranPawnAmount,0) + IsNull(t.TranSalesTax,0)) as ' +
        'TotalAmount,'
      '       t.TranTicketNo,  TranStatus,'
      
        '       t.CustNo, c.CustLast, c.CustFirst, c.CustMid, c.CustAddr,' +
        ' c.CustApt, c.CustCity, c.CustState, c.CustZip,'
      
        '       COALESCE(c.CustPhCell, c.CustPhHome, c.CustPhBussiness, c' +
        '.CustPhBeep) as CustPhoneNumber,'
      
        '       i.Description as ItemDescription, Weight, WeightUnit, i.U' +
        'nitPrice,'
      
        '       (select max(PayDate) from Payments p where p.TransactionN' +
        'o = t.TransactionNo) as DDate'
      'from Customer c'
      '  JOIN Transactions t ON c.Custno = t.Custno'
      '  JOIN InventoryItems i on i.TransactionNo = t.TransactionNo'
      'where t.TransactionNo = :TransactionNo'
      '')
    Left = 566
    Top = 17
    object qryLayawayRcptcCustName: TStringField
      FieldKind = fkCalculated
      FieldName = 'cCustName'
      Size = 50
      Calculated = True
    end
    object qryLayawayRcptcFPhone: TStringField
      FieldKind = fkCalculated
      FieldName = 'cFPhone'
      Calculated = True
    end
    object qryLayawayRcptcWeightUnit: TStringField
      FieldKind = fkCalculated
      FieldName = 'cWeightUnit'
      Size = 10
      Calculated = True
    end
    object qryLayawayRcptcSalesTax: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'cSalesTax'
      Calculated = True
    end
    object qryLayawayRcptcTotalItemCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'cTotalItemCost'
      Calculated = True
    end
    object qryLayawayRcptTranDate: TDateTimeField
      FieldName = 'TranDate'
    end
    object qryLayawayRcptTranMaturity: TDateField
      FieldName = 'TranMaturity'
    end
    object qryLayawayRcptTranPawnAmount: TFloatField
      FieldName = 'TranPawnAmount'
      currency = True
    end
    object qryLayawayRcptTranSalesTax: TFloatField
      FieldName = 'TranSalesTax'
      currency = True
    end
    object qryLayawayRcptTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      currency = True
    end
    object qryLayawayRcptTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryLayawayRcptTranStatus: TStringField
      FieldName = 'TranStatus'
      Size = 1
    end
    object qryLayawayRcptCustNo: TIntegerField
      FieldName = 'CustNo'
    end
    object qryLayawayRcptCustLast: TStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryLayawayRcptCustFirst: TStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryLayawayRcptCustMid: TStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryLayawayRcptCustAddr: TStringField
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryLayawayRcptCustApt: TStringField
      FieldName = 'CustApt'
      Size = 5
    end
    object qryLayawayRcptCustCity: TStringField
      FieldName = 'CustCity'
      Size = 40
    end
    object qryLayawayRcptCustState: TStringField
      FieldName = 'CustState'
      Size = 2
    end
    object qryLayawayRcptCustZip: TStringField
      FieldName = 'CustZip'
      Size = 11
    end
    object qryLayawayRcptCustPhoneNumber: TStringField
      FieldName = 'CustPhoneNumber'
      Size = 14
    end
    object qryLayawayRcptItemDescription: TStringField
      FieldName = 'ItemDescription'
      Size = 120
    end
    object qryLayawayRcptWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryLayawayRcptWeightUnit: TStringField
      FieldName = 'WeightUnit'
      Size = 1
    end
    object qryLayawayRcptUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      currency = True
      Precision = 19
    end
    object qryLayawayRcptDDate: TDateField
      FieldName = 'DDate'
    end
  end
  object dsLayawayRcpt: TDataSource
    DataSet = qryLayawayRcpt
    Left = 568
    Top = 74
  end
  object qryLayawayPayments: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'select PaymentNo, PayDate, PayAmount, PrincBalance'
      'from Payments'
      'where TransactionNo = :TransactionNo'
      'order by PayDate, PaymentNo ')
    Left = 568
    Top = 145
    object qryLayawayPaymentsPaymentNo: TIntegerField
      FieldName = 'PaymentNo'
    end
    object qryLayawayPaymentsPayDate: TDateField
      FieldName = 'PayDate'
    end
    object qryLayawayPaymentsPayAmount: TFloatField
      FieldName = 'PayAmount'
    end
    object qryLayawayPaymentsPrincBalance: TFloatField
      FieldName = 'PrincBalance'
    end
  end
  object dsLayawayPayments: TDataSource
    DataSet = qryLayawayPayments
    Left = 568
    Top = 202
  end
  object dbpLayawayPayments: TppDBPipeline
    DataSource = dsLayawayPayments
    OpenDataSource = False
    UserName = 'dbpLayawayPayments'
    Left = 703
    Top = 145
    object dbpLayawayPaymentsppField1: TppField
      FieldAlias = 'PaymentNo'
      FieldName = 'PaymentNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object dbpLayawayPaymentsppField2: TppField
      FieldAlias = 'PayDate'
      FieldName = 'PayDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object dbpLayawayPaymentsppField3: TppField
      FieldAlias = 'PayAmount'
      FieldName = 'PayAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object dbpLayawayPaymentsppField4: TppField
      FieldAlias = 'PrincBalance'
      FieldName = 'PrincBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
  end
end
