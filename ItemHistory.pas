unit ItemHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzLabel,
  Vcl.ComCtrls;

type
  // One step of an item's life: the status it reached and when.
  TItemStatusStep = record
    StatusName: string;
    StatusDate: TDateTime;
  end;

  TItemStatusTrail = array of TItemStatusStep;

  TfrmItemHistory = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnClose: TBitBtn;
    lblItem: TRzLabel;
    lvHistory: TListView;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure lvHistoryCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  public
    procedure LoadItem(AInvItemNo: integer);
  end;

// Builds the status trail from an item's date columns, oldest step first.
// Pass 0 for a date that is not set. The trail is reconstructed from the dates
// themselves - there is no event log - so a status set twice shows only its
// most recent date, and items pumped from the old ASA system may have gaps.
function BuildItemStatusTrail(const APawned, APurchase, ALayaway, AForSale,
  ARedeemed, ADefaulted, AMelted, ASold: TDateTime): TItemStatusTrail;

// Renders a trail as one "Pawned     01/10/2026" line per step.
function ItemStatusTrailToText(const ATrail: TItemStatusTrail): string;

// AHost, when given, centers the form over that control the way
// frmPawnChangeStatus is positioned over its grid.
procedure ShowItemHistory(AInvItemNo: integer; AHost: TWinControl = nil);

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, FireDAC.Comp.Client;

function BuildItemStatusTrail(const APawned, APurchase, ALayaway, AForSale,
  ARedeemed, ADefaulted, AMelted, ASold: TDateTime): TItemStatusTrail;
var
  Count, i, j: integer;
  Tmp: TItemStatusStep;

  procedure Add(const AStatusName: string; AStatusDate: TDateTime);
  begin
    if AStatusDate = 0 then
      Exit;
    Result[Count].StatusName := AStatusName;
    Result[Count].StatusDate := AStatusDate;
    Inc(Count);
  end;

begin
  SetLength(Result, 8);
  Count := 0;

  Add(PawnItemStatus_Pawned, APawned);
  Add('Purchased', APurchase);
  Add(PawnItemStatus_Layaway, ALayaway);
  Add(PawnItemStatus_Redeemed, ARedeemed);
  Add(PawnItemStatus_Defaulted, ADefaulted);
  Add(PawnItemStatus_ForSale, AForSale);
  Add(PawnItemStatus_Melted, AMelted);
  Add(PawnItemStatus_Sold, ASold);

  SetLength(Result, Count);

  // insertion sort, oldest first (at most 8 steps)
  for i := 1 to Count - 1 do
    begin
      Tmp := Result[i];
      j := i - 1;
      while (j >= 0) and (Result[j].StatusDate > Tmp.StatusDate) do
        begin
          Result[j + 1] := Result[j];
          Dec(j);
        end;
      Result[j + 1] := Tmp;
    end;
end;

function ItemStatusTrailToText(const ATrail: TItemStatusTrail): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to High(ATrail) do
    begin
      if Result <> '' then
        Result := Result + sLineBreak;
      Result := Result + Format('%-10s %s',
        [ATrail[i].StatusName, FormatDateTime('mm/dd/yyyy', ATrail[i].StatusDate)]);
    end;
end;

// Null dates come back as 0, which BuildItemStatusTrail reads as "not set".
function FieldDate(AQuery: TFDQuery; const AFieldName: string): TDateTime;
begin
  if AQuery.FieldByName(AFieldName).IsNull then
    Result := 0
  else
    Result := AQuery.FieldByName(AFieldName).AsDateTime;
end;

procedure ShowItemHistory(AInvItemNo: integer; AHost: TWinControl = nil);
var
  Frm: TfrmItemHistory;
begin
  Frm := TfrmItemHistory.Create(Application);
  try
    Frm.LoadItem(AInvItemNo);
    if AHost <> nil then
      CenterPopupOnControl(AHost, Frm);
    Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

procedure TfrmItemHistory.FormCreate(Sender: TObject);
begin
  lvHistory.ViewStyle := vsReport;
  lvHistory.ReadOnly := True;
  lvHistory.RowSelect := True;
  lvHistory.GridLines := True;
  lvHistory.OnCustomDrawItem := lvHistoryCustomDrawItem;

  if lvHistory.Columns.Count = 0 then
    begin
      with lvHistory.Columns.Add do
        begin
          Caption := 'Status';
          Width := 160;
        end;
      with lvHistory.Columns.Add do
        begin
          Caption := 'Date';
          Width := 120;
        end;
    end;
end;

procedure TfrmItemHistory.LoadItem(AInvItemNo: integer);
var
  Qry: TFDQuery;
  Trail: TItemStatusTrail;
  i: integer;
  Item: TListItem;
begin
  lvHistory.Items.Clear;
  lblItem.Caption := '';

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DM.ConnFB;
    Qry.SQL.Text :=
      'SELECT INV_ITEM_BARCODE, DESCRIPTION, ' +
      '       PAWNED_DATE, PURCHASE_DATE, LAYAWAY_DATE, FORSALE_DATE, ' +
      '       REDEEMED_DATE, DEFAULTED_DATE, MELTED_DATE, SOLD_DATE ' +
      'FROM INVENTORY_ITEMS ' +
      'WHERE INV_ITEM_NO = :ItemNo';
    Qry.ParamByName('ItemNo').AsInteger := AInvItemNo;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    lblItem.Caption := Trim(Qry.FieldByName('INV_ITEM_BARCODE').AsString + '  ' +
                            Qry.FieldByName('DESCRIPTION').AsString);

    Trail := BuildItemStatusTrail(FieldDate(Qry, 'PAWNED_DATE'),
                                  FieldDate(Qry, 'PURCHASE_DATE'),
                                  FieldDate(Qry, 'LAYAWAY_DATE'),
                                  FieldDate(Qry, 'FORSALE_DATE'),
                                  FieldDate(Qry, 'REDEEMED_DATE'),
                                  FieldDate(Qry, 'DEFAULTED_DATE'),
                                  FieldDate(Qry, 'MELTED_DATE'),
                                  FieldDate(Qry, 'SOLD_DATE'));
  finally
    Qry.Free;
  end;

  lvHistory.Items.BeginUpdate;
  try
    for i := 0 to High(Trail) do
      begin
        Item := lvHistory.Items.Add;
        Item.Caption := Trail[i].StatusName;
        Item.SubItems.Add(FormatDateTime('mm/dd/yyyy', Trail[i].StatusDate));
      end;
  finally
    lvHistory.Items.EndUpdate;
  end;
end;

procedure TfrmItemHistory.lvHistoryCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  StatusColor: TPawnStatusColor;
begin
  StatusColor := GetPawnStatusColor(Item.Caption);
  Sender.Canvas.Brush.Color := StatusColor.BG;
  Sender.Canvas.Font.Color := StatusColor.FG;
  DefaultDraw := True;
end;

procedure TfrmItemHistory.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
