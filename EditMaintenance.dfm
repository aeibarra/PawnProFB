object frmEditMaintenance: TfrmEditMaintenance
  Left = 359
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Maintenance'
  ClientHeight = 147
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 395
    Height = 80
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 352
    ExplicitHeight = 62
    object lblDesc: TLabel
      Left = 82
      Top = 19
      Width = 68
      Height = 16
      Caption = 'Description:'
    end
    object lblInitials: TLabel
      Left = 20
      Top = 19
      Width = 42
      Height = 16
      Caption = 'Initials:'
    end
    object edInitials: TDBEdit
      Left = 18
      Top = 37
      Width = 47
      Height = 24
      CharCase = ecUpperCase
      DataSource = dsMaintenance
      MaxLength = 1
      TabOrder = 0
    end
    object edDescription: TDBEdit
      Left = 80
      Top = 37
      Width = 298
      Height = 24
      DataSource = dsMaintenance
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 89
    Width = 395
    Height = 55
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 85
    object btnSave: TRzBitBtn
      Left = 188
      Top = 9
      Width = 92
      Height = 36
      Default = True
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ImageIndex = 5
      Images = DM.ImageListBtn
      Spacing = -5
    end
    object btnCancel: TRzBitBtn
      Left = 290
      Top = 9
      Width = 88
      Height = 36
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
    Left = 42
    Top = 74
  end
end
