object frmClients: TfrmClients
  Left = 322
  Top = 172
  Caption = 'Clients'
  ClientHeight = 752
  ClientWidth = 1672
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 17
  object Splitter1: TSplitter
    Left = 0
    Top = 389
    Width = 1672
    Height = 8
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ExplicitTop = 266
    ExplicitWidth = 766
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1672
    Height = 389
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1670
    object PanelClientInfo: TPanel
      Left = 0
      Top = 82
      Width = 1672
      Height = 307
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 1670
      object gridClients: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1666
        Height = 234
        Align = alClient
        DataSource = DM.DSCustomers
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Custno'
            Title.Caption = 'No'
            Width = 37
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustFirst'
            Title.Alignment = taCenter
            Title.Caption = 'First Name'
            Width = 121
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustMid'
            Title.Caption = 'Middle'
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustLast'
            Title.Alignment = taCenter
            Title.Caption = 'Last Name'
            Width = 161
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustAddr'
            Title.Alignment = taCenter
            Title.Caption = 'Address'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustApt'
            Title.Caption = 'Apt.'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustCity'
            Title.Alignment = taCenter
            Title.Caption = 'City'
            Width = 99
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustState'
            Title.Alignment = taCenter
            Title.Caption = 'State'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustZip'
            Title.Alignment = taCenter
            Title.Caption = 'ZIP'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cCustFlDrvLic'
            Title.Caption = 'FL Driver Lic.'
            Width = 119
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustDOB'
            Title.Caption = 'DOB'
            Width = 87
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cCustPhCell'
            Title.Caption = 'Cellular'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CCustPhHome'
            Title.Caption = 'Home Ph.'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CCustPhBeep'
            Title.Caption = 'Beeper'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CCustPhBussiness'
            Title.Caption = 'Work Ph.'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustID'
            Title.Caption = 'ID'
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustIDType'
            Title.Caption = 'ID type'
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustIDAgencyState'
            Title.Caption = 'ID Agency or State'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustGender'
            Title.Caption = 'Gender'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustRace'
            Title.Caption = 'Race'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustHair'
            Title.Caption = 'Hair'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustEyes'
            Title.Caption = 'Eyes'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustMark'
            Title.Caption = 'Mark'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustWeight'
            Title.Caption = 'Weight'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustHeight'
            Title.Caption = 'Height'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CustPlaceEmply'
            Title.Caption = 'Place Emply'
            Width = 200
            Visible = True
          end>
      end
      object Panel12: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 243
        Width = 1666
        Height = 61
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 1664
        object btnAdjPoliceReport: TRzToolButton
          Left = 596
          Top = 12
          Width = 66
          Height = 36
          ShowCaption = True
          UseToolbarShowCaption = False
          Caption = 'Adj. Pos.'
          OnClick = btnAdjPoliceReportClick
        end
        object btnClientDelete: TBitBtn
          Left = 365
          Top = 4
          Width = 144
          Height = 52
          Caption = 'Delete Client'
          ImageIndex = 10
          ImageName = 'Denied 2'
          Images = DM.vilMain
          TabOrder = 0
          OnClick = btnClientDeleteClick
        end
        object btnClientAdd: TBitBtn
          Left = 21
          Top = 4
          Width = 134
          Height = 52
          Hint = 'F5'
          Caption = 'Add Client'
          ImageIndex = 8
          ImageName = 'Add User Male 2'
          Images = DM.vilMain
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnClientAddClick
        end
        object btnClientEdit: TBitBtn
          Left = 181
          Top = 4
          Width = 134
          Height = 52
          Hint = 'F6'
          Caption = 'Edit Client'
          ImageIndex = 9
          ImageName = 'Registration1'
          Images = DM.vilMain
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnClientEditClick
        end
        object btnPrintPolRpt: TBitBtn
          Left = 671
          Top = 4
          Width = 189
          Height = 52
          Hint = 'F12'
          BiDiMode = bdLeftToRight
          Caption = ' &Print Police Report'
          ImageIndex = 0
          ImageName = 'actPrint4'
          Images = DM.vilMain
          ParentBiDiMode = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 3
          OnClick = btnPrintPolRptClick
        end
      end
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1666
      Height = 76
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 1664
      DesignSize = (
        1666
        76)
      object Label1: TLabel
        Left = 41
        Top = 13
        Width = 66
        Height = 17
        Caption = '&First Name:'
        FocusControl = edFirst
      end
      object Label2: TLabel
        Left = 177
        Top = 13
        Width = 65
        Height = 17
        Caption = '&Last Name:'
        FocusControl = edLast
      end
      object Label3: TLabel
        Left = 312
        Top = 13
        Width = 61
        Height = 17
        Caption = '&Ticket No:.'
        FocusControl = edTicketNo
      end
      object btnClearSearchFields: TSpeedButton
        Left = 10
        Top = 32
        Width = 23
        Height = 22
        Hint = 'Clear Search Fields'#13'F11 or Alt+BkSp'
        Flat = True
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFAFAFAF2F2F2E9E9E9DCDCDCDADADAD6D6D6D5D5D5D5D5D5D7D7D7DADA
          DADEDEDEE3E3E3E8E8E8EDEDEDF2F2F2F7F7F7FBFBFBFEFEFEFFFFFFFFFFFFFF
          FFFFFDFDFDECECECD3D3D3B8B8B89F9F9F808080979797B5B5B5D4D4D4D8D8D8
          DCDCDCDEDEDEDFDFDFDFDFDFDEDEDEDDDDDDDCDCDCDDDDDDDEDEDEE4E4E4ECEC
          ECF3F3F3FBFBFBFFFFFFF6F6F6DFDFDFCACACAB7B7B78B8B8BCDCDCDDDDDDDB2
          B2B2ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFCFCFCF9F9F9F8F8F8F9F9F9FDFDFDFFFFFFFBFBFBF2F2F2B2B2B2D1D1
          D1E1E1E1E0E0E0DFDFDF9897A1AAA9B6E1E1E1E4E4E4E9E9E9F0F0F0F7F7F7FD
          FDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D6D6D6D6D6D6E4E4E4E3E3E3E2E2E2BFBECA1C1BAC0B0AB2AEADC1F6F6F7F6F6
          F6F7F7F7F8F8F8FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFD9D9D9DADADAE8E8E8E7E7E7E6E6E6D1D1D05655B70303BD0303BD
          0C0BB6B9B8DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEC9C9C9ECECECEAEAEAE9E9E9D5D5D5CCCBCBD8
          D8DE4747C80303BE0303BE0C0BB7B9B8E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D1D1D1EDEDEDCBCB
          D75958BDD8D8DDDFDFDFD9D9DE4848CA0303C00303C00C0BBAB9B8E1FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F7F7F7B4B4C22D2DB90E0EC04B4BCAD8D8DF8686C2C0C0D74849CD0304C40304
          C40B0CBFB9B8E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFCECEEF2727C71717C31414C25050CCBCBCD6A5A5CE
          CECEDD484AD20205C90204C90B0DC5B8B8E6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6F02E2EC91D1DC51A
          1AC45555CEB1B1D49191C8C3C3DB4A4CD50205CD0205CD0B0DC9B8B8E8FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8C8F13434CB2424C72222C65A5AD0E0E0E67D7DC2BDBDDA4E50DA050AD201
          06D10A0ECEB9B9EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFCACAF13B3BCE2C2CCA2929C96060D3CFCFE1B7B7
          D7C2C2DD5255DE0B10D7050AD60A0ED2B9BAECFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCF24243D23233CE
          2F2FCE6465D7C0C0DDADADD5BCBCDC565AE20F15DC0A10DB2529D9BABBEFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFCDCDF44749D7393BD33637D3696BDBB3B3D9C6C6DFC4C4E05A5FE6151BE0
          1218E0292EDEC0C2F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFCFD0F54F51DB3F42D83D3FD76F70DFB6B6DB98
          98CFD6D6E85F63E81920E42B31DFB4B5D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1D1F65558DF474A
          DD4245DC7476E2D6D6E9F1F1F1EBEBF06E72E08C8DA5C4C4C4FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFD2D3F75C5FE34D51E1494DE0787BE5ECECF1E7E7E7A6A6A6A3A3A3F3F3
          F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFD4D5F86265E75458E54F53E48D8FE0A6A6A6
          A1A1A1F3F3F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D6F9686CEB79
          7CE29898A6A1A1A1F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDFE0F9B6B7C0B0B0B0F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnClearSearchFieldsClick
      end
      object Label5: TLabel
        Left = 399
        Top = 13
        Width = 39
        Height = 17
        Caption = 'P&hone:'
        FocusControl = edPhone
      end
      object edFirst: TEdit
        Left = 41
        Top = 32
        Width = 129
        Height = 25
        MaxLength = 50
        TabOrder = 0
      end
      object edLast: TEdit
        Left = 177
        Top = 32
        Width = 129
        Height = 25
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
      end
      object btnExit: TBitBtn
        AlignWithMargins = True
        Left = 1558
        Top = 10
        Width = 92
        Height = 54
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = 'E&xit'
        ImageIndex = 2
        ImageName = 'actExit'
        Images = DM.vilMain
        ModalResult = 2
        TabOrder = 5
        OnClick = btnExitClick
        ExplicitLeft = 1556
      end
      object edTicketNo: TEdit
        Left = 312
        Top = 32
        Width = 69
        Height = 25
        MaxLength = 12
        NumbersOnly = True
        TabOrder = 2
      end
      object btnSearch: TRzBitBtn
        Left = 534
        Top = 15
        Width = 124
        Height = 48
        Default = True
        Caption = '&Search'
        TabOrder = 4
        OnClick = btnSearchClick
        ImageIndex = 6
        Images = DM.vilMain
        Margin = 6
        Spacing = -5
      end
      object edPhone: TPawnPhoneEdit
        Left = 399
        Top = 32
        Width = 110
        Height = 25
        TabOrder = 3
        Text = '(   )   -    '
      end
    end
  end
  object PanelDetail: TPanel
    Left = 0
    Top = 397
    Width = 1672
    Height = 355
    Align = alClient
    BevelOuter = bvNone
    Constraints.MinHeight = 200
    TabOrder = 1
    ExplicitWidth = 1670
    object SplitterBottom: TSplitter
      Left = 687
      Top = 0
      Height = 355
      Beveled = True
      ExplicitLeft = 651
      ExplicitTop = -2
    end
    object pgTransactions: TRzPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 681
      Height = 349
      Hint = ''
      ActivePage = TabPawnTran
      Align = alLeft
      BoldCurrentTab = True
      HotTrackStyle = htsTabBar
      Images = DM.ImageListBtn
      TabHeight = 35
      TabIndex = 0
      TabOrder = 0
      OnChange = pgTransactionsChange
      FixedDimension = 35
      object TabPawnTran: TRzTabSheet
        Caption = '    Pawn Transactions  '
        object gridPawn: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 671
          Height = 238
          Align = alClient
          DataSource = DM.DSTransactions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          PopupMenu = PopMnuTransactions
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = DBGridTranDrawColumnCell
          OnDblClick = btnTranEditClick
          Columns = <
            item
              Expanded = False
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 15
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'TranDate'
              Title.Alignment = taCenter
              Title.Caption = 'Date'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranTicketNo'
              Title.Caption = 'Ticket No'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranPawnAmount'
              Title.Caption = 'Pawn Amount'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranInterest'
              Title.Caption = 'Int. %'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PrincBalance'
              Title.Caption = 'Princ. Balance'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 108
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranMaturity'
              Title.Caption = 'Maturity'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 81
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cNextInterestToPay'
              Title.Caption = 'Next Int. to pay'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 113
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'InsterestBalance'
              Title.Caption = 'I. Balance'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cComment'
              Title.Caption = 'Comment'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 139
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TransactionNo'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Visible = True
            end>
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 247
          Width = 671
          Height = 60
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnNewPawn: TBitBtn
            Left = 17
            Top = 2
            Width = 110
            Height = 50
            Hint = 'F7'
            Caption = ' New'
            ImageIndex = 15
            ImageName = 'actAddFld01'
            Images = DM.vilMain
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = btnTranAddClick
          end
          object btnEditPawn: TBitBtn
            Left = 144
            Top = 2
            Width = 110
            Height = 50
            Hint = 'F8'
            Caption = ' Edit'
            ImageIndex = 14
            ImageName = 'actEdit02'
            Images = DM.vilMain
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnTranEditClick
          end
          object btnDelPawn: TBitBtn
            Left = 278
            Top = 2
            Width = 95
            Height = 50
            Caption = ' Delete'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
              7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
              1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
              A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
              00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
              4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
              A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
              3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
              FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
              90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
              21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
              4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
              9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
              B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
              76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
              AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
              CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
              00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
              BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
              C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
            TabOrder = 2
            OnClick = btnTranDeleteClick
          end
          object btnNewPathWithItems: TRzBitBtn
            Left = 404
            Top = 2
            Width = 174
            Height = 50
            Caption = ' New Pawn with Items'
            TabOrder = 3
            OnClick = btnNewWithCopyItemsClick
            ImageIndex = 20
            Images = DM.ImageListBtn
            Margin = 5
            Spacing = -5
          end
        end
      end
      object TabPurchaseTran: TRzTabSheet
        Caption = '   Purchase Transactions    '
        object DBGrid6: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 671
          Height = 238
          Align = alClient
          DataSource = DM.DSTransactions
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          PopupMenu = PopMnuTransactions
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDblClick = btnEditPurchaseClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'TranDate'
              Title.Alignment = taCenter
              Title.Caption = 'Date'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranTicketNo'
              Title.Caption = 'Ticket No'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranPawnAmount'
              Title.Caption = 'Amount'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranMaturity'
              Title.Caption = 'Maturity'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cComment'
              Title.Caption = 'Comment'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = []
              Width = 196
              Visible = True
            end>
        end
        object Panel5: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 247
          Width = 671
          Height = 60
          Align = alBottom
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object btnNewPurchase: TBitBtn
            Left = 17
            Top = 2
            Width = 110
            Height = 50
            Caption = ' New'
            ImageIndex = 15
            ImageName = 'actAddFld01'
            Images = DM.vilMain
            TabOrder = 0
            OnClick = btnNewPurchaseClick
          end
          object btnEditPurchase: TBitBtn
            Left = 144
            Top = 2
            Width = 110
            Height = 50
            Caption = ' Edit'
            ImageIndex = 14
            ImageName = 'actEdit02'
            Images = DM.vilMain
            TabOrder = 1
            OnClick = btnEditPurchaseClick
          end
          object btnDeletePurchase: TBitBtn
            Left = 289
            Top = 2
            Width = 99
            Height = 50
            Caption = ' Delete'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
              7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
              1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
              A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
              00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
              4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
              A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
              3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
              FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
              90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
              21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
              4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
              9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
              B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
              76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
              AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
              CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
              00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
              BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
              C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
            TabOrder = 2
            OnClick = btnTranDeleteClick
          end
        end
      end
      object TabLayawayTran: TRzTabSheet
        Caption = '          LAYAWAY        '
        object DBGrid1: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 671
          Height = 238
          Align = alClient
          DataSource = DM.DSTransactions
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = PopMnuLayaway
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDrawColumnCell = DBGrid1DrawColumnCell
          OnDblClick = btnEditLayawayClick
          Columns = <
            item
              Expanded = False
              Width = 15
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranDate'
              Title.Alignment = taCenter
              Title.Caption = 'Date'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranTicketNo'
              Title.Alignment = taCenter
              Title.Caption = 'Ticket No'
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranPawnAmount'
              Title.Alignment = taCenter
              Title.Caption = 'Amount'
              Width = 92
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TranSalesTax'
              Title.Alignment = taCenter
              Title.Caption = 'Sales Tax'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cTotalSalesAmount'
              Title.Alignment = taCenter
              Title.Caption = 'Total Amount'
              Width = 92
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PrincBalance'
              Title.Alignment = taCenter
              Title.Caption = 'Balance'
              Width = 108
              Visible = True
            end>
        end
        object Panel6: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 247
          Width = 671
          Height = 60
          Align = alBottom
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          DesignSize = (
            671
            60)
          object btnLayawayRcpt: TRzToolButton
            Left = 530
            Top = 2
            Width = 131
            Height = 50
            Flat = False
            ImageIndex = 16
            Images = DM.vilMain24
            ShowCaption = True
            UseToolbarButtonSize = False
            UseToolbarShowCaption = False
            Anchors = [akTop, akRight]
            Caption = 'Print Receipt'
            OnClick = btnLayawayRcptClick
          end
          object btnNewLayaway: TBitBtn
            Left = 17
            Top = 2
            Width = 107
            Height = 50
            Caption = ' New'
            ImageIndex = 15
            ImageName = 'actAddFld01'
            Images = DM.vilMain
            TabOrder = 0
            OnClick = btnNewLayawayClick
          end
          object btnEditLayaway: TBitBtn
            Left = 144
            Top = 2
            Width = 107
            Height = 50
            Caption = ' Edit'
            ImageIndex = 14
            ImageName = 'actEdit02'
            Images = DM.vilMain
            TabOrder = 1
            OnClick = btnEditLayawayClick
          end
          object btnDeleteLayaway: TBitBtn
            Left = 417
            Top = 2
            Width = 88
            Height = 50
            Caption = ' Delete'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
              7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
              1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
              A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
              00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
              4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
              A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
              3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
              FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
              90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
              21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
              4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
              9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
              B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
              76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
              AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
              CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
              00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
              BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
              C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
            TabOrder = 3
          end
          object btnCloseLayaway: TBitBtn
            Left = 283
            Top = 2
            Width = 110
            Height = 50
            Caption = 'Close'#13#10'Layaway'
            ImageIndex = 48
            ImageName = 'shopping-bag'
            Images = DM.vilMain24
            TabOrder = 2
            OnClick = btnCloseLayawayClick
          end
        end
      end
    end
    object pgTransDetail: TRzPageControl
      AlignWithMargins = True
      Left = 693
      Top = 3
      Width = 976
      Height = 349
      Hint = ''
      ActivePage = TabPayment
      Align = alClient
      BoldCurrentTab = True
      HotTrackStyle = htsTabBar
      Images = DM.ImageListBtn
      TabHeight = 35
      TabIndex = 0
      TabOrder = 1
      OnChange = pgTransDetailChange
      ExplicitWidth = 974
      FixedDimension = 35
      object TabPayment: TRzTabSheet
        ImageIndex = 21
        Caption = 'Payments'
        ExplicitWidth = 970
        object gridPayments: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 966
          Height = 202
          Align = alClient
          DataSource = DM.DSPayments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = gridPaymentsDrawColumnCell
          OnDblClick = btnPayEditClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'No'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 35
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'PayDate'
              Title.Alignment = taCenter
              Title.Caption = 'Date'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = 'Period'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PayAmount'
              Title.Alignment = taCenter
              Title.Caption = 'Amount'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 82
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PayPrincipal'
              Title.Caption = 'Principal'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PayInterest'
              Title.Caption = 'Interest'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PrincBalance'
              Title.Caption = 'P. Balance'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 81
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'InsterestBalance'
              Title.Caption = 'I. Balance'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cComment'
              Title.Caption = 'Comment'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -13
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = []
              Visible = True
            end>
        end
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 247
          Width = 966
          Height = 60
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitWidth = 964
          DesignSize = (
            966
            60)
          object btnPrintPayReceipt: TRzToolButton
            Left = 761
            Top = 2
            Width = 192
            Height = 50
            Flat = False
            ImageIndex = 16
            Images = DM.vilMain24
            ShowCaption = True
            UseToolbarButtonSize = False
            UseToolbarShowCaption = False
            Anchors = [akTop, akRight]
            Caption = 'Print Payment Receipt'
            OnClick = btnPrintPayReceiptClick
            ExplicitLeft = 759
          end
          object btnPayAdd: TBitBtn
            Left = 17
            Top = 2
            Width = 110
            Height = 50
            Hint = 'F9'
            Caption = ' Add'
            ImageIndex = 15
            ImageName = 'actAddFld01'
            Images = DM.vilMain
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = btnPayAddClick
          end
          object btnPayEdit: TBitBtn
            Left = 144
            Top = 2
            Width = 110
            Height = 50
            Hint = 'F10'
            Caption = ' Edit'
            ImageIndex = 14
            ImageName = 'actEdit02'
            Images = DM.vilMain
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnPayEditClick
          end
          object btnPayDelete: TBitBtn
            Left = 296
            Top = 2
            Width = 95
            Height = 50
            Caption = ' Delete'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
              7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
              1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
              A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
              00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
              4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
              A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
              3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
              FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
              90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
              21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
              4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
              9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
              B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
              76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
              AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
              CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
              00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
              BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
              C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
            TabOrder = 2
            OnClick = btnPayDeleteClick
          end
        end
        object pnPawnPayBalance: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 211
          Width = 966
          Height = 30
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 2
          ExplicitWidth = 964
          DesignSize = (
            962
            26)
          object lblNextPaymentInfo: TJvLinkLabel
            Left = 15
            Top = 1
            Width = 933
            Height = 21
            Caption = 'Normal text <b>Bold text</b>'
            Text.Strings = (
              'Normal text <b>Bold text</b>')
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 931
          end
        end
      end
      object TabItems: TRzTabSheet
        ImageIndex = 22
        Caption = '   Items    '
        ExplicitWidth = 970
        object gridItems: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 966
          Height = 202
          Align = alClient
          DataSource = dsInvItems
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          PopupMenu = PopMnuPawnItems
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDrawColumnCell = gridItemsDrawColumnCell
          OnDblClick = btnEditInvItemsClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'cHasPics'
              Title.Alignment = taCenter
              Title.Caption = 'Pics'
              Width = 31
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'cStatus'
              Title.Alignment = taCenter
              Title.Caption = 'Status'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'InvItemCount'
              Title.Caption = 'Quantity'
              Width = 62
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UnitCost'
              Title.Caption = 'Cost'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Weight'
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cTotalWeight'
              Title.Caption = 'Total weight'
              Width = 86
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Description'
              Width = 191
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SizeLength'
              Title.Caption = 'Length'
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cStyle'
              Title.Caption = 'Style'
              Width = 59
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cType'
              Title.Caption = 'Type'
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cMetal'
              Title.Caption = 'Metal'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Note'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Created'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'InvItemStatus'
              Visible = True
            end>
        end
        object Panel7: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 247
          Width = 966
          Height = 60
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitWidth = 964
          DesignSize = (
            966
            60)
          object bntCalcUnitcost: TRzToolButton
            Left = 268
            Top = 2
            Width = 173
            Height = 50
            Hint = 
              'Divide total amount of the Pawn by total weight of all items in ' +
              'the Pawn and '
            Flat = False
            ImageIndex = 17
            Images = DM.vilMain24
            ShowCaption = True
            UseToolbarButtonSize = False
            UseToolbarShowCaption = False
            Caption = 'Calc Item Cost from Weight'
            ParentShowHint = False
            ShowHint = True
            OnClick = bntCalcUnitcostClick
          end
          object btnPrintEnvLabel: TRzToolButton
            Left = 575
            Top = 2
            Width = 157
            Height = 50
            GradientColorStyle = gcsSystem
            Flat = False
            ImageIndex = 11
            Images = DM.vilMain
            ShowCaption = True
            UseToolbarButtonSize = False
            UseToolbarShowCaption = False
            UseToolbarVisualStyle = False
            VisualStyle = vsWinXP
            Caption = 'Print Envelope '#13'Item Label'
            OnClick = btnPrintEnvLabelClick
          end
          object btnAddInvItems: TBitBtn
            Left = 17
            Top = 2
            Width = 110
            Height = 50
            Caption = ' Add'
            ImageIndex = 15
            ImageName = 'actAddFld01'
            Images = DM.vilMain
            TabOrder = 0
            OnClick = btnAddInvItemsClick
          end
          object btnEditInvItems: TBitBtn
            Left = 144
            Top = 2
            Width = 110
            Height = 50
            Caption = ' Edit'
            ImageIndex = 14
            ImageName = 'actEdit02'
            Images = DM.vilMain
            TabOrder = 1
            OnClick = btnEditInvItemsClick
          end
          object btnDeleteItem: TBitBtn
            Left = 459
            Top = 2
            Width = 95
            Height = 50
            Cancel = True
            Caption = 'Delete'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
              7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
              1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
              A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
              00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
              4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
              A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
              3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
              FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
              90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
              21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
              4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
              9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
              B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
              76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
              AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
              CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
              00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
              BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
              C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
            ModalResult = 2
            TabOrder = 2
            OnClick = btnDeleteItemClick
          end
          object btnItemPictures: TRzBitBtn
            Left = 818
            Top = 2
            Width = 145
            Height = 50
            Anchors = [akTop, akRight]
            Caption = 'Item Pictures'
            TabOrder = 3
            OnClick = btnItemPicturesClick
            ImageIndex = 18
            Images = DM.vilMain24
            Margin = 10
            ExplicitLeft = 816
          end
        end
        object pnPawnItemBalance: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 211
          Width = 966
          Height = 30
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 2
          ExplicitWidth = 964
          DesignSize = (
            962
            26)
          object lblNextPaymentInfoItems: TJvLinkLabel
            Left = 15
            Top = 1
            Width = 933
            Height = 21
            Caption = 'Normal text <b>Bold text</b>'
            Text.Strings = (
              'Normal text <b>Bold text</b>')
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 931
          end
        end
      end
    end
  end
  object ActionListKeys: TActionList
    Images = DM.vilMain
    Left = 37
    Top = 153
    object ActionAddClient: TAction
      Caption = 'Add Client'#13#10'Key F5'
      ImageIndex = 8
      ImageName = 'Add User Male 2'
      ShortCut = 116
      OnExecute = btnClientAddClick
    end
    object ActionEditClient: TAction
      Caption = 'Edit Client'#13#10'Key F6'
      ImageIndex = 9
      ImageName = 'Registration1'
      ShortCut = 117
      OnExecute = btnClientEditClick
    end
    object ActionAddTran: TAction
      Caption = 'Add Transaction'#13#10'Key F7'
      ImageIndex = 15
      ImageName = 'actAddFld01'
      ShortCut = 118
      OnExecute = btnTranAddClick
    end
    object ActionEditTran: TAction
      Caption = 'Edit Transaction'#13#10'Key F8'
      ImageIndex = 14
      ImageName = 'actEdit02'
      ShortCut = 119
      OnExecute = btnTranEditClick
    end
    object ActionAddPay: TAction
      Caption = 'Add Payment'#13#10'Key Ctrl+F9'
      ImageIndex = 15
      ImageName = 'actAddFld01'
      ShortCut = 16504
      OnExecute = btnPayAddClick
    end
    object ActionEditPay: TAction
      Caption = 'Edit Payment'#13#10'Key Ctrl+F10'
      ImageIndex = 14
      ImageName = 'actEdit02'
      ShortCut = 16505
      OnExecute = btnPayEditClick
    end
    object ActionPrintPoliceRpt: TAction
      Caption = 'Print Police Report'#13#10'F12'
      ImageIndex = 0
      ImageName = 'actPrint4'
      ShortCut = 123
      OnExecute = btnPrintPolRptClick
    end
    object ActionScanCard: TAction
      Caption = 'Scan Driver Lic. Card'
      Checked = True
      ShortCut = 113
      OnExecute = ActionScanCardExecute
    end
    object ActionAddPurchase: TAction
      Caption = 'New Purchase'#13#10'Key F3'
      ImageIndex = 15
      ImageName = 'actAddFld01'
      ShortCut = 114
      OnExecute = btnNewPurchaseClick
    end
    object ActionEditPurchase: TAction
      Caption = 'Edit Purchase'#13#10'Key F4'
      ImageIndex = 14
      ImageName = 'actEdit02'
      ShortCut = 115
      OnExecute = btnEditPurchaseClick
    end
    object ActionClearSearchFields: TAction
      Caption = 'ActionClearSearchFields'
      ShortCut = 122
      OnExecute = btnClearSearchFieldsClick
    end
    object Action1: TAction
      Caption = 'ActionClearSearchFields'
      ShortCut = 32776
      OnExecute = btnClearSearchFieldsClick
    end
  end
  object dsInvItems: TDataSource
    DataSet = qryInvItems
    Left = 1000
    Top = 518
  end
  object PDBPoliceRep: TppDBPipeline
    DataSource = dsPoliceRepCust
    OpenDataSource = False
    UserName = 'PDBPoliceRep'
    Left = 251
    Top = 204
    object PDBPoliceRepppField1: TppField
      FieldAlias = 'Custno'
      FieldName = 'Custno'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField2: TppField
      FieldAlias = 'CustTicketNo'
      FieldName = 'CustTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField3: TppField
      FieldAlias = 'CustLast'
      FieldName = 'CustLast'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField4: TppField
      FieldAlias = 'CustFirst'
      FieldName = 'CustFirst'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField5: TppField
      FieldAlias = 'CustMid'
      FieldName = 'CustMid'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField6: TppField
      FieldAlias = 'CustDOB'
      FieldName = 'CustDOB'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField7: TppField
      FieldAlias = 'CustGender'
      FieldName = 'CustGender'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField8: TppField
      FieldAlias = 'CustRace'
      FieldName = 'CustRace'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField9: TppField
      FieldAlias = 'CustHair'
      FieldName = 'CustHair'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField10: TppField
      FieldAlias = 'CustEyes'
      FieldName = 'CustEyes'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField11: TppField
      FieldAlias = 'CustMark'
      FieldName = 'CustMark'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField12: TppField
      FieldAlias = 'CustWeight'
      FieldName = 'CustWeight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField13: TppField
      FieldAlias = 'CustHeight'
      FieldName = 'CustHeight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField14: TppField
      FieldAlias = 'CustAddr'
      FieldName = 'CustAddr'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField15: TppField
      FieldAlias = 'CustApt'
      FieldName = 'CustApt'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField16: TppField
      FieldAlias = 'CustCity'
      FieldName = 'CustCity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField17: TppField
      FieldAlias = 'CustState'
      FieldName = 'CustState'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField18: TppField
      FieldAlias = 'CustZip'
      FieldName = 'CustZip'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField19: TppField
      FieldAlias = 'CustPlaceEmply'
      FieldName = 'CustPlaceEmply'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField20: TppField
      FieldAlias = 'CustFlDrvLic'
      FieldName = 'CustFlDrvLic'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField21: TppField
      FieldAlias = 'CustID'
      FieldName = 'CustID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField22: TppField
      FieldAlias = 'CustIDType'
      FieldName = 'CustIDType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField23: TppField
      FieldAlias = 'CustIDAgencyState'
      FieldName = 'CustIDAgencyState'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField24: TppField
      FieldAlias = 'CustPhHome'
      FieldName = 'CustPhHome'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField25: TppField
      FieldAlias = 'CustPhBussiness'
      FieldName = 'CustPhBussiness'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField26: TppField
      FieldAlias = 'CustPhBeep'
      FieldName = 'CustPhBeep'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 25
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField27: TppField
      FieldAlias = 'CustPhCell'
      FieldName = 'CustPhCell'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 26
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField28: TppField
      FieldAlias = 'CustComment'
      FieldName = 'CustComment'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 27
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField31: TppField
      FieldAlias = 'CCustPhHome'
      FieldName = 'CCustPhHome'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 30
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField32: TppField
      FieldAlias = 'CCustPhBussiness'
      FieldName = 'CCustPhBussiness'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 31
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField33: TppField
      FieldAlias = 'CCustPhBeep'
      FieldName = 'CCustPhBeep'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 32
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField34: TppField
      FieldAlias = 'cCustPhCell'
      FieldName = 'cCustPhCell'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 33
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField35: TppField
      FieldAlias = 'cCustFlDrvLic'
      FieldName = 'cCustFlDrvLic'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 34
      Searchable = False
      Sortable = False
    end
    object PDBPoliceRepppField36: TppField
      FieldAlias = 'cPrnHPhone'
      FieldName = 'cPrnHPhone'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 35
      Searchable = False
      Sortable = False
    end
  end
  object dsPoliceRepCust: TDataSource
    DataSet = qryPoliceRepCust
    Left = 253
    Top = 151
  end
  object DBPStoreInfo: TppDBPipeline
    DataSource = DM.DSStore
    OpenDataSource = False
    UserName = 'DBPStoreInfo'
    Left = 747
    Top = 98
    object DBPStoreInfoppField1: TppField
      FieldAlias = 'cCity'
      FieldName = 'cCity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField2: TppField
      FieldAlias = 'cState'
      FieldName = 'cState'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField3: TppField
      FieldAlias = 'cZIp'
      FieldName = 'cZIp'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField4: TppField
      FieldAlias = 'StoreNo'
      FieldName = 'StoreNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField5: TppField
      FieldAlias = 'StoreName'
      FieldName = 'StoreName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField6: TppField
      FieldAlias = 'StoreAddr'
      FieldName = 'StoreAddr'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField7: TppField
      FieldAlias = 'StoreCityStZIP'
      FieldName = 'StoreCityStZIP'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField8: TppField
      FieldAlias = 'StorePhone'
      FieldName = 'StorePhone'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField9: TppField
      FieldAlias = 'StorePoliceID'
      FieldName = 'StorePoliceID'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField10: TppField
      FieldAlias = 'StoreAdjTopMarg'
      FieldName = 'StoreAdjTopMarg'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField11: TppField
      FieldAlias = 'Storenumber'
      FieldName = 'Storenumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField12: TppField
      FieldAlias = 'StoreAdjDetailHeight'
      FieldName = 'StoreAdjDetailHeight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField13: TppField
      FieldAlias = 'StoreAdjFooterHeight'
      FieldName = 'StoreAdjFooterHeight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField14: TppField
      FieldAlias = 'InterestCalcMethod'
      FieldName = 'InterestCalcMethod'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField15: TppField
      FieldAlias = 'PoliceReportToPrint'
      FieldName = 'PoliceReportToPrint'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField16: TppField
      FieldAlias = 'PoliceReportLaserCopies'
      FieldName = 'PoliceReportLaserCopies'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField17: TppField
      FieldAlias = 'DefaultMaturityMonths'
      FieldName = 'DefaultMaturityMonths'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField18: TppField
      FieldAlias = 'PawnDefaultMonths'
      FieldName = 'PawnDefaultMonths'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField19: TppField
      FieldAlias = 'LeadsStoreId'
      FieldName = 'LeadsStoreId'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField20: TppField
      FieldAlias = 'LeadsOnlineFTPAddress'
      FieldName = 'LeadsOnlineFTPAddress'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField21: TppField
      FieldAlias = 'LeadsOnlineUserName'
      FieldName = 'LeadsOnlineUserName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField22: TppField
      FieldAlias = 'LeadsOnlinePassword'
      FieldName = 'LeadsOnlinePassword'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField23: TppField
      FieldAlias = 'FTPPassive'
      FieldName = 'FTPPassive'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField24: TppField
      FieldAlias = 'PawnDateCalculationBase'
      FieldName = 'PawnDateCalculationBase'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object DBPStoreInfoppField25: TppField
      FieldAlias = 'DefaultWeightMeasureUnit'
      FieldName = 'DefaultWeightMeasureUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
  end
  object DBPTransaction: TppDBPipeline
    DataSource = DM.DSTransactions
    OpenDataSource = False
    UserName = 'DBPTransaction'
    Left = 747
    Top = 151
    object DBPTransactionppField1: TppField
      FieldAlias = 'cComment'
      FieldName = 'cComment'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField2: TppField
      FieldAlias = 'cTranInsAmount1Month'
      FieldName = 'cTranInsAmount1Month'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField3: TppField
      FieldAlias = 'cTotalPay1Month'
      FieldName = 'cTotalPay1Month'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField4: TppField
      FieldAlias = 'cPawnDefaultDate'
      FieldName = 'cPawnDefaultDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField5: TppField
      FieldAlias = 'cTAmountRedeemDefaultDate'
      FieldName = 'cTAmountRedeemDefaultDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField6: TppField
      FieldAlias = 'cAnnualPercRate'
      FieldName = 'cAnnualPercRate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField7: TppField
      FieldAlias = 'cNextInterestToPay'
      FieldName = 'cNextInterestToPay'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField8: TppField
      FieldAlias = 'cTranTotalInterestAtMaturity'
      FieldName = 'cTranTotalInterestAtMaturity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField9: TppField
      FieldAlias = 'cTranTotalAmountAtMaturity'
      FieldName = 'cTranTotalAmountAtMaturity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField10: TppField
      FieldAlias = 'TransactionNo'
      FieldName = 'TransactionNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField11: TppField
      FieldAlias = 'CustNo'
      FieldName = 'CustNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField12: TppField
      FieldAlias = 'TranDate'
      FieldName = 'TranDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField13: TppField
      FieldAlias = 'TranTicketNo'
      FieldName = 'TranTicketNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField14: TppField
      FieldAlias = 'TranComment'
      FieldName = 'TranComment'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField15: TppField
      FieldAlias = 'TranMaturity'
      FieldName = 'TranMaturity'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField16: TppField
      FieldAlias = 'TranType'
      FieldName = 'TranType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField17: TppField
      FieldAlias = 'TranStatus'
      FieldName = 'TranStatus'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField18: TppField
      FieldAlias = 'TranPawnAmount'
      FieldName = 'TranPawnAmount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField19: TppField
      FieldAlias = 'TranInterest'
      FieldName = 'TranInterest'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField20: TppField
      FieldAlias = 'PrincBalance'
      FieldName = 'PrincBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField21: TppField
      FieldAlias = 'InsterestBalance'
      FieldName = 'InsterestBalance'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object DBPTransactionppField22: TppField
      FieldAlias = 'TranTime'
      FieldName = 'TranTime'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
  end
  object PopMnuTransactions: TPopupMenu
    OnPopup = PopMnuTransactionsPopup
    Left = 101
    Top = 505
    object mnuPawnStatusActive: TMenuItem
      Caption = 'Make this Pawn Active'
      OnClick = mnuPawnStatusActiveClick
    end
    object mnuPawnStatusInactive: TMenuItem
      Caption = 'Inactivate Pawn / Close Pawn'
      OnClick = mnuPawnStatusInactiveClick
    end
  end
  object DBPPawnItems: TppDBPipeline
    DataSource = dsPawnItems
    OpenDataSource = False
    UserName = 'DBPPawnItems'
    Left = 349
    Top = 204
    object DBPPawnItemsppField1: TppField
      FieldAlias = 'cStone1Shape'
      FieldName = 'cStone1Shape'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField2: TppField
      FieldAlias = 'cStone1Color'
      FieldName = 'cStone1Color'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField3: TppField
      FieldAlias = 'InvItemNo'
      FieldName = 'InvItemNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField4: TppField
      FieldAlias = 'InvItemBarcode'
      FieldName = 'InvItemBarcode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField5: TppField
      FieldAlias = 'InvCatNo'
      FieldName = 'InvCatNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField6: TppField
      FieldAlias = 'JType'
      FieldName = 'JType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField7: TppField
      FieldAlias = 'JStyle'
      FieldName = 'JStyle'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField8: TppField
      FieldAlias = 'JMetal'
      FieldName = 'JMetal'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField9: TppField
      FieldAlias = 'InvItemCount'
      FieldName = 'InvItemCount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField10: TppField
      FieldAlias = 'Note'
      FieldName = 'Note'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField11: TppField
      FieldAlias = 'SizeLength'
      FieldName = 'SizeLength'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField12: TppField
      FieldAlias = 'Weight'
      FieldName = 'Weight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField13: TppField
      FieldAlias = 'WeightUnit'
      FieldName = 'WeightUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField14: TppField
      FieldAlias = 'KT'
      FieldName = 'KT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField15: TppField
      FieldAlias = 'Created'
      FieldName = 'Created'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField16: TppField
      FieldAlias = 'UnitCost'
      FieldName = 'UnitCost'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField17: TppField
      FieldAlias = 'UnitPrice'
      FieldName = 'UnitPrice'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField18: TppField
      FieldAlias = 'InvItemStatus'
      FieldName = 'InvItemStatus'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField19: TppField
      FieldAlias = 'TransactionNo'
      FieldName = 'TransactionNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField20: TppField
      FieldAlias = 'InvOriginalItemNo'
      FieldName = 'InvOriginalItemNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField21: TppField
      FieldAlias = 'InvItemBrand'
      FieldName = 'InvItemBrand'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField22: TppField
      FieldAlias = 'OwnerAppNumber'
      FieldName = 'OwnerAppNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField23: TppField
      FieldAlias = 'ModelNumber'
      FieldName = 'ModelNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField24: TppField
      FieldAlias = 'SerialNumber'
      FieldName = 'SerialNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField25: TppField
      FieldAlias = 'Gender'
      FieldName = 'Gender'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField26: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 25
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField27: TppField
      FieldAlias = 'cStone1CT'
      FieldName = 'cStone1CT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 26
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField28: TppField
      FieldAlias = 'cStone1WT'
      FieldName = 'cStone1WT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 27
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField29: TppField
      FieldAlias = 'cStone1Qty'
      FieldName = 'cStone1Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 28
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField30: TppField
      FieldAlias = 'cStone2Shape'
      FieldName = 'cStone2Shape'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 29
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField31: TppField
      FieldAlias = 'cStone2Color'
      FieldName = 'cStone2Color'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 30
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField32: TppField
      FieldAlias = 'cStone2CT'
      FieldName = 'cStone2CT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 31
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField33: TppField
      FieldAlias = 'cStone2WT'
      FieldName = 'cStone2WT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 32
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField34: TppField
      FieldAlias = 'cStone2Qty'
      FieldName = 'cStone2Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 33
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsppField35: TppField
      FieldAlias = 'cWeightToPrint'
      FieldName = 'cWeightToPrint'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 34
      Searchable = False
      Sortable = False
    end
  end
  object dsPawnItems: TDataSource
    DataSet = qryPawnItems
    Left = 352
    Top = 151
  end
  object qryPoliceRepCust: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryPoliceRepCustCalcFields
    Parameters = <
      item
        Name = 'Custno'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *  '
      'FROM Customer'
      'WHERE Custno = :Custno'
      '')
    Left = 253
    Top = 98
    object qryPoliceRepCustCustno: TAutoIncField
      FieldName = 'Custno'
      ReadOnly = True
    end
    object qryPoliceRepCustCustTicketNo: TStringField
      FieldName = 'CustTicketNo'
      Size = 15
    end
    object qryPoliceRepCustCustLast: TStringField
      FieldName = 'CustLast'
      Size = 35
    end
    object qryPoliceRepCustCustFirst: TStringField
      FieldName = 'CustFirst'
      Size = 35
    end
    object qryPoliceRepCustCustMid: TStringField
      FieldName = 'CustMid'
      Size = 1
    end
    object qryPoliceRepCustCustDOB: TDateField
      FieldName = 'CustDOB'
    end
    object qryPoliceRepCustCustGender: TStringField
      FieldName = 'CustGender'
      Size = 1
    end
    object qryPoliceRepCustCustRace: TStringField
      FieldName = 'CustRace'
      Size = 1
    end
    object qryPoliceRepCustCustHair: TStringField
      FieldName = 'CustHair'
      Size = 5
    end
    object qryPoliceRepCustCustEyes: TStringField
      FieldName = 'CustEyes'
      Size = 5
    end
    object qryPoliceRepCustCustMark: TStringField
      FieldName = 'CustMark'
      Size = 10
    end
    object qryPoliceRepCustCustWeight: TFloatField
      FieldName = 'CustWeight'
    end
    object qryPoliceRepCustCustHeight: TStringField
      FieldName = 'CustHeight'
      Size = 8
    end
    object qryPoliceRepCustCustAddr: TStringField
      FieldName = 'CustAddr'
      Size = 55
    end
    object qryPoliceRepCustCustApt: TStringField
      FieldName = 'CustApt'
      Size = 5
    end
    object qryPoliceRepCustCustCity: TStringField
      FieldName = 'CustCity'
      Size = 40
    end
    object qryPoliceRepCustCustState: TStringField
      FieldName = 'CustState'
      Size = 2
    end
    object qryPoliceRepCustCustZip: TStringField
      FieldName = 'CustZip'
      Size = 11
    end
    object qryPoliceRepCustCustPlaceEmply: TStringField
      FieldName = 'CustPlaceEmply'
      Size = 30
    end
    object qryPoliceRepCustCustFlDrvLic: TStringField
      FieldName = 'CustFlDrvLic'
    end
    object qryPoliceRepCustCustID: TStringField
      FieldName = 'CustID'
      Size = 25
    end
    object qryPoliceRepCustCustIDType: TStringField
      FieldName = 'CustIDType'
    end
    object qryPoliceRepCustCustIDAgencyState: TStringField
      FieldName = 'CustIDAgencyState'
      Size = 10
    end
    object qryPoliceRepCustCustPhHome: TStringField
      FieldName = 'CustPhHome'
      Size = 14
    end
    object qryPoliceRepCustCustPhBussiness: TStringField
      FieldName = 'CustPhBussiness'
      Size = 14
    end
    object qryPoliceRepCustCustPhBeep: TStringField
      FieldName = 'CustPhBeep'
      Size = 14
    end
    object qryPoliceRepCustCustPhCell: TStringField
      FieldName = 'CustPhCell'
      Size = 14
    end
    object qryPoliceRepCustCustComment: TMemoField
      FieldName = 'CustComment'
      BlobType = ftMemo
    end
    object qryPoliceRepCustCCustPhHome: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCustPhHome'
      Size = 14
      Calculated = True
    end
    object qryPoliceRepCustCCustPhBussiness: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCustPhBussiness'
      Size = 14
      Calculated = True
    end
    object qryPoliceRepCustCCustPhBeep: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCustPhBeep'
      Size = 14
      Calculated = True
    end
    object qryPoliceRepCustcCustPhCell: TStringField
      FieldKind = fkCalculated
      FieldName = 'cCustPhCell'
      Size = 14
      Calculated = True
    end
    object qryPoliceRepCustcCustFlDrvLic: TStringField
      FieldKind = fkCalculated
      FieldName = 'cCustFlDrvLic'
      Calculated = True
    end
    object qryPoliceRepCustcPrnHPhone: TStringField
      FieldKind = fkCalculated
      FieldName = 'cPrnHPhone'
      Calculated = True
    end
  end
  object qryPawnItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    OnCalcFields = qryPawnItemsCalcFields
    Parameters = <
      item
        Name = 'TransactionNo'
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM InventoryItems '
      'WHERE TransactionNo = :TransactionNo')
    Left = 350
    Top = 98
    object qryPawnItemscStone1Shape: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStone1Shape'
      Size = 1
      Calculated = True
    end
    object qryPawnItemscStone1Color: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStone1Color'
      Size = 1
      Calculated = True
    end
    object qryPawnItemsInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryPawnItemsInvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryPawnItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object qryPawnItemsJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryPawnItemsJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryPawnItemsJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryPawnItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryPawnItemsNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryPawnItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryPawnItemsWeight: TFloatField
      FieldName = 'Weight'
    end
    object qryPawnItemsWeightUnit: TStringField
      FieldName = 'WeightUnit'
      Size = 1
    end
    object qryPawnItemsKT: TFloatField
      FieldName = 'KT'
    end
    object qryPawnItemsCreated: TDateTimeField
      FieldName = 'Created'
    end
    object qryPawnItemsUnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object qryPawnItemsUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object qryPawnItemsInvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryPawnItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryPawnItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object qryPawnItemsInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryPawnItemsOwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryPawnItemsModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryPawnItemsSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryPawnItemsGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryPawnItemsDescription: TStringField
      FieldName = 'Description'
      Size = 120
    end
    object qryPawnItemscStone1CT: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cStone1CT'
      Calculated = True
    end
    object qryPawnItemscStone1WT: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStone1WT'
      Calculated = True
    end
    object qryPawnItemscStone1Qty: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cStone1Qty'
      Calculated = True
    end
    object qryPawnItemscStone2Shape: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStone2Shape'
      Size = 1
      Calculated = True
    end
    object qryPawnItemscStone2Color: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStone2Color'
      Size = 1
      Calculated = True
    end
    object qryPawnItemscStone2CT: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cStone2CT'
      Calculated = True
    end
    object qryPawnItemscStone2WT: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStone2WT'
      Calculated = True
    end
    object qryPawnItemscStone2Qty: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cStone2Qty'
      Calculated = True
    end
    object qryPawnItemscWeightToPrint: TStringField
      FieldKind = fkCalculated
      FieldName = 'cWeightToPrint'
      Calculated = True
    end
  end
  object qryPawnStones: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'InvItemNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM Stones'
      'WHERE InvItemNo = :InvItemNo ')
    Left = 545
    Top = 98
    object qryPawnStonesStoneNo: TAutoIncField
      FieldName = 'StoneNo'
      ReadOnly = True
    end
    object qryPawnStonesInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryPawnStonesStoneNumber: TIntegerField
      FieldName = 'StoneNumber'
    end
    object qryPawnStonesStoneShape: TStringField
      FieldName = 'StoneShape'
      Size = 1
    end
    object qryPawnStonesStoneColor: TStringField
      FieldName = 'StoneColor'
      Size = 1
    end
    object qryPawnStonesCT: TFloatField
      FieldName = 'CT'
    end
    object qryPawnStonesWT: TFloatField
      FieldName = 'WT'
    end
    object qryPawnStonesStoneWeightUnit: TStringField
      FieldName = 'StoneWeightUnit'
      Size = 1
    end
    object qryPawnStonesStoneType: TStringField
      FieldName = 'StoneType'
      Size = 30
    end
  end
  object qryTypes: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT JType,  JTypeDesc'
      'FROM JTypes')
    Left = 1340
    Top = 520
    object qryTypesJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryTypesJTypeDesc: TStringField
      FieldName = 'JTypeDesc'
      Size = 30
    end
  end
  object qryStyles: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT JStyle, JStyleDesc'
      'FROM JStyles')
    Left = 1340
    Top = 463
    object qryStylesJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryStylesJStyleDesc: TStringField
      FieldName = 'JStyleDesc'
      Size = 30
    end
  end
  object qryMetal: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT JMetal, JMetalDesc'
      'FROM JMetals')
    Left = 1340
    Top = 586
    object qryMetalJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryMetalJMetalDesc: TStringField
      FieldName = 'JMetalDesc'
      Size = 30
    end
  end
  object qryInvItems: TADOQuery
    Connection = DM.ConnDB
    CursorType = ctStatic
    AfterOpen = qryInvItemsAfterScroll
    AfterScroll = qryInvItemsAfterScroll
    OnCalcFields = qryInvItemsCalcFields
    OnNewRecord = qryInvItemsNewRecord
    DataSource = DM.DSTransactions
    Parameters = <
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 255
        Size = 32767
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT cast((case when exists(select * from ImagesData T01 where' +
        ' T01.ImagRefToRowNo = InventoryItems.InvItemNo) then 1 else 0 en' +
        'd) as bit) as HasPics,'
      '       *'
      'FROM InventoryItems '
      'WHERE TransactionNo = :TransactionNo')
    Left = 1000
    Top = 464
    object qryInvItemscType: TStringField
      FieldKind = fkCalculated
      FieldName = 'cType'
      Size = 40
      Calculated = True
    end
    object qryInvItemscStyle: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStyle'
      Size = 30
      Calculated = True
    end
    object qryInvItemscMetal: TStringField
      FieldKind = fkCalculated
      FieldName = 'cMetal'
      Size = 30
      Calculated = True
    end
    object qryInvItemscTotalWeight: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cTotalWeight'
      Calculated = True
    end
    object qryInvItemscStatus: TStringField
      FieldKind = fkCalculated
      FieldName = 'cStatus'
      Size = 50
      Calculated = True
    end
    object qryInvItemscHasPics: TStringField
      FieldKind = fkCalculated
      FieldName = 'cHasPics'
      Size = 1
      Calculated = True
    end
    object qryInvItemsHasPics: TBooleanField
      FieldName = 'HasPics'
    end
    object qryInvItemsInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object qryInvItemsInvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object qryInvItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object qryInvItemsJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object qryInvItemsJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object qryInvItemsJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object qryInvItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object qryInvItemsNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object qryInvItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object qryInvItemsWeight: TFloatField
      FieldName = 'Weight'
      DisplayFormat = '0.##'
    end
    object qryInvItemsKT: TFloatField
      FieldName = 'KT'
    end
    object qryInvItemsCreated: TDateTimeField
      FieldName = 'Created'
    end
    object qryInvItemsUnitCost: TBCDField
      FieldName = 'UnitCost'
      currency = True
      Precision = 19
    end
    object qryInvItemsUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      currency = True
      Precision = 19
    end
    object qryInvItemsInvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object qryInvItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object qryInvItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object qryInvItemsInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object qryInvItemsOwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object qryInvItemsModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object qryInvItemsSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object qryInvItemsGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object qryInvItemsDescription: TStringField
      FieldName = 'Description'
      Size = 120
    end
    object qryInvItemsWeightUnit: TStringField
      FieldName = 'WeightUnit'
      Size = 1
    end
    object qryInvItemsPawnedDate: TDateField
      FieldName = 'PawnedDate'
    end
    object qryInvItemsPurchaseDate: TDateField
      FieldName = 'PurchaseDate'
    end
    object qryInvItemsRedeemedDate: TDateField
      FieldName = 'RedeemedDate'
    end
    object qryInvItemsDefaultedDate: TDateField
      FieldName = 'DefaultedDate'
    end
    object qryInvItemsMeltedDate: TDateField
      FieldName = 'MeltedDate'
    end
    object qryInvItemsForSaleDate: TDateField
      FieldName = 'ForSaleDate'
    end
    object qryInvItemsSoldDate: TDateField
      FieldName = 'SoldDate'
    end
    object qryInvItemsLayawayDate: TDateField
      FieldName = 'LayawayDate'
    end
  end
  object spuCalcUnitCostFromWeight: TADOStoredProc
    Connection = DM.ConnDB
    ProcedureName = 'spu_CalcUnitCostFromWeight'
    Parameters = <
      item
        Name = '@TransactionNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 818
    Top = 544
  end
  object qryCalcUnitCostFromWeight: TADOQuery
    Connection = DM.ConnDB
    Parameters = <
      item
        Name = 'TransactionNo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'exec spu_CalcUnitCostFromWeight :TransactionNo')
    Left = 1000
    Top = 569
  end
  object FormState: TRzFormState
    RegIniFile = DM.RegIniFile
    Left = 112
    Top = 140
  end
  object PropertyStore: TRzPropertyStore
    Properties = <
      item
        Component = pnTop
        PropertyName = 'Height'
      end
      item
        Component = pgTransactions
        PropertyName = 'Width'
      end>
    RegIniFile = DM.RegIniFile
    Left = 112
    Top = 196
  end
  object TimerScanningTimeOut: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerScanningTimeOutTimer
    Left = 989
    Top = 107
  end
  object RepPoliceLaser: TppReport
    AutoStop = False
    DataPipeline = DBPPawnItemsLaser
    NoDataBehaviors = [ndBlankReport]
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.Copies = 3
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 3810
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Printer'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPageWidth
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    ShowPrintDialog = False
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 650
    Top = 151
    Version = '23.02'
    mmColumnWidth = 196850
    DataPipelineName = 'DBPPawnItemsLaser'
    object ppHeaderBand2: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 79640
      mmPrintPosition = 0
      object ppLine8: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line8'
        Border.mmPadding = 0
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 2114
        mmLeft = 5408
        mmTop = 45634
        mmWidth = 170421
        BandType = 0
        LayerName = Foreground1
      end
      object ppShape2: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape2'
        Brush.Style = bsClear
        ParentWidth = True
        Pen.Color = clGray
        mmHeight = 53726
        mmLeft = 380
        mmTop = 25899
        mmWidth = 202440
        BandType = 0
        LayerName = Foreground1
      end
      object ppShape1: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape1'
        mmHeight = 10581
        mmLeft = 82815
        mmTop = 27
        mmWidth = 35190
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText10: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText1'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreName'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4763
        mmLeft = 27517
        mmTop = 6879
        mmWidth = 21166
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText21: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText2'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreAddr'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3968
        mmLeft = 30956
        mmTop = 11642
        mmWidth = 14288
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText22: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText3'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreCityStZIP'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 28310
        mmTop = 15346
        mmWidth = 20638
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText23: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText4'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePhone'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 29633
        mmTop = 19050
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText24: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText5'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 3969
        mmLeft = 148961
        mmTop = 0
        mmWidth = 529
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText52: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText6'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePoliceID'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 9
        Font.Style = [fsUnderline]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4233
        mmLeft = 143140
        mmTop = 7938
        mmWidth = 15346
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText53: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText7'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranMaturity'
        DataPipeline = DBPTransaction
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 9
        Font.Style = [fsUnderline]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 153988
        mmTop = 15346
        mmWidth = 529
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText54: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText101'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustDOB'
        DataPipeline = PDBPoliceRep
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3704
        mmLeft = 110861
        mmTop = 29369
        mmWidth = 11641
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText55: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText102'
        Border.mmPadding = 0
        DataField = 'CustGender'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3704
        mmLeft = 150067
        mmTop = 29369
        mmWidth = 8504
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText56: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText103'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustRace'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3704
        mmLeft = 166471
        mmTop = 29369
        mmWidth = 8127
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel11: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label2'
        OnGetText = ppLabel2GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3500
        mmLeft = 7148
        mmTop = 51432
        mmWidth = 33338
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel12: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label3'
        OnGetText = ppLabel3GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3500
        mmLeft = 41015
        mmTop = 51432
        mmWidth = 31836
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel13: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label4'
        OnGetText = ppLabel4GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3500
        mmLeft = 74882
        mmTop = 51432
        mmWidth = 23548
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText59: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText12'
        Border.mmPadding = 0
        DataField = 'CustHeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3500
        mmLeft = 100542
        mmTop = 51432
        mmWidth = 10016
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText60: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText17'
        Border.mmPadding = 0
        DataField = 'CustWeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3500
        mmLeft = 116857
        mmTop = 51432
        mmWidth = 9071
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText61: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText13'
        Border.mmPadding = 0
        DataField = 'CustEyes'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3500
        mmLeft = 131322
        mmTop = 51432
        mmWidth = 9328
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText62: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText19'
        Border.mmPadding = 0
        DataField = 'CustHair'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3500
        mmLeft = 143751
        mmTop = 51432
        mmWidth = 7740
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText63: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText20'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustMark'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3500
        mmLeft = 155311
        mmTop = 51432
        mmWidth = 11906
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel14: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label5'
        OnGetText = ppLabel5GetText
        Border.mmPadding = 0
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 7144
        mmTop = 29369
        mmWidth = 7144
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText64: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText41'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Storenumber'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3968
        mmLeft = 29104
        mmTop = 22490
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText65: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText51'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CCustPhBussiness'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3704
        mmLeft = 129911
        mmTop = 43921
        mmWidth = 24341
        BandType = 0
        LayerName = Foreground1
      end
      object ppChkPawnLetter: TmyCheckBox
        OnPrint = ppChkPawnPrint
        DesignLayer = ppDesignLayer2
        UserName = 'ppChkPawn'
        CheckboxState = cbUnchecked
        Checked = False
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5146
        mmLeft = 156634
        mmTop = 20825
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object chkChkPurchase: TmyCheckBox
        OnPrint = ppChkPurchasePrint
        DesignLayer = ppDesignLayer2
        UserName = 'ppChkPurchase'
        CheckboxState = cbUnchecked
        Checked = False
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5146
        mmLeft = 116682
        mmTop = 20825
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText66: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'TranTime'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsUnderline]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 3969
        mmLeft = 93255
        mmTop = 15738
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText67: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 3969
        mmLeft = 91279
        mmTop = 4788
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel25: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label10'
        Border.mmPadding = 0
        Caption = 'CONTROL #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3968
        mmLeft = 133086
        mmTop = 27
        mmWidth = 14287
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel26: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label11'
        Border.mmPadding = 0
        Caption = 'TRANSACTION DATE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3524
        mmLeft = 84667
        mmTop = 323
        mmWidth = 24871
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel27: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label12'
        Border.mmPadding = 0
        Caption = 'FLORIDA PAWNBROKER TRANSACTION FORM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 265
        mmTop = 0
        mmWidth = 57679
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel28: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label13'
        Border.mmPadding = 0
        Caption = 'DEPT #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 133086
        mmTop = 8403
        mmWidth = 8466
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel29: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label14'
        Border.mmPadding = 0
        Caption = 'MATURITY DATE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 133086
        mmTop = 15738
        mmWidth = 19844
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel30: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label15'
        Border.mmPadding = 0
        Caption = 'TIME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 86171
        mmTop = 15738
        mmWidth = 5820
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel31: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label16'
        Border.mmPadding = 0
        Caption = 'TYPE OF TRANSACTION'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 86171
        mmTop = 21559
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel32: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label17'
        Border.mmPadding = 0
        Caption = 'PURCHASE TRADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 122502
        mmTop = 21559
        mmWidth = 22490
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel33: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label18'
        Border.mmPadding = 0
        Caption = 'PAWN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 162984
        mmTop = 21559
        mmWidth = 7143
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel34: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label19'
        Border.mmPadding = 0
        Caption = 'Pawnbroker / Creditor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3779
        mmLeft = 265
        mmTop = 3209
        mmWidth = 24077
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine1: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line1'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 50726
        mmLeft = 2902
        mmTop = 25974
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine2: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line2'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 2236
        mmLeft = 265
        mmTop = 54965
        mmWidth = 202604
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel35: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label20'
        Angle = 90
        Border.mmPadding = 0
        Caption = 'PLEDGOR / SELLER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 23548
        mmLeft = 1055
        mmTop = 28661
        mmWidth = 3704
        BandType = 0
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 23548
      end
      object ppLabel36: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label21'
        Angle = 90
        Border.mmPadding = 0
        Caption = 'CODES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 8731
        mmLeft = 1055
        mmTop = 60800
        mmWidth = 3704
        BandType = 0
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 8731
      end
      object ppLabel37: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label22'
        Border.mmPadding = 0
        Caption = 'Name (Last, First Middle)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 7144
        mmTop = 26281
        mmWidth = 21696
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel38: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label38'
        Border.mmPadding = 0
        Caption = 'Date of Birth'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 110596
        mmTop = 26281
        mmWidth = 10583
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel39: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label39'
        Border.mmPadding = 0
        Caption = 'Sex (M/F)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 148211
        mmTop = 26281
        mmWidth = 8466
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel40: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label40'
        Border.mmPadding = 0
        Caption = 'Race'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 165410
        mmTop = 26281
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine3: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line3'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 1541
        mmLeft = 5556
        mmTop = 33369
        mmWidth = 170478
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText57: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText104'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cPrnHPhone'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3704
        mmLeft = 129911
        mmTop = 36777
        mmWidth = 15610
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine4: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line4'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7334
        mmLeft = 107156
        mmTop = 25975
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine5: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line5'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7334
        mmLeft = 142398
        mmTop = 25972
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine6: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line6'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7334
        mmLeft = 158918
        mmTop = 25972
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine7: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line7'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 21760
        mmLeft = 173319
        mmTop = 25972
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel41: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label23'
        Border.mmPadding = 0
        Caption = 'W. WHITE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2847
        mmLeft = 179123
        mmTop = 27224
        mmWidth = 9261
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel42: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label42'
        Border.mmPadding = 0
        Caption = 'B. BLACK'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2847
        mmLeft = 179123
        mmTop = 30712
        mmWidth = 8732
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel43: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label43'
        Border.mmPadding = 0
        Caption = 'I. AMERICAN INDIAN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2847
        mmLeft = 179123
        mmTop = 33812
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel44: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label44'
        Border.mmPadding = 0
        Caption = 'A. ASIAN/ORIENTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2847
        mmLeft = 179123
        mmTop = 37060
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel45: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label45'
        Border.mmPadding = 0
        Caption = 'H. HISPANIC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2847
        mmLeft = 179123
        mmTop = 40327
        mmWidth = 11377
        BandType = 0
        LayerName = Foreground1
      end
      object ppDBText58: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText11'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustPlaceEmply'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3704
        mmLeft = 7144
        mmTop = 43921
        mmWidth = 20108
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine9: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line9'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 21356
        mmLeft = 126739
        mmTop = 33543
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine10: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line10'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 1852
        mmLeft = 5408
        mmTop = 38762
        mmWidth = 170375
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel10: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1'
        OnGetText = ppLabel1GetText
        Border.mmPadding = 0
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 7144
        mmTop = 36967
        mmWidth = 8466
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel46: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label46'
        Border.mmPadding = 0
        Caption = 'Residential Address (Street, Apt. No. City, State & Zip Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 7129
        mmTop = 33617
        mmWidth = 51329
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel47: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label47'
        Border.mmPadding = 0
        Caption = 'Home Number (Area Code & Number)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 130571
        mmTop = 33618
        mmWidth = 31750
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel48: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label48'
        Border.mmPadding = 0
        Caption = 'Place of Employment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 7144
        mmTop = 40949
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel49: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label49'
        Border.mmPadding = 0
        Caption = 'Business Number (Area Code & Number)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3235
        mmLeft = 130175
        mmTop = 41008
        mmWidth = 34925
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel50: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label50'
        Border.mmPadding = 0
        Caption = 'D.L. # / Official Photo Id #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 7144
        mmTop = 48059
        mmWidth = 22225
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel51: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label501'
        Border.mmPadding = 0
        Caption = 'Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 41010
        mmTop = 48059
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel52: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label52'
        Border.mmPadding = 0
        Caption = 'Agency/State'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 74911
        mmTop = 48059
        mmWidth = 11641
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel53: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label53'
        Border.mmPadding = 0
        Caption = 'HGT.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 100366
        mmTop = 48249
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel54: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label54'
        Border.mmPadding = 0
        Caption = 'WGT.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 116771
        mmTop = 48249
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel55: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label55'
        Border.mmPadding = 0
        Caption = 'EYES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 132597
        mmTop = 48249
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel56: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label56'
        Border.mmPadding = 0
        Caption = 'HAIR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 144701
        mmTop = 48059
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel57: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label57'
        Border.mmPadding = 0
        Caption = 'Identifying Marks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 155489
        mmTop = 48059
        mmWidth = 14817
        BandType = 0
        LayerName = Foreground1
      end
      object ppShape3: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape3'
        Brush.Color = clSilver
        Pen.Style = psClear
        mmHeight = 21777
        mmLeft = 5556
        mmTop = 55005
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel58: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label24'
        Angle = 90
        Border.mmPadding = 0
        Caption = 'FIREARM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial Narrow'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 11906
        mmLeft = 5795
        mmTop = 59827
        mmWidth = 3969
        BandType = 0
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 11906
      end
      object ppShape4: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape4'
        Brush.Color = clSilver
        Pen.Style = psClear
        mmHeight = 21696
        mmLeft = 83873
        mmTop = 55005
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel59: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label59'
        Angle = 90
        Border.mmPadding = 0
        Caption = 'JEWELRY'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial Narrow'
        Font.Size = 9
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 12965
        mmLeft = 84316
        mmTop = 59588
        mmWidth = 3969
        BandType = 0
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 12965
      end
      object ppLabel60: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label25'
        Border.mmPadding = 0
        Caption = 'TYPE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2552
        mmLeft = 12435
        mmTop = 56328
        mmWidth = 4234
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel61: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label26'
        Border.mmPadding = 0
        Caption = 'H. Handgun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2202
        mmLeft = 12435
        mmTop = 58593
        mmWidth = 7409
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel62: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label62'
        Border.mmPadding = 0
        Caption = 'R. Rifle'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2054
        mmLeft = 12435
        mmTop = 60467
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel63: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label63'
        Border.mmPadding = 0
        Caption = 'S. Shotgun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2202
        mmLeft = 12435
        mmTop = 62404
        mmWidth = 6615
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel64: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label64'
        Border.mmPadding = 0
        Caption = 'A. Airgun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2202
        mmLeft = 12435
        mmTop = 64458
        mmWidth = 5821
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel65: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label65'
        Border.mmPadding = 0
        Caption = 'B. Black Powder'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2202
        mmLeft = 12435
        mmTop = 66543
        mmWidth = 10319
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel66: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label66'
        Border.mmPadding = 0
        Caption = 'BARREL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 29633
        mmTop = 56328
        mmWidth = 7409
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel67: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label67'
        Border.mmPadding = 0
        Caption = '1. Single'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 29633
        mmTop = 58593
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel68: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label68'
        Border.mmPadding = 0
        Caption = '2. Double'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 29633
        mmTop = 60467
        mmWidth = 5821
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel69: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label69'
        Border.mmPadding = 0
        Caption = '3. Over Under'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 29633
        mmTop = 62404
        mmWidth = 8732
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel70: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label70'
        Border.mmPadding = 0
        Caption = '4. Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 29633
        mmTop = 64458
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel71: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label71'
        Border.mmPadding = 0
        Caption = 'ACTION'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 45773
        mmTop = 56328
        mmWidth = 6879
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel72: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label72'
        Border.mmPadding = 0
        Caption = 'R. Revolver'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 45508
        mmTop = 58593
        mmWidth = 7409
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel73: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label73'
        Border.mmPadding = 0
        Caption = 'A. Semi-Auto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 45508
        mmTop = 60467
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel74: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label74'
        Border.mmPadding = 0
        Caption = 'B. Bolt Action'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 45508
        mmTop = 62404
        mmWidth = 8732
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel75: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label75'
        Border.mmPadding = 0
        Caption = 'L. Lever'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 45508
        mmTop = 64458
        mmWidth = 5028
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel76: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label76'
        Border.mmPadding = 0
        Caption = 'P. Pump'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 45508
        mmTop = 66543
        mmWidth = 5028
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel77: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label77'
        Border.mmPadding = 0
        Caption = 'S. Single Shot'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 45508
        mmTop = 68862
        mmWidth = 8203
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel78: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label78'
        Border.mmPadding = 0
        Caption = 'FINISH'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 63236
        mmTop = 56328
        mmWidth = 5820
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel79: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label79'
        Border.mmPadding = 0
        Caption = 'C. Chrome Nickel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 63236
        mmTop = 58593
        mmWidth = 11112
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel80: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label80'
        Border.mmPadding = 0
        Caption = 'B. Blue Steel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 63236
        mmTop = 60467
        mmWidth = 7937
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel81: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label81'
        Border.mmPadding = 0
        Caption = 'S. Stainless Steel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 63236
        mmTop = 62404
        mmWidth = 10583
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel82: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label701'
        Border.mmPadding = 0
        Caption = 'X. Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 63236
        mmTop = 64458
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel83: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label83'
        Border.mmPadding = 0
        Caption = 'TYPE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 90488
        mmTop = 55440
        mmWidth = 4233
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel84: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label84'
        Border.mmPadding = 0
        Caption = 'R. Ring'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 57301
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel85: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label85'
        Border.mmPadding = 0
        Caption = 'W. Watch'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 59360
        mmWidth = 6085
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel86: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label86'
        Border.mmPadding = 0
        Caption = 'N. Necklace'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 61280
        mmWidth = 7673
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel87: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label87'
        Border.mmPadding = 0
        Caption = 'B. Bracelet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 63199
        mmWidth = 7143
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel88: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label88'
        Border.mmPadding = 0
        Caption = 'P. Pendam Charm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 65119
        mmWidth = 11377
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel89: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label89'
        Border.mmPadding = 0
        Caption = 'METAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 110336
        mmTop = 55440
        mmWidth = 5821
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel90: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label90'
        Border.mmPadding = 0
        Caption = 'Y. Yellow Gold'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2117
        mmLeft = 110422
        mmTop = 57386
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel91: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label91'
        Border.mmPadding = 0
        Caption = 'W. White Gold'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2117
        mmLeft = 110422
        mmTop = 59324
        mmWidth = 8731
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel92: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label92'
        Border.mmPadding = 0
        Caption = 'S. Sterling Silver'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2117
        mmLeft = 110422
        mmTop = 61176
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel93: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label93'
        Border.mmPadding = 0
        Caption = 'P. Platimum'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2117
        mmLeft = 110422
        mmTop = 63292
        mmWidth = 7408
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel94: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label94'
        Border.mmPadding = 0
        Caption = 'T. Tri-Color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2117
        mmLeft = 110422
        mmTop = 65028
        mmWidth = 6879
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel95: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label95'
        Border.mmPadding = 0
        Caption = 'GENDER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 127799
        mmTop = 55440
        mmWidth = 7408
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel96: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label901'
        Border.mmPadding = 0
        Caption = 'M. Man'#39's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 127799
        mmTop = 57386
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel97: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label97'
        Border.mmPadding = 0
        Caption = 'W. Woman'#39's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 127799
        mmTop = 59324
        mmWidth = 7937
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel98: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label98'
        Border.mmPadding = 0
        Caption = 'N. Not Applicable'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 127799
        mmTop = 61176
        mmWidth = 10848
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel101: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label101'
        Border.mmPadding = 0
        Caption = 'STYLE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 147211
        mmTop = 55440
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel107: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label107'
        Border.mmPadding = 0
        Caption = 'STONE SHAPE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 168817
        mmTop = 55440
        mmWidth = 12171
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel113: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label113'
        Border.mmPadding = 0
        Caption = 'STONE COLOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2108
        mmLeft = 188926
        mmTop = 55588
        mmWidth = 12700
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel119: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label119'
        Border.mmPadding = 0
        Caption = 'E. Earrings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 67039
        mmWidth = 6615
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel120: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label120'
        Border.mmPadding = 0
        Caption = 'C. Chain'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 68959
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel121: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1201'
        Border.mmPadding = 0
        Caption = 'L. Cufflinks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 70879
        mmWidth = 7144
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel122: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1202'
        Border.mmPadding = 0
        Caption = 'X. Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 90488
        mmTop = 72755
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel123: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label123'
        Border.mmPadding = 0
        Caption = 'X. Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2117
        mmLeft = 110422
        mmTop = 66880
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel99: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label99'
        Border.mmPadding = 0
        Caption = 'E. Emerald'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 57301
        mmWidth = 6615
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel100: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label100'
        Border.mmPadding = 0
        Caption = 'H. Heart'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 59064
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel108: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label108'
        Border.mmPadding = 0
        Caption = 'M. Marquise'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 60984
        mmWidth = 7409
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel109: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label109'
        Border.mmPadding = 0
        Caption = 'O. Oval'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 62903
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel110: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label110'
        Border.mmPadding = 0
        Caption = 'P. Pear'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 64823
        mmWidth = 4234
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel111: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label111'
        Border.mmPadding = 0
        Caption = 'R. Round'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 66743
        mmWidth = 5821
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel112: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1203'
        Border.mmPadding = 0
        Caption = 'X. Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 171463
        mmTop = 68663
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel114: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label114'
        Border.mmPadding = 0
        Caption = 'R. Red/Pink'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 70583
        mmWidth = 7144
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel115: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1204'
        Border.mmPadding = 0
        Caption = 'P. Purple'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 68663
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel116: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label116'
        Border.mmPadding = 0
        Caption = 'O. Brown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 66891
        mmWidth = 5821
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel117: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label117'
        Border.mmPadding = 0
        Caption = 'K. Black'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 65119
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel118: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label118'
        Border.mmPadding = 0
        Caption = 'G. Green'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 63051
        mmWidth = 5556
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel124: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label124'
        Border.mmPadding = 0
        Caption = 'C. Clear'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 60984
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel125: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label125'
        Border.mmPadding = 0
        Caption = 'B. Blue'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 59212
        mmWidth = 4498
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel126: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label126'
        Border.mmPadding = 0
        Caption = 'A. Amber'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 57301
        mmWidth = 6086
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel127: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label127'
        Border.mmPadding = 0
        Caption = 'W. White'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 72459
        mmWidth = 6297
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel128: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label128'
        Border.mmPadding = 0
        Caption = 'Y. Yellow'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 191836
        mmTop = 74320
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel130: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label130'
        Border.mmPadding = 0
        Caption = 'B. Box Link'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2054
        mmLeft = 147386
        mmTop = 57301
        mmWidth = 7144
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel131: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label131'
        Border.mmPadding = 0
        Caption = 'C. Class School'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 59064
        mmWidth = 9790
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel132: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label132'
        Border.mmPadding = 0
        Caption = 'F. Figaro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 60836
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel133: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label133'
        Border.mmPadding = 0
        Caption = 'G. Gucci'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 62607
        mmWidth = 5292
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel134: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label134'
        Border.mmPadding = 0
        Caption = 'H. Herringbone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 64379
        mmWidth = 9525
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel135: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label135'
        Border.mmPadding = 0
        Caption = 'M. Monogram'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 66447
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel136: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label136'
        Border.mmPadding = 0
        Caption = 'N. Nugget'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 68367
        mmWidth = 6350
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel137: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label137'
        Border.mmPadding = 0
        Caption = 'O. Solitaire'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 70287
        mmWidth = 6615
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel138: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label138'
        Border.mmPadding = 0
        Caption = 'P. Band'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 72163
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel139: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label139'
        Border.mmPadding = 0
        Caption = 'R. Rope'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 147386
        mmTop = 74266
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel102: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label102'
        Border.mmPadding = 0
        Caption = 'S. Serpentine'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 158014
        mmTop = 72225
        mmWidth = 8202
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel103: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label103'
        Border.mmPadding = 0
        Caption = 'X. Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Browallia New'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2116
        mmLeft = 158014
        mmTop = 74266
        mmWidth = 5027
        BandType = 0
        LayerName = Foreground1
      end
      object ppLabel175: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label105'
        Border.mmPadding = 0
        Caption = 'You are giving a security interest in the following property'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 2869
        mmLeft = 4048
        mmTop = 76594
        mmWidth = 49477
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine29: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line29'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 1512
        mmLeft = 380
        mmTop = 75408
        mmWidth = 202440
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine44: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line44'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 37530
        mmTop = 47551
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine45: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line45'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 71661
        mmTop = 47815
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine46: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line46'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 94382
        mmTop = 47774
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine47: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line47'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 111104
        mmTop = 47774
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine49: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line49'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 139592
        mmTop = 47774
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
      object ppLine50: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line50'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 152441
        mmTop = 47815
        mmWidth = 2646
        BandType = 0
        LayerName = Foreground1
      end
    end
    object ppDetailBand1: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 21431
      mmPrintPosition = 0
      object ppLine38: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line35'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 1509
        mmLeft = 5365
        mmTop = 6853
        mmWidth = 197643
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine37: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line34'
        Border.mmPadding = 0
        Pen.Color = clGray
        ParentHeight = True
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 21431
        mmLeft = 200280
        mmTop = 0
        mmWidth = 2632
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine34: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line32'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 1211
        mmLeft = 190
        mmTop = 0
        mmWidth = 202678
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText68: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText21'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'SerialNumber'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3514
        mmLeft = 7144
        mmTop = 3630
        mmWidth = 16933
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText69: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText22'
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 6004
        mmTop = 18033
        mmWidth = 8243
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText70: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText23'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'InvItemBrand'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 129382
        mmTop = 3630
        mmWidth = 16404
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText71: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText24'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JStyle'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 58942
        mmTop = 18033
        mmWidth = 9573
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText72: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText25'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'UnitCost'
        DataPipeline = DBPPawnItemsLaser
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 171186
        mmTop = 10319
        mmWidth = 10583
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText73: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText26'
        Border.mmPadding = 0
        DataField = 'JMetal'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 15610
        mmTop = 18033
        mmWidth = 8508
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText74: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText28'
        Border.mmPadding = 0
        DataField = 'cWeightToPrint'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 34931
        mmTop = 17992
        mmWidth = 12823
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText75: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText29'
        Border.mmPadding = 0
        DataField = 'SizeLength'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 70115
        mmTop = 18033
        mmWidth = 12473
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText76: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText30'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'OwnerAppNumber'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3514
        mmLeft = 72761
        mmTop = 3630
        mmWidth = 24077
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText77: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText31'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'ModelNumber'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 165148
        mmTop = 3630
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText78: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText32'
        Border.mmPadding = 0
        DataField = 'Description'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 7210
        mmTop = 10390
        mmWidth = 101865
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText79: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText37'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 110067
        mmTop = 3704
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText80: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText38'
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3704
        mmLeft = 110067
        mmTop = 10390
        mmWidth = 4484
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText81: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText33'
        Border.mmPadding = 0
        DataField = 'Gender'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 48154
        mmTop = 18033
        mmWidth = 9458
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText82: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText34'
        Border.mmPadding = 0
        DataField = 'cStone1Qty'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 90081
        mmTop = 18223
        mmWidth = 8711
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText83: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText35'
        Border.mmPadding = 0
        DataField = 'cStone1Shape'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 99885
        mmTop = 18033
        mmWidth = 7440
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText84: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText39'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cStone1WT'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 118001
        mmTop = 18033
        mmWidth = 14817
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText85: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText40'
        Border.mmPadding = 0
        DataField = 'cStone1Color'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 133350
        mmTop = 18033
        mmWidth = 6192
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText86: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText36'
        Border.mmPadding = 0
        DataField = 'cStone1CT'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 109545
        mmTop = 18033
        mmWidth = 10651
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText87: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText45'
        Border.mmPadding = 0
        DataField = 'cStone2Qty'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 147787
        mmTop = 18033
        mmWidth = 7190
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText88: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText46'
        Border.mmPadding = 0
        DataField = 'cStone2Shape'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 157163
        mmTop = 18033
        mmWidth = 5920
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText89: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText47'
        Border.mmPadding = 0
        DataField = 'cStone2CT'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 165100
        mmTop = 18033
        mmWidth = 12095
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText90: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText48'
        Border.mmPadding = 0
        DataField = 'cStone2WT'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 177534
        mmTop = 18033
        mmWidth = 12171
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText91: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText401'
        Border.mmPadding = 0
        DataField = 'cStone2Color'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 190765
        mmTop = 18033
        mmWidth = 10583
        BandType = 4
        LayerName = Foreground1
      end
      object ppDBText92: TppDBText
        DesignLayer = ppDesignLayer2
        UserName = 'DBText27'
        Border.mmPadding = 0
        DataField = 'KT'
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 3325
        mmLeft = 25891
        mmTop = 18033
        mmWidth = 9829
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine35: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line33'
        Border.mmPadding = 0
        Pen.Color = clGray
        ParentHeight = True
        Position = lpLeft
        Weight = 0.75000000000000000
        mmHeight = 21431
        mmLeft = 5139
        mmTop = 0
        mmWidth = 1411
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel176: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label112'
        Angle = 90
        OnGetText = ppLabel176GetText
        Border.mmPadding = 0
        Caption = 'ITEM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 6085
        mmLeft = 1043
        mmTop = 8468
        mmWidth = 3704
        BandType = 4
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 6085
      end
      object ppLine36: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line36'
        Border.mmPadding = 0
        Pen.Color = clGray
        ParentHeight = True
        Position = lpLeft
        Weight = 0.75000000000000000
        mmHeight = 21431
        mmLeft = 297
        mmTop = 0
        mmWidth = 1411
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel177: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label115'
        Border.mmPadding = 0
        Caption = 'Serial Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3662
        mmLeft = 6085
        mmTop = 324
        mmWidth = 13026
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel178: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label121'
        Border.mmPadding = 0
        Caption = 'Owner Applied Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 72348
        mmTop = 358
        mmWidth = 19844
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel179: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label122'
        Border.mmPadding = 0
        Caption = 'Item Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3175
        mmLeft = 109471
        mmTop = 358
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel180: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label143'
        Border.mmPadding = 0
        Caption = 'Brand'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 129117
        mmTop = 358
        mmWidth = 5027
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel181: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label145'
        Border.mmPadding = 0
        Caption = 'Model Nnumber'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 165100
        mmTop = 265
        mmWidth = 13494
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel182: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label147'
        Border.mmPadding = 0
        Caption = 
          'Description of Item (Inscription, color, size,marks, design, sch' +
          'ool year, Initials, Barrel length'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 6085
        mmTop = 6879
        mmWidth = 78846
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel183: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label148'
        Border.mmPadding = 0
        Caption = 'Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 110085
        mmTop = 6979
        mmWidth = 4498
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel184: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label149'
        Border.mmPadding = 0
        Caption = 'Action'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 120296
        mmTop = 7169
        mmWidth = 5557
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel185: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label150'
        Border.mmPadding = 0
        Caption = 'Gauge Caliber'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 129382
        mmTop = 6879
        mmWidth = 12436
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel186: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label151'
        Border.mmPadding = 0
        Caption = 'Finish'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 148517
        mmTop = 6979
        mmWidth = 5557
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel187: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label152'
        Border.mmPadding = 0
        Caption = 'Barrel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 159008
        mmTop = 6979
        mmWidth = 5027
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel188: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label154'
        Border.mmPadding = 0
        Caption = 'Amount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 170657
        mmTop = 6879
        mmWidth = 6614
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine39: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line37'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 1714
        mmLeft = 5263
        mmTop = 14083
        mmWidth = 197651
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel189: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label155'
        Border.mmPadding = 0
        Caption = 'Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 7938
        mmTop = 14817
        mmWidth = 4497
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel190: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label190'
        Border.mmPadding = 0
        Caption = 'Metal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 17463
        mmTop = 14817
        mmWidth = 4762
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel191: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label156'
        Border.mmPadding = 0
        Caption = 'KT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 28840
        mmTop = 14817
        mmWidth = 2645
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel192: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label157'
        Border.mmPadding = 0
        Caption = 'WT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 40481
        mmTop = 14817
        mmWidth = 3175
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel193: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label158'
        Border.mmPadding = 0
        Caption = 'Gender'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 49742
        mmTop = 14817
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel194: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label159'
        Border.mmPadding = 0
        Caption = 'Style'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 61119
        mmTop = 14817
        mmWidth = 4498
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel195: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label160'
        Border.mmPadding = 0
        Caption = 'Size Length'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 70379
        mmTop = 14817
        mmWidth = 10319
        BandType = 4
        LayerName = Foreground1
      end
      object ppShape7: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape7'
        Brush.Color = clSilver
        Pen.Style = psClear
        mmHeight = 7169
        mmLeft = 82815
        mmTop = 14263
        mmWidth = 6904
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel196: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label161'
        Angle = 90
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'First'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5869
        mmLeft = 83314
        mmTop = 14604
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 4919
      end
      object ppLabel197: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label162'
        Angle = 90
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Stone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5870
        mmLeft = 86052
        mmTop = 14605
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 5317
      end
      object ppLabel198: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label171'
        Border.mmPadding = 0
        Caption = '#Stones'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 90488
        mmTop = 14817
        mmWidth = 7143
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel199: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label172'
        Border.mmPadding = 0
        Caption = 'Shape'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 100542
        mmTop = 14817
        mmWidth = 5556
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel200: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label175'
        Border.mmPadding = 0
        Caption = 'CT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 109538
        mmTop = 14817
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel201: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label176'
        Border.mmPadding = 0
        Caption = 'WT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 127265
        mmTop = 14817
        mmWidth = 3175
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel202: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label177'
        Border.mmPadding = 0
        Caption = 'Color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 133879
        mmTop = 14817
        mmWidth = 4498
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine40: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line38'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7259
        mmLeft = 97518
        mmTop = 14288
        mmWidth = 1890
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine42: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line42'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7334
        mmLeft = 130519
        mmTop = 14328
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppShape8: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape8'
        Brush.Color = clSilver
        Pen.Style = psClear
        mmHeight = 7169
        mmLeft = 140010
        mmTop = 14453
        mmWidth = 6904
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel203: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label203'
        Angle = 90
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Second'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5870
        mmLeft = 140155
        mmTop = 14985
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 6110
      end
      object ppLabel204: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label204'
        Angle = 90
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Stone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5870
        mmLeft = 143065
        mmTop = 14795
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 5317
      end
      object ppLabel205: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label205'
        Border.mmPadding = 0
        Caption = '#Stones'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 147373
        mmTop = 14817
        mmWidth = 7144
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel206: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label206'
        Border.mmPadding = 0
        Caption = 'Shape'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 157163
        mmTop = 14817
        mmWidth = 5556
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel207: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label207'
        Border.mmPadding = 0
        Caption = 'CT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 169334
        mmTop = 14817
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel208: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label208'
        Border.mmPadding = 0
        Caption = 'WT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 181769
        mmTop = 14817
        mmWidth = 3175
        BandType = 4
        LayerName = Foreground1
      end
      object ppLabel209: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label209'
        Border.mmPadding = 0
        Caption = 'Color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 193146
        mmTop = 14817
        mmWidth = 4498
        BandType = 4
        LayerName = Foreground1
      end
      object calcItem: TppDBCalc
        DesignLayer = ppDesignLayer2
        UserName = 'calcItem'
        Angle = 90
        Border.mmPadding = 0
        DataPipeline = DBPPawnItemsLaser
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        Visible = False
        DBCalcType = dcCount
        DataPipelineName = 'DBPPawnItemsLaser'
        mmHeight = 4498
        mmLeft = 1058
        mmTop = 15875
        mmWidth = 2910
        BandType = 4
        LayerName = Foreground1
        RotatedOriginLeft = 0
        RotatedOriginTop = 4498
      end
      object ppLine13: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line13'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7371
        mmLeft = 167255
        mmTop = 6879
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine14: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line14'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7218
        mmLeft = 68527
        mmTop = 0
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine32: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line30'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 161396
        mmTop = 0
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine33: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line39'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 21167
        mmLeft = 105684
        mmTop = 265
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine43: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line43'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 125413
        mmTop = 0
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine51: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line51'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 12625
        mmTop = 14403
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine52: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line52'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 22951
        mmTop = 14478
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine53: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line53'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 33941
        mmTop = 14288
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine54: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line54'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 45169
        mmTop = 14403
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine55: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line55'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 55834
        mmTop = 14403
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine56: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line56'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 66791
        mmTop = 14403
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine57: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line57'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 154592
        mmTop = 14288
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine58: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line58'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 162644
        mmTop = 14295
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine59: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line59'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 176138
        mmTop = 14288
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine60: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line60'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7408
        mmLeft = 187597
        mmTop = 14403
        mmWidth = 2117
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine41: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line41'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 115948
        mmTop = 7069
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine61: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line61'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 125406
        mmTop = 6879
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine62: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line62'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 144198
        mmTop = 6879
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
      object ppLine63: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line63'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 7144
        mmLeft = 155046
        mmTop = 6879
        mmWidth = 2646
        BandType = 4
        LayerName = Foreground1
      end
    end
    object ppFooterBand1: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 60960
      mmPrintPosition = 0
      object ppShape6: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape6'
        Pen.Color = clGray
        mmHeight = 8042
        mmLeft = 15
        mmTop = 41486
        mmWidth = 43077
        BandType = 8
        LayerName = Foreground1
      end
      object ppShape5: TppShape
        DesignLayer = ppDesignLayer2
        UserName = 'Shape5'
        Pen.Color = clGray
        mmHeight = 16745
        mmLeft = 0
        mmTop = 23840
        mmWidth = 43148
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine19: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line19'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpLeft
        Weight = 0.75000000000000000
        mmHeight = 22770
        mmLeft = 0
        mmTop = 343
        mmWidth = 2388
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine11: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line11'
        Border.mmPadding = 0
        Pen.Color = clGray
        ParentWidth = True
        Weight = 0.75000000000000000
        mmHeight = 2117
        mmLeft = 0
        mmTop = 190
        mmWidth = 203200
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel15: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label6'
        OnGetText = lblAmountGetText
        Border.mmPadding = 0
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 6615
        mmTop = 8519
        mmWidth = 6350
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel16: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label7'
        OnGetText = ppLabel7GetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 14280
        mmTop = 44911
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel17: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblTranInsAmount1Month'
        OnGetText = lblTranInterestAtMaturityGetText
        Border.mmPadding = 0
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 45039
        mmTop = 8139
        mmWidth = 6350
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel18: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblTotalPay1Month'
        OnGetText = lblTotalAmountAtMaturityGetText
        Border.mmPadding = 0
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 89694
        mmTop = 8139
        mmWidth = 6350
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel19: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblAnnualPercRate'
        OnGetText = lblAnnualPercRateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 137398
        mmTop = 8214
        mmWidth = 5027
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel20: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblTranMaturity'
        OnGetText = lblTranMaturityGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 174096
        mmTop = 5829
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel21: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblPawnDefaultDate'
        OnGetText = lblPawnDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 16111
        mmTop = 28028
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel22: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'lblTAmountRedeemDefaultDate'
        OnGetText = lblTAmountRedeemDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 23114
        mmTop = 36135
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel23: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label8'
        Angle = 270
        OnGetText = ppLabel8GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '01.MIAMIAA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 29633
        mmLeft = 191030
        mmTop = 15283
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground1
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
      object ppLabel24: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label9'
        Angle = 270
        OnGetText = ppLabel9GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '5678'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 29633
        mmLeft = 197320
        mmTop = 15343
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground1
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
      object ppLabel104: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label27'
        Border.mmPadding = 0
        Caption = 'AMOUNT FINANCED'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3354
        mmLeft = 2303
        mmTop = 570
        mmWidth = 24077
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel105: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label28'
        Border.mmPadding = 0
        Caption = 'The amount of cash given directly to you'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Agency FB'
        Font.Size = 8
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 1588
        mmTop = 3175
        mmWidth = 36247
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel106: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label106'
        Border.mmPadding = 0
        Caption = 'FINANCE CHARGE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 41804
        mmTop = 570
        mmWidth = 23019
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel129: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label129'
        Border.mmPadding = 0
        Caption = 'The dollar amount the credit will cost you'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Agency FB'
        Font.Size = 8
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 41804
        mmTop = 3175
        mmWidth = 37571
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine15: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line15'
        Anchors = [atTop, atRight]
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 12441
        mmLeft = 38894
        mmTop = 264
        mmWidth = 1588
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel140: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label140'
        Border.mmPadding = 0
        Caption = 'TOTAL OF PAYMENTS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3399
        mmLeft = 86254
        mmTop = 570
        mmWidth = 26459
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel141: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label141'
        Border.mmPadding = 0
        Caption = 'Amount required to redeem'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Agency FB'
        Font.Size = 8
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 86254
        mmTop = 2645
        mmWidth = 25400
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel142: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label142'
        Border.mmPadding = 0
        Caption = 'property on the Maturity Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Agency FB'
        Font.Size = 8
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 86254
        mmTop = 5026
        mmWidth = 27252
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine16: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line16'
        Anchors = [atTop, atRight]
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 12441
        mmLeft = 82405
        mmTop = 264
        mmWidth = 1588
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel143: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label1401'
        Border.mmPadding = 0
        Caption = 'ANNUAL PERCENTAGE RATE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 125453
        mmTop = 570
        mmWidth = 35984
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel144: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label144'
        Border.mmPadding = 0
        Caption = 'The cost of your credit as a yearly rate'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Agency FB'
        Font.Size = 8
        Font.Style = [fsItalic]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 125413
        mmTop = 3440
        mmWidth = 35719
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine17: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line17'
        Anchors = [atTop, atRight]
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 12441
        mmLeft = 121914
        mmTop = 264
        mmWidth = 1588
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel145: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label29'
        Border.mmPadding = 0
        Caption = 'MATURITY DATE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 168573
        mmTop = 570
        mmWidth = 19844
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine18: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line18'
        Anchors = [atTop, atRight]
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 12441
        mmLeft = 165048
        mmTop = 264
        mmWidth = 1588
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel147: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label31'
        Border.mmPadding = 0
        Caption = 'PREPAYMENT.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 54716
        mmTop = 13520
        mmWidth = 17727
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel148: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label32'
        Border.mmPadding = 0
        Caption = 'If you payoff early,  you will not'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 73118
        mmTop = 13520
        mmWidth = 26988
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel149: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label33'
        Border.mmPadding = 0
        Caption = ' be entitled to a refund of part of a Finance Charge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 54597
        mmTop = 16297
        mmWidth = 42863
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel150: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label34'
        Border.mmPadding = 0
        Caption = 'See your contract for any additional information'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3251
        mmLeft = 903
        mmTop = 13520
        mmWidth = 40481
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel151: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label35'
        Border.mmPadding = 0
        Caption = 'concerning nonpayment and default and prepayment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 794
        mmTop = 16378
        mmWidth = 44979
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel152: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label36'
        Border.mmPadding = 0
        Caption = 'refunds or penalties.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3251
        mmLeft = 903
        mmTop = 19334
        mmWidth = 17462
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine20: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line20'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 10230
        mmLeft = 50285
        mmTop = 12712
        mmWidth = 2388
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel146: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label146'
        Border.mmPadding = 0
        Caption = 'PREPAYMENT SCHEDULE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 106086
        mmTop = 13520
        mmWidth = 30692
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel153: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label153'
        Border.mmPadding = 0
        Caption = 'Total of payments is due on maturity date shown above'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 106165
        mmTop = 16297
        mmWidth = 47889
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine21: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line201'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 10231
        mmLeft = 101495
        mmTop = 12738
        mmWidth = 2381
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine22: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line21'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 1304
        mmLeft = 238
        mmTop = 22986
        mmWidth = 156312
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel154: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label30'
        Border.mmPadding = 0
        Caption = 'Pawn Default Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3705
        mmLeft = 2124
        mmTop = 24700
        mmWidth = 23812
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine24: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line22'
        Border.mmPadding = 0
        Pen.Color = clGray
        Weight = 0.75000000000000000
        mmHeight = 1919
        mmLeft = 33
        mmTop = 31864
        mmWidth = 42954
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel155: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label37'
        Border.mmPadding = 0
        Caption = 'Amount required to redeem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3434
        mmLeft = 636
        mmTop = 32076
        mmWidth = 21960
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel156: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label41'
        Border.mmPadding = 0
        Caption = 'pledge property on'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3434
        mmLeft = 636
        mmTop = 34502
        mmWidth = 15346
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel157: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label51'
        Border.mmPadding = 0
        Caption = 'pawn default date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 6
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3434
        mmLeft = 636
        mmTop = 37353
        mmWidth = 14817
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel158: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label58'
        Border.mmPadding = 0
        Caption = 'PURCHASE / TRADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 8
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3779
        mmLeft = 7871
        mmTop = 41281
        mmWidth = 24077
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine25: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line24'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 3440
        mmLeft = 768
        mmTop = 54656
        mmWidth = 39891
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel159: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label60'
        Border.mmPadding = 0
        Caption = 'Employee'#39's Initials or Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3235
        mmLeft = 3711
        mmTop = 57724
        mmWidth = 25665
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine26: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line25'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 58104
        mmLeft = 200492
        mmTop = 518
        mmWidth = 2646
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine27: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line27'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 45374
        mmLeft = 193585
        mmTop = 13032
        mmWidth = 2646
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine28: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line28'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 45563
        mmLeft = 186910
        mmTop = 13032
        mmWidth = 2646
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine30: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line26'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 4174
        mmLeft = 156495
        mmTop = 54311
        mmWidth = 46644
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine31: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line31'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 3440
        mmLeft = 52388
        mmTop = 54515
        mmWidth = 97489
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel160: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label601'
        Border.mmPadding = 0
        Caption = 'Pledgor/Seller'#39's Signature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 55033
        mmTop = 57521
        mmWidth = 22225
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel161: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label61'
        Border.mmPadding = 0
        Caption = 'X'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Black'
        Font.Size = 18
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 8731
        mmLeft = 47334
        mmTop = 50666
        mmWidth = 5027
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel162: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label82'
        Border.mmPadding = 0
        Caption = 
          'The Pledgor/Seller represents and warrants that the pledge/sold ' +
          'property is not stolen, rented or leased and that they have'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 25535
        mmWidth = 104511
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel163: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label163'
        Border.mmPadding = 0
        Caption = 
          ' to liens or emcumbraces against them. Pledgor/Seller also attes' +
          't to be the rightful owner  of the pledge/sold property,'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 28248
        mmWidth = 100542
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel164: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label164'
        Border.mmPadding = 0
        Caption = 
          ' voluntary or involuntary bankrupcy of any type and  is at least' +
          ' 18 year of age.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 34396
        mmWidth = 66676
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel165: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label165'
        Border.mmPadding = 0
        Caption = 
          ' that Pledgor/Seller has the right to pledge/sell the property. ' +
          'Pledgor/Seller, attest that the Pledgor/Seller is not in a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 31221
        mmWidth = 97896
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel167: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label167'
        Border.mmPadding = 0
        Caption = 
          'I, the Pledgor/Seller, agree to all terms and conditions on the ' +
          'front and the back and acknowledge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 37346
        mmWidth = 83609
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel168: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label168'
        Border.mmPadding = 0
        Caption = 'receipt of a copy of this document. I also state.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 40379
        mmWidth = 40217
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel169: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label169'
        Border.mmPadding = 0
        Caption = 'Under penaty of perjury, I have read the foregoing document, '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3440
        mmLeft = 86173
        mmTop = 40446
        mmWidth = 60325
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel170: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label170'
        Border.mmPadding = 0
        Caption = 'and the facts stated in it are true.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial Narrow'
        Font.Size = 7
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3439
        mmLeft = 45508
        mmTop = 43845
        mmWidth = 30957
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel172: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label104'
        Border.mmPadding = 0
        Caption = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 42786
        mmTop = 8139
        mmWidth = 1852
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel173: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label173'
        Border.mmPadding = 0
        Caption = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 87348
        mmTop = 8194
        mmWidth = 1852
        BandType = 8
        LayerName = Foreground1
      end
      object ppLabel174: TppLabel
        DesignLayer = ppDesignLayer2
        UserName = 'Label174'
        Border.mmPadding = 0
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 143307
        mmTop = 8534
        mmWidth = 2910
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine23: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line23'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpRight
        Weight = 0.75000000000000000
        mmHeight = 45558
        mmLeft = 153839
        mmTop = 12633
        mmWidth = 2646
        BandType = 8
        LayerName = Foreground1
      end
      object ppLine12: TppLine
        DesignLayer = ppDesignLayer2
        UserName = 'Line12'
        Border.mmPadding = 0
        Pen.Color = clGray
        Position = lpBottom
        Weight = 0.75000000000000000
        mmHeight = 2268
        mmLeft = 108
        mmTop = 10658
        mmWidth = 202787
        BandType = 8
        LayerName = Foreground1
      end
    end
    object ppDesignLayers2: TppDesignLayers
      object ppDesignLayer2: TppDesignLayer
        UserName = 'Foreground1'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList2: TppParameterList
    end
  end
  object clnPawnItems: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 255
        Name = 'TransactionNo'
        ParamType = ptInput
        Size = 32767
      end>
    ProviderName = 'prvPawnItems'
    Left = 451
    Top = 151
    object clnPawnItemscStone1Shape: TStringField
      FieldName = 'cStone1Shape'
      ReadOnly = True
      Size = 1
    end
    object clnPawnItemscStone1Color: TStringField
      FieldName = 'cStone1Color'
      ReadOnly = True
      Size = 1
    end
    object clnPawnItemsInvItemNo: TIntegerField
      FieldName = 'InvItemNo'
    end
    object clnPawnItemsInvItemBarcode: TStringField
      FieldName = 'InvItemBarcode'
      Size = 30
    end
    object clnPawnItemsInvCatNo: TIntegerField
      FieldName = 'InvCatNo'
    end
    object clnPawnItemsJType: TStringField
      FieldName = 'JType'
      Size = 1
    end
    object clnPawnItemsJStyle: TStringField
      FieldName = 'JStyle'
      Size = 1
    end
    object clnPawnItemsJMetal: TStringField
      FieldName = 'JMetal'
      Size = 1
    end
    object clnPawnItemsInvItemCount: TIntegerField
      FieldName = 'InvItemCount'
    end
    object clnPawnItemsNote: TStringField
      FieldName = 'Note'
      Size = 80
    end
    object clnPawnItemsSizeLength: TFloatField
      FieldName = 'SizeLength'
    end
    object clnPawnItemsWeight: TFloatField
      FieldName = 'Weight'
    end
    object clnPawnItemsWeightUnit: TStringField
      FieldName = 'WeightUnit'
      Size = 1
    end
    object clnPawnItemsKT: TFloatField
      FieldName = 'KT'
    end
    object clnPawnItemsCreated: TDateTimeField
      FieldName = 'Created'
    end
    object clnPawnItemsUnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object clnPawnItemsUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object clnPawnItemsInvItemStatus: TStringField
      FieldName = 'InvItemStatus'
      Size = 1
    end
    object clnPawnItemsTransactionNo: TIntegerField
      FieldName = 'TransactionNo'
    end
    object clnPawnItemsInvOriginalItemNo: TIntegerField
      FieldName = 'InvOriginalItemNo'
    end
    object clnPawnItemsInvItemBrand: TStringField
      FieldName = 'InvItemBrand'
      Size = 30
    end
    object clnPawnItemsOwnerAppNumber: TStringField
      FieldName = 'OwnerAppNumber'
      Size = 40
    end
    object clnPawnItemsModelNumber: TStringField
      FieldName = 'ModelNumber'
      Size = 40
    end
    object clnPawnItemsSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 40
    end
    object clnPawnItemsGender: TStringField
      FieldName = 'Gender'
      Size = 1
    end
    object clnPawnItemsDescription: TStringField
      FieldName = 'Description'
      Size = 120
    end
    object clnPawnItemscStone1CT: TFloatField
      FieldName = 'cStone1CT'
      ReadOnly = True
    end
    object clnPawnItemscStone1WT: TStringField
      FieldName = 'cStone1WT'
      ReadOnly = True
    end
    object clnPawnItemscStone1Qty: TIntegerField
      FieldName = 'cStone1Qty'
      ReadOnly = True
    end
    object clnPawnItemscStone2Shape: TStringField
      FieldName = 'cStone2Shape'
      ReadOnly = True
      Size = 1
    end
    object clnPawnItemscStone2Color: TStringField
      FieldName = 'cStone2Color'
      ReadOnly = True
      Size = 1
    end
    object clnPawnItemscStone2CT: TFloatField
      FieldName = 'cStone2CT'
      ReadOnly = True
    end
    object clnPawnItemscStone2WT: TStringField
      FieldName = 'cStone2WT'
      ReadOnly = True
    end
    object clnPawnItemscStone2Qty: TIntegerField
      FieldName = 'cStone2Qty'
      ReadOnly = True
    end
    object clnPawnItemscWeightToPrint: TStringField
      FieldName = 'cWeightToPrint'
      ReadOnly = True
    end
  end
  object dsPawnItemsLaser: TDataSource
    DataSet = clnPawnItems
    Left = 451
    Top = 204
  end
  object prvPawnItems: TDataSetProvider
    DataSet = qryPawnItems
    Left = 451
    Top = 98
  end
  object DBPPawnItemsLaser: TppDBPipeline
    DataSource = dsPawnItemsLaser
    OpenDataSource = False
    UserName = 'DBPPawnItemsLaser'
    Left = 451
    Top = 256
    object DBPPawnItemsLaserppField1: TppField
      FieldAlias = 'cStone1Shape'
      FieldName = 'cStone1Shape'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField2: TppField
      FieldAlias = 'cStone1Color'
      FieldName = 'cStone1Color'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField3: TppField
      FieldAlias = 'InvItemNo'
      FieldName = 'InvItemNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField4: TppField
      FieldAlias = 'InvItemBarcode'
      FieldName = 'InvItemBarcode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField5: TppField
      FieldAlias = 'InvCatNo'
      FieldName = 'InvCatNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField6: TppField
      FieldAlias = 'JType'
      FieldName = 'JType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField7: TppField
      FieldAlias = 'JStyle'
      FieldName = 'JStyle'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField8: TppField
      FieldAlias = 'JMetal'
      FieldName = 'JMetal'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField9: TppField
      FieldAlias = 'InvItemCount'
      FieldName = 'InvItemCount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField10: TppField
      FieldAlias = 'Note'
      FieldName = 'Note'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField11: TppField
      FieldAlias = 'SizeLength'
      FieldName = 'SizeLength'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField12: TppField
      FieldAlias = 'Weight'
      FieldName = 'Weight'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField13: TppField
      FieldAlias = 'WeightUnit'
      FieldName = 'WeightUnit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField14: TppField
      FieldAlias = 'KT'
      FieldName = 'KT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField15: TppField
      FieldAlias = 'Created'
      FieldName = 'Created'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField16: TppField
      FieldAlias = 'UnitCost'
      FieldName = 'UnitCost'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField17: TppField
      FieldAlias = 'UnitPrice'
      FieldName = 'UnitPrice'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField18: TppField
      FieldAlias = 'InvItemStatus'
      FieldName = 'InvItemStatus'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField19: TppField
      FieldAlias = 'TransactionNo'
      FieldName = 'TransactionNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField20: TppField
      FieldAlias = 'InvOriginalItemNo'
      FieldName = 'InvOriginalItemNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField21: TppField
      FieldAlias = 'InvItemBrand'
      FieldName = 'InvItemBrand'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField22: TppField
      FieldAlias = 'OwnerAppNumber'
      FieldName = 'OwnerAppNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField23: TppField
      FieldAlias = 'ModelNumber'
      FieldName = 'ModelNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField24: TppField
      FieldAlias = 'SerialNumber'
      FieldName = 'SerialNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField25: TppField
      FieldAlias = 'Gender'
      FieldName = 'Gender'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField26: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 25
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField27: TppField
      FieldAlias = 'cStone1CT'
      FieldName = 'cStone1CT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 26
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField28: TppField
      FieldAlias = 'cStone1WT'
      FieldName = 'cStone1WT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 27
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField29: TppField
      FieldAlias = 'cStone1Qty'
      FieldName = 'cStone1Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 28
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField30: TppField
      FieldAlias = 'cStone2Shape'
      FieldName = 'cStone2Shape'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 29
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField31: TppField
      FieldAlias = 'cStone2Color'
      FieldName = 'cStone2Color'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 30
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField32: TppField
      FieldAlias = 'cStone2CT'
      FieldName = 'cStone2CT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 31
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField33: TppField
      FieldAlias = 'cStone2WT'
      FieldName = 'cStone2WT'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 32
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField34: TppField
      FieldAlias = 'cStone2Qty'
      FieldName = 'cStone2Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 33
      Searchable = False
      Sortable = False
    end
    object DBPPawnItemsLaserppField35: TppField
      FieldAlias = 'cWeightToPrint'
      FieldName = 'cWeightToPrint'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 34
      Searchable = False
      Sortable = False
    end
  end
  object RptPoliceLaserPrePrinted: TppReport
    AutoStop = False
    DataPipeline = DBPPawnItems
    NoDataBehaviors = [ndBlankReport]
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 11684
    PrinterSetup.mmMarginRight = 2540
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Printer'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    ShowPrintDialog = False
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 649
    Top = 204
    Version = '23.02'
    mmColumnWidth = 196596
    DataPipelineName = 'DBPPawnItems'
    object ppHeaderBand3: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 82550
      mmPrintPosition = 0
      object rgStoreName: TppRegion
        DesignLayer = ppDesignLayer3
        UserName = 'rgStoreName'
        Brush.Style = bsClear
        Pen.Color = clWhite
        Stretch = True
        Transparent = True
        mmHeight = 9566
        mmLeft = 611
        mmTop = 4498
        mmWidth = 71641
        BandType = 0
        LayerName = Foreground2
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
        object lblStoreName2: TppLabel
          DesignLayer = ppDesignLayer3
          UserName = 'lblStoreName2'
          Border.mmPadding = 0
          Caption = 'lblStoreName2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 9
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          TextAlignment = taCentered
          Transparent = True
          mmHeight = 3969
          mmLeft = 23019
          mmTop = 9525
          mmWidth = 21960
          BandType = 0
          LayerName = Foreground2
        end
      end
      object ppRegion2: TppRegion
        DesignLayer = ppDesignLayer3
        UserName = 'Region2'
        Brush.Style = bsClear
        Caption = 'Region2'
        Pen.Color = clWhite
        ShiftRelativeTo = rgStoreName
        Transparent = True
        mmHeight = 16689
        mmLeft = 529
        mmTop = 13758
        mmWidth = 71845
        BandType = 0
        LayerName = Foreground2
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmMinHeight = 0
      end
      object ppDBText93: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText1'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreName'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4763
        mmLeft = 23521
        mmTop = 5024
        mmWidth = 21167
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText94: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText2'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreAddr'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 26961
        mmTop = 14410
        mmWidth = 14287
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText95: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText3'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreCityStZIP'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3968
        mmLeft = 23786
        mmTop = 18115
        mmWidth = 20637
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText96: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText4'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePhone'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 25505
        mmTop = 21819
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText97: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText5'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 148961
        mmTop = 1590
        mmWidth = 20108
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText98: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText6'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePoliceID'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4233
        mmLeft = 156898
        mmTop = 12171
        mmWidth = 20902
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText99: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText7'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranMaturity'
        DataPipeline = DBPTransaction
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 156634
        mmTop = 19581
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText100: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText101'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustDOB'
        DataPipeline = PDBPoliceRep
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 107950
        mmTop = 32280
        mmWidth = 13759
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText101: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText102'
        Border.mmPadding = 0
        DataField = 'CustGender'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 148961
        mmTop = 32280
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText102: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText103'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustRace'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 162190
        mmTop = 32280
        mmWidth = 8202
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel6: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label1'
        OnGetText = ppLabel1GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        VerticalAlignment = avCenter
        mmHeight = 3969
        mmLeft = 6350
        mmTop = 38629
        mmWidth = 118534
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText103: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText104'
        Border.mmPadding = 0
        DataField = 'cPrnHPhone'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 127000
        mmTop = 38629
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText104: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText11'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustPlaceEmply'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 6362
        mmTop = 44716
        mmWidth = 24077
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel166: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label2'
        OnGetText = ppLabel2GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 6350
        mmTop = 51329
        mmWidth = 30163
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel171: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label3'
        OnGetText = ppLabel3GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 37570
        mmTop = 51329
        mmWidth = 37306
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel210: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label4'
        OnGetText = ppLabel4GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3969
        mmLeft = 76728
        mmTop = 51329
        mmWidth = 21167
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText105: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText12'
        Border.mmPadding = 0
        DataField = 'CustHeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 99481
        mmTop = 51329
        mmWidth = 7673
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText106: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText17'
        Border.mmPadding = 0
        DataField = 'CustWeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 118802
        mmTop = 51330
        mmWidth = 10845
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText107: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText13'
        Border.mmPadding = 0
        DataField = 'CustEyes'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 131237
        mmTop = 51330
        mmWidth = 7663
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText108: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText19'
        Border.mmPadding = 0
        DataField = 'CustHair'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 142085
        mmTop = 51330
        mmWidth = 8460
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText109: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText20'
        Border.mmPadding = 0
        DataField = 'CustMark'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 153988
        mmTop = 51329
        mmWidth = 13758
        BandType = 0
        LayerName = Foreground2
      end
      object ppLabel211: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label5'
        OnGetText = ppLabel5GetText
        Border.mmPadding = 0
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 6362
        mmTop = 32280
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText110: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText41'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Storenumber'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 24579
        mmTop = 25523
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText111: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText51'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CCustPhBussiness'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 127000
        mmTop = 44716
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground2
      end
      object ppChkPawnLetterPrePrinted: TmyCheckBox
        OnPrint = ppChkPawnPrint
        DesignLayer = ppDesignLayer3
        UserName = 'ppChkPawn'
        Style = csCheckMark
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5556
        mmLeft = 179922
        mmTop = 24609
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground2
      end
      object chkChkPurchaseLetterPrePrinted: TmyCheckBox
        OnPrint = ppChkPurchasePrint
        DesignLayer = ppDesignLayer3
        UserName = 'ppChkPurchase'
        Style = csCheckMark
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5821
        mmLeft = 121713
        mmTop = 24344
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText112: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'TranTime'
        DataPipeline = DBPTransaction
        DisplayFormat = 'h:nn:ss AM/PM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4022
        mmLeft = 98274
        mmTop = 19581
        mmWidth = 20411
        BandType = 0
        LayerName = Foreground2
      end
      object ppDBText113: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4022
        mmLeft = 92870
        mmTop = 6351
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground2
      end
      object lblPrePrintedLaserPageType: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblPrePrintedLaserPageType'
        Angle = 270
        Anchors = [atTop, atRight]
        Border.mmPadding = 0
        Caption = 'PageType'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 14298
        mmLeft = 195089
        mmTop = 9008
        mmWidth = 3662
        BandType = 0
        LayerName = Foreground2
        RotatedOriginLeft = 3662
        RotatedOriginTop = 0
      end
      object lblPageTypeInitial: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblPageTypeInitial'
        Border.mmPadding = 0
        Caption = 'C'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 5821
        mmLeft = 194200
        mmTop = 0
        mmWidth = 3704
        BandType = 0
        LayerName = Foreground2
      end
    end
    object DetailBandpPreLaser2: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 19050
      mmPrintPosition = 0
      object ppDBText114: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText21'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'SerialNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 6353
        mmTop = 265
        mmWidth = 19516
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText115: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText22'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 6353
        mmTop = 12551
        mmWidth = 5596
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText116: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText23'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'InvItemBrand'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 130971
        mmTop = 265
        mmWidth = 18965
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText117: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText24'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JStyle'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 58743
        mmTop = 12551
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText118: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText25'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'UnitCost'
        DataPipeline = DBPPawnItems
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 171186
        mmTop = 6617
        mmWidth = 12700
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText119: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText26'
        Border.mmPadding = 0
        DataField = 'JMetal'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 13497
        mmTop = 12551
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText120: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText28'
        Border.mmPadding = 0
        DataField = 'cWeightToPrint'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 25926
        mmTop = 12419
        mmWidth = 21696
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText121: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText29'
        Border.mmPadding = 0
        DataField = 'SizeLength'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 69194
        mmTop = 12551
        mmWidth = 12435
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText122: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText30'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'OwnerAppNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 67204
        mmTop = 265
        mmWidth = 26331
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText123: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText31'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'ModelNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 166688
        mmTop = 265
        mmWidth = 20637
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText124: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText32'
        Border.mmPadding = 0
        DataField = 'Description'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 6353
        mmTop = 5822
        mmWidth = 95779
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText125: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText37'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 104768
        mmTop = 265
        mmWidth = 8636
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText126: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText38'
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 111658
        mmTop = 6617
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText127: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText33'
        Border.mmPadding = 0
        DataField = 'Gender'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 50539
        mmTop = 12551
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText128: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText34'
        Border.mmPadding = 0
        DataField = 'cStone1Qty'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 87846
        mmTop = 12551
        mmWidth = 6879
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText129: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText35'
        Border.mmPadding = 0
        DataField = 'cStone1Shape'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 96843
        mmTop = 12551
        mmWidth = 7408
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText130: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText39'
        Border.mmPadding = 0
        DataField = 'cStone1WT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 113506
        mmTop = 12419
        mmWidth = 12832
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText131: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText40'
        Border.mmPadding = 0
        DataField = 'cStone1Color'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 130710
        mmTop = 12551
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText132: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText36'
        Border.mmPadding = 0
        DataField = 'cStone1CT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3440
        mmLeft = 104777
        mmTop = 12551
        mmWidth = 8467
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText133: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText45'
        Border.mmPadding = 0
        DataField = 'cStone2Qty'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 144469
        mmTop = 12551
        mmWidth = 5292
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText134: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText46'
        Border.mmPadding = 0
        DataField = 'cStone2Shape'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 153199
        mmTop = 12551
        mmWidth = 7407
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText135: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText47'
        Border.mmPadding = 0
        DataField = 'cStone2CT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 162195
        mmTop = 12551
        mmWidth = 7144
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText136: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText48'
        Border.mmPadding = 0
        DataField = 'cStone2WT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 169993
        mmTop = 12419
        mmWidth = 12039
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText137: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText401'
        Border.mmPadding = 0
        DataField = 'cStone2Color'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        VerticalAlignment = avCenter
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 183353
        mmTop = 12551
        mmWidth = 6615
        BandType = 4
        LayerName = Foreground2
      end
      object ppDBText138: TppDBText
        DesignLayer = ppDesignLayer3
        UserName = 'DBText27'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'KT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 20376
        mmTop = 12551
        mmWidth = 3969
        BandType = 4
        LayerName = Foreground2
      end
    end
    object ppFooterBand2: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 50271
      mmPrintPosition = 0
      object ppLabel212: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblAmount'
        OnGetText = lblAmountGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 9790
        mmTop = 2648
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel213: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label7'
        OnGetText = ppLabel7GetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 9790
        mmTop = 37309
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel214: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblTranInterestAtMaturity'
        OnGetText = lblTranInterestAtMaturityGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 42863
        mmTop = 2648
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel215: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblTotalAmountAtMaturity'
        OnGetText = lblTotalAmountAtMaturityGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 87313
        mmTop = 2648
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel216: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblAnnualPercRate'
        OnGetText = lblAnnualPercRateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 127529
        mmTop = 2118
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel217: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblTranMaturity'
        OnGetText = lblTranMaturityGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 158750
        mmTop = 2118
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel218: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblPawnDefaultDate'
        OnGetText = lblPawnDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 5556
        mmTop = 20638
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel219: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'lblTAmountRedeemDefaultDate'
        OnGetText = lblTAmountRedeemDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 19845
        mmTop = 28312
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground2
      end
      object ppLabel220: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label8'
        Angle = 270
        OnGetText = ppLabel8GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '01.MIAMIAA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 26988
        mmLeft = 181768
        mmTop = 23283
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground2
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
      object ppLabel221: TppLabel
        DesignLayer = ppDesignLayer3
        UserName = 'Label9'
        Angle = 270
        OnGetText = ppLabel9GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '5678'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 26988
        mmLeft = 187588
        mmTop = 23283
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground2
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
    end
    object ppDesignLayers3: TppDesignLayers
      object ppDesignLayer3: TppDesignLayer
        UserName = 'Foreground2'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList3: TppParameterList
    end
  end
  object RptDotMatrix0924: TppReport
    AutoStop = False
    DataPipeline = DBPPawnItems
    NoDataBehaviors = [ndBlankReport]
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 7620
    PrinterSetup.mmMarginRight = 7620
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Printer'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    ShowPrintDialog = False
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 649
    Top = 256
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPPawnItems'
    object ppHeaderBand4: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 82042
      mmPrintPosition = 0
      object ppDBText139: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText1'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreName'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4763
        mmLeft = 26194
        mmTop = 7408
        mmWidth = 30692
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText140: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText2'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreAddr'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 25929
        mmTop = 12171
        mmWidth = 31486
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText141: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText3'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreCityStZIP'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 30163
        mmTop = 15875
        mmWidth = 24077
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText142: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText4'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePhone'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 31485
        mmTop = 19579
        mmWidth = 20638
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText143: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText5'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 148961
        mmTop = 0
        mmWidth = 20108
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText144: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText6'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePoliceID'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4233
        mmLeft = 156898
        mmTop = 12171
        mmWidth = 10319
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText145: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText7'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranMaturity'
        DataPipeline = DBPTransaction
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 156634
        mmTop = 17992
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText146: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText101'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustDOB'
        DataPipeline = PDBPoliceRep
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 107950
        mmTop = 31485
        mmWidth = 13759
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText147: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText102'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustGender'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 145257
        mmTop = 31485
        mmWidth = 17727
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText148: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText103'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustRace'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 160073
        mmTop = 31485
        mmWidth = 14552
        BandType = 0
        LayerName = Foreground3
      end
      object ppLabel223: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label1'
        OnGetText = ppLabel1GetText
        Border.mmPadding = 0
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3598
        mmLeft = 4242
        mmTop = 37835
        mmWidth = 9610
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText149: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText104'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cPrnHPhone'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 127000
        mmTop = 37835
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText150: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText11'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustPlaceEmply'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 4233
        mmTop = 44186
        mmWidth = 24077
        BandType = 0
        LayerName = Foreground3
      end
      object ppLabel224: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label2'
        OnGetText = ppLabel2GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3968
        mmLeft = 4233
        mmTop = 50536
        mmWidth = 31750
        BandType = 0
        LayerName = Foreground3
      end
      object ppLabel225: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label3'
        OnGetText = ppLabel3GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3968
        mmLeft = 38100
        mmTop = 50536
        mmWidth = 32808
        BandType = 0
        LayerName = Foreground3
      end
      object ppLabel226: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label4'
        OnGetText = ppLabel4GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3968
        mmLeft = 71967
        mmTop = 50536
        mmWidth = 24606
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText151: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText12'
        Border.mmPadding = 0
        DataField = 'CustHeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 97635
        mmTop = 50536
        mmWidth = 10848
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText152: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText17'
        Border.mmPadding = 0
        DataField = 'CustWeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 115887
        mmTop = 50536
        mmWidth = 9260
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText153: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText13'
        Border.mmPadding = 0
        DataField = 'CustEyes'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 126997
        mmTop = 50536
        mmWidth = 10319
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText154: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText19'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustHair'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 138110
        mmTop = 50536
        mmWidth = 12965
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText155: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText20'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustMark'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 152123
        mmTop = 50536
        mmWidth = 13759
        BandType = 0
        LayerName = Foreground3
      end
      object ppLabel227: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label5'
        OnGetText = ppLabel5GetText
        Border.mmPadding = 0
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 4233
        mmTop = 31485
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText156: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText41'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Storenumber'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 41275
        mmTop = 23283
        mmWidth = 794
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText157: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText51'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CCustPhBussiness'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 127000
        mmTop = 44186
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground3
      end
      object ppChkPawn0924: TmyCheckBox
        OnPrint = ppChkPawnPrint
        DesignLayer = ppDesignLayer4
        UserName = 'ppChkPawn'
        Style = csCheckMark
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5821
        mmLeft = 176742
        mmTop = 23283
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground3
      end
      object ppChkPurchase0924: TmyCheckBox
        OnPrint = ppChkPurchasePrint
        DesignLayer = ppDesignLayer4
        UserName = 'ppChkPurchase'
        Style = csCheckMark
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5821
        mmLeft = 119063
        mmTop = 23283
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText158: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'TranTime'
        DataPipeline = DBPTransaction
        DisplayFormat = 'h:nn:ss AM/PM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4022
        mmLeft = 98274
        mmTop = 17991
        mmWidth = 20411
        BandType = 0
        LayerName = Foreground3
      end
      object ppDBText159: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4022
        mmLeft = 92870
        mmTop = 5291
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground3
      end
    end
    object ppDetailBand3: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 19050
      mmPrintPosition = 0
      object ppDBText160: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText21'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'SerialNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 4233
        mmTop = 0
        mmWidth = 19516
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText161: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText22'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 4233
        mmTop = 12815
        mmWidth = 5596
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText162: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText23'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'InvItemBrand'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 129646
        mmTop = 0
        mmWidth = 18965
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText163: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText24'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JStyle'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 55033
        mmTop = 12815
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText164: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText25'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'UnitCost'
        DataPipeline = DBPPawnItems
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 171186
        mmTop = 6087
        mmWidth = 12171
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText165: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText26'
        Border.mmPadding = 0
        DataField = 'JMetal'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 11377
        mmTop = 12815
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText166: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText28'
        Border.mmPadding = 0
        DataField = 'cWeightToPrint'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 23945
        mmTop = 12700
        mmWidth = 18389
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText167: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText29'
        Border.mmPadding = 0
        DataField = 'SizeLength'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 64823
        mmTop = 12815
        mmWidth = 12435
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText168: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText30'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'OwnerAppNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 67204
        mmTop = 0
        mmWidth = 26331
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText169: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText31'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'ModelNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 166815
        mmTop = 0
        mmWidth = 19981
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText170: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText32'
        Border.mmPadding = 0
        DataField = 'Description'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 4233
        mmTop = 6087
        mmWidth = 101865
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText171: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText37'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 109538
        mmTop = 0
        mmWidth = 8636
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText172: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText38'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 109538
        mmTop = 6087
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText173: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText33'
        Border.mmPadding = 0
        DataField = 'Gender'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 48154
        mmTop = 12815
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText174: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText34'
        Border.mmPadding = 0
        DataField = 'cStone1Qty'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 84931
        mmTop = 12815
        mmWidth = 6879
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText175: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText35'
        Border.mmPadding = 0
        DataField = 'cStone1Shape'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 93663
        mmTop = 12815
        mmWidth = 7408
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText176: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText39'
        Border.mmPadding = 0
        DataField = 'cStone1WT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 115094
        mmTop = 12815
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText177: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText40'
        Border.mmPadding = 0
        DataField = 'cStone1Color'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 127265
        mmTop = 12815
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText178: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText36'
        Border.mmPadding = 0
        DataField = 'cStone1CT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3440
        mmLeft = 103452
        mmTop = 12815
        mmWidth = 8467
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText179: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText45'
        Border.mmPadding = 0
        DataField = 'cStone2Qty'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 140759
        mmTop = 12815
        mmWidth = 5292
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText180: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText46'
        Border.mmPadding = 0
        DataField = 'cStone2Shape'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 150284
        mmTop = 12815
        mmWidth = 8202
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText181: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText47'
        Border.mmPadding = 0
        DataField = 'cStone2CT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 159015
        mmTop = 12815
        mmWidth = 7144
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText182: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText48'
        Border.mmPadding = 0
        DataField = 'cStone2WT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 171450
        mmTop = 12815
        mmWidth = 8467
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText183: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText401'
        Border.mmPadding = 0
        DataField = 'cStone2Color'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 184680
        mmTop = 12815
        mmWidth = 11113
        BandType = 4
        LayerName = Foreground3
      end
      object ppDBText184: TppDBText
        DesignLayer = ppDesignLayer4
        UserName = 'DBText27'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'KT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 18256
        mmTop = 12815
        mmWidth = 3969
        BandType = 4
        LayerName = Foreground3
      end
    end
    object ppFooterBand3: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 50271
      mmPrintPosition = 0
      object ppLabel228: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblAmount'
        OnGetText = lblAmountGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 9790
        mmTop = 1323
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel229: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label7'
        OnGetText = ppLabel7GetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3598
        mmLeft = 19050
        mmTop = 35719
        mmWidth = 8001
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel230: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblTranInterestAtMaturity'
        OnGetText = lblTranInterestAtMaturityGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 42863
        mmTop = 1323
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel231: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblTotalAmountAtMaturity'
        OnGetText = lblTotalAmountAtMaturityGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 87313
        mmTop = 1323
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel232: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblAnnualPercRate'
        OnGetText = lblAnnualPercRateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 127529
        mmTop = 1323
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel233: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblTranMaturity'
        OnGetText = lblTranMaturityGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 158750
        mmTop = 1323
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel234: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblPawnDefaultDate'
        OnGetText = lblPawnDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 5556
        mmTop = 20638
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel235: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'lblTAmountRedeemDefaultDate'
        OnGetText = lblTAmountRedeemDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 19050
        mmTop = 27517
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground3
      end
      object ppLabel236: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label8'
        Angle = 270
        OnGetText = ppLabel8GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '01.MIAMIAA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 29633
        mmLeft = 180973
        mmTop = 20638
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground3
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
      object ppLabel237: TppLabel
        DesignLayer = ppDesignLayer4
        UserName = 'Label9'
        Angle = 270
        OnGetText = ppLabel9GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '5678'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 29633
        mmLeft = 186528
        mmTop = 20638
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground3
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
    end
    object ppDesignLayers4: TppDesignLayers
      object ppDesignLayer4: TppDesignLayer
        UserName = 'Foreground3'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList4: TppParameterList
    end
  end
  object RptPoliceRep: TppReport
    AutoStop = False
    DataPipeline = DBPPawnItems
    NoDataBehaviors = [ndBlankReport]
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 11430
    PrinterSetup.mmMarginRight = 7620
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Printer'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    EmailSettings.ConnectionSettings.MailService = 'SMTP'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.GmailSettings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectURI = 'http://localhost'
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RedirectPort = 0
    EmailSettings.ConnectionSettings.WebMail.Outlook365Settings.OAuth2.RefreshTokenLifeSpan = 365
    EmailSettings.ConnectionSettings.EnableMultiPlugin = False
    EmailSettings.ConnectionSettings.ConnectionStatusInfo = [csiStatusBar]
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = []
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.DigitalSignatureSettings.SignPDF = False
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PDFSettings.Layers = False
    PDFSettings.Outline = False
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.AppName = 'ReportBuilder'
    RTFSettings.Author = 'ReportBuilder'
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    RTFSettings.Title = 'Report'
    ShowPrintDialog = False
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    CloudDriveSettings.DropBoxSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.DropBoxSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.DropBoxSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.DropBoxSettings.DirectorySupport = True
    CloudDriveSettings.DropBoxSettings.SharedResources = True
    CloudDriveSettings.GoogleDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.GoogleDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.GoogleDriveSettings.DirectorySupport = False
    CloudDriveSettings.GoogleDriveSettings.SharedResources = False
    CloudDriveSettings.OneDriveSettings.OAuth2.AuthStorage = [oasAccessToken, oasRefreshToken, oasEncryptTokens]
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectURI = 'http://localhost'
    CloudDriveSettings.OneDriveSettings.OAuth2.RedirectPort = 0
    CloudDriveSettings.OneDriveSettings.OAuth2.RefreshTokenLifeSpan = 365
    CloudDriveSettings.OneDriveSettings.DirectorySupport = True
    CloudDriveSettings.OneDriveSettings.SharedResources = True
    Left = 649
    Top = 98
    Version = '23.02'
    mmColumnWidth = 0
    DataPipelineName = 'DBPPawnItems'
    object ppHeaderBand1: TppHeaderBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 82550
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreName'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4763
        mmLeft = 26194
        mmTop = 7408
        mmWidth = 30692
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreAddr'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 25797
        mmTop = 12171
        mmWidth = 31486
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StoreCityStZIP'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 29502
        mmTop = 15875
        mmWidth = 24077
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePhone'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 31221
        mmTop = 19579
        mmWidth = 20638
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranTicketNo'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 148961
        mmTop = 1060
        mmWidth = 20108
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText6: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText6'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'StorePoliceID'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 4233
        mmLeft = 156898
        mmTop = 12171
        mmWidth = 10319
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText7: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText7'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'TranMaturity'
        DataPipeline = DBPTransaction
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4233
        mmLeft = 156634
        mmTop = 17992
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText11: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText101'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustDOB'
        DataPipeline = PDBPoliceRep
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 107950
        mmTop = 31485
        mmWidth = 13759
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText12: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText102'
        Border.mmPadding = 0
        DataField = 'CustGender'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 145257
        mmTop = 31485
        mmWidth = 5821
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText13: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText103'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustRace'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 157423
        mmTop = 31485
        mmWidth = 7673
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        OnGetText = ppLabel1GetText
        Border.mmPadding = 0
        Caption = 'Label1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3598
        mmLeft = 4242
        mmTop = 37835
        mmWidth = 9610
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText14: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText104'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'cPrnHPhone'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3969
        mmLeft = 127000
        mmTop = 37835
        mmWidth = 18521
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText15: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText11'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustPlaceEmply'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 4233
        mmTop = 44186
        mmWidth = 24077
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        OnGetText = ppLabel2GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 4233
        mmTop = 50536
        mmWidth = 33338
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label3'
        OnGetText = ppLabel3GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 38100
        mmTop = 50536
        mmWidth = 31217
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label4'
        OnGetText = ppLabel4GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 71967
        mmTop = 50536
        mmWidth = 23548
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText16: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText12'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustHeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 90215
        mmTop = 50536
        mmWidth = 16404
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText17: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText17'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustWeight'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 108997
        mmTop = 50536
        mmWidth = 16933
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText18: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText13'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustEyes'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 119577
        mmTop = 50536
        mmWidth = 14023
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText19: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText19'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustHair'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 130160
        mmTop = 50536
        mmWidth = 12965
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText20: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText20'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CustMark'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 142595
        mmTop = 50536
        mmWidth = 13759
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel5: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label5'
        OnGetText = ppLabel5GetText
        Border.mmPadding = 0
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 4233
        mmTop = 31485
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText50: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText41'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'Storenumber'
        DataPipeline = DBPStoreInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPStoreInfo'
        mmHeight = 3969
        mmLeft = 32015
        mmTop = 23283
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText51: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText51'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'CCustPhBussiness'
        DataPipeline = PDBPoliceRep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'PDBPoliceRep'
        mmHeight = 3968
        mmLeft = 127000
        mmTop = 44186
        mmWidth = 29104
        BandType = 0
        LayerName = Foreground
      end
      object ppChkPawn: TmyCheckBox
        OnPrint = ppChkPawnPrint
        DesignLayer = ppDesignLayer1
        UserName = 'ppChkPawn'
        Style = csCheckMark
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5821
        mmLeft = 160338
        mmTop = 23283
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground
      end
      object ppChkPurchase: TmyCheckBox
        OnPrint = ppChkPurchasePrint
        DesignLayer = ppDesignLayer1
        UserName = 'ppChkPurchase'
        Style = csCheckMark
        BooleanFalse = 'False'
        BooleanTrue = 'True'
        CheckBoxColor = clWindowText
        Transparent = True
        mmHeight = 5821
        mmLeft = 119063
        mmTop = 23283
        mmWidth = 4763
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'TranTime'
        DataPipeline = DBPTransaction
        DisplayFormat = 'h:nn:ss AM/PM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4022
        mmLeft = 98274
        mmTop = 17991
        mmWidth = 20411
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'TranDate'
        DataPipeline = DBPTransaction
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'DBPTransaction'
        mmHeight = 4022
        mmLeft = 92870
        mmTop = 5291
        mmWidth = 17198
        BandType = 0
        LayerName = Foreground
      end
    end
    object DetailBand: TppDetailBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 19050
      mmPrintPosition = 0
      object ppDBText25: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText21'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'SerialNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 4233
        mmTop = 0
        mmWidth = 19516
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText26: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText22'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 4233
        mmTop = 12815
        mmWidth = 5596
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText27: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText23'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'InvItemBrand'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 129646
        mmTop = 0
        mmWidth = 18965
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText28: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText24'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JStyle'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 49742
        mmTop = 12815
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText29: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText25'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'UnitCost'
        DataPipeline = DBPPawnItems
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 166946
        mmTop = 5292
        mmWidth = 12171
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText30: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText26'
        Border.mmPadding = 0
        DataField = 'JMetal'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 9790
        mmTop = 12815
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText32: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText28'
        Border.mmPadding = 0
        DataField = 'cWeightToPrint'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 20638
        mmTop = 12700
        mmWidth = 15346
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText33: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText29'
        Border.mmPadding = 0
        DataField = 'SizeLength'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 59531
        mmTop = 12815
        mmWidth = 12435
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText34: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText30'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'OwnerAppNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 67204
        mmTop = 0
        mmWidth = 26331
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText35: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText31'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'ModelNumber'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3969
        mmLeft = 155311
        mmTop = 0
        mmWidth = 20637
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText36: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText32'
        Border.mmPadding = 0
        DataField = 'Description'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 4233
        mmTop = 5292
        mmWidth = 101865
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText37: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText37'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3598
        mmLeft = 109538
        mmTop = 0
        mmWidth = 8636
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText38: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText38'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'JType'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 109538
        mmTop = 5292
        mmWidth = 8731
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText39: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText33'
        Border.mmPadding = 0
        DataField = 'Gender'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 42863
        mmTop = 12815
        mmWidth = 7673
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText40: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText34'
        Border.mmPadding = 0
        DataField = 'cStone1Qty'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 79904
        mmTop = 12815
        mmWidth = 6879
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText41: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText35'
        Border.mmPadding = 0
        DataField = 'cStone1Shape'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 88636
        mmTop = 12815
        mmWidth = 7408
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText43: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText39'
        Border.mmPadding = 0
        DataField = 'cStone1WT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 106627
        mmTop = 12815
        mmWidth = 10848
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText44: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText40'
        Border.mmPadding = 0
        DataField = 'cStone1Color'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 121709
        mmTop = 12815
        mmWidth = 6350
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText42: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText36'
        Border.mmPadding = 0
        DataField = 'cStone1CT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3440
        mmLeft = 98425
        mmTop = 12815
        mmWidth = 8467
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText45: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText45'
        Border.mmPadding = 0
        DataField = 'cStone2Qty'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 137054
        mmTop = 12815
        mmWidth = 5292
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText46: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText46'
        Border.mmPadding = 0
        DataField = 'cStone2Shape'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 146579
        mmTop = 12815
        mmWidth = 8202
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText47: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText47'
        Border.mmPadding = 0
        DataField = 'cStone2CT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 154516
        mmTop = 12815
        mmWidth = 9790
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText48: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText48'
        Border.mmPadding = 0
        DataField = 'cStone2WT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 164174
        mmTop = 12815
        mmWidth = 10186
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText49: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText401'
        Border.mmPadding = 0
        DataField = 'cStone2Color'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 178594
        mmTop = 12815
        mmWidth = 11113
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText31: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText27'
        AutoSize = True
        Border.mmPadding = 0
        DataField = 'KT'
        DataPipeline = DBPPawnItems
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'DBPPawnItems'
        mmHeight = 3704
        mmLeft = 16669
        mmTop = 12815
        mmWidth = 3969
        BandType = 4
        LayerName = Foreground
      end
    end
    object FooterBand: TppFooterBand
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 50271
      mmPrintPosition = 0
      object lblAmount: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblAmount'
        OnGetText = lblAmountGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 9790
        mmTop = 1323
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label7'
        OnGetText = ppLabel7GetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3598
        mmLeft = 19050
        mmTop = 35719
        mmWidth = 8001
        BandType = 8
        LayerName = Foreground
      end
      object lblTranInterestAtMaturity: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblTranInterestAtMaturity'
        OnGetText = lblTranInterestAtMaturityGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 42863
        mmTop = 1323
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
      object lblTotalAmountAtMaturity: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblTotalAmountAtMaturity'
        OnGetText = lblTotalAmountAtMaturityGetText
        Border.mmPadding = 0
        Caption = '$0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 87313
        mmTop = 1323
        mmWidth = 7938
        BandType = 8
        LayerName = Foreground
      end
      object lblAnnualPercRate: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblAnnualPercRate'
        OnGetText = lblAnnualPercRateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 127529
        mmTop = 1323
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground
      end
      object lblTranMaturity: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblTranMaturity'
        OnGetText = lblTranMaturityGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 158750
        mmTop = 1323
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground
      end
      object lblPawnDefaultDate: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblPawnDefaultDate'
        OnGetText = lblPawnDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 5556
        mmTop = 20638
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground
      end
      object lblTAmountRedeemDefaultDate: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblTAmountRedeemDefaultDate'
        OnGetText = lblTAmountRedeemDefaultDateGetText
        Border.mmPadding = 0
        Caption = 'N/A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 3704
        mmLeft = 19050
        mmTop = 27517
        mmWidth = 5292
        BandType = 8
        LayerName = Foreground
      end
      object ppLabel8: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label8'
        Angle = 270
        OnGetText = ppLabel8GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '01.MIAMIAA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 29633
        mmLeft = 175155
        mmTop = 20638
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
      object ppLabel9: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label9'
        Angle = 270
        OnGetText = ppLabel9GetText
        AutoSize = False
        Border.mmPadding = 0
        Caption = '5678'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 29633
        mmLeft = 181240
        mmTop = 20638
        mmWidth = 3969
        BandType = 8
        LayerName = Foreground
        RotatedOriginLeft = 3969
        RotatedOriginTop = 0
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object TimerForScan: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerForScanTimer
    Left = 991
    Top = 172
  end
  object PopMnuPawnItems: TPopupMenu
    OnPopup = PopMnuPawnItemsPopup
    Left = 1185
    Top = 500
    object popmnuItemPawned: TMenuItem
      Caption = 'Pawned'
      OnClick = popmnuItemPawnedClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object popmnuItemRedeemed: TMenuItem
      Caption = 'Redeemed'
      OnClick = popmnuItemRedeemedClick
    end
    object popmnuItemDefaulted: TMenuItem
      Caption = 'Defaulted'
      OnClick = popmnuItemDefaultedClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object popmnuItemMeltedScrap: TMenuItem
      Caption = 'Melted / Scrap'
      OnClick = popmnuItemMeltedScrapClick
    end
    object popmnuItemForSale: TMenuItem
      Caption = 'For Sale'
      OnClick = popmnuItemForSaleClick
    end
  end
  object PopMnuLayaway: TPopupMenu
    OnPopup = PopMnuLayawayPopup
    Left = 449
    Top = 503
    object mnuCloseLayaway: TMenuItem
      Caption = 'Close Layaway'
      OnClick = mnuCloseLayawayClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mnuReOpenLayaway: TMenuItem
      Caption = 'Re-Open Layaway'
      OnClick = mnuReOpenLayawayClick
    end
  end
end
