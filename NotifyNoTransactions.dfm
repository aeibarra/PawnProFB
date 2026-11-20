object frmNotifyNoTransactions: TfrmNotifyNoTransactions
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Notify LeadsOnline - No Transactions for the Day'
  ClientHeight = 420
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 20
  object pnLeft: TRzPanel
    Left = 0
    Top = 0
    Width = 440
    Height = 420
    Align = alLeft
    BorderOuter = fsNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object lblHistory: TRzLabel
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 418
      Height = 17
      Align = alTop
      Caption = 'Previous notifications'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 135
    end
    object grHistory: TDBGrid
      AlignWithMargins = True
      Left = 11
      Top = 34
      Width = 418
      Height = 375
      Align = alClient
      DataSource = dsHistory
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ACTIVITY_DATE'
          Title.Caption = 'Date'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DECLARED_AT'
          Title.Caption = 'Notified'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RESULT'
          Title.Caption = 'Result'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DETAIL'
          Title.Caption = 'Detail'
          Width = 300
          Visible = True
        end>
    end
  end
  object pnRight: TRzPanel
    Left = 440
    Top = 0
    Width = 241
    Height = 420
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    ExplicitWidth = 380
    object lblDate: TRzLabel
      Left = 25
      Top = 40
      Width = 162
      Height = 20
      Caption = 'Day with no transactions'
    end
    object lblResult: TRzLabel
      Left = 24
      Top = 130
      Width = 330
      Height = 60
      AutoSize = False
      WordWrap = True
    end
    object btnNotify: TRzToolButton
      Left = 14
      Top = 113
      Width = 185
      Height = 48
      Flat = False
      ImageIndex = 33
      Images = DM.vilMain24
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      Caption = 'Notify LeadsOnline'
      OnClick = btnNotifyClick
    end
    object btnCancel: TRzToolButton
      Left = 41
      Top = 365
      Width = 130
      Height = 44
      Flat = False
      ImageIndex = 2
      Images = DM.vilMain24
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      Caption = 'Close'
      OnClick = btnCancelClick
    end
    object edDate: TRzDateTimeEdit
      Left = 27
      Top = 66
      Width = 158
      Height = 28
      EditType = etDate
      TabOrder = 0
      OnChange = edDateChange
    end
  end
  object clnHistory: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 53
    Top = 79
  end
  object dsHistory: TDataSource
    DataSet = clnHistory
    Left = 54
    Top = 139
  end
end
