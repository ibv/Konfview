unit NewBookmark;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfNewBookmark = class(TForm)
    Label1: TLabel;
    edNazev: TEdit;
    btOK: TButton;
    btCancel: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fNewBookmark: TfNewBookmark;

  function GetString (Cap, Lab: string): string;

implementation

{$R *.dfm}
//------------------------------------------------------------------------------
//                                                                    GetString
//------------------------------------------------------------------------------
function GetString (Cap, Lab: string): string;
begin { GetString }
  with fNewBookmark do begin
    Caption := Cap;
    Label1.Caption := Lab;
    if (ShowModal = mrOK) then Result := edNazev.Text
    else Result := '';
  end;
end;  { GetString }

procedure TfNewBookmark.FormActivate(Sender: TObject);
begin
  edNazev.SetFocus;
  edNazev.SelectAll;
end;

end.
