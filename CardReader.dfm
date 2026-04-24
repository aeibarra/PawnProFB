object frmDriverLicCardReader: TfrmDriverLicCardReader
  Left = 573
  Top = 61
  BorderStyle = bsDialog
  Caption = 'Scan USA Driver License'
  ClientHeight = 331
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 562
    Height = 183
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 265
      Top = 64
      Width = 35
      Height = 16
      Caption = 'State:'
    end
    object Label2: TLabel
      Left = 162
      Top = 64
      Width = 26
      Height = 16
      Caption = 'City:'
    end
    object Label3: TLabel
      Left = 293
      Top = 12
      Width = 28
      Height = 16
      Caption = 'Last:'
    end
    object Label4: TLabel
      Left = 12
      Top = 12
      Width = 30
      Height = 16
      Caption = 'First:'
    end
    object Label5: TLabel
      Left = 162
      Top = 12
      Width = 42
      Height = 16
      Caption = 'Middle:'
    end
    object Label6: TLabel
      Left = 12
      Top = 64
      Width = 51
      Height = 16
      Caption = 'Address:'
    end
    object Label7: TLabel
      Left = 140
      Top = 120
      Width = 103
      Height = 16
      Caption = 'Driver License No.'
    end
    object Label8: TLabel
      Left = 429
      Top = 12
      Width = 24
      Height = 16
      Caption = 'DOB'
      FocusControl = edDOB
    end
    object Label9: TLabel
      Left = 323
      Top = 64
      Width = 23
      Height = 16
      Caption = 'ZIP:'
    end
    object Label10: TLabel
      Left = 15
      Top = 120
      Width = 23
      Height = 16
      Caption = 'SEX'
    end
    object Label11: TLabel
      Left = 69
      Top = 120
      Width = 36
      Height = 16
      Caption = 'Height'
      FocusControl = edHeight
    end
    object Label12: TLabel
      Left = 414
      Top = 64
      Width = 44
      Height = 16
      Caption = 'Country'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 288
      Top = 120
      Width = 56
      Height = 16
      Caption = 'Expiration'
      FocusControl = edExp
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 388
      Top = 120
      Width = 37
      Height = 16
      Caption = 'Issued'
      Color = clRed
      FocusControl = EdIssued
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label15: TLabel
      Left = 495
      Top = 120
      Width = 35
      Height = 16
      Caption = 'Class:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edFirst: TEdit
      Left = 12
      Top = 32
      Width = 144
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object edLast: TEdit
      Left = 276
      Top = 32
      Width = 144
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
    object edMiddle: TEdit
      Left = 162
      Top = 32
      Width = 108
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
    object edAddress: TEdit
      Left = 13
      Top = 84
      Width = 143
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 4
    end
    object edCity: TEdit
      Left = 162
      Top = 84
      Width = 97
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 5
    end
    object edState: TEdit
      Left = 265
      Top = 84
      Width = 52
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 6
    end
    object edSex: TEdit
      Left = 15
      Top = 138
      Width = 48
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 9
    end
    object edHeight: TEdit
      Left = 69
      Top = 138
      Width = 65
      Height = 22
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
    end
    object Button1: TButton
      Left = 472
      Top = 84
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 14
      Visible = False
      OnClick = Button1Click
    end
    object edDOB: TRzDateTimeEdit
      Left = 429
      Top = 32
      Width = 104
      Height = 24
      EditType = etDate
      TabOrder = 3
    end
    object edZIP: TRzMaskEdit
      Left = 323
      Top = 84
      Width = 85
      Height = 24
      EditMask = '00000\-9999;1;_'
      MaxLength = 10
      TabOrder = 7
      Text = '33155-0188'
    end
    object edDrvLic: TRzMaskEdit
      Left = 140
      Top = 141
      Width = 143
      Height = 22
      EditMask = 'A999-999-99-999-0;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 17
      ParentFont = False
      TabOrder = 11
      Text = ''
    end
    object edCountry: TEdit
      Left = 414
      Top = 84
      Width = 52
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 8
    end
    object edExp: TRzDateTimeEdit
      Left = 288
      Top = 141
      Width = 94
      Height = 24
      EditType = etDate
      TabOrder = 12
    end
    object EdIssued: TRzDateTimeEdit
      Left = 388
      Top = 141
      Width = 95
      Height = 24
      EditType = etDate
      TabOrder = 13
    end
    object edDrvLicClass: TEdit
      Left = 495
      Top = 141
      Width = 52
      Height = 24
      TabStop = False
      ReadOnly = True
      TabOrder = 15
    end
    object Memo1: TMemo
      Left = 585
      Top = 3
      Width = 228
      Height = 156
      Lines.Strings = (
        '@'
        
          'ANSI 6360100102DL00390163ZF02020043DLDAARODRIGUEZ,YANELYS, DAG79' +
          '20 SW 26TH STDAIMIAMIDAJFLDAK33155-0000 DAQR362960775280DARE   D' +
          'ASNONEDATNONEDBA20230128DBB19770128DBC2DBD20140327DAU502'
        'ZFZFAZFBZFCT021403270026ZFDZFE09-01-12'
        '')
      ScrollBars = ssBoth
      TabOrder = 16
      Visible = False
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 192
    Width = 562
    Height = 136
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object MemoRawData: TMemo
      Left = 0
      Top = 0
      Width = 449
      Height = 136
      Align = alLeft
      ScrollBars = ssHorizontal
      TabOrder = 0
      OnChange = MemoRawDataChange
    end
    object BitBtn2: TBitBtn
      Left = 468
      Top = 101
      Width = 79
      Height = 30
      Cancel = True
      Caption = 'Cancel'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0732DE0732DEFF00FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DEFF00FFFF00FF0732DE
        0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732
        DE0732DEFF00FFFF00FFFF00FF0732DE0732DD0732DE0732DEFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FF
        0534ED0732DF0732DE0732DEFF00FFFF00FFFF00FFFF00FF0732DE0732DEFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DDFF
        00FF0732DD0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0732DD0633E60633E60633E90732DCFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0633E307
        32E30534EFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0732DD0534ED0533E90434EF0434F5FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0434F40534EF0533EBFF
        00FFFF00FF0434F40335F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0335FC0534EF0434F8FF00FFFF00FFFF00FFFF00FF0335FC0335FBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FCFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0335FB0335FBFF00FFFF00FFFF00FFFF00FF0335FB
        0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0335FBFF00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 2
      TabOrder = 2
      TabStop = False
    end
    object BitBtn3: TBitBtn
      Left = 468
      Top = 42
      Width = 79
      Height = 30
      Caption = '&Clear'
      TabOrder = 1
      TabStop = False
      OnClick = BitBtn3Click
    end
    object BitBtn1: TBitBtn
      Left = 468
      Top = 6
      Width = 79
      Height = 30
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 3
      TabStop = False
      OnClick = BitBtn3Click
    end
  end
  object TimerForScan: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerForScanTimer
    Left = 261
    Top = 240
  end
end
