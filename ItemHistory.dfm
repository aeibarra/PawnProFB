object frmItemHistory: TfrmItemHistory
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Item Status History'
  ClientHeight = 322
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poDefault
  OnCreate = FormCreate
  TextHeight = 20
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 354
    Height = 262
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 429
    ExplicitHeight = 358
    DesignSize = (
      354
      262)
    object lblItem: TRzLabel
      Left = 18
      Top = 13
      Width = 47
      Height = 20
      Caption = 'lblItem'
    end
    object lvHistory: TListView
      AlignWithMargins = True
      Left = 18
      Top = 39
      Width = 319
      Height = 209
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 271
    Width = 354
    Height = 48
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      354
      48)
    object btnClose: TBitBtn
      AlignWithMargins = True
      Left = 250
      Top = 5
      Width = 89
      Height = 38
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ImageIndex = 2
      ImageName = 'actExit'
      Images = DM.vilMain24
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
end
