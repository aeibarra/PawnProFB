object frmViewSentTickets: TfrmViewSentTickets
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'View Sent Tickets'
  ClientHeight = 591
  ClientWidth = 1296
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
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 79
    Width = 1290
    Height = 439
    Align = alClient
    Caption = 'Sent Tickets'
    TabOrder = 1
    ExplicitWidth = 847
    ExplicitHeight = 365
    object grSentTickets: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 1280
      Height = 409
      Align = alClient
      DataSource = dsSent
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = grSentTicketsDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'SUBMITTED_AT'
          Title.Caption = 'Sent'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRAN_DATE'
          Title.Caption = 'Date'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRAN_TYPE'
          Title.Caption = 'Type'
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRAN_TICKET_NO'
          Title.Caption = 'Ticket'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUSTOMER'
          Title.Caption = 'Customer'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITEM_COUNT'
          Title.Caption = 'Items'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHOTOS_SENT'
          Title.Caption = 'Photos'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IDS_SENT'
          Title.Caption = 'IDs'
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OUTCOME'
          Title.Caption = 'Result'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DETAIL'
          Title.Caption = 'Detail'
          Width = 339
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRANSACTION_NO'
          Title.Caption = 'Tran #'
          Width = 70
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 524
    Width = 1290
    Height = 64
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 450
    ExplicitWidth = 847
    DesignSize = (
      1290
      64)
    object lblCount: TLabel
      Left = 16
      Top = 24
      Width = 4
      Height = 20
      Caption = ' '
    end
    object btnExit: TBitBtn
      Left = 1177
      Top = 11
      Width = 100
      Height = 43
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 2
      TabOrder = 0
      OnClick = btnExitClick
      ExplicitLeft = 734
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1290
    Height = 70
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 847
    object lblSentFrom: TLabel
      Left = 27
      Top = 13
      Width = 63
      Height = 14
      Caption = 'Sent From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSentTo: TLabel
      Left = 154
      Top = 13
      Width = 48
      Height = 14
      Caption = 'Sent To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edSentFrom: TRzDateTimeEdit
      Left = 27
      Top = 31
      Width = 121
      Height = 28
      EditType = etDate
      TabOrder = 0
    end
    object edSentTo: TRzDateTimeEdit
      Left = 154
      Top = 31
      Width = 121
      Height = 28
      EditType = etDate
      TabOrder = 1
    end
    object btnRefresh: TRzBitBtn
      Left = 302
      Top = 23
      Width = 116
      Height = 36
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = btnRefreshClick
    end
  end
  object clnSent: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 640
    Top = 128
  end
  object dsSent: TDataSource
    DataSet = clnSent
    Left = 720
    Top = 128
  end
end
