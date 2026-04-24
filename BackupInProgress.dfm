object frmBackupInProgress: TfrmBackupInProgress
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 91
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  PopupMode = pmAuto
  Position = poScreenCenter
  RoundedCorners = rcOn
  TextHeight = 21
  object vImage: TVirtualImage
    Left = 23
    Top = 6
    Width = 93
    Height = 76
    ImageCollection = DM.svgMain
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 27
    ImageName = 'actBackupDB'
  end
  object lblProgress: TRzLabel
    Left = 174
    Top = 22
    Width = 131
    Height = 37
    Caption = 'lblProgress'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
end
