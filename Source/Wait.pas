unit Wait;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons;

type
  TfWait = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lCelkem: TLabel;
    lAktualni: TLabel;
    lVyhovujici: TLabel;
    Bevel1: TBevel;
    pbPos: TProgressBar;
    lWhat: TLabel;
    btZrusit: TButton;
    procedure btZrusitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Stopped: Boolean;
  end;

var
  fWait: TfWait;

implementation

uses Find;

{$R *.dfm}

procedure TfWait.btZrusitClick(Sender: TObject);
begin
  Stopped := true;
end;

procedure TfWait.FormActivate(Sender: TObject);
begin
  Stopped := false;
  lWhat.Caption := fFind.cbFindWord.Text;
end;


end.
