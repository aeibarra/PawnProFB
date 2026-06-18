object DM: TDM
  Height = 480
  Width = 640
  object ConnFB: TFDConnection
    Params.Strings = (
      'Database=C:\DB\PAWNDATA.FDB'
      'User_Name=sysdba'
      'DriverID=FB')
    LoginPrompt = False
    Left = 59
    Top = 25
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 64
    Top = 139
  end
end
