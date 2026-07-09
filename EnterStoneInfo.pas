unit EnterStoneInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, DB, Mask, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmEnterStoneInfo = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    dsStoneShapes: TDataSource;
    dsStoneColors: TDataSource;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    DBLookupComboBox4: TDBLookupComboBox;
    Label6: TLabel;
    DBLookupComboBox5: TDBLookupComboBox;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    cbStoneType: TDBComboBox;
    Label4: TLabel;
    qryStoneTypes: TFDQuery;
    qryStoneTypesSTONE_TYPE: TWideStringField;
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
  frmEnterStoneInfo: TfrmEnterStoneInfo;

implementation

Uses Inventory, PawnDM;

{$R *.dfm}

procedure TfrmEnterStoneInfo.FormShow(Sender: TObject);
begin
  Width := 267;

  dsStoneShapes.DataSet := DM.clnJStoneShapes;
  dsStoneColors.DataSet := DM.clnJStoneColors;

  qryStoneTypes.Close;
  qryStoneTypes.Open;
  cbStoneType.Items.Clear;
  while not qryStoneTypes.Eof do
   begin
     if trim(qryStoneTypesSTONE_TYPE.AsString) <> '' then
       cbStoneType.Items.Add(trim(qryStoneTypesSTONE_TYPE.AsString));
     qryStoneTypes.Next;
   end;
  qryStoneTypes.Close;

end;

procedure TfrmEnterStoneInfo.btnSaveClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmEnterStoneInfo.btnCancelClick(Sender: TObject);
begin
//  frmInventory.qryStones.Cancel;
  ModalResult := mrCancel;
end;

end.
