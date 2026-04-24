unit EnterStoneInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, DB, Mask, ADODB, Vcl.ExtCtrls;

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
    qryStoneShapes: TADOQuery;
    qryStoneShapesJShape: TStringField;
    qryStoneShapesJShapeDesc: TStringField;
    qryStoneColors: TADOQuery;
    qryStoneColorsJStoneColor: TStringField;
    qryStoneColorsJStoneDesc: TStringField;
    cbStoneType: TDBComboBox;
    Label4: TLabel;
    qryStoneTypes: TADODataSet;
    qryStoneTypesStoneType: TStringField;
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

  qryStoneTypes.Open;
  cbStoneType.Items.Clear;
  while not qryStoneTypes.Eof do
   begin
     if trim(qryStoneTypesStoneType.AsString) <> '' then
       cbStoneType.Items.Add(trim(qryStoneTypesStoneType.AsString));
     qryStoneTypes.Next;
   end;
  qryStoneTypes.Close;

  qryStoneShapes.Open;
  qryStoneColors.Open;

//  if NewRow then
//    begin
//      frmInventory.qryStones.Append;
//    end
//  else
//    begin
//      frmInventory.qryStones.Edit;
//    end;
end;

procedure TfrmEnterStoneInfo.btnSaveClick(Sender: TObject);
begin
//  frmInventory.qryStones.Post;
//  frmInventory.qryStones.ApplyUpdates;
  ModalResult := mrOK;
end;

procedure TfrmEnterStoneInfo.btnCancelClick(Sender: TObject);
begin
//  frmInventory.qryStones.Cancel;
  ModalResult := mrCancel;
end;

end.
