object frmSetupMain: TfrmSetupMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'PawnPro Setup'
  ClientHeight = 360
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 20
  object lblIntro: TLabel
    Left = 16
    Top = 16
    Width = 448
    Height = 53
    AutoSize = False
    Caption = 
      'Choose what to do. New Install is for a brand-new store. Add Wor' +
      'kstation is for a second computer in an existing shop.'
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 90
    Width = 879
    Height = 200
    Caption = 'Mode'
    TabOrder = 0
    object rbNewInstall: TRadioButton
      Left = 16
      Top = 32
      Width = 721
      Height = 20
      Caption = 
        'New Install -- rotate SYSDBA password, populate STORE row, write' +
        ' encrypted INI, write recovery.dat'
      TabOrder = 0
    end
    object rbAddWorkstation: TRadioButton
      Left = 16
      Top = 72
      Width = 721
      Height = 20
      Caption = 
        'Add Workstation -- re-encrypt INI on this machine for an existin' +
        'g store'
      TabOrder = 1
    end
    object rbRotatePassword: TRadioButton
      Left = 16
      Top = 112
      Width = 721
      Height = 20
      Caption = 
        'Rotate Password -- generate a new password and update INI + reco' +
        'very.dat'
      TabOrder = 2
    end
    object rbEditStore: TRadioButton
      Left = 16
      Top = 152
      Width = 721
      Height = 20
      Caption = 
        'Edit Store Info -- update the STORE row only (no password change' +
        's)'
      TabOrder = 3
    end
  end
  object btnContinue: TButton
    Left = 695
    Top = 310
    Width = 96
    Height = 32
    Caption = 'Continue'
    Default = True
    TabOrder = 1
    OnClick = btnContinueClick
  end
  object btnExit: TButton
    Left = 799
    Top = 310
    Width = 88
    Height = 32
    Cancel = True
    Caption = 'Exit'
    TabOrder = 2
    OnClick = btnExitClick
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 588
    Top = 53
  end
end
