unit EditMenuBook;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ImgList, StdCtrls, Buttons, ActnList;

const
  imFolder      = 0;
  imFolderAct   = 1;
  imBookmark    = 2;
  imBookmarkAct = 3;

type
  TfEditMenuBook = class(TForm)
    tvBook: TTreeView;
    acBook: TActionList;
    acbRename: TAction;
    acbDelete: TAction;
    acbNewFolder: TAction;
    pmEdBook: TPopupMenu;
    Smazat1: TMenuItem;
    Novsloka1: TMenuItem;
    Pejmenovat1: TMenuItem;
    acUp: TAction;
    acDown: TAction;
    acLeft: TAction;
    N1: TMenuItem;
    Doleva1: TMenuItem;
    Nahoru1: TMenuItem;
    Dol1: TMenuItem;
    btNewFolder: TButton;
    btOK: TButton;
    btCancel: TButton;
    btDel: TButton;
    btLeft: TButton;
    btUP: TButton;
    btDown: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acbRenameExecute(Sender: TObject);
    procedure acbDeleteExecute(Sender: TObject);
    procedure acbNewFolderExecute(Sender: TObject);
    procedure acbRenameUpdate(Sender: TObject);
    procedure tvBookDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvBookDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvBookStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tvBookEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure acUpExecute(Sender: TObject);
    procedure acLeftExecute(Sender: TObject);
    procedure acLeftUpdate(Sender: TObject);
    procedure acDownExecute(Sender: TObject);
    procedure acDownUpdate(Sender: TObject);
    procedure acUpUpdate(Sender: TObject);
  private
    { Private declarations }
    DragedItem: TTreeNode;
    procedure LoadItems;
    procedure SaveItems;
  public
    { Public declarations }
  end;

var
  fEditMenuBook: TfEditMenuBook;

const
  cTagBeg = ' [';
  cTagEnd = ']';

implementation

uses NewBookmark, Main;

{$R *.dfm}

//------------------------------------------------------------------------------
//                                                                    EncodeTag
//------------------------------------------------------------------------------
function EncodeTag (S: string; T: integer): string;
begin { EncodeTag }
  Result := S + cTagBeg + IntToStr (T) + cTagEnd;
end;  { EncodeTag }

//------------------------------------------------------------------------------
//                                                                    DecodeTag
//------------------------------------------------------------------------------
function DecodeTag (var S: string): integer;
var
  i: integer;
  Pom: string;
begin { DecodeTag }
  Result := 0;
  i := Pos (cTagBeg, S);
  if (i = 0) then exit;

  Pom := Copy (S, i + Length (cTagBeg), Length (S) -i -Length (cTagBeg) - Length (cTagEnd) +1 );
  S := Copy (S, 1, i-1);
  try
    Result := StrToInt (Pom);
  except
    On EConvertError do
      Result := 0;
  end;
end;  { DecodeTag }

//------------------------------------------------------------------------------
//                                                                     IsFolder
//------------------------------------------------------------------------------
function IsFolder (Node: TTreeNode): Boolean;
begin { IsFolder }
  Result := true;
  if (Node = nil) then exit;
  Result := (Node.ImageIndex = imFolder);
end;  { IsFolder }
//------------------------------------------------------------------------------
//                                                                    LoadItems
//------------------------------------------------------------------------------
procedure TfEditMenuBook.LoadItems;
var
  j: integer;

  procedure AddItemToTreeView (Item: TMenuItem; ParentNode: TTreeNode);
  var
    i: integer;
    Node: TTreeNode;
    S: string;
  begin
    S := Item.Caption;

    // Zjisti, zda je koncova polozka
    if (Item.Count = 0) then begin
      // Je to koncova polozka - pridam list
      //    if (ParentNode = nil) then
      Node := tvBook.Items.AddChild (ParentNode, EncodeTag (S, Item.Tag));
      Node.ImageIndex := imBookmark;
      Node.SelectedIndex := imBookmarkAct;
      Exit;
    end;

    // Neni to koncova - for cyklus
    Node := tvBook.Items.AddChild (ParentNode, S);
    Node.ImageIndex := imFolder;
    Node.SelectedIndex := imFolderAct;

    for i := 0 to Item.Count -1 do
      AddItemToTreeView (Item.Items[i], Node);
  end;

begin { LoadItems }
  // zkopceni zalozek z menu do TreeView
  tvBook.Items.Clear;

  // Nacteni zalozek -- to bude fuska
  for j := 3 to fMain.pmBookmark.Items.Count-1 do begin
    AddItemToTreeView (fMain.pmBookmark.Items[j], nil);
  end;

end;  { LoadItems }

//------------------------------------------------------------------------------
//                                                                    SaveItems
//------------------------------------------------------------------------------
procedure TfEditMenuBook.SaveItems;
var
  j, T: integer;
  Path: string;
  i, N: Integer;
  Node: TTreeNode;
begin { SaveItems }
  // zkopceni zalozek z menu do TreeView
//  for j := 0 to fMain.pmBookmark.Items.Count-1 do
//    fMain.pmBookmark.Items.Delete (0);//pmBookmark.Clear;
  fMain.ClearBookmarks;

  //  fMain.ClearBookmarks;
  // ulozeni zalozek -- to bude fuska
  for j := 0 to tvBook.Items.Count-1 do begin
    if (not IsFolder (tvBook.Items[j])) then begin
      Node := tvBook.Items[j];
      Path := Node.Text;
      N := Node.Level;
      for i := N downto 1 do begin
        Node := Node.Parent;
        Path := Node.Text + '|' + Path;
      end;
      T := DecodeTag (Path);
      Path := Path + '|' + IntToStr (T);
      fMain.AddBookItem (Path);
    end;
  end;
end;  { SaveItems }

procedure TfEditMenuBook.FormActivate(Sender: TObject);
begin
  LoadItems;
end;

procedure TfEditMenuBook.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ModalResult = mrOK) then SaveItems;
end;

procedure TfEditMenuBook.acbRenameExecute(Sender: TObject);
begin
  // Prejmenoani vybrane polozky
  tvBook.Selected.EditText;
end;

procedure TfEditMenuBook.acbDeleteExecute(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete smazat vybranou poloku?', mtConfirmation,
    [mbYes, mbNO], 0) = mrYes then
  begin
    tvBook.Selected.Delete;
  end;
end;

procedure TfEditMenuBook.acbNewFolderExecute(Sender: TObject);
var
  Node: TTreeNode;
  S: string;
begin
    S := GetString ('Nová sloka', 'Název nové sloky:');
    if (S = '') then exit;
    if ((tvBook.Selected <> nil) and (not IsFolder (tvBook.Selected))) then
      Node := tvBook.Items.AddChild (tvBook.Selected.Parent, S)
    else
      Node := tvBook.Items.AddChild (tvBook.Selected, S);

    Node.ImageIndex := imFolder;
    Node.SelectedIndex := imFolderAct;
    tvBook.Selected := Node;
end;

procedure TfEditMenuBook.acbRenameUpdate(Sender: TObject);
begin
  TAction (Sender).Enabled := (tvBook.Selected <> nil);
end;

procedure TfEditMenuBook.tvBookDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (Source is TTreeNode) then Accept := true;
end;

procedure TfEditMenuBook.tvBookDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AnItem: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
begin
  AttachMode := naAdd;
  if tvBook.Selected = nil then Exit;
  HT := tvBook.GetHitTestInfoAt(X, Y);
  AnItem := tvBook.GetNodeAt(X, Y);
  if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then AttachMode := naAddChild

    else if htNowhere in HT then AttachMode := naAdd
    else if htOnIndent in HT then AttachMode := naInsert;

    if ((AnItem <> nil) and (not IsFolder (AnItem))) then
      tvBook.Selected.MoveTo(AnItem, naInsert)
    else
      tvBook.Selected.MoveTo(AnItem, AttachMode);
  end;

end;

procedure TfEditMenuBook.tvBookStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
//  ShowMessage (tvBook.Selected.Text);
  DragedItem := tvBook.Selected;
end;

procedure TfEditMenuBook.tvBookEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
var
  NewName: string;
  T: integer;
begin
  // Vlastni dialog
  if (Node <> nil) and (not IsFolder (Node)) then begin
    AllowEdit := false;
    NewName := Node.Text;
    T := DecodeTag (NewName);
    fNewBookmark.edNazev.Text := NewName;
    NewName := GetString ('Pøejmenování záloky', 'Nové jméno záloky:');
    if (NewName <> '') then
      Node.Text := EnCodeTag (NewName, T);
  end;
end;

procedure TfEditMenuBook.acUpExecute(Sender: TObject);
begin
  if tvBook.Selected.getPrevSibling <> nil then
    tvBook.Selected.MoveTo (tvBook.Selected.getPrevSibling, naInsert);
  acUp.Update;
end;

procedure TfEditMenuBook.acLeftExecute(Sender: TObject);
begin
  tvBook.Selected.MoveTo (tvBook.Selected.Parent, naAdd);
  acLeft.Update;
end;

procedure TfEditMenuBook.acDownExecute(Sender: TObject);
var
  N: TTreeNode;
begin
  N := tvBook.Selected.getNextSibling;
  if n <> nil then
    if (N.getNextSibling <> nil) then
      tvBook.Selected.MoveTo (N.getNextSibling, naInsert)
    else
      tvBook.Selected.MoveTo (N, naAdd);

  acDown.Update;
end;

procedure TfEditMenuBook.acLeftUpdate(Sender: TObject);
begin
  TAction (Sender).Enabled := ((tvBook.Selected <> nil) and
                               (tvBook.Selected.Level > 0));
end;


procedure TfEditMenuBook.acDownUpdate(Sender: TObject);
begin

  TAction (Sender).Enabled := (tvBook.Selected <> nil) and
    (tvBook.Selected.getNextSibling <> nil);
end;

procedure TfEditMenuBook.acUpUpdate(Sender: TObject);
begin
  TAction (Sender).Enabled := (tvBook.Selected <> nil) and
    (tvBook.Selected.getPrevSibling <> nil);
end;

end.
