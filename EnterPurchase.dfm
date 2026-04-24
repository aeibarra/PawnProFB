object frmEnterPurchase: TfrmEnterPurchase
  Left = 326
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Purchase'
  ClientHeight = 268
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 18
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 442
    Height = 194
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 15
      Width = 31
      Height = 18
      Caption = 'Date'
    end
    object Label3: TLabel
      Left = 19
      Top = 67
      Width = 64
      Height = 18
      Caption = 'Comment'
    end
    object Label5: TLabel
      Left = 221
      Top = 15
      Width = 51
      Height = 18
      Caption = 'Amount'
    end
    object Label4: TLabel
      Left = 323
      Top = 15
      Width = 89
      Height = 18
      Caption = 'Maturity Date'
    end
    object Label2: TLabel
      Left = 123
      Top = 15
      Width = 62
      Height = 18
      Caption = 'Ticket No'
    end
    object DBMemo1: TDBMemo
      Left = 19
      Top = 91
      Width = 400
      Height = 81
      DataField = 'TranComment'
      DataSource = DM.DSTransactions
      ScrollBars = ssVertical
      TabOrder = 4
    end
    object edAmount: TDBEdit
      Left = 221
      Top = 33
      Width = 83
      Height = 26
      DataField = 'TranPawnAmount'
      DataSource = DM.DSTransactions
      TabOrder = 2
    end
    object edTicketNo: TDBEdit
      Left = 123
      Top = 33
      Width = 83
      Height = 26
      DataField = 'TranTicketNo'
      DataSource = DM.DSTransactions
      TabOrder = 1
    end
    object RzDBDateTimeEdit1: TRzDBDateTimeEdit
      Left = 19
      Top = 33
      Width = 98
      Height = 26
      DataSource = DM.DSTransactions
      DataField = 'TranDate'
      TabOrder = 0
      EditType = etDate
    end
    object RzDBDateTimeEdit2: TRzDBDateTimeEdit
      Left = 323
      Top = 33
      Width = 96
      Height = 26
      DataSource = DM.DSTransactions
      DataField = 'TranMaturity'
      TabOrder = 3
      EditType = etDate
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 203
    Width = 442
    Height = 62
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 8
    object btnSave: TRzBitBtn
      Left = 81
      Top = 11
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
      Left = 252
      Top = 11
      Width = 107
      Height = 41
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object qryNextTicket: TADODataSet
    Connection = DM.ConnDB
    CommandText = 'select  *'#13#10'from TableKeys'#13#10'where TableName = '#39'PawnTicketNo'#39
    Parameters = <>
    Left = 269
    Top = 122
    object qryNextTicketTableName: TStringField
      FieldName = 'TableName'
      Size = 15
    end
    object qryNextTicketLastKey: TIntegerField
      FieldName = 'LastKey'
    end
  end
end
