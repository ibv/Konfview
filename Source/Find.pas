unit Find;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, NumEdit, ExtCtrls;

type
  TfFind = class(TForm)
    pcFind: TPageControl;
    tsNormal: TTabSheet;
    tsSpecial: TTabSheet;
    Label1: TLabel;
    cbFindWord: TComboBox;
    Label5: TLabel;
    edSubject: TEdit;
    edFrom: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    edDate: TEdit;
    neCount: TEdit;
    cbCaseSensitiv: TCheckBox;
    cbSubjectToo: TCheckBox;
    cbSpecial: TCheckBox;
    cbSubject: TComboBox;
    cbFrom: TComboBox;
    cbDate: TComboBox;
    tsMethod: TTabSheet;
    rgMethod: TRadioGroup;
    cbSpec: TCheckBox;
    btOK: TButton;
    btCancel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSpecialClick(Sender: TObject);
    procedure cbSpecClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetSpecialEnabled (Enabl: Boolean);
    procedure EnableRGItem (i: integer; Enabl : Boolean);
  public
    { Public declarations }
  end;

var
  fFind: TfFind;

implementation

uses Main;

{$R *.dfm}


procedure TfFind.FormActivate(Sender: TObject);
begin
  pcFind.ActivePage := tsNormal;
  cbFindWord.SetFocus;
  EnableRGItem (1, (fMain.FoundRecCount <> 0));
  EnableRGItem (2, (fMain.FoundRecCount <> 0));
  rgMethod.ItemIndex := 0;
end;


procedure TfFind.FormCreate(Sender: TObject);
begin
  neCount.Text := '0';
  pcFind.ActivePage := tsNormal;
  cbSubject.ItemIndex := 0;
  cbFrom.ItemIndex := 0;
  cbDate.ItemIndex := 0;
end;

procedure TfFind.cbSpecialClick(Sender: TObject);
begin
  cbSpec.Checked := cbSpecial.Checked;
  SetSpecialEnabled (cbSpecial.Checked);
  if (cbSpecial.Checked) then pcFind.ActivePage := tsSpecial;
end;

procedure TfFind.SetSpecialEnabled(Enabl: Boolean);
var
  i: integer;
begin
  for i := 0 to tsSpecial.ControlCount-1 do
    if ((tsSpecial.Controls[i] as TControl).Name <> 'cbSpec') then
      (tsSpecial.Controls[i] as TControl).Enabled := Enabl;
end;

//------------------------------------------------------------------------------
//                                                                 EnableRGItem
//------------------------------------------------------------------------------
procedure TfFind.EnableRGItem (i: integer; Enabl : Boolean);
begin { EnableRGItem }
  rgMethod.Controls[i].Enabled := Enabl;
end;  { EnableRGItem }

procedure TfFind.cbSpecClick(Sender: TObject);
begin
  SetSpecialEnabled (cbSpec.Checked);
  cbSpecial.Checked := cbSpec.Checked;
end;

end.
