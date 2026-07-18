object frmSetupNewInstall: TfrmSetupNewInstall
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'PawnPro Setup - New Install'
  ClientHeight = 580
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  TextHeight = 17
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 704
    Height = 520
    ActivePage = tsDone
    TabOrder = 0
    object tsLocation: TTabSheet
      Caption = '1. Install location and database'
      DesignSize = (
        696
        488)
      object lblInstallFolder: TLabel
        Left = 24
        Top = 19
        Width = 158
        Height = 17
        Caption = 'Install to folder (copy files):'
      end
      object lblHost: TLabel
        Left = 24
        Top = 60
        Width = 77
        Height = 17
        Caption = 'Firebird host:'
      end
      object lblDatabase: TLabel
        Left = 24
        Top = 100
        Width = 88
        Height = 17
        Caption = 'Database path:'
      end
      object lblPort: TLabel
        Left = 24
        Top = 140
        Width = 27
        Height = 17
        Caption = 'Port:'
      end
      object lblCurrentPassword: TLabel
        Left = 24
        Top = 180
        Width = 156
        Height = 17
        Caption = 'Current SYSDBA password:'
      end
      object lblTestResult: TRzLabel
        Left = 319
        Top = 220
        Width = 374
        Height = 76
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        WordWrap = True
      end
      object edInstallFolder: TEdit
        Left = 208
        Top = 16
        Width = 410
        Height = 25
        TabOrder = 0
        Text = 'C:\Pawn\'
        OnChange = edInstallFolderChange
      end
      object btnBrowseInstallFolder: TButton
        Left = 624
        Top = 14
        Width = 50
        Height = 28
        Caption = '...'
        TabOrder = 1
        OnClick = btnBrowseInstallFolderClick
      end
      object edHost: TEdit
        Left = 208
        Top = 57
        Width = 221
        Height = 25
        TabOrder = 2
        Text = 'localhost'
      end
      object edDatabase: TEdit
        Left = 208
        Top = 97
        Width = 410
        Height = 25
        TabOrder = 3
        Text = 'C:\Pawn\PAWNDATA.FDB'
      end
      object edPort: TEdit
        Left = 208
        Top = 137
        Width = 80
        Height = 25
        TabOrder = 4
        Text = '3050'
      end
      object edCurrentPassword: TEdit
        Left = 208
        Top = 177
        Width = 250
        Height = 25
        PasswordChar = '*'
        TabOrder = 5
        Text = 'masterkey'
      end
      object btnTest: TButton
        Left = 208
        Top = 220
        Width = 105
        Height = 28
        Caption = 'Test connection'
        TabOrder = 6
        OnClick = btnTestClick
      end
    end
    object tsStore: TTabSheet
      Caption = '2. Store identity'
      ImageIndex = 1
      object lblStoreName: TLabel
        Left = 16
        Top = 12
        Width = 70
        Height = 17
        Caption = 'Store name:'
      end
      object lblStoreAddr: TLabel
        Left = 16
        Top = 44
        Width = 51
        Height = 17
        Caption = 'Address:'
      end
      object lblStoreCityStZip: TLabel
        Left = 16
        Top = 76
        Width = 66
        Height = 17
        Caption = 'City, ST ZIP:'
      end
      object lblStorePhone: TLabel
        Left = 16
        Top = 108
        Width = 39
        Height = 17
        Caption = 'Phone:'
      end
      object lblStorePoliceId: TLabel
        Left = 16
        Top = 140
        Width = 53
        Height = 17
        Caption = 'Police ID:'
      end
      object lblStoreNumber: TLabel
        Left = 16
        Top = 172
        Width = 56
        Height = 17
        Caption = 'Store no.:'
      end
      object lblInterestRate: TLabel
        Left = 16
        Top = 212
        Width = 88
        Height = 17
        Caption = 'Interest rate %:'
      end
      object lblSalesTax: TLabel
        Left = 220
        Top = 212
        Width = 69
        Height = 17
        Caption = 'Sales tax %:'
      end
      object lblMaturityMonths: TLabel
        Left = 16
        Top = 244
        Width = 106
        Height = 17
        Caption = 'Maturity (months):'
      end
      object lblDefaultMonths: TLabel
        Left = 220
        Top = 244
        Width = 99
        Height = 17
        Caption = 'Default (months):'
      end
      object edStoreName: TEdit
        Left = 130
        Top = 9
        Width = 540
        Height = 25
        TabOrder = 0
      end
      object edStoreAddr: TEdit
        Left = 130
        Top = 41
        Width = 540
        Height = 25
        TabOrder = 1
      end
      object edStoreCityStZip: TEdit
        Left = 130
        Top = 73
        Width = 540
        Height = 25
        TabOrder = 2
      end
      object edStorePhone: TEdit
        Left = 130
        Top = 105
        Width = 250
        Height = 25
        TabOrder = 3
      end
      object edStorePoliceId: TEdit
        Left = 130
        Top = 137
        Width = 250
        Height = 25
        TabOrder = 4
      end
      object edStoreNumber: TEdit
        Left = 130
        Top = 169
        Width = 250
        Height = 25
        TabOrder = 5
      end
      object edInterestRate: TEdit
        Left = 130
        Top = 209
        Width = 60
        Height = 25
        TabOrder = 6
      end
      object edSalesTax: TEdit
        Left = 320
        Top = 209
        Width = 60
        Height = 25
        TabOrder = 7
      end
      object edMaturityMonths: TEdit
        Left = 144
        Top = 241
        Width = 60
        Height = 25
        TabOrder = 8
      end
      object edDefaultMonths: TEdit
        Left = 344
        Top = 241
        Width = 60
        Height = 25
        TabOrder = 9
      end
      object rgDateCalc: TRadioGroup
        Left = 16
        Top = 275
        Width = 200
        Height = 60
        Caption = 'Pawn date calc base'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Days'
          'Months')
        TabOrder = 10
      end
      object rgWeightUnit: TRadioGroup
        Left = 230
        Top = 275
        Width = 200
        Height = 60
        Caption = 'Default weight unit'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Pennyweight'
          'Gram')
        TabOrder = 11
      end
      object gbLeads: TGroupBox
        Left = 16
        Top = 345
        Width = 654
        Height = 140
        Caption = 'LeadsOnline (optional)'
        TabOrder = 12
        object lblLeadsStoreId: TLabel
          Left = 16
          Top = 28
          Width = 50
          Height = 17
          Caption = 'Store ID:'
        end
        object lblLeadsFtp: TLabel
          Left = 16
          Top = 60
          Width = 74
          Height = 17
          Caption = 'FTP address:'
        end
        object lblLeadsUser: TLabel
          Left = 16
          Top = 92
          Width = 62
          Height = 17
          Caption = 'Username:'
        end
        object lblLeadsPassword: TLabel
          Left = 350
          Top = 92
          Width = 59
          Height = 17
          Caption = 'Password:'
        end
        object edLeadsStoreId: TEdit
          Left = 130
          Top = 25
          Width = 200
          Height = 25
          TabOrder = 0
        end
        object edLeadsFtp: TEdit
          Left = 130
          Top = 57
          Width = 510
          Height = 25
          TabOrder = 1
        end
        object edLeadsUser: TEdit
          Left = 130
          Top = 89
          Width = 200
          Height = 25
          TabOrder = 2
        end
        object edLeadsPassword: TEdit
          Left = 425
          Top = 89
          Width = 215
          Height = 25
          PasswordChar = '*'
          TabOrder = 3
        end
        object chkFtpPassive: TCheckBox
          Left = 16
          Top = 116
          Width = 200
          Height = 17
          Caption = 'FTP passive mode'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
      end
    end
    object tsConfirm: TTabSheet
      Caption = '3. Confirm and apply'
      ImageIndex = 2
      object memSummary: TMemo
        Left = 16
        Top = 16
        Width = 660
        Height = 220
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnApply: TButton
        Left = 16
        Top = 248
        Width = 128
        Height = 32
        Caption = 'Apply now'
        TabOrder = 1
        OnClick = btnApplyClick
      end
      object memProgress: TMemo
        Left = 16
        Top = 290
        Width = 660
        Height = 192
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
    object tsDone: TTabSheet
      Caption = '4. Done'
      ImageIndex = 3
      object lblDoneHeader: TLabel
        Left = 16
        Top = 16
        Width = 368
        Height = 21
        Caption = 'Setup complete. Save the password below NOW.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblRecoveryPath: TLabel
        Left = 16
        Top = 116
        Width = 4
        Height = 17
      end
      object lblSmokeTestResult: TLabel
        Left = 16
        Top = 144
        Width = 4
        Height = 17
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edNewPassword: TEdit
        Left = 16
        Top = 56
        Width = 540
        Height = 34
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object btnCopyPassword: TButton
        Left = 572
        Top = 56
        Width = 104
        Height = 38
        Caption = 'Copy'
        TabOrder = 1
        OnClick = btnCopyPasswordClick
      end
      object memDoneNotes: TMemo
        Left = 16
        Top = 180
        Width = 660
        Height = 302
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
  end
  object btnBack: TButton
    Left = 360
    Top = 540
    Width = 100
    Height = 32
    Caption = '< Back'
    TabOrder = 1
    OnClick = btnBackClick
  end
  object btnNext: TButton
    Left = 470
    Top = 540
    Width = 120
    Height = 32
    Caption = 'Next >'
    Default = True
    TabOrder = 2
    OnClick = btnNextClick
  end
  object btnCancel: TButton
    Left = 600
    Top = 540
    Width = 110
    Height = 32
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
