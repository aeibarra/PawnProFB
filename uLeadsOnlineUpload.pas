unit uLeadsOnlineUpload;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  Leadsonline, Soap.SOAPHTTPClient, Soap.InvokeRegistry, Vcl.Dialogs;

type
  TLeadsOnlineUploader = class
  private
    FClient: ticketWSSoap; // from your imported WSDL unit
  public
    constructor Create;
    destructor Destroy; override;
    procedure UploadTransactions(ADataset: TDataSet);
  end;

implementation

{ TLeadsOnlineUploader }

constructor TLeadsOnlineUploader.Create;
begin
  inherited Create;
  FClient := GetticketWSSoap(true, '', nil); // uses WSDL endpoint from unit
end;

destructor TLeadsOnlineUploader.Destroy;
begin
  inherited;
end;

procedure TLeadsOnlineUploader.UploadTransactions(ADataset: TDataSet);
var
  Transactions: ArrayOfTransaction;
  Tx: Transaction;
  Idx: Integer;
begin
  if ADataset.IsEmpty then
    raise Exception.Create('No transactions to upload.');

  SetLength(Transactions, ADataset.RecordCount);
  Idx := 0;

  ADataset.First;
  while not ADataset.Eof do
  begin
    Tx := Transaction.Create;
    try
      // Hardcoded field mapping from your dataset to LeadsOnline SOAP object
      Tx.TicketNumber      := ADataset.FieldByName('TicketNo').AsString;
      Tx.CustomerName      := ADataset.FieldByName('CustomerName').AsString;
      Tx.TransactionDate   := ADataset.FieldByName('TransactionDate').AsDateTime;
      Tx.ItemDescription   := ADataset.FieldByName('ItemDesc').AsString;
      Tx.AmountPaid        := ADataset.FieldByName('AmountPaid').AsFloat;
      Tx.SerialNumber      := ADataset.FieldByName('SerialNo').AsString;
      // add any other fields here as needed

      Transactions[Idx] := Tx;
      Inc(Idx);
    except
      Tx.Free;
      raise;
    end;

    ADataset.Next;
  end;

  try
    FClient.SubmitTransactions(Transactions);
    ShowMessage('Transactions uploaded successfully!');
  except
    on E: Exception do
      ShowMessage('Upload failed: ' + E.Message);
  end;

  // Free objects in array
  for Tx in Transactions do
    Tx.Free;
end;

end.
