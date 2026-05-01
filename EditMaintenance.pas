unit EditMaintenance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DB, RzButton, Vcl.ExtCtrls;

type
  TfrmEditMaintenance = class(TForm)
    GroupBox2: TGroupBox;
    lblDesc: TLabel;
    GroupBox1: TGroupBox;
    lblInitials: TLabel;
    dsMaintenance: TDataSource;
    edInitials: TDBEdit;
    edDescription: TDBEdit;
    btnSave: TRzBitBtn;
    btnCancel: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEditMaintenance: TfrmEditMaintenance;

implementation

Uses MaintenanceJewle, PawnDM;

{$R *.dfm}

procedure TfrmEditMaintenance.FormShow(Sender: TObject);
begin
  edInitials.DataField := dsMaintenance.DataSet.Fields[0].FieldName;
  edDescription.DataField := dsMaintenance.DataSet.Fields[1].FieldName;
  if NewRow then
    begin
      dsMaintenance.DataSet.Append;
    end
  else
    begin
      dsMaintenance.DataSet.Edit;
    end;
end;

procedure TfrmEditMaintenance.btnSaveClick(Sender: TObject);
begin
  dsMaintenance.DataSet.Post;
//  (dsMaintenance.DataSet as TOEDataSet).ApplyUpdates;
  ModalResult := mrOK;
end;

procedure TfrmEditMaintenance.btnCancelClick(Sender: TObject);
begin
  dsMaintenance.DataSet.Cancel;
  ModalResult := mrCancel;
end;

end.
