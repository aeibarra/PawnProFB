object frmBackupDB: TfrmBackupDB
  Left = 330
  Top = 152
  BorderStyle = bsDialog
  Caption = 'Database Backup'
  ClientHeight = 280
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 20
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 208
    Width = 623
    Height = 69
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      623
      69)
    object btnClose: TBitBtn
      Left = 490
      Top = 12
      Width = 117
      Height = 44
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      Spacing = 10
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object btnViewBackupLog: TBitBtn
      Left = 262
      Top = 12
      Width = 170
      Height = 44
      Caption = 'View Backup log'
      ImageIndex = 29
      ImageName = 'actActiveIventory'
      Images = DM.vilMain24
      TabOrder = 1
      OnClick = btnViewBackupLogClick
    end
    object btnBackUp: TBitBtn
      Left = 14
      Top = 12
      Width = 198
      Height = 44
      Caption = 'Backup Database'
      ImageIndex = 24
      ImageName = 'actBackupDB'
      Images = DM.vilMain24
      Spacing = 10
      TabOrder = 0
      OnClick = btnBackUpClick
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 623
    Height = 199
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 30
      Top = 54
      Width = 136
      Height = 20
      Caption = 'Backup Database to:'
    end
    object SpeedButton1: TSpeedButton
      Left = 554
      Top = 76
      Width = 26
      Height = 28
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object RzLabel1: TRzLabel
      Left = 31
      Top = 113
      Width = 167
      Height = 20
      Caption = 'Backup Images to Folder:'
      FocusControl = edImageDirectory
      Transparent = True
    end
    object btnSelectFolder: TRzToolButton
      Left = 555
      Top = 135
      Height = 26
      Flat = False
      ShowCaption = True
      UseToolbarShowCaption = False
      Caption = '...'
      OnClick = btnSelectFolderClick
    end
    object lblProgress: TLabel
      Left = 47
      Top = 169
      Width = 78
      Height = 20
      Caption = 'lblProgress'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edBckPath: TEdit
      Left = 31
      Top = 76
      Width = 517
      Height = 28
      TabOrder = 0
    end
    object chkDiBackupWhenClosingApp: TCheckBox
      Left = 31
      Top = 19
      Width = 295
      Height = 23
      Caption = ' Do backup when closing application'
      TabOrder = 1
    end
    object edImageDirectory: TRzEdit
      Left = 31
      Top = 135
      Width = 517
      Height = 28
      Text = ''
      TabOrder = 2
    end
  end
end
