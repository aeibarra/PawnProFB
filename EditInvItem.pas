unit EditInvItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DB, ExtCtrls, Grids,
  DBGrids, ADODB;

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
    qryMetal: TADOQuery;
    qryCategories: TADOQuery;
    qryMetalJMetal: TStringField;
    qryMetalJMetalDesc: TStringField;
    qryCategoriesInvCatNo: TAutoIncField;
    qryCategoriesInvCategory: TStringField;
    qryStyles: TADOQuery;
    qryStylesJStyle: TStringField;
    qryStylesJStyleDesc: TStringField;
    qryTypes: TADOQuery;
    qryTypesJType: TStringField;
    qryTypesJTypeDesc: TStringField;
    Label13: TLabel;
    qryBrands: TADODataSet;
    qryBrandsInvItemBrand: TStringField;
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

  qryBrands.Open;
  cbBrand.Items.Clear;
  while not qryBrands.Eof do
    begin
      if trim(qryBrandsInvItemBrand.AsString) <> '' then
        cbBrand.Items.Add(qryBrandsInvItemBrand.AsString);
      qryBrands.Next;
    end;
  qryBrands.Close;

  qryTypes.Open;
  qryStyles.Open;
  qryMetal.Open;
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
