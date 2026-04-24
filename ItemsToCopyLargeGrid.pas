unit ItemsToCopyLargeGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, Data.DB;

type
  TfrmItemsToCopyLargeGrid = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    dbGridItems: TDBGrid;
    btnCheckAll: TButton;
    btnClearAll: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure dbGridItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure dbGridItemsCellClick(Column: TColumn);
    procedure dbGridItemsTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    LastIndexUsed: string;
  public
    { Public declarations }
  end;

var
  frmItemsToCopyLargeGrid: TfrmItemsToCopyLargeGrid;

implementation

uses EnterTransactions, PawnGlobal, GLbUtils;

{$R *.dfm}

procedure TfrmItemsToCopyLargeGrid.btnCheckAllClick(Sender: TObject);
var
  SavePos: integer;
begin
  if not frmEnterTransaction.clnItemsToSelect.Active then
    exit;

  SavePos := frmEnterTransaction.clnItemsToSelect.RecNo;
  try
    frmEnterTransaction.clnItemsToSelect.DisableControls;
   frmEnterTransaction. clnItemsToSelect.First;
    while not frmEnterTransaction.clnItemsToSelect.Eof do
      begin
        frmEnterTransaction.AddToItemList(frmEnterTransaction.clnItemsToSelectInvItemNo.AsInteger);
        frmEnterTransaction.clnItemsToSelect.Next;
      end;
  finally
    frmEnterTransaction.clnItemsToSelect.RecNo := SavePos;
    frmEnterTransaction.clnItemsToSelect.EnableControls;
  end;

  dbGridItems.Invalidate;
end;

procedure TfrmItemsToCopyLargeGrid.btnClearAllClick(Sender: TObject);
begin
  frmEnterTransaction.SelectedItemList.Clear;
  dbGridItems.Invalidate;
end;

procedure TfrmItemsToCopyLargeGrid.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmItemsToCopyLargeGrid.dbGridItemsCellClick(Column: TColumn);
begin
  if frmEnterTransaction.clnItemsToSelectInvItemNo.IsNull or (Column.Index <> 0) then
    exit;

   if frmEnterTransaction.InItemList(frmEnterTransaction.clnItemsToSelectInvItemNo.AsInteger) then
      frmEnterTransaction.RemoveFromItemList(frmEnterTransaction.clnItemsToSelectInvItemNo.AsInteger)
   else
     frmEnterTransaction.AddToItemList(frmEnterTransaction.clnItemsToSelectInvItemNo.AsInteger);
     
   dbGridItems.Invalidate;
end;

procedure TfrmItemsToCopyLargeGrid.dbGridItemsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if frmEnterTransaction.clnItemsToSelectInvItemNo.IsNull then
    exit;

  GridCheckBox((Sender as TDBGrid), Rect, Column, DataCol, State, frmEnterTransaction.InItemList(frmEnterTransaction.clnItemsToSelectInvItemNo.AsInteger));

end;

procedure TfrmItemsToCopyLargeGrid.dbGridItemsTitleClick(Column: TColumn);
begin
  DoGridSorting(dbGridItems, Column, frmEnterTransaction.clnItemsToSelect, LastIndexUsed, WriteLogFile);
end;

procedure TfrmItemsToCopyLargeGrid.FormShow(Sender: TObject);
begin
  DoGridSorting(dbGridItems, dbGridItems.Columns[2], frmEnterTransaction.clnItemsToSelect, LastIndexUsed, WriteLogFile); // Sort Asc by Description
end;

end.
