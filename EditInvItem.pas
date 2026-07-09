unit EditInvItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DB, ExtCtrls, Grids,
  DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmEditInvItem = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label2: TLabel;
    dsTypes: TDataSource;
    DBLookupComboBox2: TDBLookupComboBox;
    Label3: TLabel;
    dsStyles: TDataSource;
    DBLookupComboBox3: TDBLookupComboBox;
    Label4: TLabel;
    dsMetal: TDataSource;
    DBMemo1: TDBMemo;
    Label7: TLabel;
    dsInvItems: TDataSource;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    edItemCount: TDBEdit;
    Label9: TLabel;
    DBEdit2: TDBEdit;
    Label10: TLabel;
    DBEdit3: TDBEdit;
    Label11: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    DBLookupComboBox4: TDBLookupComboBox;
    Label12: TLabel;
    dsCategories: TDataSource;
    qryCategories: TFDQuery;
    qryCategoriesINV_CAT_NO: TIntegerField;
    qryCategoriesINV_CATEGORY: TWideStringField;
    Label13: TLabel;
    qryBrands: TFDQuery;
    qryBrandsINV_ITEM_BRAND: TWideStringField;
    cbBrand: TDBComboBox;
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
  frmEditInvItem: TfrmEditInvItem;

implementation

Uses Inventory, SearchClient, PawnDM;

{$R *.dfm}

procedure TfrmEditInvItem.FormShow(Sender: TObject);
begin
  Width := 381;

  dsTypes.DataSet := DM.clnJTypes;
  dsStyles.DataSet := DM.clnJStyles;
  dsMetal.DataSet := DM.clnJMetals;

  qryBrands.Close;
  qryBrands.Open;
  cbBrand.Items.Clear;
  while not qryBrands.Eof do
    begin
      if trim(qryBrandsINV_ITEM_BRAND.AsString) <> '' then
        cbBrand.Items.Add(qryBrandsINV_ITEM_BRAND.AsString);
      qryBrands.Next;
    end;
  qryBrands.Close;

  qryCategories.Close;
  qryCategories.Open;
//  qryStoneShapes.Open;
//  qryStoneColors.Open;

  if NewRow then
    begin
      dsInvItems.DataSet.Append;
    end
  else
    begin
      dsInvItems.DataSet.Edit;
    end;
  edItemCount.SetFocus;
end;

procedure TfrmEditInvItem.btnSaveClick(Sender: TObject);
begin
  dsInvItems.DataSet.Post;
  if trim(dsInvItems.DataSet.FieldByName('InvItemBarcode').AsString) = '' then
    begin
      dsInvItems.DataSet.Edit;
      dsInvItems.DataSet.FieldByName('InvItemBarcode').AsString := DM.GetBarcode(dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger); //Format('%.6d', [dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger]);
      dsInvItems.DataSet.Post;
    end;

  ModalResult := mrOk;
end;

procedure TfrmEditInvItem.btnCancelClick(Sender: TObject);
begin
  dsInvItems.DataSet.Cancel;

  ModalResult := mrCancel;
end;

end.
