object frmViewBackupHist: TfrmViewBackupHist
  Left = 356
  Top = 353
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Backup History'
  ClientHeight = 404
  ClientWidth = 573
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
    Top = 336
    Width = 567
    Height = 65
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      567
      65)
    object btnClose: TBitBtn
      Left = 449
      Top = 12
      Width = 101
      Height = 41
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 573
    Height = 333
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 22
      Width = 563
      Height = 306
      Align = alClient
      DataSource = dsBckHist
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'BckId'
          Title.Alignment = taCenter
          Title.Caption = 'No'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BckDate'
          Title.Caption = 'Date'
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BckPath'
          Title.Caption = 'Path'
          Width = 320
          Visible = True
        end>
    end
  end
  object qryBckHist: TFDQuery
    Connection = DM.ConnFB
    SQL.Strings = (
      'select first 100'
      '  BCK_ID as "BckId",'
      '  BCK_DATE as "BckDate",'
      '  BCK_PATH as "BckPath"'
      'from BACKUP_HISTORY'
      'order by BCK_ID desc')
    Left = 40
    Top = 80
    object qryBckHistBckId: TIntegerField
      FieldName = 'BckId'
      ReadOnly = True
    end
    object qryBckHistBckDate: TSQLTimeStampField
      FieldName = 'BckDate'
      DisplayFormat = 'mm/dd/yyyy hh:nn am/pm'
    end
    object qryBckHistBckPath: TWideStringField
      FieldName = 'BckPath'
      Size = 120
    end
  end
  object dsBckHist: TDataSource
    DataSet = qryBckHist
    Left = 39
    Top = 141
  end
end
