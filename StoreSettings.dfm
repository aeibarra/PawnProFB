object frmStoreSettings: TfrmStoreSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Store Settings'
  ClientHeight = 383
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 21
  object gbButtons: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 311
    Width = 334
    Height = 69
    Align = alBottom
    TabOrder = 3
    object btnClose: TBitBtn
      Left = 200
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
    object btnSave: TRzBitBtn
      Left = 40
      Top = 13
      Width = 95
      Height = 43
      Default = True
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -2
    end
  end
  object gbPawns: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 334
    Height = 120
    Align = alTop
    Caption = 'Pawn Defaults'
    TabOrder = 0
    object lblMaturityMonths: TLabel
      Left = 24
      Top = 40
      Width = 120
      Height = 21
      Caption = 'Maturity months:'
    end
    object lblInterestRate: TLabel
      Left = 24
      Top = 79
      Width = 96
      Height = 21
      Caption = 'Interest rate:'
    end
    object lblInterestPerc: TLabel
      Left = 238
      Top = 79
      Width = 14
      Height = 21
      Caption = '%'
    end
    object edDefaultMaturityMonths: TEdit
      Left = 168
      Top = 37
      Width = 64
      Height = 29
      NumbersOnly = True
      TabOrder = 0
    end
    object edDefaultPawnInterestRate: TRzNumericEdit
      Left = 168
      Top = 76
      Width = 64
      Height = 29
      TabOrder = 1
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
  end
  object gbSalesTax: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 129
    Width = 334
    Height = 82
    Align = alTop
    Caption = 'Sales Tax'
    TabOrder = 1
    object lblSalesTax: TLabel
      Left = 24
      Top = 40
      Width = 69
      Height = 21
      Caption = 'Sales tax:'
    end
    object lblSalesTaxPerc: TLabel
      Left = 238
      Top = 40
      Width = 14
      Height = 21
      Caption = '%'
    end
    object edSalesTaxPerc: TRzNumericEdit
      Left = 168
      Top = 37
      Width = 64
      Height = 29
      TabOrder = 0
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
  end
  object gbWeightUnit: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 217
    Width = 334
    Height = 88
    Align = alTop
    Caption = 'Default Weight Unit (new items)'
    TabOrder = 2
    object rbWeightPennyweight: TRadioButton
      Left = 24
      Top = 40
      Width = 150
      Height = 25
      Caption = 'Pennyweight (dwt)'
      TabOrder = 0
    end
    object rbWeightGrams: TRadioButton
      Left = 192
      Top = 40
      Width = 110
      Height = 25
      Caption = 'Grams (g)'
      TabOrder = 1
    end
  end
end
