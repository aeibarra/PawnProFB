unit CheckBoxDrawer;
{
  Self‑contained helper that draws a square check‑box with an **“X” cross**
  instead of a ✓ tick.  Ideal for grid drawing or any place you have a
  TCanvas plus target rectangle.

  ── Example for a DBGrid OnDrawColumnCell ────────────────────────────────────
  procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
    Marked: Boolean;
  begin
    Marked := (DataSet.FieldByName('Flag').AsInteger = 1); // example
    DrawCrossBox(TDBGrid(Sender).Canvas, Rect, 1.20,   // 20 % larger than cell
                 Marked, (gdSelected in State));
  end;

  • ScaleFactor 1.00 = fits the rect; 1.20 enlarges everything 20 %.
  • Highlight   TRUE  paints the whole cell sky‑blue first.
}

interface

uses Windows, SysUtils, Graphics, Types, System.Math;

/// <summary>Draws a square with an X‑cross centred in <paramref name="ARect"/>.
/// <paramref name="ScaleFactor"/> multiplies the square size (1 = 100 %).
/// When <paramref name="Highlight"/> is TRUE the whole rect is filled with
/// clSkyBlue before drawing.</summary>
procedure DrawCheckBox(ACanvas     : TCanvas;
                       const ARect : TRect;
                       ScaleFactor : Double;
                       Checked     : Boolean;
                       Highlight   : Boolean = False);

implementation

procedure DrawCheckBox(ACanvas: TCanvas; const ARect: TRect; ScaleFactor: Double;
  Checked, Highlight: Boolean);
var
  Sz, Pad    : Integer; // Sz = square side; Pad = margin for cross arms
  Box        : TRect;   // bounding square centred in ARect
  PenSaveWid : Integer;
const
  MinStrokeFrac = 6;  // Sz/MinStrokeFrac = stroke thickness
begin
  // ----- optional highlight ---------------------------------------------------
  if Highlight then
  begin
    ACanvas.Brush.Color := clSkyBlue;
    ACanvas.FillRect(ARect);
  end;

  // ----- compute centred square ----------------------------------------------
  Sz := Round(Min(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top) * ScaleFactor);
  if Sz < 4 then Exit;  // too small to draw

  Box.Left   := ARect.Left + ((ARect.Right  - ARect.Left)  - Sz) div 2;
  Box.Top    := ARect.Top  + ((ARect.Bottom - ARect.Top)   - Sz) div 2;
  Box.Right  := Box.Left + Sz - 1;  // inclusive
  Box.Bottom := Box.Top  + Sz - 1;

  // ----- draw square border ---------------------------------------------------
  ACanvas.Pen.Style  := psSolid;
  ACanvas.Pen.Width  := 1;
  ACanvas.Pen.Color  := clBlack;
  ACanvas.Brush.Style := bsClear;
  ACanvas.Rectangle(Box);

  // ----- draw X cross ---------------------------------------------------------
  if Checked then
  begin
    PenSaveWid := ACanvas.Pen.Width;
    try
      ACanvas.Pen.Width := Max(1, Sz div MinStrokeFrac);
      Pad := Sz div 4;  // margin so the cross does not touch the border

      // first diagonal
      ACanvas.MoveTo(Box.Left  + Pad, Box.Top    + Pad);
      ACanvas.LineTo(Box.Right - Pad, Box.Bottom - Pad);

      // second diagonal
      ACanvas.MoveTo(Box.Left  + Pad, Box.Bottom - Pad);
      ACanvas.LineTo(Box.Right - Pad, Box.Top    + Pad);
    finally
      ACanvas.Pen.Width := PenSaveWid;
    end;
  end;
end;

end.

