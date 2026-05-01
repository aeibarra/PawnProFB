object frmEnterStoneInfo: TfrmEnterStoneInfo
  Left = 638
  Top = 104
  BorderStyle = bsDialog
  Caption = 'Stone Information'
  ClientHeight = 201
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 17
  object GroupBox1: TGroupBox
    Left = 0
    Top = 162
    Width = 430
    Height = 39
    Align = alBottom
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 169
      Top = 10
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TBitBtn
      Left = 86
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Save'
      Default = True
      Glyph.Data = {
        B6010000424DB60100000000000076000000280000001E000000140000000100
        0400000000004001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777770077777777777777777777777777777700778888888888
        888888777887777777007C0008888888000008779087777777007C444FFFFFFF
        444408791087777777007C444F08FFFF444408911088888887007C444F08FFFF
        444409111000000087007C444F08FFFF444491111111111087007C444FFFFFFF
        444911111111111087007C4444444444449111111111111087007C4444444444
        449911111111111087007C4444444444444991111111111087007C44FFFFFFFF
        F44499111111111077007C44FFFFFFFFF44409911099999977007C44F0000F00
        F44408991077777777007C44FFFFFFFFF44408799077777777007C44F00F0000
        F44408779977777777007CCC888888888CCCC777777777777700777777777777
        7777777777777777770077777777777777777777777777777700}
      TabOrder = 0
      OnClick = btnSaveClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 430
    Height = 162
    Align = alClient
    TabOrder = 0
    object Label5: TLabel
      Left = 16
      Top = 64
      Width = 76
      Height = 17
      Caption = 'Stone Shape:'
    end
    object Label6: TLabel
      Left = 135
      Top = 64
      Width = 72
      Height = 17
      Caption = 'Stone Color:'
    end
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 88
      Height = 17
      Caption = 'Stone Number:'
    end
    object Label2: TLabel
      Left = 108
      Top = 16
      Width = 18
      Height = 17
      Caption = 'CT:'
    end
    object Label3: TLabel
      Left = 184
      Top = 16
      Width = 22
      Height = 17
      Caption = 'WT:'
    end
    object Label4: TLabel
      Left = 16
      Top = 112
      Width = 67
      Height = 17
      Caption = 'Stone Type:'
    end
    object DBLookupComboBox4: TDBLookupComboBox
      Left = 16
      Top = 80
      Width = 105
      Height = 25
      DataField = 'StoneShape'
      KeyField = 'J_SHAPE'
      ListField = 'J_SHAPE_DESC'
      ListSource = dsStoneShapes
      TabOrder = 3
    end
    object DBLookupComboBox5: TDBLookupComboBox
      Left = 131
      Top = 80
      Width = 105
      Height = 25
      DataField = 'StoneColor'
      KeyField = 'J_STONE_COLOR'
      ListField = 'J_STONE_DESC'
      ListSource = dsStoneColors
      TabOrder = 4
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 32
      Width = 74
      Height = 25
      DataField = 'StoneNumber'
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 100
      Top = 32
      Width = 65
      Height = 25
      DataField = 'CT'
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 176
      Top = 32
      Width = 65
      Height = 25
      DataField = 'WT'
      TabOrder = 2
    end
    object cbStoneType: TDBComboBox
      Left = 16
      Top = 128
      Width = 145
      Height = 25
      DataField = 'StoneType'
      TabOrder = 5
    end
  end
  object dsStoneShapes: TDataSource
    Left = 272
    Top = 64
  end
  object dsStoneColors: TDataSource
    Left = 360
    Top = 64
  end
  object qryStoneTypes: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'SELECT DISTINCT STONE_TYPE'
      'FROM STONES'
      'WHERE STONE_TYPE IS NOT NULL'
      'ORDER BY STONE_TYPE')
    Left = 272
    Top = 120
    object qryStoneTypesSTONE_TYPE: TStringField
      FieldName = 'STONE_TYPE'
      Origin = 'STONE_TYPE'
      Size = 30
    end
  end
end
