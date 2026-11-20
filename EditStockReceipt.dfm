object frmEditStockReceipt: TfrmEditStockReceipt
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Stock Receipt'
  ClientHeight = 424
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 20
  object gbReceipt: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 614
    Height = 352
    Align = alClient
    Caption = ' Supplier Invoice '
    TabOrder = 0
    object lblReceiptNo: TLabel
      Left = 20
      Top = 30
      Width = 92
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
      Left = 20
      Top = 72
      Width = 60
      Height = 20
      Caption = 'Supplier:'
    end
    object lblReceived: TLabel
      Left = 20
      Top = 112
      Width = 66
      Height = 20
      Caption = 'Received:'
    end
    object lblInvoiceNo: TLabel
      Left = 20
      Top = 152
      Width = 67
      Height = 20
      Caption = 'Invoice #:'
    end
    object lblInvoiceDate: TLabel
      Left = 320
      Top = 152
      Width = 86
      Height = 20
      Caption = 'Invoice date:'
    end
    object lblInvoiceTotal: TLabel
      Left = 20
      Top = 192
      Width = 87
      Height = 20
      Caption = 'Invoice total:'
    end
    object lblPayType: TLabel
      Left = 320
      Top = 192
      Width = 55
      Height = 20
      Caption = 'Paid by:'
    end
    object lblNotes: TLabel
      Left = 20
      Top = 232
      Width = 45
      Height = 20
      Caption = 'Notes:'
    end
    object cbSupplier: TComboBox
      Left = 130
      Top = 68
      Width = 460
      Height = 28
      Hint = 'Pick a supplier, or type a new one'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object edReceivedDate: TRzDateTimeEdit
      Left = 130
      Top = 108
      Width = 150
      Height = 28
      EditType = etDate
      TabOrder = 1
    end
    object edInvoiceNo: TEdit
      Left = 130
      Top = 148
      Width = 170
      Height = 28
      MaxLength = 40
      TabOrder = 2
    end
    object edInvoiceDate: TRzDateTimeEdit
      Left = 430
      Top = 148
      Width = 160
      Height = 28
      EditType = etDate
      TabOrder = 3
    end
    object edInvoiceTotal: TRzNumericEdit
      Left = 130
      Top = 188
      Width = 150
      Height = 28
      TabOrder = 4
      IntegersOnly = False
      DisplayFormat = ',0.00;(,0.00)'
    end
    object cbPayType: TComboBox
      Left = 430
      Top = 188
      Width = 160
      Height = 28
      Style = csDropDownList
      TabOrder = 5
    end
    object memNotes: TMemo
      Left = 130
      Top = 228
      Width = 460
      Height = 104
      MaxLength = 500
      ScrollBars = ssVertical
      TabOrder = 6
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 358
    Width = 620
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnSave: TRzBitBtn
      Left = 290
      Top = 10
      Width = 150
      Height = 46
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
    end
    object btnCancel: TBitBtn
      Left = 452
      Top = 10
      Width = 150
      Height = 46
      Cancel = True
      Caption = '&Cancel'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 2
      TabOrder = 1
    end
  end
end
