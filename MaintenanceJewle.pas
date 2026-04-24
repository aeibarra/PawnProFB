unit MaintenanceJewle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ComCtrls, ADODB;

type
  TfrmMaintenanceJ = class(TForm)
    GroupBox1: TGroupBox;
    btnAddCat: TBitBtn;
    btnEditCat: TBitBtn;
    btnClose: TBitBtn;
    dsMaintenace: TDataSource;
    DBGrid1: TDBGrid;
    qryTypes: TADOQuery;
    qryTypesJType: TStringField;
    qryTypesJTypeDesc: TStringField;
    qryStyles: TADOQuery;
    qryStylesJStyle: TStringField;
    qryStylesJStyleDesc: TStringField;
    qryMetal: TADOQuery;
    qryMetalJMetal: TStringField;
    qryMetalJMetalDesc: TStringField;
    qryStoneShapes: TADOQuery;
    qryStoneShapesJShape: TStringField;
    qryStoneShapesJShapeDesc: TStringField;
    qryStoneColors: TADOQuery;
    qryStoneColorsJStoneColor: TStringField;
    qryStoneColorsJStoneDesc: TStringField;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddCatClick(Sender: TObject);
    procedure btnEditCatClick(Sender: TObject);
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

Uses PawnDM, EditMaintenance;

{$R *.dfm}

procedure TfrmMaintenanceJ.btnCloseClick(Sender: TObject);
begin
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
  ActiveDataSet.Open;
end;

procedure TfrmMaintenanceJ.btnAddCatClick(Sender: TObject);
begin
  frmEditMaintenance := TfrmEditMaintenance.Create(Self);
  try
    frmEditMaintenance.NewRow := true;
    frmEditMaintenance.dsMaintenance.DataSet := ActiveDataSet;
    if frmEditMaintenance.ShowModal = mrOK then
      begin
      end;
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
    frmEditMaintenance.ShowModal;
  finally
    frmEditMaintenance.Free;
  end;
end;

end.
