object frmLeadsOnlineFTPParams: TfrmLeadsOnlineFTPParams
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LeadsOnline Settings'
  ClientHeight = 532
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
    Top = 464
    Width = 359
    Height = 65
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 492
    ExplicitWidth = 356
    object RzBitBtn1: TRzBitBtn
      Left = 59
      Top = 12
      Width = 91
      Height = 42
      Default = True
      Caption = 'Save'
      TabOrder = 0
      OnClick = RzBitBtn1Click
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 5
      Spacing = -5
    end
    object RzBitBtn2: TRzBitBtn
      Left = 205
      Top = 12
      Width = 91
      Height = 42
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = RzBitBtn2Click
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
    Height = 455
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 356
    ExplicitHeight = 483
    object RzLabel1: TRzLabel
      Left = 31
      Top = 18
      Width = 213
      Height = 20
      Caption = 'LeadsOnline FTP Server Address:'
      FocusControl = edLeadsOnlineFTPAddress
    end
    object RzLabel2: TRzLabel
      Left = 31
      Top = 133
      Width = 76
      Height = 20
      Caption = 'User Name:'
      FocusControl = edUserName
    end
    object RzLabel3: TRzLabel
      Left = 172
      Top = 133
      Width = 64
      Height = 20
      Caption = 'Password:'
      FocusControl = edPassword
    end
    object RzLabel4: TRzLabel
      Left = 31
      Top = 76
      Width = 139
      Height = 20
      Caption = 'LeadsOnline Store ID'
      FocusControl = RzDBEdit1
    end
    object edLeadsOnlineFTPAddress: TRzDBEdit
      Left = 31
      Top = 38
      Width = 292
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LEADS_ONLINE_FTP_ADDRESS'
      TabOrder = 0
    end
    object edUserName: TRzDBEdit
      Left = 31
      Top = 153
      Width = 135
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LEADS_ONLINE_USER_NAME'
      TabOrder = 3
    end
    object edPassword: TRzDBEdit
      Left = 172
      Top = 153
      Width = 151
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LEADS_ONLINE_PASSWORD'
      PasswordChar = '*'
      TabOrder = 4
    end
    object RzDBEdit1: TRzDBEdit
      Left = 31
      Top = 96
      Width = 178
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LEADS_STORE_ID'
      TabOrder = 1
    end
    object DBCheckBox1: TDBCheckBox
      Left = 226
      Top = 99
      Width = 97
      Height = 17
      Caption = 'FTP Passive'
      DataField = 'FTP_PASSIVE'
      DataSource = DM.DSStore
      TabOrder = 2
    end
    object gbApi: TGroupBox
      Left = 16
      Top = 196
      Width = 324
      Height = 148
      Caption = 'LeadsOnline Web Service (SOAP)'
      TabOrder = 5
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
      Top = 356
      Width = 324
      Height = 84
      Caption = 'Send transactions to LeadsOnline using'
      DataField = 'LEADS_ONLINE_EXPORT_METHOD'
      DataSource = DM.DSStore
      Items.Strings = (
        'CSV file over FTP'
        'Web Service (SOAP)')
      TabOrder = 6
      Values.Strings = (
        'C'
        'S')
    end
  end
end
