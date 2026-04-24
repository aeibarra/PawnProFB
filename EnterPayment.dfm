object frmEnterPayment: TfrmEnterPayment
  Left = 749
  Top = 212
  BorderStyle = bsDialog
  Caption = 'Payment'
  ClientHeight = 394
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 21
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 322
    Width = 484
    Height = 69
    Align = alBottom
    TabOrder = 0
    object btnCancel: TBitBtn
      Left = 262
      Top = 10
      Width = 110
      Height = 49
      Cancel = True
      Caption = ' &Cancel'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
        7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
        1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
        A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
        00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
        4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
        A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
        3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
        FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
        90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
        21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
        4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
        9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
        B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
        76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
        AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
        CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
        00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
        BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
        C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TRzBitBtn
      Left = 119
      Top = 10
      Width = 110
      Height = 49
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -5
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 484
    Height = 313
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 37
      Top = 28
      Width = 32
      Height = 21
      Caption = 'Date'
    end
    object Label2: TLabel
      Left = 163
      Top = 28
      Width = 56
      Height = 21
      Caption = 'Amount'
    end
    object Label3: TLabel
      Left = 37
      Top = 193
      Width = 69
      Height = 21
      Caption = 'Comment'
    end
    object Label4: TLabel
      Left = 263
      Top = 9
      Width = 58
      Height = 21
      Caption = 'Apply to'
    end
    object Label6: TLabel
      Left = 263
      Top = 28
      Width = 52
      Height = 21
      Caption = 'Interest'
    end
    object Label5: TLabel
      Left = 362
      Top = 28
      Width = 60
      Height = 21
      Caption = 'Principal'
    end
    object Label7: TLabel
      Left = 362
      Top = 9
      Width = 58
      Height = 21
      Caption = 'Apply to'
    end
    object Label8: TLabel
      Left = 30
      Top = 132
      Width = 92
      Height = 21
      Caption = 'Princ Balance'
    end
    object Label10: TLabel
      Left = 135
      Top = 131
      Width = 65
      Height = 21
      Caption = 'Interest $'
    end
    object MemoComment: TDBMemo
      Left = 29
      Top = 215
      Width = 426
      Height = 88
      DataField = 'PayComment'
      DataSource = DM.DSPayments
      ScrollBars = ssVertical
      TabOrder = 6
    end
    object edInsterestBalance: TDBEdit
      Left = 135
      Top = 155
      Width = 93
      Height = 29
      TabStop = False
      DataField = 'InsterestBalance'
      DataSource = DM.DSPayments
      TabOrder = 4
    end
    object edPayPrinc: TDBEdit
      Left = 362
      Top = 50
      Width = 93
      Height = 29
      DataField = 'PayPrincipal'
      DataSource = DM.DSPayments
      TabOrder = 3
      OnExit = edPayPrincExit
    end
    object edPrincBalance: TDBEdit
      Left = 30
      Top = 155
      Width = 93
      Height = 29
      TabStop = False
      DataField = 'PrincBalance'
      DataSource = DM.DSPayments
      TabOrder = 5
    end
    object edPayInterest: TDBEdit
      Left = 261
      Top = 50
      Width = 93
      Height = 29
      DataField = 'PayInterest'
      DataSource = DM.DSPayments
      TabOrder = 2
      OnExit = edPayInterestExit
    end
    object edAmount: TDBEdit
      Left = 161
      Top = 50
      Width = 93
      Height = 29
      DataField = 'PayAmount'
      DataSource = DM.DSPayments
      MaxLength = 6
      TabOrder = 1
      OnExit = edAmountExit
    end
    object btnSplitPayment: TButton
      Left = 261
      Top = 82
      Width = 194
      Height = 31
      Caption = 'Split Payment'
      TabOrder = 7
      TabStop = False
      OnClick = btnSplitPaymentClick
    end
    object RzDBDateTimeEdit1: TRzDBDateTimeEdit
      Left = 30
      Top = 50
      Width = 124
      Height = 29
      DataSource = DM.DSPayments
      DataField = 'PayDate'
      TabOrder = 0
      OnExit = edDateAfterExit
      EditType = etDate
    end
  end
end
