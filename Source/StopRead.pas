unit StopRead;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfStopRead = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btStop: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Stopped : Boolean;
  end;

var
  fStopRead: TfStopRead;

implementation

uses Main;

{$R *.dfm}

procedure TfStopRead.FormActivate(Sender: TObject);
begin
  btStop.SetFocus;
  Stopped := false;
end;

procedure TfStopRead.btStopClick(Sender: TObject);
begin
  // Kliknuti na stopku
  Stopped := true;
  Close;
end;

procedure TfStopRead.FormShow(Sender: TObject);
var
  Point: TPoint;
begin
  // Nastaveni na stred
  Point.X := fMain.reMain.Left;
  Point.Y := fMain.reMain.Top;
  if (fMain.pnInfo.Visible) then Point.Y := Point.Y - fMain.pnInfo.Height;
  Point := fMain.reMain.ClientToScreen (Point);

  Left := Point.X + ((fMain.reMain.Width - Width) div 2);
  Top  := Point.Y + ((fMain.reMain.Height - Height) div 2);
end;

end.
