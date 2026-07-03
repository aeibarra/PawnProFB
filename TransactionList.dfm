object frmTransactionList: TfrmTransactionList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Transaction List'
  ClientHeight = 898
  ClientWidth = 1561
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
  object Splitter1: TSplitter
    Left = 891
    Top = 73
    Height = 755
    Align = alRight
    ExplicitLeft = 868
    ExplicitTop = 77
    ExplicitHeight = 100
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1555
    Height = 67
    Align = alTop
    TabOrder = 0
    object lblFDate: TLabel
      Left = 26
      Top = 10
      Width = 33
      Height = 17
      Caption = 'From:'
    end
    object lblTDate: TLabel
      Left = 137
      Top = 10
      Width = 17
      Height = 17
      Caption = 'To:'
    end
    object Label2: TLabel
      Left = 253
      Top = 10
      Width = 35
      Height = 17
      Caption = 'Status'
    end
    object edFDate: TRzDateTimeEdit
      Left = 26
      Top = 29
      Width = 95
      Height = 25
      EditType = etDate
      TabOrder = 0
    end
    object edToDate: TRzDateTimeEdit
      Left = 137
      Top = 29
      Width = 95
      Height = 25
      EditType = etDate
      TabOrder = 1
    end
    object btnSearch: TRzBitBtn
      Left = 414
      Top = 17
      Width = 106
      Height = 40
      Default = True
      Caption = ' &Search'
      TabOrder = 2
      OnClick = btnSearchClick
      ImageIndex = 5
      Images = DM.vilMain24
      Margin = 5
      Spacing = -10
    end
    object cbStatus: TComboBox
      Left = 250
      Top = 29
      Width = 141
      Height = 25
      Style = csDropDownList
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 831
    Width = 1555
    Height = 64
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      1555
      64)
    object btnExit: TBitBtn
      Left = 1435
      Top = 9
      Width = 103
      Height = 47
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain
      ModalResult = 2
      TabOrder = 0
      OnClick = btnExitClick
    end
  end
  object PgCntrlTransactionType: TRzPageControl
    AlignWithMargins = True
    Left = 3
    Top = 76
    Width = 885
    Height = 749
    Hint = ''
    ActivePage = TabSheet1
    Align = alClient
    UseColoredTabs = True
    HotTrackStyle = htsTabBar
    TabHeight = 30
    TabIndex = 0
    TabOrder = 2
    OnChange = PgCntrlTransactionTypeChange
    FixedDimension = 30
    object TabSheet1: TRzTabSheet
      Caption = '      Pawns      '
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 881
        Height = 629
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 574
          Width = 875
          Height = 52
          Align = alBottom
          TabOrder = 0
          object pnTotalPawn: TPanel
            Left = 151
            Top = 10
            Width = 320
            Height = 30
            Alignment = taLeftJustify
            BevelOuter = bvLowered
            Caption = '   Total Pawn: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object btnPrint: TBitBtn
            Left = 21
            Top = 5
            Width = 102
            Height = 42
            BiDiMode = bdLeftToRight
            Caption = 'Print'
            ImageIndex = 0
            ImageName = 'actPrint4'
            Images = DM.vilMain24
            ParentBiDiMode = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnPrintClick
          end
        end
        object DBGridTran: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 875
          Height = 565
          Align = alClient
          DataSource = dsTranList
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'cCustFullName'
              Title.Caption = 'Name'
              Width = 174
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'TranDate'
              Title.Alignment = taCenter
              Title.Caption = 'Date'
              Width = 98
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranTicketNo'
              Title.Caption = 'Ticket No'
              Width = 68
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'TranStatus'
              Title.Alignment = taCenter
              Title.Caption = 'Status'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranPawnAmount'
              Title.Caption = 'Amount'
              Width = 57
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranInterest'
              Title.Caption = 'Int. %'
              Width = 41
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PrincBalance'
              Title.Caption = 'Princ. Balance'
              Width = 87
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranMaturity'
              Title.Caption = 'Maturity'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'InsterestBalance'
              Title.Caption = 'I. Balance'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cComment'
              Title.Caption = 'Comment'
              Width = 169
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TransactionNo'
              Visible = True
            end>
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 629
        Width = 881
        Height = 86
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox4: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 525
          Height = 80
          Align = alLeft
          Caption = 'Pawn Totals by Status in Selected Date Range'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object DBGrid1: TDBGrid
            AlignWithMargins = True
            Left = 5
            Top = 22
            Width = 515
            Height = 53
            Align = alClient
            DataSource = dsTotals
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = [fsBold]
            Columns = <
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'PawnedCount'
                Title.Alignment = taCenter
                Title.Caption = 'Pawned Items'
                Title.Font.Charset = ANSI_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -13
                Title.Font.Name = 'Segoe UI'
                Title.Font.Style = []
                Width = 126
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'RedeemedCount'
                Title.Alignment = taCenter
                Title.Caption = 'Redeemed Items'
                Title.Font.Charset = ANSI_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -13
                Title.Font.Name = 'Segoe UI'
                Title.Font.Style = []
                Width = 126
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'DefaultedCount'
                Title.Alignment = taCenter
                Title.Caption = 'Defaulted Items'
                Title.Font.Charset = ANSI_CHARSET
                Title.Font.Color = clWindowText
                Title.Font.Height = -13
                Title.Font.Name = 'Segoe UI'
                Title.Font.Style = []
                Width = 126
                Visible = True
              end>
          end
        end
        object GroupBox5: TGroupBox
          AlignWithMargins = True
          Left = 534
          Top = 3
          Width = 344
          Height = 80
          Align = alClient
          Caption = 'Defaulted Pawns Items Actions'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object DBGrid2: TDBGrid
            AlignWithMargins = True
            Left = 5
            Top = 22
            Width = 334
            Height = 53
            Align = alClient
            DataSource = dsDefaultTotals
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
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
                FieldName = 'DefaultedMeltedCount'
                Title.Alignment = taCenter
                Title.Caption = 'Melted'
                Width = 133
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'DefaultedForSaleCount'
                Title.Alignment = taCenter
                Title.Caption = 'Items Placed for Sale'
                Width = 133
                Visible = True
              end>
          end
        end
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = '      Purchases    '
      object DBGrid4: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 875
        Height = 651
        Align = alClient
        DataSource = dsTranList
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
            FieldName = 'cCustFullName'
            Title.Caption = 'Name'
            Width = 174
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TranDate'
            Title.Alignment = taCenter
            Title.Caption = 'Date'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TranTicketNo'
            Title.Caption = 'Ticket No'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TranType'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TranStatus'
            Title.Alignment = taCenter
            Title.Caption = 'Status'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TranPawnAmount'
            Title.Caption = 'Amount'
            Width = 57
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cComment'
            Title.Caption = 'Comment'
            Width = 139
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TransactionNo'
            Visible = True
          end>
      end
      object GroupBox6: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 660
        Width = 875
        Height = 52
        Align = alBottom
        TabOrder = 1
        object pnPurchase: TPanel
          Left = 22
          Top = 13
          Width = 320
          Height = 30
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          Caption = '   Total Purchases: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TRzTabSheet
      Caption = '      Layaway    '
      object DBGrid6: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 875
        Height = 709
        Align = alClient
        DataSource = dsTranList
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
            FieldName = 'cCustFullName'
            Title.Caption = 'Name'
            Width = 174
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TranDate'
            Title.Alignment = taCenter
            Title.Caption = 'Date'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TranTicketNo'
            Title.Caption = 'Ticket No'
            Width = 68
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TranStatus'
            Title.Alignment = taCenter
            Title.Caption = 'Status'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TranPawnAmount'
            Title.Caption = 'Amount'
            Width = 57
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrincBalance'
            Title.Alignment = taCenter
            Title.Caption = 'Balance'
            Width = 87
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TranMaturity'
            Title.Alignment = taCenter
            Title.Caption = 'Date Wanted'
            Width = 81
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cComment'
            Title.Caption = 'Comment'
            Width = 169
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TransactionNo'
            Visible = True
          end>
      end
    end
  end
  object pnIntems: TPanel
    Left = 894
    Top = 73
    Width = 667
    Height = 755
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
    object gridItems: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 36
      Width = 661
      Height = 716
      Align = alClient
      DataSource = dsInvItems
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
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
          FieldName = 'InvItemCount'
          Title.Caption = 'Quantity'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UnitCost'
          Title.Caption = 'Cost'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Weight'
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cTotalWeight'
          Title.Caption = 'Total Weight'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SizeLength'
          Title.Caption = 'Length'
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cStyle'
          Title.Caption = 'Style'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cType'
          Title.Caption = 'Type'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cMetal'
          Title.Caption = 'Metal'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cStatus'
          Title.Caption = 'Status'
          Width = 78
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
    object pnDetail: TPanel
      Left = 0
      Top = 0
      Width = 667
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Pawn Items'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object qryTranList: TFDQuery
    AfterScroll = qryTranListAfterScroll
    OnCalcFields = qryTranListCalcFields
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'SELECT'
      '  T1.TRANSACTION_NO AS "TransactionNo",'
      '  T1.CUST_NO AS "CustNo",'
      '  T1.TRAN_DATE AS "TranDate",'
      '  T1.TRAN_TICKET_NO AS "TranTicketNo",'
      '  T1.TRAN_COMMENT AS "TranComment",'
      '  T1.TRAN_MATURITY AS "TranMaturity",'
      '  T1.TRAN_TYPE AS "TranType",'
      '  T1.TRAN_STATUS AS "TranStatus",'
      '  T1.TRAN_VOID_DATE AS "TranVoidDate",'
      '  T1.TRAN_PAWN_AMOUNT AS "TranPawnAmount",'
      '  T1.TRAN_INTEREST AS "TranInterest",'
      '  T1.PRINC_BALANCE AS "PrincBalance",'
      '  T1.INTEREST_BALANCE AS "InsterestBalance",'
      '  T2.CUST_LAST AS "CustLast",'
      '  T2.CUST_FIRST AS "CustFirst",'
      '  T2.CUST_MID AS "CustMid"'
      'FROM TRANSACTIONS T1'
      ' join CUSTOMER T2 on T1.CUST_NO = T2.CUST_NO'
      '--<PARAMS>'
      'ORDER BY T1.TRAN_DATE, T1.TRAN_TICKET_NO'
      '')
    Left = 104
    Top = 231
    object qryTranListcCustFullName: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cCustFullName'
      Size = 120
      Calculated = True
    end
    object qryTranListcTransaction: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cTransaction'
      Size = 40
      Calculated = True
    end
    object qryTranListTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryTranListCustNo: TIntegerField
      FieldName = 'CustNo'
    end
    object qryTranListTranDate: TDateField
      FieldName = 'TranDate'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object qryTranListTranTicketNo: TWideStringField
      FieldName = 'TranTicketNo'
      Size = 30
    end
    object qryTranListTranComment: TMemoField
      FieldName = 'TranComment'
      BlobType = ftMemo
    end
    object qryTranListTranMaturity: TDateField
      FieldName = 'TranMaturity'
    end
    object qryTranListTranType: TWideStringField
      FieldName = 'TranType'
      Size = 1
    end
    object qryTranListTranStatus: TWideStringField
      FieldName = 'TranStatus'
      Size = 1
    end
    object qryTranListTranVoidDate: TSQLTimeStampField
      FieldName = 'TranVoidDate'
      DisplayFormat = 'mm/dd/yyyy'
    end
    object qryTranListTranPawnAmount: TFloatField
      FieldName = 'TranPawnAmount'
      currency = True
    end
    object qryTranListTranInterest: TFloatField
      FieldName = 'TranInterest'
      DisplayFormat = '0.00'
    end
    object qryTranListPrincBalance: TFloatField
      FieldName = 'PrincBalance'
      currency = True
    end
    object qryTranListInsterestBalance: TFloatField
      FieldName = 'InsterestBalance'
      currency = True
    end
    object qryTranListCustLast: TWideStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryTranListCustFirst: TWideStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryTranListCustMid: TWideStringField
      FieldName = 'CustMid'
      Size = 1
    end
  end
  object dsTranList: TDataSource
    DataSet = qryTranList
    Left = 104
    Top = 288
  end
  object qryTranTotals: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      
        'SELECT T1.TRAN_TYPE as "TranType", T3.TRAN_TYPE_DESC as "TranTyp' +
        'eDesc",'
      
        '       CAST(Count(*) AS INTEGER) as "TranCount", SUM(T1.TRAN_PAW' +
        'N_AMOUNT) as "TotalAmount"'
      'FROM TRANSACTIONS T1'
      '  JOIN CUSTOMER T2 ON T1.CUST_NO = T2.CUST_NO'
      '  JOIN TRANSACTION_TYPES T3 ON T1.TRAN_TYPE = T3.TRAN_TYPE'
      
        'WHERE T1.TRAN_STATUS = '#39'A'#39' AND T1.TRAN_DATE between :FDate and :' +
        'ToDate'
      'GROUP BY T1.TRAN_TYPE, T3.TRAN_TYPE_DESC')
    Left = 248
    Top = 232
    ParamData = <
      item
        Name = 'FDate'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ToDate'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
    object qryTranTotalsTranType: TWideStringField
      FieldName = 'TranType'
      ReadOnly = True
      Size = 1
    end
    object qryTranTotalsTranTypeDesc: TWideStringField
      FieldName = 'TranTypeDesc'
      ReadOnly = True
    end
    object qryTranTotalsTranCount: TIntegerField
      FieldName = 'TranCount'
      ReadOnly = True
    end
    object qryTranTotalsTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      ReadOnly = True
    end
  end
  object DBPTranList: TppDBPipeline
    DataSource = dsTranList
    UserName = 'DBPTranList'
    Left = 360
    Top = 232
    object DBPTranListppField1: TppField
      FieldAlias = 'cCustFullName'
      FieldName = 'cCustFullName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField2: TppField
      FieldAlias = 'cTransaction'
      FieldName = 'cTransaction'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField3: TppField
      FieldAlias = 'TransactionNo'
      FieldName = 'TransactionNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField4: TppField
      FieldAlias = 'CustNo'
      FieldName = 'CustNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField5: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField6: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField7: TppField
      FieldAlias = 'TranComment'
      FieldName = 'TranComment'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField8: TppField
      FieldAlias = 'TranMaturity'
      FieldName = 'TranMaturity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField9: TppField
      FieldAlias = 'TranType'
      FieldName = 'TranType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField10: TppField
      FieldAlias = 'TranStatus'
      FieldName = 'TranStatus'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField11: TppField
      FieldAlias = 'TranVoidDate'
      FieldName = 'TranVoidDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField12: TppField
      FieldAlias = 'TranPawnAmount'
      FieldName = 'TranPawnAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField13: TppField
      FieldAlias = 'TranInterest'
      FieldName = 'TranInterest'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField14: TppField
      FieldAlias = 'PrincBalance'
      FieldName = 'PrincBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField15: TppField
      FieldAlias = 'InsterestBalance'
      FieldName = 'InsterestBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField16: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField17: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object DBPTranListppField18: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
  end
  object RepTranList: TppReport
    AutoStop = False
    DataPipeline = DBPTranList
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
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    CachePages = True
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
    Left = 360
    Top = 280
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPTranList'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13758
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable1'
        HyperlinkEnabled = False
        Border.mmPadding = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 794
        mmTop = 0
        mmWidth = 13229
        BandType = 0
        LayerName = Foreground
      end
      object ppSystemVariable2: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable2'
        HyperlinkEnabled = False
        Border.mmPadding = 0
        VarType = vtPageNoDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3440
        mmLeft = 194998
        mmTop = 0
        mmWidth = 7673
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        HyperlinkEnabled = False
        Border.mmPadding = 0
        Caption = 'Transaction List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 16
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 6646
        mmLeft = 81475
        mmTop = 265
        mmWidth = 39963
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        HyperlinkEnabled = False
        OnGetText = ppLabel2GetText
        Border.mmPadding = 0
        Caption = 'From To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 12
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4995
        mmLeft = 93467
        mmTop = 7673
        mmWidth = 16002
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 3969
      mmPrintPosition = 0
      object ppDBMemo1: TppDBMemo
        DesignLayer = ppDesignLayer1
        UserName = 'DBMemo1'
        Border.mmPadding = 0
        CharWrap = False
        DataField = 'cCustFullName'
        DataPipeline = DBPTranList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        RemoveEmptyLines = False
        Stretch = True
        Transparent = True
        DataPipelineName = 'DBPTranList'
        mmHeight = 3704
        mmLeft = 0
        mmTop = 265
        mmWidth = 57679
        BandType = 4
        LayerName = Foreground
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        mmLeading = 0
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        HyperlinkEnabled = False
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPTranList
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTranList'
        mmHeight = 3683
        mmLeft = 58743
        mmTop = 265
        mmWidth = 17187
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        HyperlinkEnabled = False
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPTranList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPTranList'
        mmHeight = 3725
        mmLeft = 82550
        mmTop = 265
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        HyperlinkEnabled = False
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranPawnAmount'
        DataPipeline = DBPTranList
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPTranList'
        mmHeight = 3725
        mmLeft = 100542
        mmTop = 0
        mmWidth = 11769
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppSummaryBand1: TppSummaryBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 10054
      mmPrintPosition = 0
      object ppLine3: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line3'
        Border.mmPadding = 0
        ParentWidth = True
        Style = lsDouble
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 0
        mmWidth = 203200
        BandType = 7
        LayerName = Foreground
      end
      object ppLine4: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line4'
        Border.mmPadding = 0
        ParentWidth = True
        Position = lpBottom
        Style = lsDouble
        Weight = 0.75000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 6085
        mmWidth = 203200
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc3: TppDBCalc
        DesignLayer = ppDesignLayer1
        UserName = 'DBCalc3'
        HyperlinkEnabled = False
        AutoSize = True
        Border.mmPadding = 0
        DataPipeline = DBPTranList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DBCalcType = dcCount
        DataPipelineName = 'DBPTranList'
        mmHeight = 3969
        mmLeft = 23548
        mmTop = 2910
        mmWidth = 12435
        BandType = 7
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label7'
        HyperlinkEnabled = False
        Border.mmPadding = 0
        Caption = 'Grand Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 3704
        mmTop = 3175
        mmWidth = 16933
        BandType = 7
        LayerName = Foreground
      end
      object ppDBCalc4: TppDBCalc
        DesignLayer = ppDesignLayer1
        UserName = 'DBCalc4'
        HyperlinkEnabled = False
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranPawnAmount'
        DataPipeline = DBPTranList
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPTranList'
        mmHeight = 3969
        mmLeft = 78052
        mmTop = 3175
        mmWidth = 34132
        BandType = 7
        LayerName = Foreground
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'cTransaction'
      DataPipeline = DBPTranList
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'DBPTranList'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 13758
        mmPrintPosition = 0
        object ppDBText1: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText1'
          HyperlinkEnabled = False
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'cTransaction'
          DataPipeline = DBPTranList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 12
          Font.Style = [fsBold]
          TextAlignment = taCentered
          Transparent = True
          DataPipelineName = 'DBPTranList'
          mmHeight = 4995
          mmLeft = 1852
          mmTop = 1588
          mmWidth = 23749
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
          mmTop = 9789
          mmWidth = 203200
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel3: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label3'
          HyperlinkEnabled = False
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
          mmHeight = 3725
          mmLeft = 2910
          mmTop = 8731
          mmWidth = 7789
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel4: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label4'
          HyperlinkEnabled = False
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
          mmHeight = 3725
          mmLeft = 60061
          mmTop = 8731
          mmWidth = 6308
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel5: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label5'
          HyperlinkEnabled = False
          Border.mmPadding = 0
          Caption = 'Ticket No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 3725
          mmLeft = 79375
          mmTop = 8467
          mmWidth = 13208
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel6: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label6'
          HyperlinkEnabled = False
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
          mmHeight = 3725
          mmLeft = 102394
          mmTop = 8467
          mmWidth = 10922
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 7938
        mmPrintPosition = 0
        object ppDBText2: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText2'
          HyperlinkEnabled = False
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'cTransaction'
          DataPipeline = DBPTranList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPTranList'
          mmHeight = 3704
          mmLeft = 2910
          mmTop = 1588
          mmWidth = 17727
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc1: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc1'
          HyperlinkEnabled = False
          AutoSize = True
          Border.mmPadding = 0
          DataPipeline = DBPTranList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DBCalcType = dcCount
          DataPipelineName = 'DBPTranList'
          mmHeight = 3968
          mmLeft = 23548
          mmTop = 1588
          mmWidth = 12435
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLine2: TppLine
          DesignLayer = ppDesignLayer1
          UserName = 'Line2'
          Border.mmPadding = 0
          Weight = 0.75000000000000000
          mmHeight = 3969
          mmLeft = 89959
          mmTop = 0
          mmWidth = 28310
          BandType = 5
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBCalc2: TppDBCalc
          DesignLayer = ppDesignLayer1
          UserName = 'DBCalc2'
          HyperlinkEnabled = False
          AutoSize = True
          Border.mmPadding = 0
          DataField = 'TranPawnAmount'
          DataPipeline = DBPTranList
          DisplayFormat = '$#,0.00;-$#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Times New Roman'
          Font.Size = 9
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'DBPTranList'
          mmHeight = 3968
          mmLeft = 78052
          mmTop = 1588
          mmWidth = 34132
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
  object qryInvItems: TFDQuery
    OnCalcFields = qryInvItemsCalcFields
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'SELECT'
      '  t.J_TYPE_DESC AS "JTypeDesc",'
      '  s.J_STYLE_DESC AS "JStyleDesc",'
      '  m.J_METAL_DESC AS "JMetalDesc",'
      '  i.INV_ITEM_NO AS "InvItemNo",'
      '  i.INV_ITEM_BARCODE AS "InvItemBarcode",'
      '  i.INV_CAT_NO AS "InvCatNo",'
      '  i.J_TYPE AS "JType",'
      '  i.J_STYLE AS "JStyle",'
      '  i.J_METAL AS "JMetal",'
      '  i.INV_ITEM_COUNT AS "InvItemCount",'
      '  i.NOTE AS "Note",'
      '  i.SIZE_LENGTH AS "SizeLength",'
      '  i.WEIGHT AS "Weight",'
      '  i.KT AS "KT",'
      '  i.CREATED AS "Created",'
      '  i.UNIT_COST AS "UnitCost",'
      '  i.UNIT_PRICE AS "UnitPrice",'
      '  i.INV_ITEM_STATUS AS "InvItemStatus",'
      '  i.TRANSACTION_NO AS "TransactionNo",'
      '  i.INV_ORIGINAL_ITEM_NO AS "InvOriginalItemNo",'
      '  i.INV_ITEM_BRAND AS "InvItemBrand",'
      '  i.OWNER_APP_NUMBER AS "OwnerAppNumber",'
      '  i.MODEL_NUMBER AS "ModelNumber",'
      '  i.SERIAL_NUMBER AS "SerialNumber",'
      '  i.GENDER AS "Gender",'
      '  i.DESCRIPTION AS "Description",'
      '  i.WEIGHT_UNIT AS "WeightUnit",'
      '  i.PAWNED_DATE AS "PawnedDate",'
      '  i.PURCHASE_DATE AS "PurchaseDate",'
      '  i.REDEEMED_DATE AS "RedeemedDate",'
      '  i.DEFAULTED_DATE AS "DefaultedDate",'
      '  i.MELTED_DATE AS "MeltedDate",'
      '  i.FORSALE_DATE AS "ForSaleDate",'
      '  i.SOLD_DATE AS "SoldDate",'
      '  i.LAYAWAY_DATE AS "LayawayDate"'
      'FROM INVENTORY_ITEMS i'
      '  LEFT OUTER JOIN J_TYPES t on i.J_TYPE = t.J_TYPE'
      '  LEFT OUTER JOIN J_STYLES s on i.J_STYLE = s.J_STYLE'
      '  LEFT OUTER JOIN J_METALS m ON m.J_METAL = i.J_METAL'
      'WHERE i.TRANSACTION_NO = :TransactionNo')
    Left = 1188
    Top = 214
    ParamData = <
      item
        Name = 'TransactionNo'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryInvItemscTotalWeight: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cTotalWeight'
      Calculated = True
    end
    object qryInvItemscStatus: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cStatus'
      Calculated = True
    end
    object qryInvItemsInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryInvItemsInvItemBarcode: TWideStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryInvItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object qryInvItemsJType: TWideStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryInvItemsJStyle: TWideStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryInvItemsJMetal: TWideStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryInvItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryInvItemsNote: TWideStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryInvItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryInvItemsWeight: TFloatField
      FieldName = 'Weight'
      DisplayFormat = '0.##'
    end
    object qryInvItemsKT: TFloatField
      FieldName = 'KT'
    end
    object qryInvItemsCreated: TSQLTimeStampField
      FieldName = 'Created'
    end
    object qryInvItemsUnitCost: TFMTBCDField
      FieldName = 'UnitCost'
      currency = True
      Precision = 19
    end
    object qryInvItemsUnitPrice: TFMTBCDField
      FieldName = 'UnitPrice'
      currency = True
      Precision = 19
    end
    object qryInvItemsInvItemStatus: TWideStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryInvItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryInvItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object qryInvItemsInvItemBrand: TWideStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryInvItemsOwnerAppNumber: TWideStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryInvItemsModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryInvItemsSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryInvItemsGender: TWideStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryInvItemsDescription: TWideStringField
      FieldName = 'Description'
      Size = 120
    end
    object qryInvItemsJTypeDesc: TWideStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
    object qryInvItemsJStyleDesc: TWideStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
    object qryInvItemsJMetalDesc: TWideStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
    object qryInvItemsWeightUnit: TWideStringField
      FieldName = 'WeightUnit'
      Size = 1
    end
    object qryInvItemsPawnedDate: TDateField
      FieldName = 'PawnedDate'
    end
    object qryInvItemsPurchaseDate: TDateField
      FieldName = 'PurchaseDate'
    end
    object qryInvItemsRedeemedDate: TDateField
      FieldName = 'RedeemedDate'
    end
    object qryInvItemsDefaultedDate: TDateField
      FieldName = 'DefaultedDate'
    end
    object qryInvItemsMeltedDate: TDateField
      FieldName = 'MeltedDate'
    end
    object qryInvItemsForSaleDate: TDateField
      FieldName = 'ForSaleDate'
    end
    object qryInvItemsSoldDate: TDateField
      FieldName = 'SoldDate'
    end
    object qryInvItemsLayawayDate: TDateField
      FieldName = 'LayawayDate'
    end
  end
  object dsInvItems: TDataSource
    DataSet = qryInvItems
    Left = 1195
    Top = 271
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 1023
    Top = 18
  end
  object PropertyStore: TRzPropertyStore
    Properties = <
      item
        Component = pnIntems
        PropertyName = 'Width'
      end>
    RegIniFile = DM.RegIniFile
    Left = 1135
    Top = 18
  end
  object qryTotals: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      
        'SELECT CAST(SUM(CASE WHEN PAWNED_DATE BETWEEN '#39'2000-01-01'#39' AND '#39 +
        '2025-12-01'#39' THEN 1 ELSE 0 END) AS INTEGER) AS "PawnedCount",'
      
        '      CAST(SUM(CASE WHEN REDEEMED_DATE BETWEEN '#39'2000-01-01'#39' AND ' +
        #39'2025-12-01'#39' THEN 1 ELSE 0 END) AS INTEGER) AS "RedeemedCount",'
      
        '      CAST(SUM(CASE WHEN DEFAULTED_DATE BETWEEN '#39'2000-01-01'#39' AND' +
        ' '#39'2025-12-01'#39' THEN 1 ELSE 0 END) AS INTEGER) AS "DefaultedCount"'
      'FROM INVENTORY_ITEMS'
      'WHERE PAWNED_DATE IS NOT NULL;'
      '')
    Left = 425
    Top = 436
    object qryTotalsPawnedCount: TIntegerField
      FieldName = 'PawnedCount'
    end
    object qryTotalsRedeemedCount: TIntegerField
      FieldName = 'RedeemedCount'
    end
    object qryTotalsDefaultedCount: TIntegerField
      FieldName = 'DefaultedCount'
    end
  end
  object dsTotals: TDataSource
    DataSet = qryTotals
    Left = 427
    Top = 498
  end
  object qryDefaultTotals: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      
        'SELECT CAST(SUM(CASE WHEN DEFAULTED_DATE BETWEEN '#39'2000-01-01'#39' AN' +
        'D '#39'2025-12-01'#39' AND MELTED_DATE IS NOT NULL THEN 1 ELSE 0 END) AS' +
        ' INTEGER) AS "DefaultedMeltedCount", '
      
        'CAST(SUM(CASE WHEN DEFAULTED_DATE BETWEEN '#39'2000-01-01'#39' AND '#39'2025' +
        '-12-01'#39' AND FORSALE_DATE IS NOT NULL THEN 1 ELSE 0 END) AS INTEG' +
        'ER) AS "DefaultedForSaleCount" '
      'FROM INVENTORY_ITEMS WHERE PAWNED_DATE IS NOT NULL ')
    Left = 566
    Top = 436
    object qryDefaultTotalsDefaultedMeltedCount: TIntegerField
      FieldName = 'DefaultedMeltedCount'
    end
    object qryDefaultTotalsDefaultedForSaleCount: TIntegerField
      FieldName = 'DefaultedForSaleCount'
    end
  end
  object dsDefaultTotals: TDataSource
    DataSet = qryDefaultTotals
    Left = 573
    Top = 498
  end
end
