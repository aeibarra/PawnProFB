unit EnterPawnStoneInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, ADODB, DB, RzButton,
  Datasnap.DBClient, Vcl.ExtCtrls;

type
  TfrmEnterPawnStoneInfo = class(TForm)
    qryStoneShapes: TADOQuery;
    qryStoneShapesJShape: TStringField;
    qryStoneShapesJShapeDesc: TStringField;
    dsStoneShapes: TDataSource;
    qryStoneTypes: TADODataSet;
    qryStoneTypesStoneType: TStringField;
    dsStoneColors: TDataSource;
    qryStoneColors: TADOQuery;
    qryStoneColorsJStoneColor: TStringField;
    qryStoneColorsJStoneDesc: TStringField;
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
    clnWeigthUnitsWeigthUnitValue: TStringField;
    clnWeigthUnitsWeightUnit: TStringField;
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

  DM.GetWeightUnits(clnWeigthUnits);

  if NewRow then
    begin
      frmEnterItems.clnStones.Append;
    end
  else
    begin
      frmEnterItems.clnStones.Edit;
    end;
end;

procedure TfrmEnterPawnStoneInfo.btnSaveClick(Sender: TObject);
begin
  if frmEnterItems.clnStonesStoneNumber.IsNull then
    begin
      MsgInfo('Please enter the number of stones.');
      edStoneNumber.SetFocus;
      exit;
    end;

  if frmEnterItems.clnStonesStoneShape.IsNull then
    begin
      MsgInfo('Please enter the stone shape.');
      lkStoneShape.SetFocus;
      exit;
    end;

  if frmEnterItems.clnStonesStoneColor.IsNull then
    begin
      MsgInfo('Please enter the stone color.');
      lkStoneColor.SetFocus;
      exit;
    end;

  if frmEnterItems.clnStonesWT.IsNull then
    frmEnterItems.clnStonesWT.AsFloat := 0;

  if frmEnterItems.clnStonesCT.IsNull then
    frmEnterItems.clnStonesCT.AsFloat := 0;

  frmEnterItems.clnStones.Post;

  ModalResult := mrOk;
end;

procedure TfrmEnterPawnStoneInfo.btnCancelClick(Sender: TObject);
begin
  frmEnterItems.clnStones.Cancel;
  ModalResult := mrCancel;
end;

end.
