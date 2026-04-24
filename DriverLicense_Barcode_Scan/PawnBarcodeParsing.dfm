object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 646
  ClientWidth = 1038
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    1038
    646)
  PixelsPerInch = 96
  TextHeight = 19
  object GroupBox1: TGroupBox
    Left = 0
    Top = 592
    Width = 1038
    Height = 54
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 441
    DesignSize = (
      1038
      54)
    object Button1: TButton
      Left = 942
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = Button2Click
    end
    object brtnParseData: TButton
      Left = 128
      Top = 13
      Width = 161
      Height = 25
      Caption = 'Parse Data'
      TabOrder = 2
      OnClick = brtnParseDataClick
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 1022
    Height = 233
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      '@'
      
        'ANSI 636010090002DL00410250ZF02910067DLDAQI160005651820DCSIBARRA' +
        'DDENDACALBERTODDFNDADENRIQUEDDGNDCAEDCBADCDNONEDBD04172019DBB052' +
        '21965DBA05222027DBC1DAU068 INDAG3654 NW 20TH STDAIMIAMIDAJFLDAK3' +
        '31426806  DCFX631904170710DCGUSADCK0100372324019086DDAFDDB031620' +
        '17DDK1'
      'ZFZFAZFBZFCSAFE DRIVERZFDZFEZFFZFGZFHZFIZFJ0037160707ZFK'
      '')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Memo3: TMemo
    Left = 8
    Top = 247
    Width = 553
    Height = 329
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitHeight = 178
  end
  object Memo2: TMemo
    Left = 584
    Top = 247
    Width = 433
    Height = 281
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssBoth
    TabOrder = 3
    ExplicitHeight = 130
  end
end
