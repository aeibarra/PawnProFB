object frmEnterClientInfo: TfrmEnterClientInfo
  Left = 203
  Top = 263
  BorderStyle = bsDialog
  Caption = 'Client Information'
  ClientHeight = 488
  ClientWidth = 886
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
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
  TextHeight = 17
  object gnBottom: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 421
    Width = 649
    Height = 63
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 508
      Top = 9
      Width = 98
      Height = 45
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
      Left = 389
      Top = 9
      Width = 98
      Height = 45
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
    Width = 649
    Height = 413
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object Label9: TLabel
      Left = 514
      Top = 11
      Width = 26
      Height = 17
      Caption = 'DOB'
    end
    object Label8: TLabel
      Left = 518
      Top = 112
      Width = 53
      Height = 17
      Caption = 'Zip Code'
    end
    object Label1: TLabel
      Left = 298
      Top = 11
      Width = 26
      Height = 17
      Caption = 'Last:'
    end
    object Label2: TLabel
      Left = 25
      Top = 11
      Width = 27
      Height = 17
      Caption = 'First:'
    end
    object Label3: TLabel
      Left = 240
      Top = 11
      Width = 41
      Height = 17
      Caption = 'Middle'
    end
    object Label10: TLabel
      Left = 25
      Top = 62
      Width = 43
      Height = 17
      Caption = 'Gender'
    end
    object Label11: TLabel
      Left = 105
      Top = 62
      Width = 28
      Height = 17
      Caption = 'Race'
    end
    object Label12: TLabel
      Left = 518
      Top = 62
      Width = 36
      Height = 17
      Caption = 'Marks'
    end
    object Label13: TLabel
      Left = 438
      Top = 62
      Width = 24
      Height = 17
      Caption = 'Hair'
    end
    object Label14: TLabel
      Left = 357
      Top = 62
      Width = 62
      Height = 17
      Caption = 'Eyes Color'
    end
    object Label15: TLabel
      Left = 301
      Top = 62
      Width = 40
      Height = 17
      Caption = 'Weight'
    end
    object Label16: TLabel
      Left = 240
      Top = 62
      Width = 38
      Height = 17
      Caption = 'Height'
    end
    object Label4: TLabel
      Left = 25
      Top = 112
      Width = 51
      Height = 17
      Caption = 'Address:'
    end
    object Label5: TLabel
      Left = 240
      Top = 112
      Width = 23
      Height = 17
      Caption = 'Apt:'
    end
    object Label6: TLabel
      Left = 313
      Top = 112
      Width = 24
      Height = 17
      Caption = 'City:'
    end
    object Label7: TLabel
      Left = 438
      Top = 112
      Width = 29
      Height = 17
      Caption = 'State'
    end
    object Label20: TLabel
      Left = 25
      Top = 161
      Width = 122
      Height = 17
      Caption = 'Place of Employment'
    end
    object Label17: TLabel
      Left = 25
      Top = 210
      Width = 99
      Height = 17
      Caption = 'Identification No.'
    end
    object Label18: TLabel
      Left = 212
      Top = 210
      Width = 27
      Height = 17
      Caption = 'Type'
    end
    object Label19: TLabel
      Left = 344
      Top = 210
      Width = 76
      Height = 17
      Caption = 'Agency/State'
    end
    object Label27: TLabel
      Left = 240
      Top = 161
      Width = 131
      Height = 17
      Caption = 'Florida Drivers Licence'
    end
    object Label21: TLabel
      Left = 25
      Top = 308
      Width = 56
      Height = 17
      Caption = 'Comment'
    end
    object Label23: TLabel
      Left = 134
      Top = 259
      Width = 35
      Height = 17
      Caption = 'Home'
    end
    object Label24: TLabel
      Left = 244
      Top = 259
      Width = 55
      Height = 17
      Caption = 'Bussiness'
    end
    object Label25: TLabel
      Left = 354
      Top = 259
      Width = 33
      Height = 17
      Caption = 'Other'
    end
    object Label26: TLabel
      Left = 25
      Top = 259
      Width = 43
      Height = 17
      Caption = 'Cellular'
    end
    object lblCustAge: TRzLabel
      Left = 552
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
      Left = 300
      Top = 30
      Width = 211
      Height = 25
      DataField = 'CUST_LAST'
      DataSource = DM.DSCustomers
      TabOrder = 2
    end
    object edFirst: TDBEdit
      Left = 24
      Top = 30
      Width = 208
      Height = 25
      DataField = 'CUST_FIRST'
      DataSource = DM.DSCustomers
      TabOrder = 0
    end
    object edMid: TDBEdit
      Left = 240
      Top = 30
      Width = 52
      Height = 25
      DataField = 'CUST_MID'
      DataSource = DM.DSCustomers
      TabOrder = 1
    end
    object DBEdit11: TDBEdit
      Left = 518
      Top = 80
      Width = 96
      Height = 25
      DataField = 'CUST_MARK'
      DataSource = DM.DSCustomers
      TabOrder = 10
    end
    object DBEdit14: TDBEdit
      Left = 300
      Top = 80
      Width = 47
      Height = 25
      DataField = 'CUST_WEIGHT'
      DataSource = DM.DSCustomers
      TabOrder = 7
    end
    object DBEdit15: TDBEdit
      Left = 240
      Top = 80
      Width = 53
      Height = 25
      DataField = 'CUST_HEIGHT'
      DataSource = DM.DSCustomers
      TabOrder = 6
    end
    object DBEdit4: TDBEdit
      Left = 25
      Top = 130
      Width = 207
      Height = 25
      DataField = 'CUST_ADDR'
      DataSource = DM.DSCustomers
      TabOrder = 11
    end
    object DBEdit5: TDBEdit
      Left = 240
      Top = 130
      Width = 53
      Height = 25
      DataField = 'CUST_APT'
      DataSource = DM.DSCustomers
      TabOrder = 12
    end
    object DBEdit6: TDBEdit
      Left = 300
      Top = 130
      Width = 130
      Height = 25
      DataField = 'CUST_CITY'
      DataSource = DM.DSCustomers
      TabOrder = 13
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 438
      Top = 130
      Width = 73
      Height = 25
      DataField = 'CUST_STATE'
      DataSource = DM.DSCustomers
      DropDownWidth = 150
      KeyField = 'State_Abbr'
      ListField = 'State_Abbr;State_Name'
      ListSource = DM.DSStates
      TabOrder = 14
    end
    object DBEdit9: TDBEdit
      Left = 25
      Top = 180
      Width = 207
      Height = 25
      DataField = 'CUST_PLACE_EMPLY'
      DataSource = DM.DSCustomers
      TabOrder = 16
    end
    object DBEdit16: TDBEdit
      Left = 26
      Top = 228
      Width = 180
      Height = 25
      DataField = 'CUST_ID'
      DataSource = DM.DSCustomers
      TabOrder = 18
    end
    object DBEdit17: TDBEdit
      Left = 212
      Top = 228
      Width = 125
      Height = 25
      DataField = 'CUST_ID_TYPE'
      DataSource = DM.DSCustomers
      TabOrder = 19
    end
    object DBEdit18: TDBEdit
      Left = 344
      Top = 228
      Width = 167
      Height = 25
      DataField = 'CUST_ID_AGENCY_STATE'
      DataSource = DM.DSCustomers
      TabOrder = 20
    end
    object DBMemo1: TDBMemo
      Left = 25
      Top = 328
      Width = 581
      Height = 74
      DataField = 'CUST_COMMENT'
      DataSource = DM.DSCustomers
      ScrollBars = ssVertical
      TabOrder = 25
    end
    object cbCustDOB: TRzDBDateTimeEdit
      Left = 518
      Top = 31
      Width = 95
      Height = 25
      DataSource = DM.DSCustomers
      DataField = 'CUST_DOB'
      TabOrder = 3
      OnExit = RzDBDateTimeEdit1Exit
      EditType = etDate
    end
    object DBEdit1: TDBEdit
      Left = 518
      Top = 130
      Width = 96
      Height = 25
      DataField = 'CUST_ZIP'
      DataSource = DM.DSCustomers
      TabOrder = 15
    end
    object cbGender: TComboBox
      Left = 26
      Top = 81
      Width = 73
      Height = 25
      Style = csDropDownList
      TabOrder = 4
      Items.Strings = (
        'Male'
        'Female'
        'N/A')
    end
    object cbRace: TComboBox
      Left = 105
      Top = 80
      Width = 127
      Height = 25
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
      Left = 357
      Top = 80
      Width = 73
      Height = 25
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
      Left = 438
      Top = 80
      Width = 73
      Height = 25
      Style = csDropDownList
      TabOrder = 9
      Items.Strings = (
        'Black'
        'Blond'
        'Brown'
        'Gray'
        'Red')
    end
    object edFLDriverLicense: TPawnFLDLEdit
      Left = 240
      Top = 180
      Width = 148
      Height = 25
      TabOrder = 17
      Text = '    -   -  -   - '
    end
    object edCellNumber: TPawnPhoneEdit
      Left = 25
      Top = 277
      Width = 100
      Height = 25
      TabOrder = 21
      Text = '(   )   -    '
    end
    object edHomePhoneNumber: TPawnPhoneEdit
      Left = 134
      Top = 277
      Width = 100
      Height = 25
      TabOrder = 22
      Text = '(   )   -    '
    end
    object edBussinessPhoneNumber: TPawnPhoneEdit
      Left = 245
      Top = 277
      Width = 100
      Height = 25
      TabOrder = 23
      Text = '(   )   -    '
    end
    object edOtherPhoneNumber: TPawnPhoneEdit
      Left = 354
      Top = 277
      Width = 100
      Height = 25
      TabOrder = 24
      Text = '(   )   -    '
    end
  end
  object ActionListClientInfo: TActionList
    Left = 710
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
    Left = 706
    Top = 153
  end
  object qryCheckClient: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'CustLast'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'CustFirst'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end
      item
        Name = 'CustDOB'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 255
        Size = 32767
        Value = 32874d
      end>
    SQL.Strings = (
      'SELECT Count(*) as TClients'
      'FROM Customer'
      
        'WHERE CustLast = :CustLast AND CustFirst = :CustFirst AND CustDO' +
        'B = :CustDOB')
    Left = 702
    Top = 24
    object qryCheckClientTClients: TIntegerField
      FieldName = 'TClients'
    end
  end
  object TimerForScan: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerForScanTimer
    Left = 703
    Top = 91
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 712
    Top = 292
  end
end
