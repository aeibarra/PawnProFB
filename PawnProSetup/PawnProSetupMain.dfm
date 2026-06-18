object frmPawnProSetupMain: TfrmPawnProSetupMain
  Left = 0
  Top = 0
  Caption = 'PawnPro Setup'
  ClientHeight = 584
  ClientWidth = 1165
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 1061
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 20
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 568
    Top = 3
    Width = 594
    Height = 578
    Align = alClient
    Caption = 'Log'
    TabOrder = 0
    object MemoLog: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 584
      Height = 548
      Align = alClient
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 559
    Height = 578
    Align = alLeft
    Caption = 'Installation Steps'
    TabOrder = 1
    object lblInstallFolder: TLabel
      Left = 25
      Top = 28
      Width = 231
      Height = 20
      Caption = 'Local Computer installation Folder:'
    end
    object lblHost: TLabel
      Left = 25
      Top = 98
      Width = 97
      Height = 20
      Caption = 'Firebird server:'
    end
    object lblDatabase: TLabel
      Left = 25
      Top = 158
      Width = 100
      Height = 20
      Caption = 'Database path:'
    end
    object lblPort: TLabel
      Left = 442
      Top = 98
      Width = 29
      Height = 20
      Caption = 'Port:'
    end
    object lblCurrentPassword: TLabel
      Left = 25
      Top = 218
      Width = 176
      Height = 20
      Caption = 'Current SYSDBA password:'
    end
    object lblNewPassword: TLabel
      Left = 25
      Top = 278
      Width = 158
      Height = 20
      Caption = 'New SYSDBA password:'
    end
    object btnBrowseInstallFolder: TRzToolbarButton
      Left = 442
      Top = 51
      Width = 43
      Height = 34
      Caption = '...'
      Flat = False
      OnClick = btnBrowseInstallFolderClick
      HotNumGlyphs = 0
    end
    object edInstallFolder: TEdit
      Left = 25
      Top = 56
      Width = 410
      Height = 28
      TabOrder = 0
      Text = 'C:\Pawn\'
      OnChange = edInstallFolderChange
    end
    object edHost: TEdit
      Left = 25
      Top = 122
      Width = 410
      Height = 28
      TabOrder = 1
      Text = 'localhost'
    end
    object edPort: TEdit
      Left = 442
      Top = 122
      Width = 70
      Height = 28
      TabOrder = 2
      Text = '3050'
    end
    object edDatabase: TEdit
      Left = 25
      Top = 182
      Width = 486
      Height = 28
      TabOrder = 3
      Text = 'C:\Pawn\PAWNDATA.FDB'
      OnChange = edDatabaseChange
    end
    object edCurrentPassword: TEdit
      Left = 25
      Top = 242
      Width = 486
      Height = 28
      PasswordChar = '*'
      TabOrder = 4
      Text = 'masterkey'
    end
    object edNewPassword: TEdit
      Left = 25
      Top = 302
      Width = 486
      Height = 28
      PasswordChar = '*'
      TabOrder = 5
    end
    object btnCopyPawnProFiles: TRzButton
      Left = 25
      Top = 380
      Width = 446
      Height = 56
      Alignment = taLeftJustify
      Caption = '    01 - Copy Files Needed to Run PawnPro'
      TabOrder = 6
      OnClick = btnCopyPawnProFilesClick
    end
    object btnTestConnection: TRzButton
      Left = 25
      Top = 504
      Width = 215
      Height = 56
      Alignment = taLeftJustify
      Caption = '    03 - Test Encrypted INI'
      TabOrder = 7
      OnClick = btnTestConnectionClick
    end
    object btnEnterStoreInfo: TRzButton
      Left = 25
      Top = 442
      Width = 445
      Height = 56
      Alignment = taLeftJustify
      Caption = '    02 - Set Firebird Password + Encrypt INI'
      TabOrder = 8
      OnClick = btnEnterStoreInfoClick
    end
    object chkIsDBLocal: TCheckBox
      Left = 25
      Top = 348
      Width = 185
      Height = 17
      Caption = 'Is Database Local?'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 9
    end
  end
end
