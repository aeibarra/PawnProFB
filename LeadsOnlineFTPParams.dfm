object frmLeadsOnlineFTPParams: TfrmLeadsOnlineFTPParams
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LeadsOnline FTP Params'
  ClientHeight = 283
  ClientWidth = 362
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
    Top = 215
    Width = 356
    Height = 65
    Align = alBottom
    TabOrder = 1
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
    Width = 356
    Height = 206
    Align = alClient
    TabOrder = 0
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
      FocusControl = edLeadsOnlineFTPAddress
    end
    object edLeadsOnlineFTPAddress: TRzDBEdit
      Left = 31
      Top = 38
      Width = 292
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LeadsOnlineFTPAddress'
      TabOrder = 0
    end
    object edUserName: TRzDBEdit
      Left = 31
      Top = 153
      Width = 135
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LeadsOnlineUserName'
      TabOrder = 3
    end
    object edPassword: TRzDBEdit
      Left = 172
      Top = 153
      Width = 151
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LeadsOnlinePassword'
      PasswordChar = '*'
      TabOrder = 4
    end
    object RzDBEdit1: TRzDBEdit
      Left = 31
      Top = 96
      Width = 178
      Height = 28
      DataSource = DM.DSStore
      DataField = 'LeadsStoreId'
      TabOrder = 1
    end
    object DBCheckBox1: TDBCheckBox
      Left = 226
      Top = 99
      Width = 97
      Height = 17
      Caption = 'FTP Passive'
      DataField = 'FTPPassive'
      DataSource = DM.DSStore
      TabOrder = 2
    end
  end
end
