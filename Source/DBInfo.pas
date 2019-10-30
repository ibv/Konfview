unit DBInfo;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons;

type

  { TfDBInfo }

  TfDBInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lName: TLabel;
    lPath: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    lRecordCount: TLabel;
    Bevel1: TBevel;
    BitBtn1: TButton;
    reComment: TMemo;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDBInfo: TfDBInfo;

implementation

uses Main;

{$R *.dfm}

procedure TfDBInfo.FormActivate(Sender: TObject);
begin
  lName.Caption := fMain.TableName;
  lPath.Caption := fMain.DatabaseName;
  lRecordCount.Caption :=
    IntToStr (fMain.TotalRecords (fMain.DatabaseName, fMain.TableName));
end;

end.
