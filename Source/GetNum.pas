unit GetNum;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, NumEdit;

type
  TfGetNum = class(TForm)
    Label1: TLabel;
    edNum: TEdit;
    btOK: TButton;
    btCancel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGetNum: TfGetNum;

implementation

{$R *.dfm}

procedure TfGetNum.FormActivate(Sender: TObject);
begin
  edNum.SetFocus;
  edNum.SelStart := 0;
  edNum.SelLength := Length (edNum.Text);
end;



procedure TfGetNum.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Value: integer;
begin
  if (ModalResult = mrOK) then begin
    try
      Value := StrToInt ('0'+edNum.Text);
      if ((Value > edNum.Tag) or (Value < 1)) then begin
        MessageDlg ('Číslo zprávy musí být v intervalu 1 až '+IntToStr (edNum.Tag),
                    mtError, [mbOK], 0);
        CanClose := false;
      end;
    except
      on EConvertError do begin
         MessageDlg ('Číslo zprávy musí být v intervalu 1 až '+IntToStr (edNum.Tag),
                  mtError, [mbOK], 0);
        CanClose := false;
      end;
    end; // try
  end; // mrOK
end;

end.
