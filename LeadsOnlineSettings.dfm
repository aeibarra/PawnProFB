object frmLeadsOnlineSettings: TfrmLeadsOnlineSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LeadsOnline Settings'
  ClientHeight = 607
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 20
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 539
    Width = 359
    Height = 65
    Align = alBottom
    TabOrder = 1
    object btnSave: TRzBitBtn
      Left = 52
      Top = 12
      Width = 99
      Height = 42
      Default = True
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 5
      Spacing = -5
    end
    object btnCancel: TRzBitBtn
      Left = 198
      Top = 12
      Width = 99
      Height = 42
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
      ImageIndex = 3
      Images = DM.ImageListBtn
      Margin = 5
      Spacing = -5
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 359
    Height = 530
    Align = alClient
    TabOrder = 0
    object RzLabel4: TRzLabel
      Left = 31
      Top = 10
      Width = 142
      Height = 20
      Caption = 'LeadsOnline Store ID'
      FocusControl = edStoreId
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gbApi: TGroupBox
      Left = 16
      Top = 267
      Width = 324
      Height = 190
      Caption = 'LeadsOnline Web Service (SOAP)'
      TabOrder = 2
      object lblApiUser: TRzLabel
        Left = 15
        Top = 26
        Width = 76
        Height = 20
        Caption = 'User Name:'
        FocusControl = edApiUser
      end
      object lblApiPassword: TRzLabel
        Left = 156
        Top = 26
        Width = 64
        Height = 20
        Caption = 'Password:'
        FocusControl = edApiPassword
      end
      object edApiUser: TRzDBEdit
        Left = 15
        Top = 46
        Width = 135
        Height = 28
        DataSource = DM.DSStore
        DataField = 'LEADS_ONLINE_API_USER'
        TabOrder = 0
      end
      object edApiPassword: TRzDBEdit
        Left = 156
        Top = 46
        Width = 151
        Height = 28
        DataSource = DM.DSStore
        DataField = 'LEADS_ONLINE_API_PASSWORD'
        PasswordChar = '*'
        TabOrder = 1
      end
      object chkUseSandbox: TDBCheckBox
        Left = 17
        Top = 86
        Width = 307
        Height = 17
        Caption = 'Use LeadsOnline SANDBOX - testing only'
        DataField = 'LEADS_ONLINE_USE_SANDBOX'
        DataSource = DM.DSStore
        TabOrder = 2
      end
      object chkSkipCsvSent: TDBCheckBox
        Left = 17
        Top = 148
        Width = 296
        Height = 17
        Caption = 'Do not resend what the CSV export already sent'
        DataField = 'LEADS_ONLINE_SKIP_CSV_SENT'
        DataSource = DM.DSStore
        TabOrder = 4
      end
      object lblSkipCsvHint: TLabel
        Left = 36
        Top = 167
        Width = 280
        Height = 15
        Caption = 'Leave ticked when moving a store from CSV to the web service.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnTestConnection: TRzBitBtn
        Left = 15
        Top = 110
        Width = 152
        Height = 30
        Caption = 'Test Connection'
        TabOrder = 3
        OnClick = btnTestConnectionClick
      end
    end
    object rgExportMethod: TDBRadioGroup
      Left = 16
      Top = 420
      Width = 324
      Height = 108
      Caption = 'LeadsOnline reporting for this store'
      DataField = 'LEADS_ONLINE_EXPORT_METHOD'
      DataSource = DM.DSStore
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      Items.Strings = (
        'Not using LeadsOnline'
        'Send as CSV file over FTP'
        'Send by Web Service (SOAP)')
      ParentFont = False
      TabOrder = 3
      Values.Strings = (
        'N'
        'C'
        'S')
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 64
      Width = 324
      Height = 197
      Caption = 'LeadsOnline FTP Information'
      TabOrder = 1
      object RzLabel1: TRzLabel
        Left = 15
        Top = 30
        Width = 213
        Height = 20
        Caption = 'LeadsOnline FTP Server Address:'
        FocusControl = edLeadsOnlineFTPAddress
      end
      object RzLabel2: TRzLabel
        Left = 15
        Top = 130
        Width = 76
        Height = 20
        Caption = 'User Name:'
        FocusControl = edUserName
      end
      object RzLabel3: TRzLabel
        Left = 156
        Top = 130
        Width = 64
        Height = 20
        Caption = 'Password:'
        FocusControl = edPassword
      end
      object edLeadsOnlineFTPAddress: TRzDBEdit
        Left = 15
        Top = 50
        Width = 292
        Height = 28
        DataSource = DM.DSStore
        DataField = 'LEADS_ONLINE_FTP_ADDRESS'
        TabOrder = 0
      end
      object edUserName: TRzDBEdit
        Left = 15
        Top = 150
        Width = 135
        Height = 28
        DataSource = DM.DSStore
        DataField = 'LEADS_ONLINE_USER_NAME'
        TabOrder = 2
      end
      object edPassword: TRzDBEdit
        Left = 156
        Top = 150
        Width = 151
        Height = 28
        DataSource = DM.DSStore
        DataField = 'LEADS_ONLINE_PASSWORD'
        PasswordChar = '*'
        TabOrder = 3
      end
      object DBCheckBox1: TDBCheckBox
        Left = 26
        Top = 97
        Width = 97
        Height = 17
        Caption = 'FTP Passive'
        DataField = 'FTP_PASSIVE'
        DataSource = DM.DSStore
        TabOrder = 1
      end
    end
    object edStoreId: TRzDBEdit
      Left = 31
      Top = 30
      Width = 178
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LEADS_STORE_ID'
      TabOrder = 0
    end
  end
end
