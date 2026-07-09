unit EnterPawnStoneInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, DB, RzButton,
  Datasnap.DBClient, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmEnterPawnStoneInfo = class(TForm)
    dsStoneShapes: TDataSource;
    qryStoneTypes: TFDQuery;
    qryStoneTypesSTONE_TYPE: TWideStringField;
    dsStoneColors: TDataSource;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lkStoneShape: TDBLookupComboBox;
    lkStoneColor: TDBLookupComboBox;
    edStoneNumber: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    cbStoneType: TDBComboBox;
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TRzBitBtn;
    clnWeigthUnits: TClientDataSet;
    clnWeigthUnitsWeigthUnitValue: TWideStringField;
    clnWeigthUnitsWeightUnit: TWideStringField;
    dsWeigthUnits: TDataSource;
    Label18: TLabel;
    cbWeightUnit: TDBLookupComboBox;
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
  frmEnterPawnStoneInfo: TfrmEnterPawnStoneInfo;

implementation

Uses Entertems, GLbUtils, PawnDM;

{$R *.dfm}

procedure TfrmEnterPawnStoneInfo.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);
//  Width := 267;

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

  DM.GetWeightUnits(clnWeigthUnits);

  if NewRow then
    begin
      frmEnterItems.qryStones.Append;
    end
  else
    begin
      frmEnterItems.qryStones.Edit;
    end;
end;

procedure TfrmEnterPawnStoneInfo.btnSaveClick(Sender: TObject);
begin
  if frmEnterItems.qryStonesSTONE_NUMBER.IsNull then
    begin
      MsgInfo('Please enter the number of stones.');
      edStoneNumber.SetFocus;
      exit;
    end;

  if frmEnterItems.qryStonesSTONE_SHAPE.IsNull then
    begin
      MsgInfo('Please enter the stone shape.');
      lkStoneShape.SetFocus;
      exit;
    end;

  if frmEnterItems.qryStonesSTONE_COLOR.IsNull then
    begin
      MsgInfo('Please enter the stone color.');
      lkStoneColor.SetFocus;
      exit;
    end;

  if frmEnterItems.qryStonesWT.IsNull then
    frmEnterItems.qryStonesWT.AsFloat := 0;

  if frmEnterItems.qryStonesCT.IsNull then
    frmEnterItems.qryStonesCT.AsFloat := 0;

  frmEnterItems.qryStones.Post;

  ModalResult := mrOk;
end;

procedure TfrmEnterPawnStoneInfo.btnCancelClick(Sender: TObject);
begin
  frmEnterItems.qryStones.Cancel;
  ModalResult := mrCancel;
end;

end.
