unit MaintenanceJTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB;

type
  TfrmMaintenanceJType = class(TForm)
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    btnAddCat: TBitBtn;
    btnEditCat: TBitBtn;
    btnClose: TBitBtn;
    qryBrands: TADODataSet;
    qryBrandsBrandNo: TAutoIncField;
    qryBrandsBrandName: TStringField;
    dsMaintenance: TDataSource;
    qryStoneTypes: TADODataSet;
    qryStoneTypesStoneTypeNo: TAutoIncField;
    qryStoneTypesStoneTypeDesc: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddCatClick(Sender: TObject);
    procedure btnEditCatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Select: integer;
    procedure EditMaintenance(NewRow: boolean);
  end;

var
  frmMaintenanceJType: TfrmMaintenanceJType;

implementation

Uses PawnDM, EditMaintenance;

{$R *.dfm}

procedure TfrmMaintenanceJType.FormShow(Sender: TObject);
begin
  case Select of
  1: //Brand
    begin
      Caption := 'Brands maintenace';
      dsMaintenance.DataSet := qryBrands;
    end;
  2: //Stone Type
    begin
      Caption := 'Stone Type';
      dsMaintenance.DataSet := qryStoneTypes;
    end;
  end;

  dsMaintenance.DataSet.Open;
end;

procedure TfrmMaintenanceJType.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMaintenanceJType.EditMaintenance(NewRow: boolean);
begin
  frmEditMaintenance := TfrmEditMaintenance.Create(Application);
  try
    frmEditMaintenance.NewRow := NewRow;
    frmEditMaintenance.dsMaintenance.DataSet := dsMaintenance.DataSet;
    frmEditMaintenance.edInitials.Visible := false;
    frmEditMaintenance.edDescription.Left := frmEditMaintenance.edInitials.Left;
    frmEditMaintenance.lblDesc.Left := frmEditMaintenance.edInitials.Left + 3;
    frmEditMaintenance.edDescription.Width := 352 - 40;
    frmEditMaintenance.lblInitials.Caption := '';
    frmEditMaintenance.ShowModal;
  finally
    frmEditMaintenance.Free;
  end;
end;

procedure TfrmMaintenanceJType.btnAddCatClick(Sender: TObject);
begin
  EditMaintenance(true);
end;

procedure TfrmMaintenanceJType.btnEditCatClick(Sender: TObject);
begin
  EditMaintenance(false);
end;

end.
