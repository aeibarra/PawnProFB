unit MaintenanceJewle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ComCtrls,
  FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.Stan.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmMaintenanceJ = class(TForm)
    GroupBox1: TGroupBox;
    btnAddCat: TBitBtn;
    btnEditCat: TBitBtn;
    btnClose: TBitBtn;
    dsMaintenace: TDataSource;
    DBGrid1: TDBGrid;
    qryTypes: TFDQuery;
    qryTypesJ_TYPE: TStringField;
    qryTypesJ_TYPE_DESC: TStringField;
    qryStyles: TFDQuery;
    qryStylesJ_STYLE: TStringField;
    qryStylesJ_STYLE_DESC: TStringField;
    qryMetal: TFDQuery;
    qryMetalJ_METAL: TStringField;
    qryMetalJ_METAL_DESC: TStringField;
    qryStoneShapes: TFDQuery;
    qryStoneShapesJ_SHAPE: TStringField;
    qryStoneShapesJ_SHAPE_DESC: TStringField;
    qryStoneColors: TFDQuery;
    qryStoneColorsJ_STONE_COLOR: TStringField;
    qryStoneColorsJ_STONE_DESC: TStringField;
    qryTypesCUST_FIELD: TBooleanField;
    qryStylesCUST_FIELD: TBooleanField;
    qryMetalCUST_FIELD: TBooleanField;
    qryStoneShapesCUST_FIELD: TBooleanField;
    qryStoneColorsCUST_FIELD: TBooleanField;
    btnDelete: TBitBtn;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddCatClick(Sender: TObject);
    procedure btnEditCatClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dsMaintenaceDataChange(Sender: TObject; Field: TField);
    procedure qryNewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Selection: integer;
    ActiveDataSet: TDataSet;
  end;

var
  frmMaintenanceJ: TfrmMaintenanceJ;

implementation

Uses PawnDM, EditMaintenance, uPawnDialogs;

{$R *.dfm}

procedure TfrmMaintenanceJ.btnCloseClick(Sender: TObject);
begin
  if Assigned(ActiveDataSet) and (ActiveDataSet.State in dsEditModes) then
    ActiveDataSet.Cancel;
  Close;
end;

procedure TfrmMaintenanceJ.FormShow(Sender: TObject);
begin
  case Selection of
  1: // Type
    begin
      Caption := 'Jewel Type';
      ActiveDataSet := qryTypes;
///      qryTypes.Open;
    end;
  2:  //Style
    begin
      Caption := 'Jewel Styles';
      ActiveDataSet := qryStyles;
//      qryStyles.Open;
    end;
  3:  //Metal
    begin
//      PageControl.ActivePage := TabSheetMetal;
      Caption := 'Jewel Metals';
      ActiveDataSet := qryMetal;
//      qryMetal.Open;
    end;
  4:  //Stone Shape
    begin
//      PageControl.ActivePage := TabSheetStoneShape;
      Caption := 'Jewel Stone Shapes';
      ActiveDataSet := qryStoneShapes;
//      qryStoneShapes.Open;
    end;
  5:  //Stone Color
    begin
//      PageControl.ActivePage := TabSheetStoneColor;
      Caption := 'Jewel Stone Colors';
      ActiveDataSet := qryStoneColors;
//      qryStoneColors.Open;
    end;
  end; //case

  dsMaintenace.DataSet := ActiveDataSet;
  if Assigned(ActiveDataSet) then
    begin
      ActiveDataSet.Close;
      ActiveDataSet.Open;
    end;
end;

procedure TfrmMaintenanceJ.btnAddCatClick(Sender: TObject);
begin
  frmEditMaintenance := TfrmEditMaintenance.Create(Self);
  try
    frmEditMaintenance.NewRow := true;
    frmEditMaintenance.dsMaintenance.DataSet := ActiveDataSet;
    if frmEditMaintenance.ShowModal = mrOK then
      begin
        ActiveDataSet.Refresh;
        DM.RefreshLookupMemTables;
      end
    else if ActiveDataSet.State in dsEditModes then
      ActiveDataSet.Cancel;
  finally
    frmEditMaintenance.Free;
  end;
end;

procedure TfrmMaintenanceJ.btnEditCatClick(Sender: TObject);
begin
  frmEditMaintenance := TfrmEditMaintenance.Create(Self);
  try
    frmEditMaintenance.NewRow := false;
    frmEditMaintenance.dsMaintenance.DataSet := ActiveDataSet;
    if frmEditMaintenance.ShowModal = mrOK then
      begin
        ActiveDataSet.Refresh;
        DM.RefreshLookupMemTables;
      end
    else if ActiveDataSet.State in dsEditModes then
      ActiveDataSet.Cancel;
  finally
    frmEditMaintenance.Free;
  end;
end;

procedure TfrmMaintenanceJ.btnDeleteClick(Sender: TObject);
var
  CustField: TField;
begin
  if not Assigned(ActiveDataSet) or ActiveDataSet.IsEmpty then
    Exit;

  CustField := ActiveDataSet.FindField('CUST_FIELD');
  if not Assigned(CustField) or not CustField.AsBoolean then
    begin
      PawnWarn('Only custom entries can be deleted. Standard police-required values cannot be removed.');
      Exit;
    end;

  if not PawnConfirm('Delete this custom entry?') then
    Exit;

  try
    ActiveDataSet.Delete;
    DM.RefreshLookupMemTables;
  except
    on E: Exception do
      PawnError('Could not delete this entry. It may be in use by an existing inventory item.' + sLineBreak + sLineBreak + E.Message);
  end;
end;

procedure TfrmMaintenanceJ.dsMaintenaceDataChange(Sender: TObject; Field: TField);
var
  CustField: TField;
begin
  CustField := nil;
  if Assigned(ActiveDataSet) and ActiveDataSet.Active and not ActiveDataSet.IsEmpty then
    CustField := ActiveDataSet.FindField('CUST_FIELD');
  btnDelete.Enabled := Assigned(CustField) and CustField.AsBoolean;
end;

procedure TfrmMaintenanceJ.qryNewRecord(DataSet: TDataSet);
begin
  // New rows added through this form are user-defined customs and may be deleted.
  // Standard police-required rows pre-date the column and have CUST_FIELD = false.
  DataSet.FieldByName('CUST_FIELD').AsBoolean := True;
end;

procedure TfrmMaintenanceJ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ActiveDataSet) and (ActiveDataSet.State in dsEditModes) then
    ActiveDataSet.Cancel;
  DM.RefreshLookupMemTables;
end;

end.
