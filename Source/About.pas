unit About;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfAbout = class(TForm)
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    BitBtn1: TButton;
    lVerze: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Label6DblClick(Sender: TObject);
    procedure Label5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

implementation

uses Main,
    fileinfo  ;

{$R *.dfm}

procedure TfAbout.FormCreate(Sender: TObject);
var
  FileVerInfo: TFileVersionInfo;
begin
  FileVerInfo:=TFileVersionInfo.Create(nil);
  try
    FileVerInfo.ReadFileInfo;
    lVerze.Caption := 'Verze: '+FileVerInfo.VersionStrings.Values['FileVersion'];
  finally
    FileVerInfo.Free;
  end;

  ///lVerze.Caption := VersionNumber;
end;

procedure TfAbout.Label6DblClick(Sender: TObject);
begin
   OpenDocument(PChar ((Sender as TLabel).Caption)); { *Převedeno z ShellExecute* }
end;

procedure TfAbout.Label5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if (Button = mbRight) then begin
    with Sender as TLabel do begin
      fMain.CopyText := Caption;
      P.X := X; P.Y := Y;
      P := ClientToScreen (P);
      fMain.pmCopy.PopUp (P.X, P.Y);
    end;
  end;
end;

procedure TfAbout.Label10Click(Sender: TObject);
var
  s: string;
begin
  s := StringReplace('mailto:' + (Sender as TLabel).Caption + '?subject=KofView verze ' + lVerze.Caption,
     ' ', '%20', [rfReplaceAll]);
   OpenDocument(PChar(s)); { *Převedeno z ShellExecute* }
end;

end.
