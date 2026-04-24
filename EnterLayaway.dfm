object frmEnterLayaway: TfrmEnterLayaway
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Layaway'
  ClientHeight = 271
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 20
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 206
    Width = 470
    Height = 62
    Align = alBottom
    TabOrder = 0
    object btnSave: TRzBitBtn
      Left = 206
      Top = 10
      Width = 107
      Height = 41
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -5
    end
    object btnCancel: TBitBtn
      Left = 350
      Top = 10
      Width = 107
      Height = 41
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 470
    Height = 197
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 19
      Top = 13
      Width = 32
      Height = 20
      Caption = 'Date'
    end
    object Label3: TLabel
      Left = 255
      Top = 10
      Width = 46
      Height = 20
      Caption = 'Memo:'
    end
    object Label5: TLabel
      Left = 68
      Top = 76
      Width = 53
      Height = 20
      Caption = 'Amount'
    end
    object Label2: TLabel
      Left = 131
      Top = 13
      Width = 63
      Height = 20
      Caption = 'Ticket No'
    end
    object Label4: TLabel
      Left = 62
      Top = 114
      Width = 59
      Height = 20
      Caption = 'Sales Tax'
    end
    object Label6: TLabel
      Left = 31
      Top = 152
      Width = 90
      Height = 20
      Alignment = taRightJustify
      Caption = 'Total Amount'
    end
    object DBMemo1: TDBMemo
      Left = 255
      Top = 33
      Width = 200
      Height = 143
      TabStop = False
      DataField = 'TranComment'
      DataSource = DM.DSTransactions
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object edAmount: TDBEdit
      Left = 131
      Top = 72
      Width = 88
      Height = 28
      DataField = 'TranPawnAmount'
      DataSource = DM.DSTransactions
      TabOrder = 2
      OnExit = edAmountExit
      OnKeyPress = edAmountKeyPress
    end
    object edTicketNo: TDBEdit
      Left = 131
      Top = 33
      Width = 88
      Height = 28
      DataField = 'TranTicketNo'
      DataSource = DM.DSTransactions
      TabOrder = 1
    end
    object RzDBDateTimeEdit1: TRzDBDateTimeEdit
      Left = 19
      Top = 33
      Width = 98
      Height = 28
      DataSource = DM.DSTransactions
      DataField = 'TranDate'
      TabOrder = 0
      EditType = etDate
    end
    object edSalesTax: TDBEdit
      Left = 131
      Top = 110
      Width = 88
      Height = 28
      TabStop = False
      Color = clBtnFace
      DataField = 'TranSalesTax'
      DataSource = DM.DSTransactions
      TabOrder = 4
    end
    object edTotalAmount: TDBEdit
      Left = 131
      Top = 148
      Width = 88
      Height = 28
      TabStop = False
      Color = clBtnFace
      DataField = 'cTotalSalesAmount'
      DataSource = DM.DSTransactions
      TabOrder = 5
    end
  end
end
