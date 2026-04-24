object frmSetDefaultMaturityMonth: TfrmSetDefaultMaturityMonth
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pawn Defaults'
  ClientHeight = 273
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 21
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 201
    Width = 285
    Height = 69
    Align = alBottom
    TabOrder = 0
    object btnClose: TBitBtn
      Left = 165
      Top = 13
      Width = 95
      Height = 43
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object RzBitBtn1: TRzBitBtn
      Left = 20
      Top = 13
      Width = 95
      Height = 43
      Default = True
      Caption = 'Save'
      TabOrder = 0
      OnClick = RzBitBtn1Click
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -2
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 285
    Height = 93
    Align = alTop
    Caption = 'Default Maturity Month'
    TabOrder = 1
    object Label1: TLabel
      Left = 51
      Top = 42
      Width = 60
      Height = 21
      Caption = 'Months: '
    end
    object edDefaultMaturityMonths: TEdit
      Left = 117
      Top = 39
      Width = 61
      Height = 29
      NumbersOnly = True
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 102
    Width = 285
    Height = 93
    Align = alTop
    Caption = 'Default Pawn Interest'
    TabOrder = 2
    object Label2: TLabel
      Left = 48
      Top = 42
      Width = 55
      Height = 21
      Caption = 'Interest:'
    end
    object edDefaultPawnInterestRate: TRzNumericEdit
      Left = 117
      Top = 38
      Width = 61
      Height = 29
      TabOrder = 0
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
  end
end
