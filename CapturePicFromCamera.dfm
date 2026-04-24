object frmCapturePicFromCamera: TfrmCapturePicFromCamera
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Capture Picture'
  ClientHeight = 628
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    833
    628)
  TextHeight = 17
  object PaintBox_Video: TPaintBox
    AlignWithMargins = True
    Left = 8
    Top = 110
    Width = 815
    Height = 454
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitHeight = 462
  end
  object Panel_Top: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 827
    Height = 101
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      827
      101)
    object Label_Cameras: TLabel
      Left = 10
      Top = 4
      Width = 64
      Height = 17
      Caption = 'Camera #1'
    end
    object Label1: TLabel
      Left = 495
      Top = 11
      Width = 80
      Height = 17
      Caption = 'Display mode'
    end
    object btnStart: TRzToolButton
      Left = 207
      Top = 17
      Width = 40
      Height = 40
      ImageIndex = 17
      Images = DM.ImageListBtn
      OnClick = btnStartClick
    end
    object btnStop: TRzToolButton
      Left = 249
      Top = 17
      Width = 40
      Height = 40
      ImageIndex = 18
      Images = DM.ImageListBtn
      OnClick = btnStopClick
    end
    object btnTakePic: TRzToolButton
      Left = 302
      Top = 13
      Width = 175
      Height = 40
      Hint = 'F12'
      ImageIndex = 15
      Images = DM.ImageListBtn
      ShowCaption = True
      UseToolbarShowCaption = False
      Caption = 'Take Picture and Save'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTakePicClick
    end
    object Label_VideoSize: TLabel
      Left = 12
      Top = 44
      Width = 61
      Height = 17
      Caption = 'Video Size'
    end
    object SpeedButton1: TSpeedButton
      Left = 658
      Top = 17
      Width = 40
      Height = 35
      Flat = True
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        0800000000004002000000000000000000000001000000010000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003A4042003A464B003A4C53003D58610041626D00446B78004877
        85004C8190004F899900528FA1005597A900579CAE0059A0B3005CA5B80060A8
        BB0061ABBF0063B1C60064B4CA0064B7CE0063B8D00066BBD20068BDD50066BF
        D70063C1DB0062C5DF0062C8E30060C9E5005DCCE9005BCFED0058D2F00056D4
        F30053D5F50051D5F6004BD6F80044D7FA003CD6FB0032D5FB002AD5FC0027D4
        FC0023D4FD001DD3FD001AD2FD0018D2FD0016D1FC0014D0FC0016D0FB0018CD
        F8001ACBF6001BC8F3001CC5F0001FBFEC0021BBE80024B6E50026B1E00025AE
        DC0024ACD90024A8D60022A4D1001FA0CC001A9AC5001895C0001791BC00168C
        B7001389B3001285AF001082AD000F81AB000F81AB000F81AB000F81AB001182
        AC001485AE001888B100208FB6002593B9002895BB002997BD002B99BE002F9D
        C30036A5CA003CACD00040B2D50045B8DB0048BDE1004CC0E40050C4E70057CA
        EB0060D1F00069D7F4006DDAF50076DEF7007CE0F80081E2F90086E4FA008FE6
        FA009BEAFC00A2EBFB00ACECFA00BFEDF800CCEEF700D6EDF400DCEBF100E0E9
        EF00E5E5EE00E6D9EE00EAB9F000F189F500F84FF800FB23FB00FD0EFD00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00F90AF900F414F400E52D
        E500D04BD000BA6ABA00AC7FAC00A28BA2009C919C0099939800979497009694
        95009493940095949400959494009695950097959500999696009B9898009D99
        99009F9A9A00A19C9C00A49E9E00A5A0A000A6A1A100A8A3A400AAA6A600ACA7
        A700ADA8A800AFA9A900B1AAAA00B5AAAA00B9AAAA00BCABAB00BDABAB00C0AF
        AF00C2B3B300C6B8B800CBBCBC00C9C0C000CAC3C300CBC2C200BFBFBFBFBFBF
        BFBFBFBF7D78747DBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF755E908C
        7DBFBFBFBFBFBFBFBFBFBFBFBFBF7D8C73797D7872787385837D848B8D7DBFBF
        BFBFBFBFBFBF858D705F6D7276625D8E89939A548B7DBFBFBFBFBFBFBFBF7D8C
        5285767861655E94888A864D997DBFBFBFBFBF7D838A84959A99925C5F64605B
        95979D9E9E86857DBFBFBF869C958593989A96945D62635D94999C9A9477918E
        79BFBF8384788A92969A98945C6065615F626767676C73757ABFBF7D71706F91
        93999A954B49474B6C6767676767676775BFBF7D7870708F929750EDFBF4EDF5
        EE8C67676767676D7DBFBF7D8974708E5695EBA2FEF4EDF9FCEF69675F5A917A
        7DBFBF7D7670706F9093F4A2FEF4EDF9FCF8539A9D9E9E507DBFBF7D78737070
        8F92F4A2FEF4EDF9FCF854989C9E9B4D7DBFBFBFBF7D78708D91F4A2FEF4EDF9
        FCF854959A867DBFBFBFBFBFBFBF79707090F4A2FEF4EDF9FCF855949983BFBF
        BFBFBFBFBFBF7D797987F4A2FEF4EDF9FCF88887887DBFBFBFBFBFBFBFBFBFBF
        BFBFF4A2FEF4EDF9FCF8BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF4A2FEF4EDF9
        FCF8BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF4FDEAE5E3E2EEF6BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFE2F4FEF4ECF0F5E2BFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFEFA0A3FEF3ECF6ECBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFECA0A2FEFBEE
        EEEABFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFEFA2A2FEF4E7BFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFE2E2E2E2BFBFBFBFBFBFBFBFBFBF}
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 22
      Top = 72
      Width = 91
      Height = 17
      Caption = 'Picture Caption:'
    end
    object ComboBox_Cams: TComboBox
      Left = 10
      Top = 22
      Width = 193
      Height = 25
      TabOrder = 0
      Text = 'No cameras found'
      OnChange = ComboBox_CamsChange
    end
    object ComboBox_DisplayMode: TComboBox
      Left = 495
      Top = 28
      Width = 148
      Height = 25
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Normal'
      Items.Strings = (
        'Normal'
        'Inverted'
        'Gray Scale')
    end
    object btnExit: TBitBtn
      Left = 719
      Top = 7
      Width = 101
      Height = 52
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain
      TabOrder = 2
      OnClick = btnExitClick
    end
    object edImageDesc: TEdit
      Left = 117
      Top = 68
      Width = 526
      Height = 25
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 649
      Top = 68
      Width = 171
      Height = 25
      Style = csDropDownList
      Enabled = False
      TabOrder = 4
      OnChange = ComboBox1Change
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 573
    Width = 827
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnTakePicBR: TRzToolButton
      Left = 623
      Top = 7
      Width = 197
      Height = 40
      Hint = 'F12'
      ImageIndex = 15
      Images = DM.ImageListBtn
      ShowCaption = True
      UseToolbarShowCaption = False
      Caption = 'Take Picture and Save'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTakePicClick
    end
    object btnTakePicBL: TRzToolButton
      Left = 12
      Top = 8
      Width = 197
      Height = 40
      Hint = 'F12'
      ImageIndex = 15
      Images = DM.ImageListBtn
      ShowCaption = True
      UseToolbarShowCaption = False
      Caption = 'Take Picture and Save'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTakePicClick
    end
  end
  object ActionList1: TActionList
    Left = 79
    Top = 216
    object ActionTakePic: TAction
      Caption = 'Take Picture and Send'
      ShortCut = 123
      OnExecute = btnTakePicClick
    end
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 235
    Top = 203
  end
end
