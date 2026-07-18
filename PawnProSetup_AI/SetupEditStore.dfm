object frmSetupEditStore: TfrmSetupEditStore
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'PawnPro Setup - Edit Store Info'
  ClientHeight = 600
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 17
  object lblStoreName: TLabel
    Left = 16
    Top = 12
    Width = 70
    Height = 17
    Caption = 'Store name:'
  end
  object lblStoreAddr: TLabel
    Left = 16
    Top = 44
    Width = 51
    Height = 17
    Caption = 'Address:'
  end
  object lblStoreCityStZip: TLabel
    Left = 16
    Top = 76
    Width = 66
    Height = 17
    Caption = 'City, ST ZIP:'
  end
  object lblStorePhone: TLabel
    Left = 16
    Top = 108
    Width = 39
    Height = 17
    Caption = 'Phone:'
  end
  object lblStorePoliceId: TLabel
    Left = 16
    Top = 140
    Width = 53
    Height = 17
    Caption = 'Police ID:'
  end
  object lblStoreNumber: TLabel
    Left = 16
    Top = 172
    Width = 56
    Height = 17
    Caption = 'Store no.:'
  end
  object lblInterestRate: TLabel
    Left = 16
    Top = 212
    Width = 88
    Height = 17
    Caption = 'Interest rate %:'
  end
  object lblSalesTax: TLabel
    Left = 220
    Top = 212
    Width = 69
    Height = 17
    Caption = 'Sales tax %:'
  end
  object lblMaturityMonths: TLabel
    Left = 16
    Top = 244
    Width = 106
    Height = 17
    Caption = 'Maturity (months):'
  end
  object lblDefaultMonths: TLabel
    Left = 220
    Top = 244
    Width = 99
    Height = 17
    Caption = 'Default (months):'
  end
  object lblStatus: TLabel
    Left = 16
    Top = 540
    Width = 600
    Height = 22
    AutoSize = False
    WordWrap = True
  end
  object edStoreName: TEdit
    Left = 130
    Top = 9
    Width = 570
    Height = 25
    TabOrder = 0
  end
  object edStoreAddr: TEdit
    Left = 130
    Top = 41
    Width = 570
    Height = 25
    TabOrder = 1
  end
  object edStoreCityStZip: TEdit
    Left = 130
    Top = 73
    Width = 570
    Height = 25
    TabOrder = 2
  end
  object edStorePhone: TEdit
    Left = 130
    Top = 105
    Width = 250
    Height = 25
    TabOrder = 3
  end
  object edStorePoliceId: TEdit
    Left = 130
    Top = 137
    Width = 250
    Height = 25
    TabOrder = 4
  end
  object edStoreNumber: TEdit
    Left = 130
    Top = 169
    Width = 250
    Height = 25
    TabOrder = 5
  end
  object edInterestRate: TEdit
    Left = 130
    Top = 209
    Width = 60
    Height = 25
    TabOrder = 6
  end
  object edSalesTax: TEdit
    Left = 320
    Top = 209
    Width = 60
    Height = 25
    TabOrder = 7
  end
  object edMaturityMonths: TEdit
    Left = 144
    Top = 241
    Width = 60
    Height = 25
    TabOrder = 8
  end
  object edDefaultMonths: TEdit
    Left = 344
    Top = 241
    Width = 60
    Height = 25
    TabOrder = 9
  end
  object rgDateCalc: TRadioGroup
    Left = 16
    Top = 275
    Width = 200
    Height = 60
    Caption = 'Pawn date calc base'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Days'
      'Months')
    TabOrder = 10
  end
  object rgWeightUnit: TRadioGroup
    Left = 230
    Top = 275
    Width = 200
    Height = 60
    Caption = 'Default weight unit'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Pennyweight'
      'Gram')
    TabOrder = 11
  end
  object gbLeads: TGroupBox
    Left = 16
    Top = 345
    Width = 685
    Height = 140
    Caption = 'LeadsOnline'
    TabOrder = 12
    object lblLeadsStoreId: TLabel
      Left = 16
      Top = 28
      Width = 50
      Height = 17
      Caption = 'Store ID:'
    end
    object lblLeadsFtp: TLabel
      Left = 16
      Top = 60
      Width = 74
      Height = 17
      Caption = 'FTP address:'
    end
    object lblLeadsUser: TLabel
      Left = 16
      Top = 92
      Width = 62
      Height = 17
      Caption = 'Username:'
    end
    object lblLeadsPassword: TLabel
      Left = 350
      Top = 92
      Width = 59
      Height = 17
      Caption = 'Password:'
    end
    object edLeadsStoreId: TEdit
      Left = 130
      Top = 25
      Width = 200
      Height = 25
      TabOrder = 0
    end
    object edLeadsFtp: TEdit
      Left = 130
      Top = 57
      Width = 540
      Height = 25
      TabOrder = 1
    end
    object edLeadsUser: TEdit
      Left = 130
      Top = 89
      Width = 200
      Height = 25
      TabOrder = 2
    end
    object edLeadsPassword: TEdit
      Left = 425
      Top = 89
      Width = 245
      Height = 25
      PasswordChar = '*'
      TabOrder = 3
    end
    object chkFtpPassive: TCheckBox
      Left = 16
      Top = 116
      Width = 200
      Height = 17
      Caption = 'FTP passive mode'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object btnSave: TButton
    Left = 480
    Top = 500
    Width = 105
    Height = 32
    Caption = 'Save'
    Default = True
    TabOrder = 13
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 595
    Top = 500
    Width = 105
    Height = 32
    Cancel = True
    Caption = 'Close'
    TabOrder = 14
    OnClick = btnCloseClick
  end
end
