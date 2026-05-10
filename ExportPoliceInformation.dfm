object frmExportPoliceInformation: TfrmExportPoliceInformation
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Generate police file'
  ClientHeight = 472
  ClientWidth = 1497
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 17
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 362
    Width = 993
    Height = 69
    TabOrder = 0
    DesignSize = (
      993
      69)
    object btnExit: TBitBtn
      Left = 881
      Top = 11
      Width = 96
      Height = 48
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
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
    Height = 357
    Hint = ''
    ActivePage = TabExportData
    HotTrackStyle = htsTabBar
    TabHeight = 35
    TabIndex = 0
    TabOrder = 1
    OnChange = PageControlExportChange
    FixedDimension = 35
    object TabExportData: TRzTabSheet
      Caption = 'Export Transactions Data'
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 985
        Height = 312
        Align = alClient
        DockSite = True
        TabOrder = 0
        object Label2: TLabel
          Left = 354
          Top = 7
          Width = 41
          Height = 17
          Caption = 'History'
        end
        object lblProgress: TLabel
          Left = 261
          Top = 261
          Width = 66
          Height = 17
          Caption = 'lblProgress'
        end
        object btnSelectFolder: TSpeedButton
          Left = 305
          Top = 216
          Width = 27
          Height = 26
          Caption = '...'
          OnClick = btnSelectFolderClick
        end
        object lblRegenProgress: TLabel
          Left = 414
          Top = 7
          Width = 82
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'lblProgress'
        end
        object DBGrid1: TDBGrid
          Left = 354
          Top = 27
          Width = 628
          Height = 282
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
              Width = 308
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
            Left = 16
            Top = 88
            Width = 94
            Height = 19
            AutoSizeWidth = 94
            Caption = 'Date Range'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = rbExportDateRangeClick
          end
          object rbExportNotExportedTran: TRzRadioButton
            Left = 16
            Top = 19
            Width = 245
            Height = 19
            AutoSizeWidth = 245
            Caption = 'Generate Not Exported Transactions'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            TabStop = True
            OnClick = rbExportNotExportedTranClick
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
            AutoSizeWidth = 176
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
              Value = 1000.00000000000000000
            end
          end
        end
        object edExportFolder: TLabeledEdit
          Left = 12
          Top = 216
          Width = 282
          Height = 25
          EditLabel.Width = 111
          EditLabel.Height = 17
          EditLabel.Caption = 'Export Files Folder:'
          TabOrder = 3
          Text = ''
        end
        object btnGenAndExport: TRzBitBtn
          Left = 12
          Top = 248
          Width = 236
          Height = 54
          Caption = 'Generate and Export'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnGenAndExportClick
          ImageIndex = 33
          Images = DM.vilMain
          Layout = blGlyphRight
          Margin = 20
          Spacing = -4
        end
      end
    end
    object TabSendImages: TRzTabSheet
      Caption = '  Send Images to LeadsOnline'
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 985
        Height = 312
        Align = alClient
        TabOrder = 0
        DesignSize = (
          985
          312)
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
          ImageIndex = 33
          Images = DM.vilMain
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
          Height = 283
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
          Height = 280
          Hint = ''
          ActivePage = TabSheet1
          Anchors = [akLeft, akTop, akBottom]
          TabIndex = 0
          TabOrder = 2
          OnChange = pgItemPicsChange
          FixedDimension = 23
          object TabSheet1: TRzTabSheet
            Caption = 'Item'#39's Pictures not Sent'
            object RzPanel1: TRzPanel
              Left = 0
              Top = 0
              Width = 379
              Height = 253
              Align = alClient
              BorderOuter = fsNone
              TabOrder = 0
              object DBGrid2: TDBGrid
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 373
                Height = 247
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
              Height = 247
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
  object qryHistTranDays: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select first 2000'
      '  EXPORT_LOG_ID as "ExportLogID",'
      '  EXPORT_DATE as "ExportDate",'
      '  FILE_NAME as "FileName",'
      '  ITEM_COUNT as "ItemCount"'
      'from EXPORT_FILE_LOG'
      'order by EXPORT_LOG_ID desc')
    Left = 1029
    Top = 34
    object qryHistTranDaysExportLogID: TIntegerField
      FieldName = 'ExportLogID'
    end
    object qryHistTranDaysExportDate: TSQLTimeStampField
      FieldName = 'ExportDate'
      DisplayFormat = 'mm/dd/yyyy hh:nn:ss AM/PM'
    end
    object qryHistTranDaysFileName: TWideStringField
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
    Top = 87
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
  object qryImagesNotExp: TFDQuery
    Connection = DM.ConnFB
    AfterOpen = qryImagesNotExpAfterOpen
    SQL.Strings = (
      'select'
      '  T1.TRANSACTION_NO as "TransactionNo",'
      '  T1.INV_ITEM_NO as "InvItemNo",'
      '  T1.ITEM_SEQ as "ItemSeq",'
      '  T3.IMAGES_DATA_NO as "ImagesDataNo",'
      '  T3.IMAGE_DESC as "ImageDesc",'
      '  T4.TRAN_TICKET_NO as "TranTicketNo",'
      '  T4.TRAN_TYPE as "TranType",'
      '  T4.TRAN_DATE as "TranDate"'
      'from EXPORT_LOG_FILE_DETAIL T1'
      
        '  join INVENTORY_ITEMS T2 on T1.TRANSACTION_NO = T2.TRANSACTION' +
        '_NO AND T1.INV_ITEM_NO = T2.INV_ITEM_NO'
      '  join IMAGES_DATA T3 on T2.INV_ITEM_NO = T3.IMAG_REF_TO_ROW_NO'
      '  join TRANSACTIONS T4 on T4.TRANSACTION_NO = T1.TRANSACTION_NO'
      'where T3.IMAGE_TYPE_NO = 2 and T3.UPLOAD_TIME is null'
      'order by T1.TRANSACTION_NO, T1.INV_ITEM_NO')
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
    object qryImagesNotExpImageDesc: TWideStringField
      FieldName = 'ImageDesc'
      Size = 125
    end
    object qryImagesNotExpTranTicketNo: TWideStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryImagesNotExpTranType: TWideStringField
      FieldName = 'TranType'
      Size = 1
    end
    object qryImagesNotExpTranDate: TDateField
      FieldName = 'TranDate'
    end
  end
  object dsImagesNotExp: TDataSource
    DataSet = qryImagesNotExp
    Left = 1128
    Top = 87
  end
  object popMnu: TPopupMenu
    Left = 80
    Top = 158
    object ViewImages1: TMenuItem
      Caption = 'View Images'
      OnClick = ViewImages1Click
    end
  end
  object FTP: TIdFTP
    OnStatus = FTPStatus
    OnDisconnected = FTPDisconnected
    OnConnected = FTPConnected
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
  object qrySentImg: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select'
      '  IMAGES_DATA_NO as "ImagesDataNo",'
      '  IMAGE_DESC as "ImageDesc",'
      '  UPLOAD_TIME as "UploadTime",'
      '  UPLOAD_FILE_NAME as "UploadFileName"'
      'from IMAGES_DATA'
      'where UPLOAD_TIME is not null'
      'order by UPLOAD_TIME desc')
    Left = 1028
    Top = 164
    object qrySentImgImagesDataNo: TIntegerField
      FieldName = 'ImagesDataNo'
    end
    object qrySentImgImageDesc: TWideStringField
      FieldName = 'ImageDesc'
      Size = 125
    end
    object qrySentImgUploadTime: TSQLTimeStampField
      FieldName = 'UploadTime'
    end
    object qrySentImgUploadFileName: TWideStringField
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
  object qryExpLogDetail: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select'
      '  ID as "ID",'
      '  EXPORT_LOG_ID as "ExportLogID",'
      '  TRANSACTION_NO as "TransactionNo",'
      '  EXPORT_LINE as "ExportLine",'
      '  INV_ITEM_NO as "InvItemNo",'
      '  ITEM_SEQ as "ItemSeq"'
      'from EXPORT_LOG_FILE_DETAIL'
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
    Top = 87
  end
  object qryGetItemNo: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select INV_ITEM_NO as "InvItemNo"'
      'from INVENTORY_ITEMS'
      'where TRANSACTION_NO = :TransactionNo'
      'order by INV_ITEM_NO')
    Left = 1128
    Top = 164
    ParamData = <
      item
        Name = 'TRANSACTIONNO'
        DataType = ftInteger
        ParamType = ptInput
      end>
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
