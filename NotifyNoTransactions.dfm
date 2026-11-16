object frmNotifyNoTransactions: TfrmNotifyNoTransactions
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Notify LeadsOnline - No Transactions for the Day'
  ClientHeight = 420
  ClientWidth = 820
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
    Caption = 'Previous notifications'
    Alignment = taLeftJustify
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object grHistory: TDBGrid
      AlignWithMargins = True
      Left = 8
      Top = 32
      Width = 424
      Height = 380
      Align = alClient
      DataSource = dsHistory
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
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
    Width = 380
    Height = 420
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    object lblDate: TRzLabel
      Left = 24
      Top = 40
      Width = 158
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
      Caption = ''
    end
    object edDate: TRzDateTimeEdit
      Left = 24
      Top = 66
      Width = 150
      Height = 28
      EditType = etDate
      TabOrder = 0
      OnChange = edDateChange
    end
    object btnNotify: TRzToolButton
      Left = 24
      Top = 230
      Width = 180
      Height = 44
      Flat = False
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      Caption = 'Notify LeadsOnline'
      OnClick = btnNotifyClick
    end
    object btnCancel: TRzToolButton
      Left = 220
      Top = 230
      Width = 130
      Height = 44
      Flat = False
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      Caption = 'Close'
      OnClick = btnCancelClick
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
    Left = 600
    Top = 340
  end
  object dsHistory: TDataSource
    DataSet = clnHistory
    Left = 680
    Top = 340
  end
end
