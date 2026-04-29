unit ChangePawnItemsStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, SelectedItemsInGridClass,
  RzButton, Vcl.Mask, Vcl.DBCtrls, RzCmboBx, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmChangePawnItemsStatus = class(TForm)
    GroupBox1: TGroupBox;
    btnExit: TBitBtn;
    GroupBox2: TGroupBox;
    btnSave: TRzBitBtn;
    GroupBox3: TGroupBox;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    cbPawnStatus: TRzComboBox;
    Panel1: TPanel;
    cbItemStatusToSet: TRzComboBox;
    Label4: TLabel;
    dbGridItems: TDBGrid;
    Label5: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbGridItemsCellClick(Column: TColumn);
    procedure dbGridItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    SelectedItemsInGrid: TSelectedItemsInGridClass;
  public
    { Public declarations }
  end;

var
  frmChangePawnItemsStatus: TfrmChangePawnItemsStatus;

implementation

uses PawnDM, SearchClient, GLbUtils;

{$R *.dfm}

procedure TfrmChangePawnItemsStatus.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChangePawnItemsStatus.btnSaveClick(Sender: TObject);
begin
  //
end;

procedure TfrmChangePawnItemsStatus.dbGridItemsCellClick(Column: TColumn);
begin
  if frmClients.qryInvItemsInvItemNo.IsNull or (Column.Index <> 0) then
    exit;

   if SelectedItemsInGrid.IsInCheckList(frmClients.qryInvItemsInvItemNo.AsString) then
      SelectedItemsInGrid.RemoveFromCheckList(frmClients.qryInvItemsInvItemNo.AsString)
   else
     SelectedItemsInGrid.AddToCheckList(frmClients.qryInvItemsInvItemNo.AsString);

   dbGridItems.Invalidate;

end;

procedure TfrmChangePawnItemsStatus.dbGridItemsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if frmClients.qryInvItemsInvItemNo.IsNull then
    exit;


  GridCheckBox((Sender as TDBGrid), Rect, Column, DataCol, State, SelectedItemsInGrid.IsInCheckList(frmClients.qryInvItemsInvItemNo.AsString));

end;

procedure TfrmChangePawnItemsStatus.FormShow(Sender: TObject);
begin
  SelectedItemsInGrid := TSelectedItemsInGridClass.Create;

  DM.FillPawnStatusCombobox(cbPawnStatus, DM.qryTransactionsTRAN_STATUS.AsString);
  FillCombo(TCombobox(cbItemStatusToSet), DM.clnItemStatus, 'StatusDesc', '', false);

end;

end.
