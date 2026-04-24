object frmItemPictures: TfrmItemPictures
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Item Pictures'
  ClientHeight = 572
  ClientWidth = 995
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 16
  object ImageJewelrySet: TImage
    Left = 321
    Top = 0
    Width = 674
    Height = 491
    Align = alClient
    AutoSize = True
    ExplicitLeft = 1019
    ExplicitWidth = 594
  end
  object gbFooter: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 494
    Width = 989
    Height = 75
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      989
      75)
    object btnExit: TBitBtn
      Left = 865
      Top = 14
      Width = 109
      Height = 49
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = ' &Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain
      Margin = 10
      ModalResult = 2
      TabOrder = 0
      OnClick = btnExitClick
    end
    object btnTakeNewPic: TRzBitBtn
      Left = 16
      Top = 14
      Width = 129
      Height = 49
      Caption = 'Take New Picture'
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
    Width = 315
    Height = 485
    Align = alLeft
    Caption = 'Images'
    TabOrder = 1
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 21
      Width = 305
      Height = 459
      Align = alClient
      DataSource = dsItemImages
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
          FieldName = 'ImagesDataNo'
          Title.Caption = 'No'
          Width = 47
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ImageDesc'
          Width = 215
          Visible = True
        end>
    end
  end
  object qryItemImages: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    AfterScroll = qryItemImagesAfterScroll
    OnNewRecord = qryItemImagesNewRecord
    Parameters = <
      item
        Name = 'InvItemNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'select ImagesDataNo, ImageTypeNo, ImagRefToRowNo, ImageDesc, Cre' +
        'ated'
      'from ImagesData'
      'where ImageTypeNo = 2 and ImagRefToRowNo = :InvItemNo'
      'order by ImagesDataNo')
    Left = 55
    Top = 75
    object qryItemImagesImagesDataNo: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ImagesDataNo'
    end
    object qryItemImagesImageTypeNo: TIntegerField
      FieldName = 'ImageTypeNo'
    end
    object qryItemImagesImagRefToRowNo: TIntegerField
      FieldName = 'ImagRefToRowNo'
    end
    object qryItemImagesImageDesc: TStringField
      FieldName = 'ImageDesc'
      Size = 125
    end
    object qryItemImagesCreated: TDateTimeField
      FieldName = 'Created'
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
