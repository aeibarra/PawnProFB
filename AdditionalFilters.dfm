object frmAdditionalFilters: TfrmAdditionalFilters
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Additional Filters'
  ClientHeight = 319
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 20
  object gbButtons: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 253
    Width = 558
    Height = 63
    Align = alBottom
    TabOrder = 0
    object btnCancel: TBitBtn
      Left = 358
      Top = 12
      Width = 129
      Height = 41
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object btnApplyFilters: TBitBtn
      Left = 60
      Top = 12
      Width = 129
      Height = 41
      Caption = 'Apply Filters'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object gbFilters: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 558
    Height = 244
    Align = alClient
    TabOrder = 1
    object gbPawns: TGroupBox
      Left = 30
      Top = 13
      Width = 297
      Height = 211
      Caption = 'Pawns'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object chkPawnActive: TRzCheckBox
        Left = 26
        Top = 30
        Width = 64
        Height = 22
        AutoSizeWidth = 64
        Caption = 'Active'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 0
      end
      object chkPawnInactive: TRzCheckBox
        Left = 26
        Top = 58
        Width = 74
        Height = 22
        AutoSizeWidth = 74
        Caption = 'Inactive'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 1
      end
      object chkPawnRedeemed: TRzCheckBox
        Left = 26
        Top = 86
        Width = 95
        Height = 22
        AutoSizeWidth = 95
        Caption = 'Redeemed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 2
      end
      object chkPawnScrap: TRzCheckBox
        Left = 26
        Top = 142
        Width = 121
        Height = 22
        AutoSizeWidth = 121
        Caption = 'Scrap / Melted'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 4
      end
      object chkPawnDefaulted: TRzCheckBox
        Left = 26
        Top = 114
        Width = 255
        Height = 22
        AutoSize = False
        AutoSizeWidth = 255
        Caption = 'Defaulted (undecided items status)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 3
        WordWrap = True
      end
      object chkPawnForSale: TRzCheckBox
        Left = 26
        Top = 171
        Width = 76
        Height = 22
        AutoSizeWidth = 76
        Caption = 'For Sale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 5
      end
    end
    object gbLayaways: TGroupBox
      Left = 343
      Top = 53
      Width = 188
      Height = 96
      Caption = 'Layaways'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object chkLayawayActive: TRzCheckBox
        Left = 26
        Top = 30
        Width = 64
        Height = 22
        AutoSizeWidth = 64
        Caption = 'Active'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 0
      end
      object chkLayawayClosed: TRzCheckBox
        Left = 26
        Top = 58
        Width = 68
        Height = 22
        AutoSizeWidth = 68
        Caption = 'Closed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        State = cbUnchecked
        TabOrder = 1
      end
    end
    object chkPurchases: TRzCheckBox
      Left = 343
      Top = 23
      Width = 93
      Height = 22
      AutoSizeWidth = 93
      Caption = 'Purchases'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbUnchecked
      TabOrder = 2
    end
  end
end
