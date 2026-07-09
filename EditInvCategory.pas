unit EditInvCategory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, Vcl.ExtCtrls;

type
  TfrmEditInvCat = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEditInvCat: TfrmEditInvCat;

implementation

Uses Inventory;

{$R *.dfm}

procedure TfrmEditInvCat.FormShow(Sender: TObject);
begin
  if NewRow then
    begin
      frmInventory.qryCategories.Append;
    end
  else
    begin
      frmInventory.qryCategories.Edit;
    end;
end;

procedure TfrmEditInvCat.btnCancelClick(Sender: TObject);
begin
  frmInventory.qryCategories.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmEditInvCat.btnSaveClick(Sender: TObject);
begin
  frmInventory.qryCategories.Post;
//  frmInventory.qryCategories.ApplyUpdates;
  ModalResult := mrOk;
end;

end.
