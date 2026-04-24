object frmConfirmCloseLayaway: TfrmConfirmCloseLayaway
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Closing Layaway'
  ClientHeight = 283
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    562
    283)
  TextHeight = 15
  object lblBalance: TLabel
    Left = 8
    Top = 28
    Width = 536
    Height = 25
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'This layaway still has an outstanding balance of $1,091.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 598
  end
  object Label1: TLabel
    Left = 8
    Top = 75
    Width = 536
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'How would you like to close it?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 598
  end
  object btnPayoff: TRzBitBtn
    Left = 109
    Top = 112
    Width = 340
    Height = 44
    Caption = 'Payoff Balance & Release Items'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnPayoffClick
    ImageIndex = 27
    Images = DM.vilMain24
  end
  object btnCancelLayaway: TRzBitBtn
    Left = 109
    Top = 170
    Width = 340
    Height = 44
    Caption = 'Cancel Layaway (Do Not Release Items)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnCancelLayawayClick
    ImageIndex = 3
    Images = DM.ImageListBtn
  end
  object btnCancel: TBitBtn
    Left = 333
    Top = 227
    Width = 116
    Height = 44
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    Kind = bkCancel
    NumGlyphs = 2
    ParentFont = False
    Spacing = 10
    TabOrder = 2
  end
end
