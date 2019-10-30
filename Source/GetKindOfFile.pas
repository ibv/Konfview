unit GetKindOfFile;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfGetKindOfFile = class(TForm)
    rgKind: TRadioGroup;
    btCancel: TButton;
    btOK: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGetKindOfFile: TfGetKindOfFile;

implementation

{$R *.dfm}

end.
