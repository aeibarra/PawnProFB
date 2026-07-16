object DM: TDM
  Height = 480
  Width = 640
  object Conn: TFDConnection
    Params.Strings = (
      'Database=C:\Pawn\PAWNDATA.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 46
    Top = 45
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 56
    Top = 120
  end
end
