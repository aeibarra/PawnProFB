object frmPumpAsaFb50Main: TfrmPumpAsaFb50Main
  Left = 0
  Top = 0
  Caption = 'Pump DB From Pawn ASA to Pawn FB5'
  ClientHeight = 655
  ClientWidth = 851
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    851
    655)
  TextHeight = 21
  object lblCurrentProcess: TLabel
    Left = 165
    Top = 223
    Width = 129
    Height = 21
    Caption = 'lblCurrentProcess'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnClose: TButton
    Left = 746
    Top = 605
    Width = 97
    Height = 42
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object btnGo: TButton
    Left = 8
    Top = 249
    Width = 151
    Height = 34
    Caption = 'Start Pump'
    TabOrder = 1
    OnClick = btnGoClick
  end
  object MemoErrors: TMemo
    Left = 165
    Top = 247
    Width = 678
    Height = 341
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoErrors')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object pnConnections: TPanel
    Left = 0
    Top = 0
    Width = 851
    Height = 221
    Align = alTop
    TabOrder = 3
    object lblAsaServer: TLabel
      Left = 179
      Top = 9
      Width = 74
      Height = 21
      Caption = 'Asa Server'
    end
    object lblAsaDBName: TLabel
      Left = 315
      Top = 9
      Width = 98
      Height = 21
      Caption = 'Asa DB Name:'
      FocusControl = edAsaDBName
    end
    object lblAsaUser: TLabel
      Left = 458
      Top = 9
      Width = 61
      Height = 21
      Caption = 'Asa User'
    end
    object Label2: TLabel
      Left = 594
      Top = 9
      Width = 95
      Height = 21
      Caption = 'Asa Password'
      FocusControl = edAsaPassword
    end
    object Label1: TLabel
      Left = 179
      Top = 81
      Width = 66
      Height = 21
      Caption = 'FB Server'
    end
    object Label3: TLabel
      Left = 315
      Top = 81
      Width = 90
      Height = 21
      Caption = 'FB DB Name:'
      FocusControl = edFBDBName
    end
    object Label4: TLabel
      Left = 179
      Top = 140
      Width = 53
      Height = 21
      Caption = 'FB User'
    end
    object Label5: TLabel
      Left = 315
      Top = 140
      Width = 87
      Height = 21
      Caption = 'FB Password'
      FocusControl = edFBPassword
    end
    object Label6: TLabel
      Left = 452
      Top = 140
      Width = 28
      Height = 21
      Caption = 'Port'
    end
    object Label7: TLabel
      Left = 513
      Top = 140
      Width = 59
      Height = 21
      Caption = 'Char Set'
    end
    object edAsaServerIP: TEdit
      Left = 179
      Top = 31
      Width = 121
      Height = 29
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object edAsaDBName: TEdit
      Left = 315
      Top = 31
      Width = 131
      Height = 29
      TabOrder = 1
      Text = 'Pawn'
    end
    object edAsaUser: TEdit
      Left = 458
      Top = 31
      Width = 121
      Height = 29
      TabOrder = 2
      Text = 'dba'
    end
    object edAsaPassword: TEdit
      Left = 594
      Top = 31
      Width = 131
      Height = 29
      TabOrder = 3
      Text = 'KAKITA'
    end
    object edFBServer: TEdit
      Left = 179
      Top = 103
      Width = 121
      Height = 29
      TabOrder = 4
      Text = 'localhost'
    end
    object edFBDBName: TEdit
      Left = 315
      Top = 105
      Width = 283
      Height = 29
      TabOrder = 5
      Text = 'C:\PAWN\PAWNDATA.FDB'
    end
    object edFBUser: TEdit
      Left = 179
      Top = 162
      Width = 121
      Height = 29
      TabOrder = 6
      Text = 'sysdba'
    end
    object edFBPassword: TEdit
      Left = 315
      Top = 162
      Width = 131
      Height = 29
      TabOrder = 7
      Text = '@PepitoKAKITA'
    end
    object edFBPort: TEdit
      Left = 452
      Top = 162
      Width = 55
      Height = 29
      TabOrder = 8
      Text = '3050'
    end
    object edFBCharSet: TEdit
      Left = 513
      Top = 162
      Width = 85
      Height = 29
      TabOrder = 9
      Text = 'UTF8'
    end
    object btnTestAsa: TButton
      Left = 67
      Top = 31
      Width = 82
      Height = 30
      Caption = 'Test ASA'
      TabOrder = 10
      OnClick = btnTestAsaClick
    end
    object btnTestFb: TButton
      Left = 67
      Top = 103
      Width = 82
      Height = 30
      Caption = 'Test FB'
      TabOrder = 11
      OnClick = btnTestFbClick
    end
  end
  object ConnectionFB: TFDConnection
    Params.Strings = (
      'Database=C:\DB\PAWNDATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'ExtendedMetadata=True'
      'DriverID=FB')
    LoginPrompt = False
    Left = 55
    Top = 125
  end
  object ConnDB: TADOConnection
    ConnectionString = 
      'Provider=SAOLEDB.12;Password=kakita;Persist Security Info=True;U' +
      'ser ID=dba;Initial Catalog=Pawn;Data Source=Pawn;Location=127.0.' +
      '0.1'
    KeepConnection = False
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SAOLEDB.12'
    Left = 55
    Top = 20
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 798
    Top = 21
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrDefault
    Left = 799
    Top = 85
  end
end
