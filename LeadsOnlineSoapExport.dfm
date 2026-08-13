object frmLeadsOnlineSoapExport: TfrmLeadsOnlineSoapExport
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'LeadsOnline'
  ClientHeight = 814
  ClientWidth = 1215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  TextHeight = 20
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 742
    Width = 1209
    Height = 69
    Align = alBottom
    TabOrder = 0
    ExplicitWidth = 1059
    DesignSize = (
      1209
      69)
    object lblProgress: TLabel
      Left = 208
      Top = 26
      Width = 4
      Height = 20
    end
    object btnExit: TBitBtn
      Left = 1097
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
      ExplicitLeft = 947
    end
    object btnSubmit: TBitBtn
      Left = 16
      Top = 11
      Width = 176
      Height = 48
      Caption = ' &Submit selected'
      Default = True
      TabOrder = 1
      OnClick = btnSubmitClick
    end
    object pbSubmit: TProgressBar
      Left = 208
      Top = 46
      Width = 873
      Height = 12
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Visible = False
      ExplicitWidth = 723
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1209
    Height = 733
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 1059
    DesignSize = (
      1209
      733)
    object lblSandbox: TLabel
      Left = 503
      Top = 22
      Width = 490
      Height = 20
      Caption = 'SANDBOX MODE - these tickets are NOT reported to law enforcement'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblCount: TLabel
      Left = 1087
      Top = 60
      Width = 4
      Height = 20
      Anchors = [akTop, akRight]
      ExplicitLeft = 640
    end
    object btnRefresh: TBitBtn
      Left = 528
      Top = 56
      Width = 120
      Height = 32
      Caption = ' &Refresh'
      TabOrder = 2
      OnClick = btnRefreshClick
    end
    object grdTickets: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 173
      Width = 1199
      Height = 491
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsTickets
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = grdTicketsCellClick
      OnDrawColumnCell = grdTicketsDrawColumnCell
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SELECTED'
          Title.Alignment = taCenter
          Title.Caption = 'Send'
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRAN_DATE'
          Title.Caption = 'Date'
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TRAN_TYPE'
          Title.Alignment = taCenter
          Title.Caption = 'Type'
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRAN_TICKET_NO'
          Title.Caption = 'Ticket'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUSTOMER'
          Title.Caption = 'Customer'
          Width = 200
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITEM_COUNT'
          Title.Alignment = taCenter
          Title.Caption = 'Items'
          Width = 50
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITEM_IMAGE_COUNT'
          Title.Alignment = taCenter
          Title.Caption = 'Photos'
          Width = 56
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ID_IMAGE_COUNT'
          Title.Alignment = taCenter
          Title.Caption = 'IDs'
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OUTCOME'
          Title.Caption = 'Result'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DETAIL'
          Title.Caption = 'Detail'
          Width = 339
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRANSACTION_NO'
          Title.Caption = 'Tran #'
          Width = 70
          Visible = True
        end>
    end
    object gbExportTranSelection: TGroupBox
      Left = 12
      Top = 11
      Width = 469
      Height = 151
      Caption = 'Which transactions'
      TabOrder = 1
      object rbSendDateRange: TRzRadioButton
        Left = 16
        Top = 61
        Width = 376
        Height = 22
        AutoSizeWidth = 376
        Caption = 'A date range  (for a store starting on LeadsOnline)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = ScopeChanged
      end
      object rbSendAllNotSentYet: TRzRadioButton
        Left = 16
        Top = 28
        Width = 322
        Height = 22
        AutoSizeWidth = 322
        Caption = 'Everything not sent yet  (normal daily use)'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = True
        OnClick = ScopeChanged
      end
      object pnDateRange: TRzPanel
        Left = 43
        Top = 85
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
          Height = 28
          EditType = etDate
          Enabled = False
          TabOrder = 0
          OnChange = DateRangeChanged
        end
        object edTDate: TRzDateTimeEdit
          Left = 137
          Top = 22
          Width = 121
          Height = 28
          EditType = etDate
          Enabled = False
          TabOrder = 1
          OnChange = DateRangeChanged
        end
      end
    end
    object GroupBox3: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 669
      Width = 1199
      Height = 59
      Align = alBottom
      TabOrder = 3
      ExplicitWidth = 1049
      object btnCheckAll: TButton
        Left = 23
        Top = 14
        Width = 86
        Height = 32
        Caption = 'Check all'
        TabOrder = 0
        TabStop = False
        OnClick = btnCheckAllClick
      end
      object btnClearAll: TButton
        Left = 124
        Top = 14
        Width = 86
        Height = 32
        Caption = 'Clear all'
        TabOrder = 1
        TabStop = False
        OnClick = btnClearAllClick
      end
    end
  end
  object clnTickets: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 470
    Top = 324
  end
  object dsTickets: TDataSource
    DataSet = clnTickets
    Left = 470
    Top = 380
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 470
    Top = 436
  end
end
