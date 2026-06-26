object frmImagesStorageSettings: TfrmImagesStorageSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Images Storage Settings'
  ClientHeight = 367
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 17
  object PageControlImageSettings: TPageControl
    Left = 0
    Top = 0
    Width = 601
    Height = 367
    ActivePage = TabSheet1
    Align = alClient
    HotTrack = True
    TabOrder = 0
    TabWidth = 150
    OnChange = PageControlImageSettingsChange
    object TabSheet1: TTabSheet
      Caption = '  Images Storage  '
      object RzGroupBox1: TRzGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 587
        Height = 155
        Align = alTop
        Color = clWhite
        GradientColorStyle = gcsCustom
        GradientColorStop = clWhite
        TabOrder = 0
        VisualStyle = vsGradient
        object rbStoreInDB: TRadioButton
          Left = 27
          Top = 26
          Width = 189
          Height = 17
          Caption = 'Store Images in Database'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbStoreInDBClick
        end
        object rbStoreInDir: TRadioButton
          Left = 27
          Top = 58
          Width = 189
          Height = 17
          Caption = 'Store Images in Directory'
          TabOrder = 1
          OnClick = rbStoreInDBClick
        end
        object pnImageFolder: TRzPanel
          Left = 40
          Top = 76
          Width = 533
          Height = 64
          BorderOuter = fsNone
          TabOrder = 2
          Transparent = True
          object RzLabel1: TRzLabel
            Left = 12
            Top = 6
            Width = 40
            Height = 17
            Caption = 'Folder:'
            FocusControl = edImageDirectory
            Transparent = True
          end
          object btnSelectFolder: TRzToolButton
            Left = 494
            Top = 23
            Height = 26
            Flat = False
            ShowCaption = True
            UseToolbarShowCaption = False
            Caption = '...'
            OnClick = btnSelectFolderClick
          end
          object edImageDirectory: TRzEdit
            Left = 12
            Top = 23
            Width = 476
            Height = 25
            Text = ''
            TabOrder = 0
          end
        end
      end
      object RzGroupBox2: TRzGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 266
        Width = 587
        Height = 66
        Align = alBottom
        Color = clWhite
        GradientColorStyle = gcsCustom
        GradientColorStop = clWhite
        TabOrder = 2
        VisualStyle = vsGradient
        DesignSize = (
          587
          66)
        object btnSave: TRzBitBtn
          Left = 329
          Top = 16
          Width = 107
          Height = 41
          Anchors = [akTop, akRight]
          Caption = '&Save'
          TabOrder = 0
          OnClick = btnSaveClick
          ImageIndex = 19
          Images = DM.vilMain24
          Margin = 10
          Spacing = -5
        end
        object btnCancel: TBitBtn
          Left = 454
          Top = 16
          Width = 107
          Height = 41
          Anchors = [akTop, akRight]
          Kind = bkCancel
          NumGlyphs = 2
          TabOrder = 1
        end
      end
      object gbSharedImagePath: TRzGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 164
        Width = 587
        Height = 101
        Align = alTop
        Caption = 'Secondary Workstation Shared Image Path (UNC)'
        TabOrder = 1
        object RzLabel2: TRzLabel
          Left = 52
          Top = 36
          Width = 192
          Height = 17
          Caption = 'Shared image folder path (UNC):'
        end
        object edImageSharedFolder: TRzEdit
          Left = 52
          Top = 56
          Width = 476
          Height = 25
          Text = ''
          TabOrder = 0
        end
      end
    end
    object TabSheetMigrateImages: TTabSheet
      Caption = 'Migrate to Folder'
      ImageIndex = 1
      object RzGroupBox3: TRzGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 587
        Height = 329
        Align = alClient
        Color = clWhite
        GradientColorStyle = gcsCustom
        TabOrder = 0
        ExplicitHeight = 427
        object lblFolder: TLabel
          Left = 56
          Top = 74
          Width = 61
          Height = 21
          Caption = 'lblFolder'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblProgress: TLabel
          Left = 292
          Top = 35
          Width = 66
          Height = 17
          Caption = 'lblProgress'
        end
        object btnExportImages: TBitBtn
          Left = 32
          Top = 20
          Width = 232
          Height = 48
          Caption = 'Extract Images to Folder'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BitBtn1Click
        end
      end
    end
  end
end
