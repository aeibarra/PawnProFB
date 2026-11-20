object frmEditStockReceipt: TfrmEditStockReceipt
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Stock Receipt'
  ClientHeight = 474
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 20
  object gbReceipt: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 510
    Height = 402
    Align = alClient
    Caption = ' Supplier Invoice '
    TabOrder = 0
    ExplicitWidth = 516
    ExplicitHeight = 399
    object lblReceiptNo: TLabel
      Left = 20
      Top = 30
      Width = 89
      Height = 21
      Caption = 'New receipt'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSupplier: TLabel
      Left = 25
      Top = 62
      Width = 58
      Height = 20
      Caption = 'Supplier:'
    end
    object lblReceived: TLabel
      Left = 295
      Top = 63
      Width = 63
      Height = 20
      Caption = 'Received:'
    end
    object lblInvoiceNo: TLabel
      Left = 25
      Top = 124
      Width = 63
      Height = 20
      Caption = 'Invoice #:'
    end
    object lblInvoiceDate: TLabel
      Left = 188
      Top = 124
      Width = 84
      Height = 20
      Caption = 'Invoice date:'
    end
    object lblInvoiceTotal: TLabel
      Left = 328
      Top = 124
      Width = 85
      Height = 20
      Caption = 'Invoice total:'
    end
    object lblPayType: TLabel
      Left = 25
      Top = 188
      Width = 51
      Height = 20
      Caption = 'Paid by:'
    end
    object lblNotes: TLabel
      Left = 25
      Top = 249
      Width = 42
      Height = 20
      Caption = 'Notes:'
    end
    object cbSupplier: TComboBox
      Left = 25
      Top = 86
      Width = 247
      Height = 28
      Hint = 'Pick a supplier, or type a new one'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object edReceivedDate: TRzDateTimeEdit
      Left = 295
      Top = 86
      Width = 150
      Height = 28
      EditType = etDate
      TabOrder = 1
    end
    object edInvoiceNo: TEdit
      Left = 25
      Top = 147
      Width = 150
      Height = 28
      MaxLength = 40
      TabOrder = 2
    end
    object edInvoiceDate: TRzDateTimeEdit
      Left = 188
      Top = 147
      Width = 126
      Height = 28
      EditType = etDate
      TabOrder = 3
    end
    object edInvoiceTotal: TRzNumericEdit
      Left = 328
      Top = 147
      Width = 117
      Height = 28
      TabOrder = 4
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object cbPayType: TComboBox
      Left = 25
      Top = 214
      Width = 160
      Height = 28
      Style = csDropDownList
      TabOrder = 5
    end
    object memNotes: TMemo
      Left = 25
      Top = 275
      Width = 460
      Height = 104
      MaxLength = 500
      ScrollBars = ssVertical
      TabOrder = 6
    end
  end
  object gbButtons: TGroupBox
    Left = 0
    Top = 408
    Width = 516
    Height = 66
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 2
    ExplicitWidth = 517
    object BitBtn1: TBitBtn
      Left = 378
      Top = 12
      Width = 109
      Height = 43
      ImageName = 'Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      Spacing = 7
      TabOrder = 1
    end
    object RzBitBtn1: TRzBitBtn
      Left = 247
      Top = 12
      Width = 109
      Height = 43
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
    end
  end
end
