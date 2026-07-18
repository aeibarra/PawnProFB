object frmReport01: TfrmReport01
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pawn with late payments'
  ClientHeight = 184
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 21
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 109
    Width = 381
    Height = 71
    TabOrder = 1
    DesignSize = (
      381
      71)
    object RzBitBtn1: TRzBitBtn
      Left = 11
      Top = 12
      Width = 112
      Height = 49
      Caption = 'Preview'
      TabOrder = 0
      OnClick = RzBitBtn1Click
      ImageIndex = 30
      Images = DM.vilMain24
      Spacing = 0
    end
    object RzBitBtn2: TRzBitBtn
      Left = 133
      Top = 12
      Width = 112
      Height = 49
      Caption = 'Print'
      TabOrder = 1
      OnClick = RzBitBtn2Click
      ImageIndex = 0
      Images = DM.vilMain24
      Spacing = 0
    end
    object btnExit: TBitBtn
      Left = 274
      Top = 12
      Width = 97
      Height = 49
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 2
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 381
    Height = 100
    TabOrder = 0
    object Label1: TLabel
      Left = 25
      Top = 11
      Width = 207
      Height = 19
      Caption = 'Pawn with late payments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 35
      Top = 51
      Width = 89
      Height = 21
      Caption = 'Months Late:'
    end
    object lblProgress: TLabel
      Left = 230
      Top = 51
      Width = 78
      Height = 21
      Caption = 'lblProgress'
    end
    object edMonths: TRzSpinEdit
      Left = 137
      Top = 48
      Width = 65
      Height = 29
      Max = 100.00000000000000000
      Value = 1.00000000000000000
      TabOrder = 0
    end
  end
  object dsLatePawn: TDataSource
    DataSet = clnLatePawn
    Left = 683
    Top = 73
  end
  object DBPLatePawn: TppDBPipeline
    DataSource = dsLatePawn
    OpenDataSource = False
    UserName = 'DBPLatePawn'
    Left = 768
    Top = 11
    object DBPLatePawnppField1: TppField
      FieldAlias = 'cFullName'
      FieldName = 'cFullName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField2: TppField
      FieldAlias = 'cPhones'
      FieldName = 'cPhones'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField3: TppField
      FieldAlias = 'TransactionNo'
      FieldName = 'TransactionNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField4: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField5: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField6: TppField
      FieldAlias = 'Custno'
      FieldName = 'Custno'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField7: TppField
      FieldAlias = 'LatePayment'
      FieldName = 'LatePayment'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField8: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField9: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField10: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField11: TppField
      FieldAlias = 'TranPawnAmount'
      FieldName = 'TranPawnAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField12: TppField
      FieldAlias = 'TranInterest'
      FieldName = 'TranInterest'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField13: TppField
      FieldAlias = 'CustPhCell'
      FieldName = 'CustPhCell'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField14: TppField
      FieldAlias = 'CustPhHome'
      FieldName = 'CustPhHome'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField15: TppField
      FieldAlias = 'CustPhBussiness'
      FieldName = 'CustPhBussiness'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField16: TppField
      FieldAlias = 'InterestOwed'
      FieldName = 'InterestOwed'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPLatePawnppField17: TppField
      FieldAlias = 'NextDueDate'
      FieldName = 'NextDueDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
  end
  object RepLatePawn: TppReport
    AutoStop = False
    DataPipeline = DBPLatePawn
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
    Left = 768
    Top = 73
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPLatePawn'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 27781
      mmPrintPosition = 0
      object lblRptLatePayTitle: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblRptLatePayTitle'
        Border.mmPadding = 0
        Caption = 'Pawns with Payments 2 Months Late'
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
        mmLeft = 46302
        mmTop = 1852
        mmWidth = 110596
        BandType = 0
        LayerName = Foreground
      end
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable1'
        Border.mmPadding = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 1325
        mmTop = 0
        mmWidth = 14288
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
        mmTop = 23548
        mmWidth = 203200
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
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 189177
        mmTop = 0
        mmWidth = 14023
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        Border.mmPadding = 0
        Caption = 'Client Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 757
        mmTop = 22225
        mmWidth = 17992
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel10: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label10'
        Border.mmPadding = 0
        Caption = 'Client Phone Numbers'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 75488
        mmTop = 22225
        mmWidth = 32808
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 9790
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPLatePawn
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPLatePawn'
        mmHeight = 3969
        mmLeft = 19680
        mmTop = 0
        mmWidth = 18257
        BandType = 4
        LayerName = Foreground
      end
      object ppSubReport1: TppSubReport
        DesignLayer = ppDesignLayer1
        UserName = 'SubReport1'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'DBPPayments'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 4760
        mmWidth = 203200
        BandType = 4
        LayerName = Foreground
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = DBPPayments
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
          Version = '23.02'
          mmColumnWidth = 0
          DataPipelineName = 'DBPPayments'
          object ppTitleBand1: TppTitleBand
            Border.mmPadding = 0
            mmBottomOffset = 0
            mmHeight = 4763
            mmPrintPosition = 0
            object ppLine2: TppLine
              DesignLayer = ppDesignLayer2
              UserName = 'Line2'
              Border.mmPadding = 0
              Position = lpBottom
              Weight = 0.75000000000000000
              mmHeight = 3969
              mmLeft = 35719
              mmTop = 794
              mmWidth = 60590
              BandType = 1
              LayerName = Foreground1
            end
            object ppLabel4: TppLabel
              DesignLayer = ppDesignLayer2
              UserName = 'Label4'
              Border.mmPadding = 0
              Caption = 'Payment Date'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 9
              Font.Style = [fsBold]
              FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
              FormFieldSettings.FormFieldType = fftNone
              Transparent = True
              mmHeight = 3968
              mmLeft = 39136
              mmTop = 0
              mmWidth = 19579
              BandType = 1
              LayerName = Foreground1
            end
            object ppLabel5: TppLabel
              DesignLayer = ppDesignLayer2
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
              mmHeight = 3968
              mmLeft = 79617
              mmTop = 0
              mmWidth = 11113
              BandType = 1
              LayerName = Foreground1
            end
          end
          object ppDetailBand2: TppDetailBand
            Border.mmPadding = 0
            mmBottomOffset = 0
            mmHeight = 4763
            mmPrintPosition = 0
            object ppDBText3: TppDBText
              DesignLayer = ppDesignLayer2
              UserName = 'DBText3'
              Border.mmPadding = 0
              DataField = 'PayDate'
              DataPipeline = DBPPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 9
              Font.Style = []
              Transparent = True
              DataPipelineName = 'DBPPayments'
              mmHeight = 4498
              mmLeft = 40725
              mmTop = 265
              mmWidth = 17198
              BandType = 4
              LayerName = Foreground1
            end
            object ppDBText6: TppDBText
              DesignLayer = ppDesignLayer2
              UserName = 'DBText6'
              Border.mmPadding = 0
              DataField = 'PayAmount'
              DataPipeline = DBPPayments
              DisplayFormat = '$#,0.00;($#,0.00)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 9
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'DBPPayments'
              mmHeight = 4498
              mmLeft = 73798
              mmTop = 265
              mmWidth = 17198
              BandType = 4
              LayerName = Foreground1
            end
          end
          object ppSummaryBand1: TppSummaryBand
            Border.mmPadding = 0
            mmBottomOffset = 0
            mmHeight = 1323
            mmPrintPosition = 0
            object ppLine3: TppLine
              DesignLayer = ppDesignLayer2
              UserName = 'Line3'
              Border.mmPadding = 0
              Weight = 0.75000000000000000
              mmHeight = 1319
              mmLeft = 35719
              mmTop = 0
              mmWidth = 60590
              BandType = 7
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
        end
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText7'
        Border.mmPadding = 0
        DataField = 'TranPawnAmount'
        DataPipeline = DBPLatePawn
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPLatePawn'
        mmHeight = 3969
        mmLeft = 75631
        mmTop = 0
        mmWidth = 19903
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPLatePawn
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPLatePawn'
        mmHeight = 4498
        mmLeft = 46038
        mmTop = 0
        mmWidth = 18766
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        Border.mmPadding = 0
        DataField = 'LatePayment'
        DataPipeline = DBPLatePawn
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPLatePawn'
        mmHeight = 3969
        mmLeft = 104823
        mmTop = 0
        mmWidth = 18007
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'InterestOwed'
        DataPipeline = DBPLatePawn
        DisplayFormat = '$#,0.00;($#,0.00)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPLatePawn'
        mmHeight = 3969
        mmLeft = 131234
        mmTop = 0
        mmWidth = 20093
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText10: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText10'
        Border.mmPadding = 0
        DataField = 'NextDueDate'
        DataPipeline = DBPLatePawn
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPLatePawn'
        mmHeight = 3969
        mmLeft = 162257
        mmTop = 0
        mmWidth = 20282
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'cFullName'
      DataPipeline = DBPLatePawn
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      KeepTogether = True
      OutlineSettings.CreateNode = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'DBPLatePawn'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 8996
        mmPrintPosition = 0
        object ppDBText1: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText1'
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'cFullName'
          DataPipeline = DBPLatePawn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          Transparent = True
          DataPipelineName = 'DBPLatePawn'
          mmHeight = 3969
          mmLeft = 794
          mmTop = 0
          mmWidth = 13758
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText4: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText4'
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'cPhones'
          DataPipeline = DBPLatePawn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = []
          Transparent = True
          DataPipelineName = 'DBPLatePawn'
          mmHeight = 3969
          mmLeft = 75406
          mmTop = 0
          mmWidth = 10584
          BandType = 3
          GroupNo = 0
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
          mmLeft = 21162
          mmTop = 5025
          mmWidth = 15081
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel7: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label7'
          Border.mmPadding = 0
          Caption = 'Pawn Amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 10
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 75406
          mmTop = 5027
          mmWidth = 19844
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel8: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label8'
          Border.mmPadding = 0
          Caption = 'Pawn Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 10
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 48154
          mmTop = 5026
          mmWidth = 15082
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel1: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label1'
          Border.mmPadding = 0
          Caption = 'Next Due Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 10
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3969
          mmLeft = 162032
          mmTop = 4233
          mmWidth = 20638
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel6: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label6'
          Border.mmPadding = 0
          Caption = 'Interest Owed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 10
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3968
          mmLeft = 131234
          mmTop = 4763
          mmWidth = 20108
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel9: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label9'
          Border.mmPadding = 0
          Caption = 'Months Late'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 10
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3968
          mmLeft = 104511
          mmTop = 4763
          mmWidth = 17991
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
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
  object qryPayments: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select'
      '  PAYMENT_NO as "PaymentNo",'
      '  TRANSACTION_NO as "TransactionNo",'
      '  PAY_DATE as "PayDate",'
      '  PAY_AMOUNT as "PayAmount",'
      '  PAY_COMMENT as "PayComment",'
      '  PAY_METHOD as "PayMethod",'
      '  PAY_INTEREST as "PayInterest",'
      '  PAY_PRINCIPAL as "PayPrincipal",'
      '  PRINC_BALANCE as "PrincBalance",'
      '  INTEREST_BALANCE as "InsterestBalance"'
      'from PAYMENTS'
      'where TRANSACTION_NO = :TransactionNo'
      'order by PAY_DATE, PAYMENT_NO')
    Left = 432
    Top = 11
    ParamData = <
      item
        Name = 'TransactionNo'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsPayments: TDataSource
    DataSet = qryPayments
    Left = 432
    Top = 73
  end
  object prvLatePawn: TDataSetProvider
    DataSet = spLatePawn
    Left = 603
    Top = 73
  end
  object clnLatePawn: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'prvLatePawn'
    AfterScroll = clnLatePawnAfterScroll
    OnCalcFields = clnLatePawnCalcFields
    Left = 683
    Top = 10
    object clnLatePawncFullName: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cFullName'
      Size = 120
      Calculated = True
    end
    object clnLatePawncPhones: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cPhones'
      Size = 128
      Calculated = True
    end
    object clnLatePawnTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
      Origin = '"TransactionNo"'
    end
    object clnLatePawnTranTicketNo: TWideStringField
      FieldName = 'TranTicketNo'
      Origin = '"TranTicketNo"'
      Size = 30
    end
    object clnLatePawnTranDate: TDateField
      FieldName = 'TranDate'
      Origin = '"TranDate"'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object clnLatePawnCustno: TIntegerField
      FieldName = 'Custno'
      Origin = '"Custno"'
    end
    object clnLatePawnLatePayment: TIntegerField
      FieldName = 'LatePayment'
      Origin = '"LatePayment"'
    end
    object clnLatePawnCustLast: TWideStringField
      FieldName = 'CustLast'
      Origin = '"CustLast"'
      Size = 35
    end
    object clnLatePawnCustFirst: TWideStringField
      FieldName = 'CustFirst'
      Origin = '"CustFirst"'
      Size = 35
    end
    object clnLatePawnCustMid: TWideStringField
      FieldName = 'CustMid'
      Origin = '"CustMid"'
      Size = 1
    end
    object clnLatePawnTranPawnAmount: TFloatField
      FieldName = 'TranPawnAmount'
      Origin = '"TranPawnAmount"'
    end
    object clnLatePawnTranInterest: TFloatField
      FieldName = 'TranInterest'
      Origin = '"TranInterest"'
    end
    object clnLatePawnCustPhCell: TWideStringField
      FieldName = 'CustPhCell'
      Origin = '"CustPhCell"'
      Size = 14
    end
    object clnLatePawnCustPhHome: TWideStringField
      FieldName = 'CustPhHome'
      Origin = '"CustPhHome"'
      Size = 14
    end
    object clnLatePawnCustPhBussiness: TWideStringField
      FieldName = 'CustPhBussiness'
      Origin = '"CustPhBussiness"'
      Size = 14
    end
    object clnLatePawnInterestOwed: TFloatField
      FieldName = 'InterestOwed'
      Origin = '"InterestOwed"'
      DisplayFormat = '$#,##0.00'
    end
    object clnLatePawnNextDueDate: TDateField
      FieldName = 'NextDueDate'
      Origin = '"NextDueDate"'
      DisplayFormat = 'mm/dd/yyyy'
    end
  end
  object DBPPayments: TppDBPipeline
    DataSource = dsPayments
    OpenDataSource = False
    UserName = 'DBPPayments'
    Left = 504
    Top = 11
  end
  object spLatePawn: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select'
      '  T2.TRANSACTION_NO as "TransactionNo",'
      '  T2.TRAN_TICKET_NO as "TranTicketNo",'
      '  CAST(T2.TRAN_DATE AS DATE) as "TranDate",'
      '  CAST(0 AS INTEGER) as "LatePayment",'
      '  T1.CUST_NO as "Custno",'
      '  T1.CUST_LAST as "CustLast",'
      '  T1.CUST_FIRST as "CustFirst",'
      '  T1.CUST_MID as "CustMid",'
      '  T2.TRAN_PAWN_AMOUNT as "TranPawnAmount",'
      '  T2.TRAN_INTEREST as "TranInterest",'
      '  T1.CUST_PH_CELL as "CustPhCell",'
      '  T1.CUST_PH_HOME as "CustPhHome",'
      '  T1.CUST_PH_BUSINESS as "CustPhBussiness",'
      '  CAST(0 AS DOUBLE PRECISION) as "InterestOwed",'
      '  CAST(NULL AS DATE) as "NextDueDate"'
      'from CUSTOMER T1'
      '  join TRANSACTIONS T2 on T1.CUST_NO = T2.CUST_NO'
      '  where T2.TRAN_TYPE = '#39'P'#39' and T2.TRAN_STATUS = '#39'A'#39
      '  order by T1.CUST_FIRST, T1.CUST_LAST, T1.CUST_NO')
    Left = 604
    Top = 11
  end
end
