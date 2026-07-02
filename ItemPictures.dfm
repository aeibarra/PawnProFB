object frmItemPictures: TfrmItemPictures
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Item Pictures'
  ClientHeight = 662
  ClientWidth = 1190
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 20
  object gbFooter: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 584
    Width = 1184
    Height = 75
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 520
    ExplicitWidth = 1092
    DesignSize = (
      1184
      75)
    object btnExit: TBitBtn
      Left = 1060
      Top = 14
      Width = 109
      Height = 49
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      Margin = 10
      ModalResult = 2
      TabOrder = 0
      OnClick = btnExitClick
      ExplicitLeft = 968
    end
    object btnTakeNewPic: TRzBitBtn
      Left = 16
      Top = 14
      Width = 129
      Height = 49
      Caption = 'Take New Picture'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnTakeNewPicClick
      ImageIndex = 15
      Images = DM.ImageListBtn
      Spacing = 0
    end
    object btnReTakePic: TRzBitBtn
      Left = 159
      Top = 14
      Width = 129
      Height = 49
      Caption = 'Re-take Picture'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnReTakePicClick
      ImageIndex = 16
      Images = DM.ImageListBtn
      Spacing = 0
    end
  end
  object gbImageList: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 358
    Height = 575
    Align = alLeft
    Caption = 'Images'
    TabOrder = 1
    ExplicitHeight = 511
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 25
      Width = 348
      Height = 545
      Align = alClient
      DataSource = dsItemImages
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'IMAGES_DATA_NO'
          Title.Alignment = taCenter
          Title.Caption = 'No'
          Width = 47
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMAGE_DESC'
          Title.Caption = 'Image Description'
          Width = 249
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 364
    Top = 0
    Width = 826
    Height = 581
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 636
    ExplicitTop = 96
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pnImgTop: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 820
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 130
      ExplicitTop = 38
      ExplicitWidth = 185
      object lblZoom: TLabel
        Left = 300
        Top = 11
        Width = 36
        Height = 20
        Caption = '100%'
      end
      object btnZoomOut: TButton
        Left = 8
        Top = 4
        Width = 75
        Height = 33
        Caption = 'Zoom -'
        TabOrder = 0
        OnClick = btnZoomOutClick
      end
      object btnZoomIn: TButton
        Left = 87
        Top = 4
        Width = 75
        Height = 33
        Caption = 'Zoom +'
        TabOrder = 1
        OnClick = btnZoomInClick
      end
      object btnZoomFit: TButton
        Left = 166
        Top = 4
        Width = 60
        Height = 33
        Caption = 'Fit'
        TabOrder = 2
        OnClick = btnZoomFitClick
      end
      object btnZoom100: TButton
        Left = 230
        Top = 4
        Width = 64
        Height = 33
        Caption = '100%'
        TabOrder = 3
        OnClick = btnZoom100Click
      end
    end
    object sbImage: TScrollBox
      Left = 0
      Top = 47
      Width = 826
      Height = 534
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 1
      object ImageJewelrySet: TImage
        Left = 0
        Top = 0
        Width = 820
        Height = 500
        Stretch = True
        OnMouseDown = ImageJewelrySetMouseDown
        OnMouseMove = ImageJewelrySetMouseMove
        OnMouseUp = ImageJewelrySetMouseUp
      end
    end
  end
  object qryItemImages: TFDQuery
    AfterScroll = qryItemImagesAfterScroll
    OnNewRecord = qryItemImagesNewRecord
    Connection = DM.ConnFB
    UpdateOptions.UpdateTableName = 'IMAGES_DATA'
    UpdateOptions.KeyFields = 'IMAGES_DATA_NO'
    UpdateOptions.AutoIncFields = 'IMAGES_DATA_NO'
    SQL.Strings = (
      'select'
      '  IMAGES_DATA_NO,'
      '  IMAGE_TYPE_NO,'
      '  IMAG_REF_TO_ROW_NO,'
      '  IMAGE_DESC,'
      '  IMAGE_DATA,'
      '  CREATED'
      'from IMAGES_DATA'
      
        'where IMAGE_TYPE_NO = :IMAGE_TYPE_NO and IMAG_REF_TO_ROW_NO = :R' +
        'EF_ROW_NO'
      'order by IMAGES_DATA_NO')
    Left = 55
    Top = 75
    ParamData = <
      item
        Name = 'IMAGE_TYPE_NO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'REF_ROW_NO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object qryItemImagesIMAGES_DATA_NO: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IMAGES_DATA_NO'
      Origin = 'IMAGES_DATA_NO'
    end
    object qryItemImagesIMAGE_TYPE_NO: TIntegerField
      FieldName = 'IMAGE_TYPE_NO'
      Origin = 'IMAGE_TYPE_NO'
    end
    object qryItemImagesIMAG_REF_TO_ROW_NO: TIntegerField
      FieldName = 'IMAG_REF_TO_ROW_NO'
      Origin = 'IMAG_REF_TO_ROW_NO'
    end
    object qryItemImagesIMAGE_DESC: TWideStringField
      FieldName = 'IMAGE_DESC'
      Origin = 'IMAGE_DESC'
      Size = 125
    end
    object qryItemImagesIMAGE_DATA: TBlobField
      FieldName = 'IMAGE_DATA'
      Origin = 'IMAGE_DATA'
    end
    object qryItemImagesCREATED: TSQLTimeStampField
      FieldName = 'CREATED'
      Origin = 'CREATED'
    end
  end
  object dsItemImages: TDataSource
    DataSet = qryItemImages
    Left = 57
    Top = 139
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 523
    Top = 103
  end
end
