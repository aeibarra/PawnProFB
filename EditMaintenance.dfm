object frmEditMaintenance: TfrmEditMaintenance
  Left = 359
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Maintenance'
  ClientHeight = 165
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 20
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 465
    Height = 89
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 100
    object lblDesc: TLabel
      Left = 82
      Top = 19
      Width = 79
      Height = 20
      Caption = 'Description:'
    end
    object lblInitials: TLabel
      Left = 20
      Top = 19
      Width = 46
      Height = 20
      Caption = 'Initials:'
    end
    object edInitials: TDBEdit
      Left = 18
      Top = 40
      Width = 47
      Height = 28
      CharCase = ecUpperCase
      DataSource = dsMaintenance
      MaxLength = 1
      TabOrder = 0
    end
    object edDescription: TDBEdit
      Left = 80
      Top = 40
      Width = 298
      Height = 28
      DataSource = dsMaintenance
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 98
    Width = 465
    Height = 64
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 111
    object btnSave: TRzBitBtn
      Left = 184
      Top = 11
      Width = 96
      Height = 41
      Default = True
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 19
      Images = DM.vilMain24
      Spacing = -5
    end
    object btnCancel: TRzBitBtn
      Left = 293
      Top = 11
      Width = 96
      Height = 41
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
      ImageIndex = 3
      Images = DM.ImageListBtn
      Spacing = -5
    end
  end
  object dsMaintenance: TDataSource
    Left = 341
    Top = 25
  end
end
