unit FindInText;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfFindInText = class(TForm)
    Label1: TLabel;
    memFindWords: TMemo;
    btOK: TButton;
    btCancel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure memFindWordsKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fFindInText: TfFindInText;

implementation

{$R *.dfm}

procedure TfFindInText.FormActivate(Sender: TObject);
begin
  memFindWords.SetFocus;
end;

procedure TfFindInText.memFindWordsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(VK_ESCAPE) then ModalResult := mrCancel;
end;

end.
