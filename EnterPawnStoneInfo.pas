unit EnterPawnStoneInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, DB, RzButton, Vcl.ExtCtrls, RzLabel;

type
  TfrmEnterPawnStoneInfo = class(TForm)
    dsStoneShapes: TDataSource;
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
    dsWeigthUnits: TDataSource;
    Label18: TLabel;
    cbWeightUnit: TDBLookupComboBox;
    btnSabve: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DBEdit3Change(Sender: TObject);
  private
    procedure UpdateWeightUnitState;
    function Stones: TDataSet;
  public
    { Public declarations }
    NewRow: boolean;
    // The caller's stones (its dsStones): the pawn/purchase item form, or the
    // Receive Stock item form. Set before ShowModal.
    StonesSource: TDataSource;
    // True: every label in normal (not bold) font. Receive Stock sets it.
    PlainLabels: boolean;
  end;

var
  frmEnterPawnStoneInfo: TfrmEnterPawnStoneInfo;

implementation

Uses System.UITypes, GLbUtils, PawnDM, PawnGlobal;

{$R *.dfm}

function TfrmEnterPawnStoneInfo.Stones: TDataSet;
begin
  Result := StonesSource.DataSet;
end;

procedure TfrmEnterPawnStoneInfo.FormShow(Sender: TObject);
var
  i: integer;
begin
  if PlainLabels then
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TLabel then
        TLabel(Components[i]).Font.Style := TLabel(Components[i]).Font.Style - [fsBold];

  // Every data control edits the caller's stones.
  lkStoneShape.DataSource := StonesSource;
  lkStoneColor.DataSource := StonesSource;
  edStoneNumber.DataSource := StonesSource;
  DBEdit2.DataSource := StonesSource;
  DBEdit3.DataSource := StonesSource;
  cbStoneType.DataSource := StonesSource;
  cbWeightUnit.DataSource := StonesSource;

  FrmSetViewSize(Self);
//  Width := 267;

  dsStoneShapes.DataSet := DM.clnJStoneShapes;
  dsStoneColors.DataSet := DM.clnJStoneColors;
  dsWeigthUnits.DataSet := DM.clnWeigthUnits;

  FillCombo(cbStoneType, DM.clnStoneTypes, 'STONE_TYPE', '', '');

  if NewRow then
    begin
      Stones.Append;
    end
  else
    begin
      Stones.Edit;
    end;

  UpdateWeightUnitState;
end;

procedure TfrmEnterPawnStoneInfo.DBEdit3Change(Sender: TObject);
begin
  UpdateWeightUnitState;
end;

procedure TfrmEnterPawnStoneInfo.UpdateWeightUnitState;
var
  ReportedWeight: Double;
  HasReportedWeight: Boolean;
begin
  HasReportedWeight := TryStrToFloat(Trim(DBEdit3.Text), ReportedWeight) and
    (ReportedWeight > 0);

  cbWeightUnit.Enabled := HasReportedWeight;

  if not (Stones.State in dsEditModes) then
    Exit;

  if HasReportedWeight then
  begin
    if Stones.FieldByName('STONE_WEIGHT_UNIT').IsNull then
      Stones.FieldByName('STONE_WEIGHT_UNIT').AsString :=
        DefaultWeightMeasureUnit;
  end
  else if not Stones.FieldByName('STONE_WEIGHT_UNIT').IsNull then
    Stones.FieldByName('STONE_WEIGHT_UNIT').Clear;
end;

procedure TfrmEnterPawnStoneInfo.btnSaveClick(Sender: TObject);
begin
  if Stones.FieldByName('STONE_NUMBER').IsNull then
    begin
      MsgInfo('Please enter the number of stones.');
      edStoneNumber.SetFocus;
      exit;
    end;

  if Stones.FieldByName('STONE_SHAPE').IsNull then
    begin
      MsgInfo('Please enter the stone shape.');
      lkStoneShape.SetFocus;
      exit;
    end;

  if Stones.FieldByName('STONE_COLOR').IsNull then
    begin
      MsgInfo('Please enter the stone color.');
      lkStoneColor.SetFocus;
      exit;
    end;

  if Stones.FieldByName('WT').IsNull then
    Stones.FieldByName('WT').AsFloat := 0;

  if Stones.FieldByName('CT').IsNull then
    Stones.FieldByName('CT').AsFloat := 0;

  DM.AddStoneType(Stones.FieldByName('STONE_TYPE').AsString);

  Stones.Post;

  ModalResult := mrOk;
end;

procedure TfrmEnterPawnStoneInfo.btnCancelClick(Sender: TObject);
begin
  Stones.Cancel;
  ModalResult := mrCancel;
end;

end.
