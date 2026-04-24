unit uPawnDialogs;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs, Winapi.Windows, Vcl.Forms, Vcl.Controls;

type
  TPawnDlgKind = (pdkInfo, pdkWarning, pdkError, pdkConfirm);

  // For your Layaway close scenario
  TLayawayCloseReason = (
    lcrUnknown,
    lcrCustomerCanceled,
    lcrPaidOffReleaseItem,
    lcrForgotLastPayment
  );

function PawnInfo(const Msg: string; Title: string = 'PawnPro'; const Parent: TWinControl = nil): Integer;
function PawnWarn(const Msg: string; Title: string = 'PawnPro'; const Parent: TWinControl = nil): Integer;
function PawnError(const Msg: string; Title: string = 'PawnPro'; const Parent: TWinControl = nil): Integer;

function PawnConfirm(const Msg: string; Title: string = 'Confirm'; const Parent: TWinControl = nil): Boolean;

function PawnPrompt(const Prompt, Title: string; var Value: string; const Parent: TWinControl = nil): Boolean;

// Command-link style choice for Layaway close
function PawnChooseLayawayCloseReason(
  const Title: string = 'Close Layaway';
  const Parent: TWinControl = nil
): TLayawayCloseReason;

implementation

function ResolveOwner(const Parent: TWinControl): TComponent;
begin
  // In Delphi 13, TTaskDialog doesn't expose ParentWindowHandle.
  // Best practice: use the Parent control (usually a form) as the Owner for UI context.
  if Assigned(Parent) then
    Result := Parent
  else if Assigned(Application) and Assigned(Application.MainForm) then
    Result := Application.MainForm
  else
    Result := Application;
end;

procedure ConfigureStdTaskDialog(
  Dlg: TTaskDialog;
  const Title, Msg: string;
  const Kind: TPawnDlgKind
);
begin
  Dlg.Caption := 'PawnPro';
  Dlg.Title := Title;
  Dlg.Text := Msg;

  // Note: TaskDialog doesn't have a "Question" icon. Use Warning (common) for confirmations.
  case Kind of
    pdkInfo:    Dlg.MainIcon := tdiInformation;
    pdkWarning: Dlg.MainIcon := tdiWarning;
    pdkError:   Dlg.MainIcon := tdiError;
    pdkConfirm: Dlg.MainIcon := tdiWarning;
  end;
end;

function ExecStdMessage(
  const Title, Msg: string;
  const Parent: TWinControl;
  const Kind: TPawnDlgKind
): Integer;
var
  Flags: Cardinal;
begin
  Flags := MB_OK;

  case Kind of
    pdkInfo:    Flags := Flags or MB_ICONINFORMATION;
    pdkWarning: Flags := Flags or MB_ICONWARNING;
    pdkError:   Flags := Flags or MB_ICONERROR;
    pdkConfirm: Flags := Flags or MB_ICONQUESTION;
  end;

  // MessageBox-style fallback (Windows/VCL)
  Result := Application.MessageBox(PChar(Msg), PChar(Title), Flags);
end;

function PawnInfo(const Msg: string; Title: string; const Parent: TWinControl): Integer;
var
  Dlg: TTaskDialog;
begin
  Dlg := TTaskDialog.Create(ResolveOwner(Parent));
  try
    ConfigureStdTaskDialog(Dlg, Title, Msg, pdkInfo);
    Dlg.CommonButtons := [tcbOk];
    Dlg.Execute;
    Result := Dlg.ModalResult;
  finally
    Dlg.Free;
  end;
end;

function PawnWarn(const Msg: string; Title: string; const Parent: TWinControl): Integer;
var
  Dlg: TTaskDialog;
begin
  Dlg := TTaskDialog.Create(ResolveOwner(Parent));
  try
    ConfigureStdTaskDialog(Dlg, Title, Msg, pdkWarning);
    Dlg.CommonButtons := [tcbOk];
    Dlg.Execute;
    Result := Dlg.ModalResult;
  finally
    Dlg.Free;
  end;
end;

function PawnError(const Msg: string; Title: string; const Parent: TWinControl): Integer;
var
  Dlg: TTaskDialog;
begin
  Dlg := TTaskDialog.Create(ResolveOwner(Parent));
  try
    ConfigureStdTaskDialog(Dlg, Title, Msg, pdkError);
    Dlg.CommonButtons := [tcbOk];
    Dlg.Execute;
    Result := Dlg.ModalResult;
  finally
    Dlg.Free;
  end;
end;

function PawnConfirm(const Msg: string; Title: string; const Parent: TWinControl): Boolean;
var
  Dlg: TTaskDialog;
begin
  Dlg := TTaskDialog.Create(ResolveOwner(Parent));
  try
    ConfigureStdTaskDialog(Dlg, Title, Msg, pdkConfirm);
    Dlg.CommonButtons := [tcbYes, tcbNo];
    Dlg.DefaultButton := tcbNo;
    Dlg.Execute;
    Result := Dlg.ModalResult = mrYes;
  finally
    Dlg.Free;
  end;
end;

function PawnPrompt(const Prompt, Title: string; var Value: string; const Parent: TWinControl): Boolean;
begin
  // InputQuery does not accept a parent in classic VCL.
  // It's fine for quick prompts.
  Result := InputQuery(Title, Prompt, Value);
end;

function PawnChooseLayawayCloseReason(const Title: string; const Parent: TWinControl): TLayawayCloseReason;
var
  Dlg: TTaskDialog;
  BtnCancel, BtnPaid, BtnCanceled, BtnForgot: TTaskDialogButtonItem;
begin
  Result := lcrUnknown;

  Dlg := TTaskDialog.Create(ResolveOwner(Parent));
  try
    Dlg.Caption := 'PawnPro';
    Dlg.Title := Title;
    Dlg.Text := 'Why are you closing this layaway?';
    Dlg.ExpandedText := 'Select the reason';
    Dlg.MainIcon := tdiWarning;

    // Make buttons look like "command links" (big choices)
    Dlg.Flags := Dlg.Flags + [tfUseCommandLinks];

    BtnPaid := Dlg.Buttons.Add as TTaskDialogButtonItem;
    BtnPaid.Caption := 'Customer paid off the balance (release item)';
    BtnPaid.CommandLinkHint := 'Use this when the customer is completing the layaway and taking the item.';
    BtnPaid.ModalResult := 100;

    BtnCanceled := Dlg.Buttons.Add as TTaskDialogButtonItem;
    BtnCanceled.Caption := 'Customer canceled the layaway';
    BtnCanceled.CommandLinkHint := 'Use this when the layaway is being canceled and items return to inventory rules.';
    BtnCanceled.ModalResult := 101;

    BtnForgot := Dlg.Buttons.Add as TTaskDialogButtonItem;
    BtnForgot.Caption := 'We still have a balance (last payment may be missing)';
    BtnForgot.CommandLinkHint := 'Use this when you expected it to be paid off, but the balance is not zero.';
    BtnForgot.ModalResult := 102;

    BtnCancel := Dlg.Buttons.Add as TTaskDialogButtonItem;
    BtnCancel.Caption := 'Cancel (do not close)';
    BtnCancel.CommandLinkHint := 'Go back without making changes.';
    BtnCancel.ModalResult := 103;

    Dlg.DefaultButton := tcbCancel;

    if Dlg.Execute then
    begin
      if Dlg.ModalResult = BtnPaid.ModalResult then
        Result := lcrPaidOffReleaseItem
      else if Dlg.ModalResult = BtnCanceled.ModalResult then
        Result := lcrCustomerCanceled
      else if Dlg.ModalResult = BtnForgot.ModalResult then
        Result := lcrForgotLastPayment
      else
        Result := lcrUnknown;
    end;

  finally
    Dlg.Free;
  end;
end;

end.

