unit Settings;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type

  { TfSettings }

  TfSettings = class(TForm)
    GroupBox1: TGroupBox;
    lbRe: TListBox;
    edRe: TEdit;
    btAdd: TButton;
    btDel: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    lbEOM: TListBox;
    btAddEOM: TButton;
    btDelEOM: TButton;
    edEOM: TEdit;
    btClearHistory: TButton;
    cbFindInNext: TCheckBox;
    GroupBox4: TGroupBox;
    fdFont: TFontDialog;
    Button1: TButton;
    Button2: TButton;
    edAttach: TEdit;
    Label2: TLabel;
    cbSaveAttach: TCheckBox;
    lExample: TLabel;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edFrom: TEdit;
    edDate: TEdit;
    edSubj: TEdit;
    cbColorFindWords: TCheckBox;
    btOK: TButton;
    btAttach: TButton;
    btNormal: TButton;
    btQuote: TButton;
    btHref: TButton;
    btFind: TButton;
    btCancel: TButton;
    DirectoryDlg: TSelectDirectoryDialog;
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure btAddEOMClick(Sender: TObject);
    procedure btDelEOMClick(Sender: TObject);
    procedure btClearHistoryClick(Sender: TObject);
    procedure btNormalClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btAttachClick(Sender: TObject);
    procedure cbSaveAttachClick(Sender: TObject);
    procedure lbReClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDefaultRe;
    procedure SetDefaultEOM;
  end;

var
  fSettings: TfSettings;

const
  aRe: array [0..33] of string = (
    ':', 'Re ', 'Re:', '(2)', '(3)', '(4)', '(5)', '[2]', '[3]', '[4]', '[5]',
    '(2x)', '(3x)', '(4x)', '(5x)', 'Re-', 'Re.', 'FWD', 'FW', '(Fwd)',
    '(Delphi)', '[dt]', '"FWD"', '>', '[', '2', '3', '4', '5', 'Re(2x)',
    'Re(3x)', 'Re(4x)', '(Yx)', '.'
  );

  aEOM: array [0..2] of string = (
    '---------- End of message ----------',
    '-- End --',
    '==============================================================================='
  );

implementation

uses Find{, SelectDir};
{$R *.dfm}

procedure TfSettings.btAddClick(Sender: TObject);
begin
  if (edRe.Text <> '') then lbRe.Items.Add (edRe.Text);
end;

procedure TfSettings.btDelClick(Sender: TObject);
begin
  if (lbRe.ItemIndex = -1) then exit;
  lbRe.Items.Delete (lbRe.ItemIndex);
end;

procedure TfSettings.btAddEOMClick(Sender: TObject);
begin
  if (edEOM.Text <> '') then lbEOM.Items.Add (edEOM.Text);
end;

procedure TfSettings.btDelEOMClick(Sender: TObject);
begin
  if (lbEOM.ItemIndex = -1) then exit;
  lbEOM.Items.Delete (lbEOM.ItemIndex);
end;

procedure TfSettings.btClearHistoryClick(Sender: TObject);
begin
  fFind.cbFindWord.Items.Clear;
end;

procedure TfSettings.btNormalClick(Sender: TObject);
begin
  fdFont.Font := TButton(Sender).Font;
  if (fdFont.Execute) then
    TButton(Sender).Font := fdFont.Font;
end;

procedure TfSettings.Button1Click(Sender: TObject);
begin
  if (MessageDlg('Opravdu chcete nastavit původní doporučené hodnoty pro filtrování začátků zpráv?',
    mtConfirmation, [mbYes, mbNO], 0) <> mrYes) then exit;
  // Vratime standartni hodnoty
  SetDefaultRe;
end;

//------------------------------------------------------------------------------
//                                                                SetDefaultRe
//------------------------------------------------------------------------------
procedure TfSettings.SetDefaultRe;
var
  i: integer;
begin { SetDefaultRe }
  lbRe.Items.Clear;
  for i := 0 to Length (aRe) - 1 do
    lbRe.Items.Add (aRe[i]);
end;  { SetDefaultRe }


//------------------------------------------------------------------------------
//                                                                SetDefaultEOM
//------------------------------------------------------------------------------
procedure TfSettings.SetDefaultEOM;
var
  i: integer;
begin { SetDefaultEOM }
  lbEOM.Items.Clear;
  for i := 0 to Length (aEOM) - 1 do
    lbEOM.Items.Add (aEOM[i]);
end;  { SetDefaultEOM }

procedure TfSettings.Button2Click(Sender: TObject);
begin
  if (MessageDlg('Opravdu chcete nastavit původní doporučené hodnoty pro filtrování konců zpráv?',
          mtConfirmation, [mbYes, mbNO], 0) <> mrYes) then exit;
  // Vratime standartni hodnoty
  SetDefaultEOM;
end;

procedure TfSettings.btAttachClick(Sender: TObject);
begin
  // Vyber adresare
  if DirectoryDlg.Execute then
    edAttach.Text:=DirectoryDlg.FileName;
  ///edAttach.Text := SelectDirectory ('');
end;

procedure TfSettings.cbSaveAttachClick(Sender: TObject);
begin
  edAttach.Enabled := cbSaveAttach.Checked;
  btAttach.Enabled := cbSaveAttach.Checked;
end;

procedure TfSettings.lbReClick(Sender: TObject);
begin
  if (lbRe.ItemIndex <> -1) then
    lExample.Caption := '"' + lbRe.Items[lbRe.ItemIndex] + '"'
  else
    lExample.Caption := '""';
end;

end.
