object frmReceiveStock: TfrmReceiveStock
  Left = 0
  Top = 0
  Caption = 'Receive Stock'
  ClientHeight = 767
  ClientWidth = 1263
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 1000
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 20
  object Splitter1: TSplitter
    Left = 0
    Top = 383
    Width = 1263
    Height = 5
    Cursor = crVSplit
    Align = alTop
    MinSize = 150
    ExplicitWidth = 1300
  end
  object gbReceipts: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1257
    Height = 377
    Align = alTop
    Caption = ' Receipts '
    TabOrder = 0
    ExplicitWidth = 1294
    object pnReceiptButtons: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 316
      Width = 1247
      Height = 56
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 1284
      object lblTotals: TLabel
        Left = 600
        Top = 16
        Width = 4
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnNewR: TBitBtn
        Left = 37
        Top = 7
        Width = 110
        Height = 43
        Hint = 'F7'
        Caption = ' New'
        ImageIndex = 15
        ImageName = 'actAddFld01'
        Images = DM.vilMain24
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnNewRClick
      end
      object btnEditR: TBitBtn
        Left = 171
        Top = 7
        Width = 110
        Height = 43
        Hint = 'F8'
        Caption = ' Edit'
        ImageIndex = 14
        ImageName = 'actEdit02'
        Images = DM.vilMain24
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnEditRClick
      end
      object btnVoidR: TBitBtn
        Left = 331
        Top = 7
        Width = 150
        Height = 43
        Hint = 
          'Void a receipt entered by mistake: its items are deleted (logged' +
          ')'
        Caption = 'Void Receipt'
        ImageIndex = 61
        ImageName = 'Cancel'
        Images = DM.vilMain20
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        Spacing = 10
        TabOrder = 2
        OnClick = btnVoidRClick
      end
    end
    object dbgReceipts: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 1247
      Height = 285
      Align = alClient
      DataSource = dsReceipts
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = dbgReceiptsDrawColumnCell
      OnDblClick = btnEditRClick
      Columns = <
        item
          Expanded = False
          FieldName = 'STOCK_RECEIPT_NO'
          Title.Caption = 'Receipt #'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RECEIVED_DATE'
          Title.Caption = 'Received'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUPPLIER_NAME'
          Title.Caption = 'Supplier'
          Width = 280
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INVOICE_NO'
          Title.Caption = 'Invoice #'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INVOICE_DATE'
          Title.Caption = 'Invoice Date'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INVOICE_TOTAL'
          Title.Caption = 'Invoice Total'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITEMS'
          Title.Caption = 'Items'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITEMS_COST'
          Title.Caption = 'Items Cost'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PAY_TYPE'
          Title.Caption = 'Paid by'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Title.Caption = 'Status'
          Width = 80
          Visible = True
        end>
    end
  end
  object gbItems: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 391
    Width = 1257
    Height = 311
    Align = alClient
    Caption = ' Items Received '
    TabOrder = 1
    ExplicitWidth = 1294
    ExplicitHeight = 404
    object pnItemButtons: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 250
      Width = 1247
      Height = 56
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 343
      ExplicitWidth = 1284
      object btnAddItem: TBitBtn
        Left = 37
        Top = 6
        Width = 110
        Height = 43
        Caption = ' Add'
        ImageIndex = 15
        ImageName = 'actAddFld01'
        Images = DM.vilMain24
        TabOrder = 0
        OnClick = btnAddItemClick
      end
      object btnEditItem: TBitBtn
        Left = 171
        Top = 6
        Width = 110
        Height = 43
        Caption = ' Edit'
        ImageIndex = 14
        ImageName = 'actEdit02'
        Images = DM.vilMain24
        TabOrder = 1
        OnClick = btnEditItemClick
      end
      object btnRemoveItem: TBitBtn
        Left = 331
        Top = 6
        Width = 120
        Height = 43
        Hint = 'Take an unsold item off this receipt (it is deleted, and logged)'
        Caption = 'Remove'
        ImageIndex = 22
        ImageName = 'actTrash'
        Images = DM.vilMain24
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnRemoveItemClick
      end
    end
    object dbgItems: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 1247
      Height = 219
      Align = alClient
      DataSource = dsLines
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = dbgItemsDrawColumnCell
      OnDblClick = btnEditItemClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'PIECE_NO'
          Title.Alignment = taCenter
          Title.Caption = 'Group'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BARCODE'
          Title.Caption = 'Barcode'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIPTION'
          Title.Caption = 'Description'
          Width = 380
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CATEGORY'
          Title.Caption = 'Category'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KT'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WEIGHT'
          Title.Caption = 'Weight'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIT_COST'
          Title.Caption = 'Cost'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIT_PRICE'
          Title.Caption = 'Price'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Title.Caption = 'Status'
          Width = 110
          Visible = True
        end>
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 705
    Width = 1263
    Height = 62
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 798
    ExplicitWidth = 1300
    DesignSize = (
      1263
      62)
    object btnClose: TBitBtn
      Left = 1121
      Top = 8
      Width = 131
      Height = 46
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitLeft = 1158
    end
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 1180
    Top = 120
  end
  object qryReceipts: TFDQuery
    AfterScroll = qryReceiptsAfterScroll
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 1000
    Top = 120
  end
  object dsReceipts: TDataSource
    DataSet = qryReceipts
    Left = 1000
    Top = 176
  end
  object qryLines: TFDQuery
    Connection = DM.ConnFB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 1000
    Top = 480
  end
  object dsLines: TDataSource
    DataSet = qryLines
    OnDataChange = dsLinesDataChange
    Left = 1000
    Top = 536
  end
  object qryItem: TFDQuery
    AfterPost = qryItemAfterPost
    OnNewRecord = qryItemNewRecord
    Connection = DM.ConnFB
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.UpdateTableName = 'INVENTORY_ITEMS'
    UpdateOptions.KeyFields = 'INV_ITEM_NO'
    UpdateOptions.AutoIncFields = 'INV_ITEM_NO'
    Left = 1090
    Top = 480
  end
end
