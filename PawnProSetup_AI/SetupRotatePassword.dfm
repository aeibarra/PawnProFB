object frmSetupRotatePassword: TfrmSetupRotatePassword
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'PawnPro Setup - Rotate Password'
  ClientHeight = 540
  ClientWidth = 660
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
  object lblCurrentPassword: TLabel
    Left = 24
    Top = 136
    Width = 156
    Height = 17
    Caption = 'Current SYSDBA password:'
  end
  object lblNewPasswordHeader: TLabel
    Left = 24
    Top = 380
    Width = 240
    Height = 21
    Caption = 'New password - save this NOW:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object edHost: TEdit
    Left = 220
    Top = 25
    Width = 410
    Height = 25
    TabOrder = 0
  end
  object edDatabase: TEdit
    Left = 220
    Top = 61
    Width = 410
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
  object edCurrentPassword: TEdit
    Left = 220
    Top = 133
    Width = 250
    Height = 25
    PasswordChar = '*'
    TabOrder = 3
  end
  object btnRotate: TButton
    Left = 220
    Top = 175
    Width = 130
    Height = 32
    Caption = 'Rotate'
    Default = True
    TabOrder = 4
    OnClick = btnRotateClick
  end
  object memProgress: TMemo
    Left = 24
    Top = 220
    Width = 610
    Height = 150
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object edNewPassword: TEdit
    Left = 24
    Top = 410
    Width = 490
    Height = 34
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -22
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Visible = False
  end
  object btnCopyPassword: TButton
    Left = 528
    Top = 410
    Width = 105
    Height = 38
    Caption = 'Copy'
    TabOrder = 7
    Visible = False
    OnClick = btnCopyPasswordClick
  end
  object btnClose: TButton
    Left = 528
    Top = 488
    Width = 105
    Height = 32
    Cancel = True
    Caption = 'Close'
    TabOrder = 8
    OnClick = btnCloseClick
  end
end
