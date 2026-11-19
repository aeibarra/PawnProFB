object frmQuickSale: TfrmQuickSale
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Quick Sale'
  ClientHeight = 330
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 17
  object lblItemCaption: TLabel
    Left = 20
    Top = 18
    Width = 32
    Height = 17
    Caption = 'Item:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblItem: TLabel
    Left = 20
    Top = 38
    Width = 400
    Height = 40
    AutoSize = False
    Caption = 'lblItem'
    WordWrap = True
  end
  object lblAskingCaption: TLabel
    Left = 20
    Top = 90
    Width = 81
    Height = 17
    Caption = 'Asking price:'
  end
  object lblAsking: TLabel
    Left = 140
    Top = 90
    Width = 35
    Height = 17
    Caption = '$0.00'
  end
  object lblPriceCaption: TLabel
    Left = 20
    Top = 124
    Width = 75
    Height = 20
    Caption = 'Sale price:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 20
    Top = 162
    Width = 400
    Height = 2
    Shape = bsTopLine
  end
  object lblSubtotalCaption: TLabel
    Left = 200
    Top = 174
    Width = 60
    Height = 17
    Alignment = taRightJustify
    Caption = 'Subtotal:'
  end
  object lblSubtotal: TLabel
    Left = 300
    Top = 174
    Width = 120
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = '$0.00'
  end
  object lblTaxCaption: TLabel
    Left = 200
    Top = 198
    Width = 60
    Height = 17
    Alignment = taRightJustify
    Caption = 'Tax (0%):'
  end
  object lblTax: TLabel
    Left = 300
    Top = 198
    Width = 120
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = '$0.00'
  end
  object lblTotalCaption: TLabel
    Left = 200
    Top = 224
    Width = 44
    Height = 25
    Alignment = taRightJustify
    Caption = 'Total:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotal: TLabel
    Left = 280
    Top = 224
    Width = 140
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = '$0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edSalePrice: TRzNumericEdit
    Left = 140
    Top = 120
    Width = 130
    Height = 28
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = edSalePriceChange
    IntegersOnly = False
    DisplayFormat = ',0.00;(,0.00)'
  end
  object btnCompleteSale: TRzBitBtn
    Left = 20
    Top = 268
    Width = 260
    Height = 44
    Caption = 'Complete Sale'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnCompleteSaleClick
    ImageIndex = 28
    Images = DM.vilMain24
    Margin = 8
  end
  object btnCancel: TBitBtn
    Left = 300
    Top = 268
    Width = 120
    Height = 44
    Cancel = True
    Caption = '&Cancel'
    ImageIndex = 2
    ImageName = 'actExit'
    Images = DM.vilMain24
    ModalResult = 2
    TabOrder = 2
  end
end
