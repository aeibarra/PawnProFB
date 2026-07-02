object frmEnterClientInfo: TfrmEnterClientInfo
  Left = 234
  Top = 263
  BorderStyle = bsDialog
  Caption = 'Client Information'
  ClientHeight = 523
  ClientWidth = 1022
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 20
  object gnBottom: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 444
    Width = 749
    Height = 67
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 586
      Top = 9
      Width = 113
      Height = 48
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
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TRzBitBtn
      Left = 449
      Top = 9
      Width = 113
      Height = 48
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
    Width = 749
    Height = 435
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object Label9: TLabel
      Left = 593
      Top = 11
      Width = 31
      Height = 20
      Caption = 'DOB'
    end
    object Label8: TLabel
      Left = 598
      Top = 117
      Width = 61
      Height = 20
      Caption = 'Zip Code'
    end
    object Label1: TLabel
      Left = 344
      Top = 11
      Width = 29
      Height = 20
      Caption = 'Last:'
    end
    object Label2: TLabel
      Left = 29
      Top = 11
      Width = 30
      Height = 20
      Caption = 'First:'
    end
    object Label3: TLabel
      Left = 277
      Top = 11
      Width = 47
      Height = 20
      Caption = 'Middle'
    end
    object Label10: TLabel
      Left = 29
      Top = 63
      Width = 48
      Height = 20
      Caption = 'Gender'
    end
    object Label11: TLabel
      Left = 121
      Top = 63
      Width = 32
      Height = 20
      Caption = 'Race'
    end
    object Label12: TLabel
      Left = 598
      Top = 63
      Width = 39
      Height = 20
      Caption = 'Marks'
    end
    object Label13: TLabel
      Left = 505
      Top = 63
      Width = 28
      Height = 20
      Caption = 'Hair'
    end
    object Label14: TLabel
      Left = 412
      Top = 63
      Width = 69
      Height = 20
      Caption = 'Eyes Color'
    end
    object Label15: TLabel
      Left = 347
      Top = 63
      Width = 47
      Height = 20
      Caption = 'Weight'
    end
    object Label16: TLabel
      Left = 277
      Top = 63
      Width = 45
      Height = 20
      Caption = 'Height'
    end
    object Label4: TLabel
      Left = 29
      Top = 117
      Width = 56
      Height = 20
      Caption = 'Address:'
    end
    object Label5: TLabel
      Left = 277
      Top = 117
      Width = 27
      Height = 20
      Caption = 'Apt:'
    end
    object Label6: TLabel
      Left = 361
      Top = 117
      Width = 28
      Height = 20
      Caption = 'City:'
    end
    object Label7: TLabel
      Left = 505
      Top = 117
      Width = 34
      Height = 20
      Caption = 'State'
    end
    object Label20: TLabel
      Left = 29
      Top = 171
      Width = 141
      Height = 20
      Caption = 'Place of Employment'
    end
    object Label17: TLabel
      Left = 29
      Top = 224
      Width = 115
      Height = 20
      Caption = 'Identification No.'
    end
    object Label18: TLabel
      Left = 243
      Top = 224
      Width = 31
      Height = 20
      Caption = 'Type'
    end
    object Label19: TLabel
      Left = 395
      Top = 224
      Width = 89
      Height = 20
      Caption = 'Agency/State'
    end
    object Label27: TLabel
      Left = 277
      Top = 171
      Width = 149
      Height = 20
      Caption = 'Florida Drivers Licence'
    end
    object Label21: TLabel
      Left = 29
      Top = 331
      Width = 65
      Height = 20
      Caption = 'Comment'
    end
    object Label23: TLabel
      Left = 155
      Top = 278
      Width = 41
      Height = 20
      Caption = 'Home'
    end
    object Label24: TLabel
      Left = 282
      Top = 278
      Width = 61
      Height = 20
      Caption = 'Bussiness'
    end
    object Label25: TLabel
      Left = 408
      Top = 278
      Width = 37
      Height = 20
      Caption = 'Other'
    end
    object Label26: TLabel
      Left = 29
      Top = 278
      Width = 50
      Height = 20
      Caption = 'Cellular'
    end
    object lblCustAge: TRzLabel
      Left = 637
      Top = 11
      Width = 74
      Height = 17
      Caption = '18 Years old'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edLast: TDBEdit
      Left = 346
      Top = 32
      Width = 243
      Height = 28
      DataField = 'CUST_LAST'
      DataSource = DM.DSCustomers
      TabOrder = 2
    end
    object edFirst: TDBEdit
      Left = 29
      Top = 32
      Width = 240
      Height = 28
      DataField = 'CUST_FIRST'
      DataSource = DM.DSCustomers
      TabOrder = 0
    end
    object edMid: TDBEdit
      Left = 277
      Top = 32
      Width = 60
      Height = 28
      DataField = 'CUST_MID'
      DataSource = DM.DSCustomers
      TabOrder = 1
    end
    object DBEdit11: TDBEdit
      Left = 598
      Top = 86
      Width = 111
      Height = 28
      DataField = 'CUST_MARK'
      DataSource = DM.DSCustomers
      TabOrder = 10
    end
    object DBEdit14: TDBEdit
      Left = 346
      Top = 86
      Width = 54
      Height = 28
      DataField = 'CUST_WEIGHT'
      DataSource = DM.DSCustomers
      TabOrder = 7
    end
    object DBEdit15: TDBEdit
      Left = 277
      Top = 86
      Width = 61
      Height = 28
      DataField = 'CUST_HEIGHT'
      DataSource = DM.DSCustomers
      TabOrder = 6
    end
    object DBEdit4: TDBEdit
      Left = 29
      Top = 140
      Width = 239
      Height = 28
      DataField = 'CUST_ADDR'
      DataSource = DM.DSCustomers
      TabOrder = 11
    end
    object DBEdit5: TDBEdit
      Left = 277
      Top = 140
      Width = 61
      Height = 28
      DataField = 'CUST_APT'
      DataSource = DM.DSCustomers
      TabOrder = 12
    end
    object DBEdit6: TDBEdit
      Left = 346
      Top = 140
      Width = 150
      Height = 28
      DataField = 'CUST_CITY'
      DataSource = DM.DSCustomers
      TabOrder = 13
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 505
      Top = 140
      Width = 84
      Height = 28
      DataField = 'CUST_STATE'
      DataSource = DM.DSCustomers
      DropDownWidth = 150
      KeyField = 'State_Abbr'
      ListField = 'State_Abbr;State_Name'
      ListSource = DM.DSStates
      TabOrder = 14
    end
    object DBEdit9: TDBEdit
      Left = 29
      Top = 193
      Width = 239
      Height = 28
      DataField = 'CUST_PLACE_EMPLY'
      DataSource = DM.DSCustomers
      TabOrder = 16
    end
    object DBEdit16: TDBEdit
      Left = 29
      Top = 246
      Width = 208
      Height = 28
      DataField = 'CUST_ID'
      DataSource = DM.DSCustomers
      TabOrder = 18
    end
    object DBEdit17: TDBEdit
      Left = 243
      Top = 246
      Width = 144
      Height = 28
      DataField = 'CUST_ID_TYPE'
      DataSource = DM.DSCustomers
      TabOrder = 19
    end
    object DBEdit18: TDBEdit
      Left = 395
      Top = 246
      Width = 193
      Height = 28
      DataField = 'CUST_ID_AGENCY_STATE'
      DataSource = DM.DSCustomers
      TabOrder = 20
    end
    object DBMemo1: TDBMemo
      Left = 29
      Top = 352
      Width = 670
      Height = 74
      DataField = 'CUST_COMMENT'
      DataSource = DM.DSCustomers
      ScrollBars = ssVertical
      TabOrder = 25
    end
    object cbCustDOB: TRzDBDateTimeEdit
      Left = 598
      Top = 33
      Width = 110
      Height = 28
      DataSource = DM.DSCustomers
      DataField = 'CUST_DOB'
      TabOrder = 3
      OnExit = RzDBDateTimeEdit1Exit
      EditType = etDate
    end
    object DBEdit1: TDBEdit
      Left = 598
      Top = 140
      Width = 111
      Height = 28
      DataField = 'CUST_ZIP'
      DataSource = DM.DSCustomers
      TabOrder = 15
    end
    object cbGender: TComboBox
      Left = 29
      Top = 86
      Width = 84
      Height = 28
      Style = csDropDownList
      TabOrder = 4
      Items.Strings = (
        'Male'
        'Female'
        'N/A')
    end
    object cbRace: TComboBox
      Left = 121
      Top = 86
      Width = 147
      Height = 28
      Style = csDropDownList
      TabOrder = 5
      Items.Strings = (
        'White'
        'Black'
        'American-Indian'
        'Asian/Oriental'
        'Hispanic')
    end
    object cbEyes: TComboBox
      Left = 412
      Top = 86
      Width = 84
      Height = 28
      Style = csDropDownList
      TabOrder = 8
      Items.Strings = (
        'Blue'
        'Black'
        'Brown'
        'Green '
        'Gray'
        'Hazel')
    end
    object cbHair: TComboBox
      Left = 505
      Top = 86
      Width = 84
      Height = 28
      Style = csDropDownList
      TabOrder = 9
      Items.Strings = (
        'Black'
        'Blond'
        'Brown'
        'Gray'
        'Red')
    end
    object edCellNumber: TDBPawnPhoneEdit
      Left = 29
      Top = 298
      Width = 115
      Height = 28
      MaxLength = 14
      TabOrder = 21
      Text = '(   )   -    '
      DataSource = DM.DSCustomers
      DataField = 'CUST_PH_CELL'
    end
    object edHomePhoneNumber: TDBPawnPhoneEdit
      Left = 155
      Top = 298
      Width = 115
      Height = 28
      MaxLength = 14
      TabOrder = 22
      Text = '(   )   -    '
      DataSource = DM.DSCustomers
      DataField = 'CUST_PH_HOME'
    end
    object edBussinessPhoneNumber: TDBPawnPhoneEdit
      Left = 283
      Top = 298
      Width = 115
      Height = 28
      MaxLength = 14
      TabOrder = 23
      Text = '(   )   -    '
      DataSource = DM.DSCustomers
      DataField = 'CUST_PH_BUSINESS'
    end
    object edOtherPhoneNumber: TDBPawnPhoneEdit
      Left = 408
      Top = 298
      Width = 115
      Height = 28
      MaxLength = 14
      TabOrder = 24
      Text = '(   )   -    '
      DataSource = DM.DSCustomers
      DataField = 'CUST_PH_BEEP'
    end
    object edFLDriverLicense: TDBPawnFLDLEdit
      Left = 277
      Top = 193
      Width = 171
      Height = 28
      MaxLength = 17
      TabOrder = 17
      Text = '    -   -  -   - '
      OnEnter = txtFlDrvLicAfterEnter
      DataSource = DM.DSCustomers
      DataField = 'CUST_FL_DRV_LIC'
    end
  end
  object ActionListClientInfo: TActionList
    Left = 819
    Top = 221
    object ActionScanCard: TAction
      Caption = 'ActionScanCard'
      ShortCut = 113
      OnExecute = ActionScanCardExecute
    end
  end
  object TimerScanningTimeOut: TTimer
    Enabled = False
    Interval = 12000
    OnTimer = TimerScanningTimeOutTimer
    Left = 815
    Top = 153
  end
  object qryCheckClient: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT CAST(COUNT(*) AS INTEGER) as "TClients"'
      'FROM CUSTOMER'
      
        'WHERE CUST_LAST = :CustLast AND CUST_FIRST = :CustFirst AND CUST' +
        '_DOB = :CustDOB')
    Left = 810
    Top = 24
    ParamData = <
      item
        Name = 'CustLast'
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'CustFirst'
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'CustDOB'
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 32874d
      end>
    object qryCheckClientTClients: TIntegerField
      FieldName = 'TClients'
    end
  end
  object TimerForScan: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerForScanTimer
    Left = 811
    Top = 91
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 822
    Top = 292
  end
end
