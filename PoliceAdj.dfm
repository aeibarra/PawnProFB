object frmPoliceRptAdj: TfrmPoliceRptAdj
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Police Report Adj.'
  ClientHeight = 200
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 17
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 135
    Width = 283
    Height = 62
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      283
      62)
    object btnCancel: TBitBtn
      Left = 166
      Top = 10
      Width = 80
      Height = 44
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TRzBitBtn
      Left = 39
      Top = 10
      Width = 86
      Height = 44
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain
      Spacing = 0
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 283
    Height = 126
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 25
      Width = 113
      Height = 17
      Caption = 'Top Margin Height:'
    end
    object Label2: TLabel
      Left = 56
      Top = 52
      Width = 78
      Height = 17
      Caption = 'Detail Height:'
    end
    object Label3: TLabel
      Left = 51
      Top = 79
      Width = 83
      Height = 17
      Caption = 'Footer Height:'
    end
    object lblDetail: TLabel
      Left = 188
      Top = 54
      Width = 47
      Height = 17
      Caption = 'lblDetail'
    end
    object lblFooter: TLabel
      Left = 188
      Top = 78
      Width = 52
      Height = 17
      Caption = 'lblFooter'
    end
    object edAdjTopMargin: TMaskEdit
      Left = 140
      Top = 22
      Width = 26
      Height = 25
      TabOrder = 0
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 166
      Top = 22
      Width = 15
      Height = 25
      Associate = edAdjTopMargin
      Max = 32000
      TabOrder = 1
    end
    object edDetail: TMaskEdit
      Left = 140
      Top = 49
      Width = 26
      Height = 25
      TabOrder = 2
      Text = '0'
    end
    object UpDown2: TUpDown
      Left = 166
      Top = 49
      Width = 15
      Height = 25
      Associate = edDetail
      Max = 32000
      TabOrder = 3
    end
    object edFooter: TMaskEdit
      Left = 140
      Top = 76
      Width = 26
      Height = 25
      TabOrder = 4
      Text = '0'
    end
    object UpDown3: TUpDown
      Left = 166
      Top = 76
      Width = 15
      Height = 25
      Associate = edFooter
      Max = 32000
      TabOrder = 5
    end
  end
end
