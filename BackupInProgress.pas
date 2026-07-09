unit BackupInProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.VirtualImage, Vcl.StdCtrls, RzLabel;

type
  TfrmBackupInProgress = class(TForm)
    vImage: TVirtualImage;
    lblProgress: TRzLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBackupInProgress: TfrmBackupInProgress;

implementation

{$R *.dfm}

uses PawnDM;

end.
