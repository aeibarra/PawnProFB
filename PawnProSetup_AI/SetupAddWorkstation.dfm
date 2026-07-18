object frmSetupAddWorkstation: TfrmSetupAddWorkstation
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'PawnPro Setup - Add Workstation'
  ClientHeight = 320
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 17
  object lblHost: TLabel
    Left = 24
    Top = 28
    Width = 77
    Height = 17
    Caption = 'Firebird host:'
  end
  object lblDatabase: TLabel
    Left = 24
    Top = 64
    Width = 88
    Height = 17
    Caption = 'Database path:'
  end
  object lblPort: TLabel
    Left = 24
    Top = 100
    Width = 27
    Height = 17
    Caption = 'Port:'
  end
  object lblPassword: TLabel
    Left = 24
    Top = 136
    Width = 156
    Height = 17
    Caption = 'Current SYSDBA password:'
  end
  object lblResult: TLabel
    Left = 24
    Top = 218
    Width = 510
    Height = 60
    AutoSize = False
    WordWrap = True
  end
  object edHost: TEdit
    Left = 220
    Top = 25
    Width = 310
    Height = 25
    TabOrder = 0
  end
  object edDatabase: TEdit
    Left = 220
    Top = 61
    Width = 310
    Height = 25
    TabOrder = 1
  end
  object edPort: TEdit
    Left = 220
    Top = 97
    Width = 80
    Height = 25
    TabOrder = 2
  end
  object edPassword: TEdit
    Left = 220
    Top = 133
    Width = 250
    Height = 25
    PasswordChar = '*'
    TabOrder = 3
  end
  object btnApply: TButton
    Left = 220
    Top = 175
    Width = 105
    Height = 32
    Caption = 'Apply'
    Default = True
    TabOrder = 4
    OnClick = btnApplyClick
  end
  object btnClose: TButton
    Left = 444
    Top = 280
    Width = 100
    Height = 30
    Cancel = True
    Caption = 'Close'
    TabOrder = 5
    OnClick = btnCloseClick
  end
end
