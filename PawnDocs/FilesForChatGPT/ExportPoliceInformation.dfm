object frmExportPoliceInformation: TfrmExportPoliceInformation
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Generate police file'
  ClientHeight = 411
  ClientWidth = 1497
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 323
    Width = 993
    Height = 62
    TabOrder = 0
    DesignSize = (
      993
      62)
    object btnExit: TBitBtn
      Left = 874
      Top = 12
      Width = 96
      Height = 39
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
    end
  end
  object PageControlExport: TRzPageControl
    AlignWithMargins = True
    Left = 8
    Top = 3
    Width = 995
    Height = 317
    Hint = ''
    ActivePage = TabExportData
    TabIndex = 0
    TabOrder = 1
    TabStyle = tsDoubleSlant
    OnChange = PageControlExportChange
    FixedDimension = 23
    object TabExportData: TRzTabSheet
      Caption = 'Export Transactions Data'
      ExplicitTop = 21
      ExplicitHeight = 293
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 985
        Height = 284
        Align = alClient
        DockSite = True
        TabOrder = 0
        ExplicitHeight = 287
        object Label2: TLabel
          Left = 354
          Top = 7
          Width = 41
          Height = 17
          Caption = 'History'
        end
        object lblProgress: TLabel
          Left = 254
          Top = 247
          Width = 66
          Height = 17
          Caption = 'lblProgress'
        end
        object btnSelectFolder: TSpeedButton
          Left = 254
          Top = 208
          Width = 27
          Height = 23
          Caption = '...'
          OnClick = btnSelectFolderClick
        end
        object lblRegenProgress: TLabel
          Left = 414
          Top = 7
          Width = 82
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'lblProgress'
        end
        object DBGrid1: TDBGrid
          Left = 354
          Top = 24
          Width = 612
          Height = 249
          DataSource = dsHistTranDays
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = PopupMenuHistory
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ExportDate'
              Title.Alignment = taCenter
              Title.Caption = 'Date'
              Width = 162
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ItemCount'
              Title.Alignment = taCenter
              Title.Caption = 'Items Exported'
              Width = 98
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FileName'
              Title.Caption = 'File Name'
              Width = 281
              Visible = True
            end>
        end
        object gbExportTranSelection: TGroupBox
          Left = 12
          Top = 12
          Width = 324
          Height = 175
          TabOrder = 2
          object rbExportDateRange: TRzRadioButton
            Left = 20
            Top = 88
            Width = 87
            Height = 19
            Caption = 'Date Range'
            TabOrder = 0
            OnClick = rbExportDateRangeClick
          end
          object rbExportNotExportedTran: TRzRadioButton
            Left = 16
            Top = 19
            Width = 231
            Height = 19
            Caption = 'Generate Not Exported Transactions'
            Checked = True
            TabOrder = 1
            TabStop = True
          end
          object pnDateRange: TRzPanel
            Left = 35
            Top = 110
            Width = 267
            Height = 54
            BorderOuter = fsNone
            Enabled = False
            TabOrder = 2
            object Label1: TLabel
              Left = 10
              Top = 4
              Width = 63
              Height = 14
              Caption = 'From Date'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 137
              Top = 4
              Width = 48
              Height = 14
              Caption = 'To Date'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object edFDate: TRzDateTimeEdit
              Left = 10
              Top = 22
              Width = 121
              Height = 25
              EditType = etDate
              Enabled = False
              TabOrder = 0
            end
            object edTDate: TRzDateTimeEdit
              Left = 137
              Top = 22
              Width = 121
              Height = 25
              EditType = etDate
              Enabled = False
              TabOrder = 1
            end
          end
          object chkLimitRows: TRzCheckBox
            Left = 35
            Top = 42
            Width = 176
            Height = 30
            AlignmentVertical = avCenter
            AutoSize = False
            Caption = 'Limit number of transactions to export: '
            State = cbUnchecked
            TabOrder = 3
            WordWrap = True
            OnClick = chkLimitRowsClick
          end
          object pnRowLimit: TRzPanel
            Left = 209
            Top = 37
            Width = 78
            Height = 34
            BorderOuter = fsNone
            Enabled = False
            TabOrder = 4
            object edLimitRows: TRzNumericEdit
              Left = 8
              Top = 6
              Width = 65
              Height = 25
              Enabled = False
              TabOrder = 0
              DisplayFormat = ',0;(,0)'
              Value = 1000.000000000000000000
            end
          end
        end
        object edExportFolder: TLabeledEdit
          Left = 36
          Top = 208
          Width = 212
          Height = 25
          EditLabel.Width = 111
          EditLabel.Height = 17
          EditLabel.Caption = 'Export Files Folder:'
          TabOrder = 3
        end
        object btnGenAndExport: TRzBitBtn
          Left = 36
          Top = 236
          Width = 212
          Height = 42
          Caption = 'Generate and Export'
          TabOrder = 1
          OnClick = btnGenAndExportClick
          ImageIndex = 13
          Images = DM.ImageListBtn
          Layout = blGlyphRight
          Margin = 20
          Spacing = -4
        end
      end
    end
    object TabSendImages: TRzTabSheet
      Caption = 'Send Images to LeadsOnline'
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 985
        Height = 284
        Align = alClient
        TabOrder = 0
        DesignSize = (
          985
          284)
        object lblNotSendPics: TLabel
          Left = 23
          Top = 6
          Width = 135
          Height = 17
          Caption = 'Item'#39's Pictures not Sent'
        end
        object btnSendImages: TRzToolButton
          AlignWithMargins = True
          Left = 402
          Top = 104
          Width = 153
          Height = 48
          Flat = False
          ImageIndex = 13
          Images = DM.ImageListBtn
          Layout = blGlyphRight
          ShowCaption = True
          Spacing = 15
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          Caption = 'Send Images'
          OnClick = btnSendImagesClick
        end
        object lblFTPStatus: TLabel
          Left = 423
          Top = 158
          Width = 69
          Height = 17
          Caption = 'lblFTPStatus'
        end
        object lblSendImgProgress: TLabel
          Left = 423
          Top = 187
          Width = 117
          Height = 17
          Caption = 'lblSendImgProgress'
        end
        object Label4: TLabel
          Left = 571
          Top = 6
          Width = 98
          Height = 17
          Caption = 'Operation Result'
        end
        object MemoTxResult: TMemo
          Left = 561
          Top = 26
          Width = 407
          Height = 241
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object chkShowTxDetail: TCheckBox
          Left = 423
          Top = 31
          Width = 114
          Height = 26
          Caption = 'Show TX Detail'
          TabOrder = 1
          WordWrap = True
        end
        object pgItemPics: TRzPageControl
          Left = 13
          Top = 26
          Width = 383
          Height = 252
          Hint = ''
          ActivePage = TabSheet1
          Anchors = [akLeft, akTop, akBottom]
          TabIndex = 0
          TabOrder = 2
          OnChange = pgItemPicsChange
          FixedDimension = 23
          object TabSheet1: TRzTabSheet
            Caption = 'Item'#39's Pictures not Sent'
            ExplicitTop = 21
            ExplicitHeight = 228
            object RzPanel1: TRzPanel
              Left = 0
              Top = 0
              Width = 379
              Height = 225
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 0
              ExplicitHeight = 228
              object DBGrid2: TDBGrid
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 373
                Height = 219
                Align = alClient
                DataSource = dsImagesNotExp
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
                PopupMenu = popMnu
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -13
                TitleFont.Name = 'Segoe UI'
                TitleFont.Style = []
                OnDblClick = ViewImages1Click
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'TranTicketNo'
                    Title.Caption = 'Ticket No.'
                    Width = 94
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ItemSeq'
                    Title.Caption = 'Item No'
                    Width = 51
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'ImageDesc'
                    Title.Caption = 'Decription'
                    Width = 172
                    Visible = True
                  end>
              end
            end
          end
          object TabSheet2: TRzTabSheet
            Caption = 'Item'#39's Pictures Sent'
            object DBGrid3: TDBGrid
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 373
              Height = 219
              Align = alClient
              DataSource = dsSentImg
              PopupMenu = popMnu2
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'Segoe UI'
              TitleFont.Style = []
              Columns = <
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'ImagesDataNo'
                  Title.Alignment = taCenter
                  Title.Caption = 'No'
                  Width = 45
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ImageDesc'
                  Title.Caption = 'Comment'
                  Width = 120
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UploadTime'
                  Title.Caption = 'Uploaded'
                  Width = 155
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UploadFileName'
                  Title.Caption = 'Upload File Name'
                  Width = 261
                  Visible = True
                end>
            end
          end
        end
        object chkFTPOnlyOne: TCheckBox
          Left = 424
          Top = 64
          Width = 97
          Height = 17
          Caption = 'FTP only one'
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TRzTabSheet
      TabVisible = False
      Caption = 'Update for Images'
      object lblItemSeq: TLabel
        Left = 27
        Top = 80
        Width = 61
        Height = 17
        Caption = 'lblItemSeq'
      end
      object lblItemInvNo: TLabel
        Left = 27
        Top = 100
        Width = 61
        Height = 17
        Caption = 'lblItemSeq'
      end
      object lblRowProgress: TLabel
        Left = 27
        Top = 49
        Width = 52
        Height = 17
        Caption = 'Progress'
      end
      object Button1: TButton
        Left = 18
        Top = 18
        Width = 98
        Height = 25
        Caption = 'Update Info'
        TabOrder = 0
        OnClick = Button1Click
      end
      object btnOpen: TButton
        Left = 27
        Top = 255
        Width = 75
        Height = 25
        Caption = 'Open'
        TabOrder = 1
        OnClick = btnOpenClick
      end
    end
  end
  object qryHistTranDays: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select top 2000 *'
      'from ExportFileLog '
      'order by ExportLogID desc')
    Left = 1029
    Top = 34
    object qryHistTranDaysExportLogID: TIntegerField
      FieldName = 'ExportLogID'
    end
    object qryHistTranDaysExportDate: TDateTimeField
      FieldName = 'ExportDate'
    end
    object qryHistTranDaysFileName: TStringField
      FieldName = 'FileName'
      Size = 50
    end
    object qryHistTranDaysItemCount: TIntegerField
      FieldName = 'ItemCount'
    end
  end
  object dsHistTranDays: TDataSource
    AutoEdit = False
    DataSet = qryHistTranDays
    Left = 1028
    Top = 83
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'Text Files (*.txt)|*.txt'
    Options = [ofReadOnly, ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 1382
    Top = 269
  end
  object PropertyStore: TRzPropertyStore
    Properties = <
      item
        Component = edExportFolder
        PropertyName = 'Text'
      end>
    RegIniFile = DM.RegIniFile
    Left = 1384
    Top = 210
  end
  object qryImagesNotExp: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    AfterOpen = qryImagesNotExpAfterOpen
    Parameters = <>
    SQL.Strings = (
      
        'select T1.TransactionNo, T1.InvItemNo, T1.ItemSeq, T3.ImagesData' +
        'No, T3.ImageDesc,'
      '       T4.TranTicketNo, T4.TranType, T4.TranDate'
      'from ExportLogFileDetail T1'
      
        '  join InventoryItems T2 on T1.TransactionNo = T2.TransactionNo ' +
        'AND  T1.InvItemNo = T2.InvItemNo'
      '  join ImagesData T3 on T2.InvItemNo = T3.ImagRefToRowNo'
      '  join Transactions T4 on T4.TransactionNo = T1.TransactionNo'
      'where T3.ImageTypeNo = 2 AND  T3.UploadTime is NULL'
      'order by T1.TransactionNo, T1.InvItemNo')
    Left = 1124
    Top = 34
    object qryImagesNotExpTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryImagesNotExpInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryImagesNotExpItemSeq: TIntegerField
      FieldName = 'ItemSeq'
    end
    object qryImagesNotExpImagesDataNo: TIntegerField
      FieldName = 'ImagesDataNo'
    end
    object qryImagesNotExpImageDesc: TStringField
      FieldName = 'ImageDesc'
      Size = 125
    end
    object qryImagesNotExpTranTicketNo: TStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryImagesNotExpTranType: TStringField
      FieldName = 'TranType'
      Size = 1
    end
    object qryImagesNotExpTranDate: TDateTimeField
      FieldName = 'TranDate'
    end
  end
  object dsImagesNotExp: TDataSource
    DataSet = qryImagesNotExp
    Left = 1128
    Top = 83
  end
  object popMnu: TPopupMenu
    Left = 146
    Top = 99
    object ViewImages1: TMenuItem
      Caption = 'View Images'
      OnClick = ViewImages1Click
    end
  end
  object FTP: TIdFTP
    OnStatus = FTPStatus
    OnDisconnected = FTPDisconnected
    OnConnected = FTPConnected
    IPVersion = Id_IPv4
    Passive = True
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 1163
    Top = 321
  end
  object qrySentImg: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select ImagesDataNo, ImageDesc, UploadTime, UploadFileName'
      'from ImagesData'
      'where UploadTime is not NULL '
      'order by UploadTime DESC ')
    Left = 1028
    Top = 164
    object qrySentImgImagesDataNo: TIntegerField
      FieldName = 'ImagesDataNo'
    end
    object qrySentImgImageDesc: TStringField
      FieldName = 'ImageDesc'
      Size = 125
    end
    object qrySentImgUploadTime: TDateTimeField
      FieldName = 'UploadTime'
    end
    object qrySentImgUploadFileName: TStringField
      FieldName = 'UploadFileName'
      Size = 50
    end
  end
  object dsSentImg: TDataSource
    DataSet = qrySentImg
    Left = 1028
    Top = 217
  end
  object popMnu2: TPopupMenu
    Left = 154
    Top = 175
    object MenuItem1: TMenuItem
      Caption = 'View Images'
      OnClick = MenuItem1Click
    end
  end
  object qryExpLogDetail: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from ExportLogFileDetail'
      'order by ID')
    Left = 1260
    Top = 34
    object qryExpLogDetailID: TIntegerField
      FieldName = 'ID'
    end
    object qryExpLogDetailExportLogID: TIntegerField
      FieldName = 'ExportLogID'
    end
    object qryExpLogDetailTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryExpLogDetailExportLine: TMemoField
      FieldName = 'ExportLine'
      BlobType = ftMemo
    end
    object qryExpLogDetailInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryExpLogDetailItemSeq: TIntegerField
      FieldName = 'ItemSeq'
    end
  end
  object dsExpLogDetail: TDataSource
    DataSet = qryExpLogDetail
    Left = 1264
    Top = 83
  end
  object qryGetItemNo: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'select InvItemNo'
      'from InventoryItems'
      'where TransactionNo = :TransactionNo'
      'order by InvItemNo')
    Left = 1128
    Top = 164
    object qryGetItemNoInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
  end
  object PopupMenuHistory: TPopupMenu
    Images = DM.ImageListBtn
    Left = 604
    Top = 115
    object ReGenerateExportFile1: TMenuItem
      Bitmap.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000F3F3F3DDDDDD
        D5D5D5D0D0D0CBCBCBCCCCCCC7C7C8C8C8CBC8CACDC9CACECECED1CCCCCED0D0
        D0D5D5D5DDDDDDF3F3F3FAFAFAF2F2F2E6E5E3E2E1DEE1E2E5DFDFE2D7D5D0B1
        A381A2884FA18749AB9971D3D0C8E4E5E6EAEAEBF2F2F2FBFBFBFFFFFFFFFFFF
        D9CCADB59650FFFFFFD3C39F9E771D9E78229E79249E7925A47F29CCB278EADE
        C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7C59A9E7A28A8863A9E79279E7A289E
        7A289F7B29CDB682FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        CFB782A17C2BA17C2BA17C2BA17C2BA37E2DEBE2CCFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0B171B18938B18938B18938B18A39F3
        EDE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        D2AC61BD9543BD9544BD9544C09748F7F3EAFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBE5BAEBCB8AE5C279E0B769DEB465E2
        B96BFEFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF8F4FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
        F7F5AA832EBC9648CCA961D8B878E5C78CFAE9C8FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBE1CCAF8938B88F40C19848C99F
        4FE6C079FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF6F3ECB38D3CBA9142C39A4ACBA051EECF94FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2ECDFB18A3BB28D3CBC9344C39A4ACDA2
        53F4DAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAC79CA4
        7F2CAD8734B48C3CBB9241CFAA5DCFA250FAE6C0FFFFFFFFFFFFFFFFFFFFFFFF
        FEFEFEE8DBBED5C296AB8A3A9C7825A37E2BAC8532BB9545EDD8ABFFFFFFE2BC
        75F6E8CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6DDC6CBB682BEA464C9
        AE73E2CFA6F7F3EBFFFFFFFFFFFFFAF8F4FAF8F5FFFFFFFFFFFF}
      Caption = 'Re-Generate Export File'
      ImageIndex = 14
      OnClick = btnExportFromDateSelectedInGridClick
    end
  end
end
