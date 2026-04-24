object frmPawnChangeStatus: TfrmPawnChangeStatus
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change Pawn Status'
  ClientHeight = 320
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  TextHeight = 21
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 323
    Height = 246
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 16
      Width = 214
      Height = 25
      Caption = 'Reason for Inactivation?'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rbRedeemed: TRadioButton
      Left = 55
      Top = 56
      Width = 199
      Height = 17
      Caption = 'Pawn Redeemed'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = rbRedeemedClick
    end
    object rbDefaulted: TRadioButton
      Left = 55
      Top = 92
      Width = 199
      Height = 17
      Caption = 'Pawn Defaulted'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = rbRedeemedClick
    end
    object pnItemStatus: TRzPanel
      Left = 75
      Top = 124
      Width = 193
      Height = 102
      BorderOuter = fsFlat
      Enabled = False
      TabOrder = 2
      object Label2: TLabel
        Left = 13
        Top = 10
        Width = 102
        Height = 21
        Caption = 'Items will be....:'
        Enabled = False
      end
      object rbItemScrap: TRzRadioButton
        Left = 32
        Top = 38
        Width = 124
        Height = 23
        AlignmentVertical = avCenter
        AutoSizeWidth = 124
        Caption = 'Scrap / Melted'
        Enabled = False
        TabOrder = 0
      end
      object rbItemForSame: TRzRadioButton
        Left = 32
        Top = 66
        Width = 79
        Height = 23
        AlignmentVertical = avCenter
        AutoSizeWidth = 79
        Caption = 'For Sale'
        Enabled = False
        TabOrder = 1
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 255
    Width = 323
    Height = 62
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      323
      62)
    object btnSave: TRzBitBtn
      Left = 43
      Top = 10
      Width = 102
      Height = 42
      Anchors = [akTop, akRight]
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Margin = 10
      Spacing = -5
    end
    object btnCancel: TBitBtn
      Left = 173
      Top = 10
      Width = 102
      Height = 42
      Anchors = [akTop, akRight]
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
    end
  end
end
