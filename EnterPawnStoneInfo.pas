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
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEnterPawnStoneInfo: TfrmEnterPawnStoneInfo;

implementation

Uses Entertems, GLbUtils, PawnDM, PawnGlobal;

{$R *.dfm}

procedure TfrmEnterPawnStoneInfo.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);
//  Width := 267;

  dsStoneShapes.DataSet := DM.clnJStoneShapes;
  dsStoneColors.DataSet := DM.clnJStoneColors;
  dsWeigthUnits.DataSet := DM.clnWeigthUnits;

  FillCombo(cbStoneType, DM.clnStoneTypes, 'STONE_TYPE', '', '');

  if NewRow then
    begin
      frmEnterItems.qryStones.Append;
    end
  else
    begin
      frmEnterItems.qryStones.Edit;
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

  if not (frmEnterItems.qryStones.State in dsEditModes) then
    Exit;

  if HasReportedWeight then
  begin
    if frmEnterItems.qryStonesSTONE_WEIGHT_UNIT.IsNull then
      frmEnterItems.qryStonesSTONE_WEIGHT_UNIT.AsString :=
        DefaultWeightMeasureUnit;
  end
  else if not frmEnterItems.qryStonesSTONE_WEIGHT_UNIT.IsNull then
    frmEnterItems.qryStonesSTONE_WEIGHT_UNIT.Clear;
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

  DM.AddStoneType(frmEnterItems.qryStonesSTONE_TYPE.AsString);

  frmEnterItems.qryStones.Post;

  ModalResult := mrOk;
end;

procedure TfrmEnterPawnStoneInfo.btnCancelClick(Sender: TObject);
begin
  frmEnterItems.qryStones.Cancel;
  ModalResult := mrCancel;
end;

end.
