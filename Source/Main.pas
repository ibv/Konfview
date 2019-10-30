unit Main;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls, ComCtrls, DBCtrls, ExtCtrls, Grids, DBGrids,
  {ToolWin,} FileCtrl, ImgList, Db, sqldb, sqlite3conn, ActnList, clipbrd,
  IniFiles, {uException, uLocalize,}
  MaskEdit {DBActns,}  ;

const

  // Nastaveni zapamatovani souboru
  sfMaxCount  = 4;    // Maximalni pocet souboru na zapamatovani
  sfPrefixLen = 4;    // Delka prefixu pred vlasnim nazvem souboru ("&X ")

  defDBClickTime = 0.000003574074; // Cas na DBClick

  // Rozdeleni Status Baru
  pStatus = 0;
  pInfo   = 1;
  pSize   = 2;
  pCount  = 3;
  pRest   = 4;

  fmNew = 0;
  fmAnd = 1;
  fmOr  = 2;

  // Z jakeho zdroje se budou prevadet texty
  afkMail = 0;   // Z normalniho meilu (PMail)
  afkHtml = 1;   // Z webovskych stranek konference

type
  TDarray = array of integer;

  { TfMain }

  TfMain = class(TForm)
    reMain: TMemo;
    sbMain: TStatusBar;
    grMain: TDBGrid;
    Splitter: TSplitter;
    pnRight: TPanel;
    pnInfo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmMain: TMainMenu;
    mSoubor: TMenuItem;
    Hledat1: TMenuItem;
    mInformace: TMenuItem;
    conDatabase: TSQLite3Connection;
    Splitter1: TSplitter;
    SQLTransaction1: TSQLTransaction;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    Zobrazit1: TMenuItem;
    miHeader: TMenuItem;
    miToolBar: TMenuItem;
    miStatusBar: TMenuItem;
    Nastaven1: TMenuItem;
    miSettings: TMenuItem;
    miSaveSettings: TMenuItem;
    miInformace: TMenuItem;
    Informaceodatabzi1: TMenuItem;
    miSort: TMenuItem;
    N1: TMenuItem;
    miFrom: TMenuItem;
    miDate: TMenuItem;
    miFind: TMenuItem;
    miFindInText: TMenuItem;
    miNewDB: TMenuItem;
    miOpenDB: TMenuItem;
    miAddFile: TMenuItem;
    miFileSeparator1: TMenuItem;
    miExit: TMenuItem;
    ilTool: TImageList;
    dsMain: TDataSource;
    qrMain: TSQLQuery;
    odOpen: TOpenDialog;
    miID: TMenuItem;
    sdSave: TSaveDialog;
    Table: TSQLQuery;
    miSortID: TMenuItem;
    miSortSubject: TMenuItem;
    lAutor: TDBText;
    lSubject: TDBText;
    lDatum: TDBText;
    miGoToLineNum: TMenuItem;
    N3: TMenuItem;
    miShowAll: TMenuItem;
    miShowFound: TMenuItem;
    ActionList1: TActionList;
    acOpenDB: TAction;
    acNew: TAction;
    acExit: TAction;
    acAddFile: TAction;
    acFind: TAction;
    acFindNextInText: TAction;
    acGoToMailNum: TAction;
    acSettings: TAction;
    acHeader: TAction;
    acToolBar: TAction;
    acStatusBar: TAction;
    acID: TAction;
    acAutor: TAction;
    acDate: TAction;
    acShowAll: TAction;
    acShowFound: TAction;
    acWordWrap: TAction;
    acSaveToINI: TAction;
    acSortID: TAction;
    acSortSubject: TAction;
    acInfo: TAction;
    acHelp: TAction;
    acDBInfo: TAction;
    Npovda1: TMenuItem;
    pnTool: TPanel;
    tbMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    N4: TMenuItem;
    ToolButton13: TToolButton;
    miBookmark: TMenuItem;
    acAddBookmark: TAction;
    acBookmarkSetting: TAction;
    acCopy: TAction;
    acSelectAll: TAction;
    pravy1: TMenuItem;
    Koprovat1: TMenuItem;
    Vybratve1: TMenuItem;
    acPrint: TAction;
    Tiskpspvku1: TMenuItem;
    pmCopy: TPopupMenu;
    miCopyClip: TMenuItem;
    pmBookmark: TPopupMenu;
    Pidataktulnpspvek2: TMenuItem;
    miSeparator: TMenuItem;
    Nastavenzloek2: TMenuItem;
    acBookmarks: TAction;
    pmGrid: TPopupMenu;
    Pidataktulnpspvek1: TMenuItem;
    Zloky1: TMenuItem;
    Skoknazprvu1: TMenuItem;
    N6: TMenuItem;
    Nastavenzloek1: TMenuItem;
    N7: TMenuItem;
    ToolButton12: TToolButton;
    tmShowMail: TTimer;
    miFileSeparator2: TMenuItem;
    acGoToURL: TAction;
    SkoknaURL1: TMenuItem;
    acCopyURL: TAction;
    KoprovatURL1: TMenuItem;
    qrPom: TSQLQuery;
    acSaveFilter: TAction;
    acLoadFilter: TAction;
    ToolButton15: TToolButton;
    ToolButton19: TToolButton;
    N2: TMenuItem;
    Nastvbr1: TMenuItem;
    Uloitvbr1: TMenuItem;
    acFindInText: TAction;
    Hlednvpspvku1: TMenuItem;
    ///Session: TSession;
    ToolButton14: TToolButton;
    N8: TMenuItem;
    ToolButton18: TToolButton;
    N9: TMenuItem;
    pnQuickSearch: TPanel;
    edQuickSearch: TEdit;
    acMailToAutor: TAction;
    Poslatemailautorovi1: TMenuItem;
    Poslatemailautorovi2: TMenuItem;
    N5: TMenuItem;
    Poslatemailautorovi3: TMenuItem;
    procedure grMainTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure grMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grMainKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure acOpenDBUpdate(Sender: TObject);
    procedure acOpenDBExecute(Sender: TObject);
    procedure acNewUpdate(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acAddFileUpdate(Sender: TObject);
    procedure acAddFileExecute(Sender: TObject);
    procedure acExitUpdate(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acFindUpdate(Sender: TObject);
    procedure acFindExecute(Sender: TObject);
    procedure acFindNextInTextUpdate(Sender: TObject);
    procedure acFindNextInTextExecute(Sender: TObject);
    procedure acGoToMailNumUpdate(Sender: TObject);
    procedure acGoToMailNumExecute(Sender: TObject);
    procedure acAlways(Sender: TObject);
    procedure acInfoExecute(Sender: TObject);
    procedure acNever(Sender: TObject);
    procedure acSortIDUpdate(Sender: TObject);
    procedure acSettingsExecute(Sender: TObject);
    procedure acSortIDExecute(Sender: TObject);
    procedure acSortSubjectExecute(Sender: TObject);
    procedure acTableOpenUpdate(Sender: TObject);
    procedure acHeaderExecute(Sender: TObject);
    procedure acToolBarExecute(Sender: TObject);
    procedure acStatusBarExecute(Sender: TObject);
    procedure acIDExecute(Sender: TObject);
    procedure acAutorExecute(Sender: TObject);
    procedure acDateExecute(Sender: TObject);
    procedure acShowAllExecute(Sender: TObject);
    procedure acShowFoundExecute(Sender: TObject);
    procedure acShowAllUpdate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edQuickSearchExit(Sender: TObject);
    procedure edQuickSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edQuickSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edQuickSearchChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure acAddBookmarkExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miBookmarkClick(Sender: TObject);
    procedure acBookmarkSettingExecute(Sender: TObject);
    procedure miBookClick (Sender: TObject);
    procedure acCopyUpdate(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure acSelectAllUpdate(Sender: TObject);
    procedure acSelectAllExecute(Sender: TObject);
    procedure acPrintUpdate(Sender: TObject);
    procedure acPrintExecute(Sender: TObject);
    procedure acSaveToINIExecute(Sender: TObject);
    procedure miCopyClipClick(Sender: TObject);
    procedure lSubjectMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure acBookmarksExecute(Sender: TObject);
    procedure acWordWrapExecute(Sender: TObject);
    procedure tmShowMailTimer(Sender: TObject);
    procedure reMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure reMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure acGoToURLExecute(Sender: TObject);
    procedure acGoToURLUpdate(Sender: TObject);
    procedure acCopyURLExecute(Sender: TObject);
    procedure acDBInfoExecute(Sender: TObject);
    procedure acDBInfoUpdate(Sender: TObject);
    procedure acSaveFilterExecute(Sender: TObject);
    procedure acLoadFilterExecute(Sender: TObject);
    procedure acSaveFilterUpdate(Sender: TObject);
    procedure acLoadFilterUpdate(Sender: TObject);
    procedure acBookmarksUpdate(Sender: TObject);
    procedure grMainKeyPress(Sender: TObject; var Key: Char);
    procedure reMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acFindInTextExecute(Sender: TObject);
    procedure acIDUpdate(Sender: TObject);
    procedure acMailToAutorExecute(Sender: TObject);
    procedure acMailToAutorUpdate(Sender: TObject);
  private
    { Private declarations }
    DBClickTime: TDateTime;
    KeyUp: Boolean;
    IniFileName: string;
    ClipBoard: TClipBoard;

    procedure WriteToINI;
    procedure ReadFromINI;
    procedure WriteToDBIni;
    procedure ReadFromDBIni;

    procedure AddFileToDB;
    procedure Info (S: string);
    function CreateNewTable (FileName: string): Boolean;
    procedure SetDBOpen (DBName, TBName: string);
    procedure SetDBClose;
    function OpenDB (FileName: string): Boolean;
    procedure CloseDB;
    procedure SelectData;
    procedure SetCaption;
    function ParseParams: string;

    procedure InitVariables;
    function GetIndexName: string;

    function FindWordAC: longint;
    function FindWord2 (PomList: TStringList): longint;

    procedure InsertToPomFoundArray (X: integer);
    function IsInFoundArray (X: integer): Boolean;
    procedure ClearArray (var A: TDarray; var ACount: integer);
    procedure SortArray (var A: TDarray; var ACount: integer);

//    procedure AddToArray (X: integer; var ACount: integer; var A: TDarray);
    procedure AppendArray (const A: TDarray; var B: TDarray;
                                  const ACount: integer; var BCount: integer);
    procedure CopyArray (const A: TDarray; var B: TDarray;
                                const ACount: integer; var BCount: integer);

    procedure ShowMail;

    procedure Odpoj;
    procedure Pripoj;

    procedure Filtruj (Filtr: Boolean);

    procedure FindInDB;
    procedure FindInText;

    procedure ShowHint(Sender: TObject);
    function ShowRecordsCount: integer;
    procedure ShowSize (N: integer);

    procedure WaitCur;
    procedure DefCur;

    procedure SetHeader (Vis: boolean);
    procedure SetToolBar (Vis: boolean);
    procedure SetStatusBar (Vis: boolean);
    procedure SetDate (Vis: Boolean);
    procedure SetID (Vis: Boolean);
    procedure SetAutor (Vis: Boolean);
    procedure SetAttributes;
    procedure SetEditAttr (FN: TFont);
    function ReadPathFromIni(const PathName: string): string;
    procedure WritePathToIni(const PathName: string; const Path: string);

    function  FindItem (MI: TComponent; S: string): TMenuItem;
    procedure SaveBookmarksToFile (IniFile: TIniFile; Sec, Name: string; PM: TPopUpMenu);
    procedure LoadBookmarksFromFile (IniFile: TIniFile; Sec, Name: string; PM: TPopUpMenu);
    function  GetColumnIndex(const ColName: string): Integer;

  public
    { Public declarations }
    CursorURL: string;
    slFind, slSyntax: TStringList;
    FoundRecCount, PomFoundRecCount: integer;

    daPomFound, daFound: TDarray;
    TableName, DatabaseName: string;
    Records: longint;
    CopyText: string;
    fnNormal, fnHref, fnFind, fnQuote, fnOld: TFont;
    procedure AddBookItem (S: string);
    procedure ClearBookmarks;

    procedure AddFileToMenu (FileName: string);
    procedure miOldFileClick(Sender: TObject);
    function TotalRecords (DBName, TBName: string): longint;
    procedure LastMailInDB (var ID: longint; var S: string);
    procedure AddDBComment (Section,S: string);
  end;

var
  fMain: TfMain;

implementation

uses AddFile, About, GetNum, Settings, Find, My_ac, Vyraz, Wait,
  NewBookmark, Tisk, StopRead, GetKindOfFile, SelectDir, Utils,
  EditMenuBook, DBInfo, FindInText;

{$R *.dfm}
{$R xp.res}


//------------------------------------------------------------------------------
//                                                               FontStyleToInt
//------------------------------------------------------------------------------
function FontStyleToInt (F: TFont): Integer;
var
  R: integer;
begin { FontStyleToInt }
  R := 0;
  R := R or (1*Integer(fsBold in F.Style));
  R := R or (2*Integer(fsItalic in F.Style));
  R := R or (4*Integer(fsUnderLine in F.Style));
  R := R or (8*Integer(fsStrikeOut in F.Style));

  Result := R;
end;  { FontStyleToInt }

//------------------------------------------------------------------------------
//                                                               IntToFontStyle
//------------------------------------------------------------------------------
procedure IntToFontStyle (F: TFont; Int: Integer);
begin { IntToFontStyle }
  if ((Int and 1) = 1) then F.Style := F.Style + [fsBold];
  if ((Int and 2) = 2) then F.Style := F.Style + [fsItalic];
  if ((Int and 4) = 4) then F.Style := F.Style + [fsUnderLine];
  if ((Int and 8) = 8) then F.Style := F.Style + [fsStrikeOut];
end;  { IntToFontStyle }

//------------------------------------------------------------------------------
//                                                                     SaveFont
//------------------------------------------------------------------------------
procedure SaveFont (FN: TFont; Ini: TIniFile; Sec,Name: string);
begin  { SaveFont }
  with Ini do begin
    WriteString  (Sec, Name+'_Name', FN.Name);
    WriteInteger (Sec, Name+'_Size', FN.Size);
    WriteInteger (Sec, Name+'_Color', FN.Color);
    WriteInteger (Sec, Name+'_Charset', FN.Charset);
    WriteInteger (Sec, Name+'_Style', FontStyleToInt (FN));
  end;
end;   { SaveFont }

//------------------------------------------------------------------------------
//                                                                     LoadFont
//------------------------------------------------------------------------------
procedure LoadFont (FN: TFont; Ini: TIniFile; Sec,Name: string);
begin  { LoadFont }
  with Ini do begin
    FN.Name := ReadString  (Sec, Name+'_Name', FN.Name);
    FN.Size := ReadInteger (Sec, Name+'_Size', FN.Size);
    FN.Color := ReadInteger (Sec, Name+'_Color', FN.Color);
    FN.CharSet := ReadInteger (Sec, Name+'_Charset', FN.Charset);
    IntToFontStyle (FN, ReadInteger (Sec, Name+'_Style', FontStyleToInt (FN)));
  end;
end;   { LoadFont }

//------------------------------------------------------------------------------
//                                                                         Info
//------------------------------------------------------------------------------
procedure TfMain.Info (S: string);
begin { Info }
  sbMain.Panels[1].Text := S;
  sbMain.Update;
end;  { Info }


//------------------------------------------------------------------------------
//                                                               CreateNewTable
//------------------------------------------------------------------------------
// 1) Napoji Query na zadany adresar
// 2) Vytvori tam prislusnou tabulku
function TfMain.CreateNewTable (FileName: string): Boolean;
var
  DBName, TBName: string;
  s: string;
begin { CreateNewTable }
  Result := false;

  // Zapsani souboru do menu
  AddFileToMenu (FileName);

  if (FileName = '') then exit;

  ///DBName := ExtractFileDir (Filename);
  TBName := ExtractFileName (Filename);
  TBName := ChangeFileExt (TBName, '');
  conDatabase.DatabaseName:= FileName;
  ///conDatabase.Transaction:=SQLtransaction1;
  ///qrMain.DataBase:=conDatabase;

  ///qrMain.DatabaseName := DBName;

  // Vytvorime tabulku - soubor
  try
    if not conDatabase.Connected then
      conDatabase.Connected := True;

    qrMain.Close;
    qrMain.SQL.Clear;
    qrMain.SQL.Add (Format(
     'CREATE TABLE "%s" ('
     + ' ID        INTEGER PRIMARY KEY,'
     + ' DATUM     VarChar (50),'
     + ' AUTOR     VarChar (80),'
     + ' SUBJECT   VarChar (120),'
     + ' MAIL      Blob (0,1))', [TBName]));
     ///+ ' PRIMARY KEY (ID))', [TBName]));
    qrMain.ExecSQL;
    SQLTransaction1.CommitRetaining;
    qrMain.Close;
  Except
    ///on EDBEngineError do begin
    ///  MessageDlg ('Nepodařilo se vytvoøit tabulku! (možná již existuje)',
    ///      mtError, [mbOK], 0);
      SQLTransaction1.Rollback;
      qrMain.Close;
      Exit;
    ///end;
  end;

  // Vytvorime index na subject
  try
    qrMain.Close;
    qrMain.SQL.Clear;
    qrMain.SQL.Add (Format('CREATE INDEX ISubject ON "%s" (SUBJECT)', [TBName]));
    qrMain.ExecSQL;
    qrMain.Close;
  Except
    ///on EDBEngineError do begin
    ///  MessageDlg('Nepodařilo se vytvořit index!',
    ///      mtError, [mbOK], 0);
      qrMain.Close;
      Exit;
    ///end;
  end;

  { smazeme ini soubor, pokud existuje }
  s := ChangeFileExt (FileName, '.ini');
  DeleteFile(s);

  OpenDB (FileName);

  AddDBComment ('-', '');
  AddDBComment ('', FormatDateTime ('d. mmmm yyyy (hh:nn:ss)', now));
  AddDBComment ('-','');
  AddDBComment ('','Vytvoreni tabulky');
  AddDBComment ('','');
end;  { CreateNewTable }

//------------------------------------------------------------------------------
//                                                                   SetDBOpen
//------------------------------------------------------------------------------
procedure TfMain.SetDBOpen (DBName, TBName: string);
begin { SetDBOpen }
  // Nastavime parametry otevrene DB
  DatabaseName := DBName;
  TableName := TBName;
//  Table.TableName := TableName;
end;  { SetDBOpen }

//------------------------------------------------------------------------------
//                                                                   SetDBClose
//------------------------------------------------------------------------------
procedure TfMain.SetDBClose;
begin { SetDBClose }
  DatabaseName := '';
  TableName := '';
  SetCaption;
end;  { SetDBClose }

//------------------------------------------------------------------------------
//                                                                        Odpoj
//------------------------------------------------------------------------------
// Odpoji se komponenty napriklad pri pridavani zaznamu do databaze,
// nebo hledani
procedure TfMain.Odpoj;
begin { Odpoj }
  dsMain.DataSet := nil;
end;  { Odpoj }

//------------------------------------------------------------------------------
//                                                                       Pripoj
//------------------------------------------------------------------------------
procedure TfMain.Pripoj;
begin { Pripoj }
  dsMain.DataSet := qrMain; ///Table;
end;  { Pripoj }

//------------------------------------------------------------------------------
//                                                                      Filtruj
//------------------------------------------------------------------------------
procedure TfMain.Filtruj (Filtr: Boolean);
begin { Filtruj }
  acShowAll.Checked := not Filtr;
  acShowFound.Checked := Filtr;
  {Table.Filtered := Filtr;

  if (Filtr) then begin
    Table.OnFilterRecord := TableFilterRecord;
  end else begin
    Table.OnFilterRecord := nil;
  end;}
  qrMain.Filtered:= Filtr;
  if (Filtr) then begin
    qrMAin.OnFilterRecord := TableFilterRecord;
  end else begin
    qrMain.OnFilterRecord := nil;
  end;

  ShowRecordsCount;
end;  { Filtruj }

//------------------------------------------------------------------------------
//                                                                  AddFileToDB
//------------------------------------------------------------------------------
procedure TfMain.AddFileToDB;
var
  Kind : integer;
  AttachDir, FileName: string;
begin  { AddFileToDB }
  // Pridavani dalsich mejliku do DB

  // Nejdrive se zeptame z jakeho zdroje chce pridavat.
  if fGetKindOfFile = nil then fGetKindOfFile := TfGetKindOfFile.Create(Self);
  if (fGetKindOfFile.ShowModal <> mrOK) then exit;
  Kind := fGetKindOfFile.rgKind.ItemIndex;

  case Kind of
    afkMail: begin
      odOpen.Filter := 'Textové soubory (*.txt)|*.txt|Všechny soubory (*.*)|*.*';
      odOpen.InitialDir := ReadPathFromIni('NewsFile');
      if odOpen.Execute then
      begin
        FileName := odOpen.FileName;
        WritePathToIni('NewsFile', ExtractFileDir(FileName));
      end;
    end; // Mail

    afkHtml: begin
      FileName := SelectDirectory ('');
      if (FileName = '') then exit;
    end;
  end; // case

  AttachDir := fSettings.edAttach.Text;
  if (not fSettings.cbSaveAttach.Checked) then AttachDir := '';

  if ((AttachDir <> '') and (not ExistsDir (AttachDir))) then
    if (MessageDlg('Název adresáře, kam se mají přílohy ukládat je neplatný.'+#13+
            'Adresář: '+AttachDir+#13+
            'Přílohy se proto nebudou ukládat.'+#13+#13+
            'Pokračovat s tímto nastavením?',
            mtConfirmation, [mbYes, mbNO], 0) <> mrYes) then exit
    else AttachDir := '';

  { pokud si neco vybereme, zpracujeme to }
  if (Kind = afkMail) and (FileExists(FileName)) or
    (Kind = afkHtml) and DirectoryExists(AttachDir) then
  begin
    // Zobrazime cekaci formularek
    fAddFile := TfAddFile.Create(Self);
    try
      AddFile.Path := FileName;
      ///AddFile.Kind := Kind;
      AddFile.AttachDirectory := AttachDir;
      Odpoj;
      fAddFile.ShowModal;
      Pripoj;
      ///fAddFile.Release;
      ///fAddFile := nil;
      SelectData;
    finally
      fAddFile.Free;
    end;
  end;
end;   { AddFileToDB }


//------------------------------------------------------------------------------
//                                                                   SelectData
//------------------------------------------------------------------------------
// 'Select * from %s '
procedure TfMain.SelectData;
var
  SelectedIndex: string;
begin { SelectData }
  // Zjistime, dle ceho se ma tridit
  SelectedIndex := GetIndexName;
  ///Table.Close;
  qrMain.Close;

  try
    {Pokud je tabulka otevrena, tak ji zavreme, aby se mohl zmenit index}
    ///if (Table.IndexName <> SelectedIndex) then
    ///  Table.IndexName := SelectedIndex;
    ///Table.DatabaseName := DatabaseName;
    ///Table.TableName := TableName;
    ///Table.Open;

    //conDatabase.Transaction:=SQLtransaction1;
    ///if (qrMain.IndexName <> SelectedIndex) then
      ///qrMain.IndexName := SelectedIndex;
    conDatabase.DatabaseName:= DatabaseName;
    if not conDatabase.Connected then
      conDatabase.Connected := True;
    qrMain.DataBase:=conDatabase;
    qrMain.SQL.Clear;
    qrMain.SQL.Add('select * from '+TableName);
    qrMain.Open;
    dsMain.dataset := qrMain;
    //propojim DBgrid s datasource
    //qrMain.DataSource := dsMain;

  except
    ///On EDBEngineError do begin
      MessageDlg ('Nepodařilo se otevřít tabulku ' + TableName, mtError, [mbOK], 0);
      SetDBClose;
      exit;
    ///end;

  end; // try
  ///Table.RecordCount;
  Records := qrMain.RecordCount;

  Info ('Celkem '+IntToStr (Records)+' záznamù v databázi.');
  ShowRecordsCount;
end;  { SelectData }

//------------------------------------------------------------------------------
//                                                                       OpenDB
//------------------------------------------------------------------------------
// Otevre zadanou databazi
function TfMain.OpenDB (FileName: string): Boolean;
var
  DBName, TBName:string;

begin { OpenDB }
  Result := false;
  if ((FileName = '') or (not FileExists (FileName))) then begin
    MessageDlg ('Soubor zadaného jména neexistuje!'+#13+'('+FileName+')',
        mtError, [mbOK], 0);
    exit;
  end;

  if (TableName <> '') then WriteToDBIni;

  Pripoj;
  Filtruj (False);

  ///DBName := ExtractFileDir (Filename);
  TBName := ExtractFileName (Filename);
  TBName := ChangeFileExt (TBName, '');

  ///SetDBOpen (DBName, TBName);
  SetDBOpen (FileName, TBName);

  SelectData;

  SetCaption;

  // Zapsani souboru do menu
  AddFileToMenu (FileName);

  // Nacteni informaci z inisouboru
  ReadFromDBIni;

  Result := true;
end;  { OpenDB }

//------------------------------------------------------------------------------
//                                                                   SetCaption
//------------------------------------------------------------------------------
procedure TfMain.SetCaption;
var
  Cap: string;
begin  { SetCaption }
  Cap := 'Prohlížeč konferencí';
  if (TableName <> '') then
    Cap := Cap + ' [' + ChangeFileExt (TableName, '') +']';

  Caption := Cap;
end;   { SetCaption }


//------------------------------------------------------------------------------
//                                                                      CloseDB
//------------------------------------------------------------------------------
procedure TfMain.CloseDB;
begin { CloseDB }
  ///Table.Close;
  qrmain.close;
  WriteToDBIni;
  SetDBClose;
end;  { CloseDB }



//------------------------------------------------------------------------------
//                                                                  ParseParams
//------------------------------------------------------------------------------
// Tady se pak bude moct zadat jiny ini soubor
// Vrati cestu k databazi, kteoru ma otevrit na zacatku
function TfMain.ParseParams: string;
var
  i, ini: integer;
  S: string;
begin { ParseParams }
  Result := '';
  Ini := 0;
  if (ParamCount = 0) then exit;

  for i := 1 to ParamCount do begin
    S := ParamStr(i);
    if ((NotCSPos ('/i=', S) = 1) or (NotCSPos ('/i=', S) = 1)) then begin
      S := Copy (S, 4, Length (S)-3);
      Ini := i;
      if (FileExists (S)) then  IniFileName := S;
    end;
  end;

  if (Ini <> 1) then Result := ParamStr (1);
//    OpenDB (ParamStr (1));
end;  { ParseParams }

//------------------------------------------------------------------------------
//                                                                InitVariables
//------------------------------------------------------------------------------
procedure TfMain.InitVariables;
begin { InitVariables }
  Records := 0;
  TableName := '';
  DatabaseName := '';
  KeyUp := true;
end;  { InitVariables }


//------------------------------------------------------------------------------
//                                                                 GetIndexName
//------------------------------------------------------------------------------
function TfMain.GetIndexName: string;
var
  i: integer;
begin { GetIndexName }
  if (acSortID.Checked) then begin
    Result := '';
    for i := 0 to grMain.Columns.Count-1 do begin
      if (AnsiUpperCase (grMain.Columns[i].FieldName) <> 'ID') then
        grMain.Columns[i].Title.Font.Style := []
      else
        grMain.Columns[i].Title.Font.Style := [fsBold];
    end;
  end else begin
    Result := 'ISubject';
    for i := 0 to grMain.Columns.Count-1 do begin
      if (AnsiUpperCase (grMain.Columns[i].FieldName) <> 'SUBJECT') then
        grMain.Columns[i].Title.Font.Style := []
      else
        grMain.Columns[i].Title.Font.Style := [fsBold];
    end;
  end;
end;  { GetIndexName }

procedure TfMain.grMainTitleClick(Column: TColumn);
begin
  // Zmena sorteni
  if (not Table.Active) then Exit;
  if (Column.FieldName = 'ID') then begin
    if (acSortID.Checked) then exit;
    acSortIDExecute (acSortID);
  end;

  if (Column.FieldName = 'SUBJECT') then begin
    if (acSortSubject.Checked) then exit;
    acSortSubjectExecute (acSortSubject);
  end;
end;

//------------------------------------------------------------------------------
//                                                                     FindInDB
//------------------------------------------------------------------------------
procedure TfMain.FindInDB;
var
  Res: longint;
{  SF: string;
  i: integer;
}
begin
  if (fFind.ShowModal <> mrOK) then exit;

  { Pridame hledane slovicko do ComboBoxu }
  { mozna by se hodilo, ze pokud uz tam je a je jako posledni tak jej nepridavat}
  (*if ((fFind.cbFindWord.Text <> '') and (
     (fFind.cbFindWord.Items.Count < 0) or
     (fFind.cbFindWord.Items[0] <> fFind.cbFindWord.Text))) then *)
        fFind.cbFindWord.Items.Insert (0, fFind.cbFindWord.Text);

  {Vyhledavani spravnych polozek}
  { - tady se zobrazi nejaky cekaci dialog }

  Odpoj;

  { Tady se zavola hledani }
  Res := FindWordAC;
//  ShowMessage (TimeToStr (now - T1));

  if (Res = 0) then begin
    MessageDlg ('Nebyl nalezen žádný příspěvek odpovídající dotazu!',
      mtInformation, [mbOK], 0);
    Pripoj;
    exit;
  end;

  SortArray (daFound, FoundRecCount);
  Info ('Bylo nalezeno ' + IntToStr (Res) + ' příspěvkù vyhovujících dotazu.');
  Records := Res;
  Pripoj;

(*
  SF := '';
  for i := 0 to Res-1 do
    SF := SF + IntToStr(i) + '=' + IntToStr (daFound[i]) + ', ';
  ShowMessage (SF);
*)
  Filtruj (True);
end;

{-----------------------------------------------------------------FindWordAC---}
function TfMain.FindWordAC: longint;
var
  PomList: TStringList;
  Slovo, S: string;
  i: integer;
  CS: Boolean;
begin { FindWordAC }
  Result := 0;
  S  := fFind.cbFindWord.Text;
  CS := fFind.cbCaseSensitiv.Checked;

  { Vycistime listbox se seznamem toho co hledam }
  slFind.Clear;

  { Upravime vyraz }
  NajdiSpojky (S);

  { zapiseme pomoci polske notace }
  vError := 0;
  Vyhodnot (S, slFind);
  if (vError <> 0) then begin
    ShowMessage ('Špatně zapsaný výraz!');
    Exit;
  end;

  { Vytvorime AC automat a nahazime hledana slovicka do spravneho listboxu }
  InicializaceAutomatu;
  fFindInText.memFindWords.Lines.Clear;
  for i := 0 to slFind.Count-1 do begin
    Slovo := slFind.Strings[i];
    if (Slovo <> '&') and     { pokud to neni spojka pridame to do automatu}
       (Slovo <> '|') and
       (Slovo <> '!') then begin
          fFindInText.memFindWords.Lines.Add (Slovo);
          if (CS) then PridejSlovo (Slovo)
          else PridejSlovo (AnsiUpperCase (Slovo));
    end;
  end;

  for i := 0 to slFind.Count-1 do begin
    Slovo := slFind.Strings[i];
    if (Slovo <> '&') and      { pro slova v automatu spocitame zpetnou fci F }
       (Slovo <> '|') and
       (Slovo <> '!') then begin
          if (CS) then SpoctiF (Slovo)
          else SpoctiF (AnsiUpperCase (Slovo));
    end;
  end;

  { Zobrazim cekaci formular }
  if fWait = nil then fWait := TfWait.Create(Self);
  fWait.lAktualni.Caption := '0';
  fWait.lVyhovujici.Caption := '0';

  fWait.Show;
  fMain.Hide;

  PomList := TStringList.Create;
  { Prohledame }
  Result := FindWord2 (PomList);{List, PomList}
  { Zjistime vysledky }
  PomList.Free;

  { Schovam cekaci a ukazu normalni formular }
  fWait.Hide;
  fMain.Show;
end;  { FindWordAC }


//------------------------------------------------------------------------------
//                                                                    FindWord2
//------------------------------------------------------------------------------
function TfMain.FindWord2 (PomList: TStringList): longint;
var
  Subj, CS: Boolean;
  ActRecord, ItemsFound: longint;
  Celkem: longint;
  NumToFind: integer;

  i, j, Pom: integer;
  Vysl, Slovo: string;
  ATitle,
  FirstID, FirstSubj,
  MailSubj, MailDate, MailFrom,
  SpecSubj, SpecDate, SpecFrom: string;

  Spec: Boolean;
  RecordOK: Boolean;
  MyTrue: Boolean;
  Method: Integer;


  function NextItem: boolean;
  begin
    Result := false;
    ///if Table.EOF then exit;
    ///Table.Next;
    ///if Table.EOF then exit;
    if qrMain.EOF then exit;
    qrMain.Next;
    if qrMain.EOF then exit;
    Result := true;
  end;

begin { FindWord2 }
  ItemsFound := 0;

  {-------- Nastaveni promennych pro vyhledavani --------}
  Subj     := fFind.cbSubjectToo.Checked;
  CS       := fFind.cbCaseSensitiv.Checked;
  Spec     := fFind.cbSpecial.Checked;
  SpecSubj := ANSIUpperCase(fFind.edSubject.Text);
  SpecFrom := ANSIUpperCase(fFind.edFrom.Text);
  SpecDate := ANSIUpperCase(fFind.edDate.Text);
  ATitle := Application.Title;
  Method := fFind.rgMethod.ItemIndex;

  NumToFind := 0;
  if Spec then begin
    try
      NumToFind := StrToInt (fFind.neCount.Text);
    except
      On EConvertError do
        NumToFind := 0;
    end; // try
  end;

  ActRecord := 0;
  ClearArray (daPomFound, PomFoundRecCount);


  // Jeste se koukneme, z ceho se bude vyhledavat
  if (Method = fmOR) then begin
    Filtruj (true);
    ///Table.Last;
    ///FirstID := Table.FieldByName ('ID').AsString;
    ///FirstSubj := Table.FieldByName ('Subject').AsString;
    qrMain.Last;
    FirstID := qrMain.FieldByName ('ID').AsString;
    FirstSubj := qrMain.FieldByName ('Subject').AsString;
  end;

  ///if (Table.Filtered and (fFind.rgMethod.ItemIndex <> fmAnd)) then
  if (qrMain.Filtered and (fFind.rgMethod.ItemIndex <> fmAnd)) then
    Filtruj (false)
  else begin
    ///if (not Table.Filtered and (fFind.rgMethod.ItemIndex = fmAnd)) then
    if (not qrMain.Filtered and (fFind.rgMethod.ItemIndex = fmAnd)) then
      Filtruj (true);
  end;

  ///Celkem := Table.RecordCount;
  Celkem := qrMain.RecordCount;

  if (Method <> fmOR) then
    ///Table.First
    qrMain.First
  else begin // Skoci to na zaznam, ktery je vetsi nezposledni nalezeny
    if (GetIndexName = '') then
      ///Table.FindNearest ([FirstID])
      qrMain.Locate('ID',FirstID,[loPartialKey])
    else
      ///Table.FindNearest ([FirstSubj]);
      qrMain.Locate('SUBJECT',FirstSubj,[loPartialKey]);
    ///if (not Table.EOF) then Table.Next;
    if (not qrMain.EOF) then qrMain.Next;
    Celkem := Celkem - daFound[FoundRecCount-1];
  end;

  fWait.lCelkem.Caption := IntToStr (Celkem);

  // Z ceho a jak se bude hledat (Zpusob)
  //--------------------------------------


  ///MyTrue := not Table.EOF;
  MyTrue := not qrMain.EOF;

  {------------------------ Vlastni hledani ------------------}
  while MyTrue do begin
    { obnovime obrazovku, vypiseme pozici a podobne }

    if (ActRecord mod 50)=0 then begin
      fWait.lAktualni.Caption := IntToStr (ActRecord);
      fWait.lVyhovujici.Caption := IntToStr (ItemsFound);
      fWait.pbPos.Position := (100 * ActRecord) div Celkem;
      Application.ProcessMessages;

      if (fWait.WindowState = wsMinimized) then begin
        Application.Title := Format (' %d %% %s',[fWait.pbPos.Position, ATitle]);
//        Application.Minimize;
      end;
    end;

    if (fWait.Stopped) then begin
      Break;
    end;


    { Zkopirujeme retezce do pomocneho listu }
    PomList.AddStrings (slFind);
    inc (ActRecord);

    { Vycistime pole odpovedi }
    for j := 1 to LastStav do
      if (Vystup[j] > 1) then Vystup[j] := 1;


    ///MailSubj := Table.FieldByName ('Subject').AsString;
    MailSubj := qrMAin.FieldByName ('Subject').AsString;

    { Nejdrive se koukneme do Subjectu }
    if (Subj) then begin
      ///if (CS) then My_ac.Find (Table.FieldByName ('Subject').AsString)
      ///else My_ac.Find (ANSIUpperCase (Table.FieldByName ('Subject').AsString));
      if (CS) then My_ac.Find (qrMain.FieldByName ('Subject').AsString)
      else My_ac.Find (ANSIUpperCase (qrMain.FieldByName ('Subject').AsString));
    end; { Subject }

    { No a ted jeste proverime telo zpravicky }
    if (CS) then
      ///My_ac.Find (Table.FieldByName ('Mail').AsString)
      My_ac.Find (qrMain.FieldByName ('Mail').AsString)
    else
      ///My_ac.Find (ANSIUpperCase (Table.FieldByName ('Mail').AsString));
      My_ac.Find (ANSIUpperCase (qrMain.FieldByName ('Mail').AsString));

    { Zpracuj vysledky }
    j := 1;
    for i := 0 to PomList.Count-1 do begin  // forcyklus pres lexikony retezce
      Slovo := PomList.Strings[i];
      if (Slovo <> '&') and     { pokud to neni spojka pridame to do automatu}
         (Slovo <> '|') and
         (Slovo <> '!') then begin
           while ((Vystup[j] = 0)) do inc (j);   // hledam VYSTUPNI stav (<> 0)
           if Vystup[j] = 1 then Vysl := '0' else Vysl := '1'; // 1..nenamezen
           { nahrada retezce v seznamu }
           PomList.Delete(i);
           PomList.Insert(i, Vysl);
           inc (j);
      end; {if}
    end; {for}

    // Pokud jsme neco prece jenom nasli
    //------------------------------------
    if ((Vycisli (PomList) <> 0) or
       (Spec and (fFind.cbFindWord.Text = ''))) then begin
      RecordOK := true;
      // Specialni vyhledavani
      if (Spec) then begin

        if (SpecSubj <> '') then begin
          MailSubj := ANSIUpperCase(MailSubj);
          Pom := Pos (SpecSubj, MailSubj);
          if ((Pom = 0) and (fFind.cbSubject.ItemIndex = 0)) then RecordOK := false;
          if ((Pom <> 0) and (fFind.cbSubject.ItemIndex = 1)) then RecordOK := false;
        end; // Subj

        if (SpecFrom <> '') and (RecordOK) then begin
          MailFrom := ANSIUpperCase(Table.FieldByName ('Autor').AsString);
          Pom := Pos (SpecFrom, MailFrom);
          if ((Pom = 0) and (fFind.cbFrom.ItemIndex = 0)) then RecordOK := false;
          if ((Pom <> 0) and (fFind.cbFrom.ItemIndex = 1)) then RecordOK := false;
        end; // From

        if (SpecDate <> '') and (RecordOK) then begin
          MailDate := ANSIUpperCase(Table.FieldByName ('Datum').AsString);
          Pom := Pos (SpecDate, MailDate);
          if ((Pom = 0) and (fFind.cbDate.ItemIndex = 0)) then RecordOK := false;
          if ((Pom <> 0) and (fFind.cbDate.ItemIndex = 1)) then RecordOK := false;
        end; // Date
      end;

      if (RecordOK) then begin
        // Opravdu splnuje vsechna kriteria
        //----------------------------------
        ///InsertToPomFoundArray (Table.FieldByName ('ID').AsInteger);
        InsertToPomFoundArray (qrMain.FieldByName ('ID').AsInteger);
        inc (ItemsFound);

        // Pokud jsme vyhledali dostatecne mnozstvi vyskytu...
        if (Spec) and (NumToFind > 0) then
          if (ItemsFound >= NumToFind) then Break;
      end;
    end;

    { Pokud jsme na konci, tak vyskocime z cyklu }
    if not NextItem then Break;
  end;

  if (Method = fmOr) then
    AppendArray (daPomFound, daFound, PomFoundRecCount, FoundRecCount)
  else
    CopyArray (daPomFound, daFound, PomFoundRecCount, FoundRecCount);

  Application.Title := ATitle;
  Result := ItemsFound;
end;  { FindWord2 }

//------------------------------------------------------------------------------
//                                                                   ClearArray
//------------------------------------------------------------------------------
// Vynuluje pole
procedure TfMain.ClearArray (var A: TDarray; var ACount: integer);
var
  i: integer;
begin { ClearArray }
  for i := 0 to Length (A)-1 do
    A[i] := 0;
  ACount := 0;
end;  { ClearArray }

//------------------------------------------------------------------------------
//                                                                    SortArray
//------------------------------------------------------------------------------
// Setridi pole
procedure TfMain.SortArray (var A: TDarray; var ACount: integer);
var
  i, j, Pom: integer;
  Sorted: Boolean;
begin { SortArray }
  if (ACount < 2) then exit;
  for j := 0 to ACount-1 do begin
    Sorted := true;
    for i := 0 to ACount-2 do begin
      if (A[i] > A[i+1]) then begin
        // Prehozeni
        Pom := A[i];
        A[i] := A[i+1];
        A[i+1] := Pom;
        Sorted := false;
      end;
    end;
    if (Sorted) then break;
  end;
end;  { SortArray }


//------------------------------------------------------------------------------
//                                                        InsertToPomFoundArray
//------------------------------------------------------------------------------
// Vlozi do pole na pozici i prvek X, pokud je jiz polke plne, tak jej zvetsi
// o 100 prvku
procedure TfMain.InsertToPomFoundArray (X: integer);
begin { InsertToPomFoundArray }
  if (PomFoundRecCount >= Length (daPomFound)) then
    SetLength (daPomFound, Length (daPomFound) + 100);
  daPomFound[PomFoundRecCount] := X;
  inc (PomFoundRecCount);
end;  { InsertToPomFoundArray }

(*
//------------------------------------------------------------------------------
//                                                                   AddToArray
//------------------------------------------------------------------------------
// Vlozi do pole na konec prvek X, pokud je jiz polke plne, tak jej zvetsi
// o 100 prvku
procedure TfMain.AddToArray (X: integer; var ACount: integer; var A: TDarray);
begin { AddToArray }
  if (ACount >= Length (A)) then
    SetLength (A, Length (A) + 100);
  A[ACount] := X;
  inc (ACount);
end;  { AddToArray }
*)
//------------------------------------------------------------------------------
//                                                                  AppendArray
//------------------------------------------------------------------------------
// Na konec pole B prida vsechny prvky z pole A
procedure TfMain.AppendArray (const A: TDarray; var B: TDarray;
                              const ACount: integer; var BCount: integer);
var
  i: integer;
begin { AppendArray }
  if (Length (B) < (BCount + ACount)) then
    SetLength (B, BCount + ACount);

  for i := 0 to ACount-1 do begin
    B[BCount] := A[i];
    inc (BCount);
  end;
end;  { AppendArray }

//------------------------------------------------------------------------------
//                                                                    CopyArray
//------------------------------------------------------------------------------
// Do pole B zkopiruje vsechny prvky z pole A
procedure TfMain.CopyArray (const A: TDarray; var B: TDarray;
                            const ACount: integer; var BCount: integer);
var
  i: integer;

begin { CopyArray }
  ClearArray (B, BCount);
  if (Length (B) < (ACount)) then
    SetLength (B, ACount);

  for i := 0 to ACount-1 do begin
    B[i] := A[i];
  end;
  BCount := ACount
end;  { CopyArray }

//------------------------------------------------------------------------------
//                                                               IsInFoundArray
//------------------------------------------------------------------------------
// Zjisti, zda zadany prvek (X) je v poli do pozice Max (vcetne)
// Predpoklada se, ze pole je setridene
function TfMain.IsInFoundArray (X: integer): Boolean;
var
  i: integer;
begin { IsInFoundArray }
  // Zatim jenom blbe prochazeni, pozdeji asi puleni intervalu
  if (X > daFound[FoundRecCount-1]) then begin
    Result := false;
    Exit;
  end;

  Result := true;
  for i := 0 to FoundRecCount-1 do
    if (daFound[i] = X) then exit;

  Result := false;
end;  { IsInFoundArray }

//..............................................................................
//                                                                   FormCreate
//..............................................................................
procedure TfMain.FormCreate(Sender: TObject);
var
//  MI: TMenuItemInfo;
//  Buffer: array[0..79] of Char;
  DbToOpen: string;
  TMP: string;
  a: integer;
  pom: array[0..255] of char;
begin
  a:=255;
  ///GetTempPath(a,pom);
  TMP := pom;
  TMP := ExtractShortPathName(TMP);

  { lokalizace tlacitek a hlavicek MessageDLG }
  ///LocalizeDialogs;

  // Vytvoreni formulare Nastaveni
  fSettings := TfSettings.Create (Application);
  fFind := TfFind.Create (Application);
  fDBInfo := TfDBInfo.Create (Application);
  fFindInText := TfFindInText.Create(Self);
  ClipBoard := TClipBoard.Create;
  CopyText := '';

  ///Session.NetFileDir := TMP;
  ///Session.PrivateDir := TMP;
  ///Session.Active := True;

  // IniFileName
  IniFileName := ChangeFileExt (Application.ExeName, '.ini');

// MENU INFORMACE uplne vpravo
//  ZeroMemory(@MI, Sizeof(MI));
//  MI.cbSize := 44; // Win95
//  MI.fMask := MIIM_TYPE;
//  MI.dwTypeData := Buffer;
//  MI.cch := SizeOf(Buffer);
//  if GetMenuItemInfo(mmMain.Handle, mInformace.MenuIndex, True, MI) then begin
//    MI.fType := MI.fType or MFT_RIGHTJUSTIFY;
//    if SetMenuItemInfo(mmMain.Handle, mInformace.MenuIndex, True, MI) then
//      DrawMenuBar(mmMain.WindowHandle);
//  end;


  slFind := TStringList.Create;
  slSyntax := TStringList.Create;

  SetLength (daFound, 100);
  SetLength (daPomFound, 100);

  FoundRecCount := 0;
  PomFoundRecCount := 0;
  DBClickTime := Now;

  InitVariables;

  // Koukneme se na parametry
  DbToOpen := ParseParams;

  // Presmerovani hintu do statusbaru
  Application.OnHint := ShowHint;

  // Desetiny separator
  DecimalSeparator := '.';

  // Nasosame data z INI souboru
  ReadFromINI;
  SetAttributes;

  conDatabase.Transaction:=SQLtransaction1;
  qrMain.DataBase:=conDatabase;


  if (DbToOpen <> '') then OpenDB (DbToOpen);
end;

//..............................................................................
//                                                                    FormClose
//..............................................................................
procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteToINI;
  fDBInfo.Free;
end;

//------------------------------------------------------------------------------
//                                                                   FindInText
//------------------------------------------------------------------------------
{ Vyhledavani textu v aktualnim meilu v richeditu}
procedure TfMain.FindInText;
var
  First, N, Len, Pom: longint;
  S: string;
  i: integer;
  StartPos, EndPos: integer;
begin { FindInText }
  { Hledani v textu }
//  if slFind.Count = 0 then exit;

  with reMain do begin
    N := Length (Text);
    Len := 0;
    First := N+1;
    StartPos := SelStart+SelLength;
    EndPos := N;

{
    for i := 0 to slFind.Count-1 do begin
      S := slFind.Strings[i];
      if (Length (S) = 0) then continue;
      if (S <> '&') and
         (S <> '|') and
         (S <> '!') then begin
}
    for i := 0 to fFindInText.memFindWords.Lines.Count-1 do begin
      S := fFindInText.memFindWords.Lines[i];
      if (Length (S) = 0) then continue;
      ///Pom := FindText (S, StartPos, EndPos, []);
      if (Pom > 0) then begin
        if Pom<First then begin
          { Nasel se blizsi vzorek }
          First := Pom;
          Len := length (S);
        end; { a zatim je prvni }
      end; {nalezene}
    end; {for}

    if (Len <> 0) then begin
      ///SelStart := First;
      ///SelLength := Len;
      if (not Focused) then begin
        SetFocus;
        if (grMain.Enabled and grMain.Visible) then grMain.SetFocus;
      end;
    end else begin
      if (not fSettings.cbFindInNext.Checked) then
        Info ('Další hledaná slova nebyla v nalezena')
      else begin
        // Prechod na dalsi prispevek
        if Table.EOF then begin
          Info ('Další hledaná slova nebyla v nalezena');
          exit;
        end;
        Table.Next;
        if Table.EOF then begin
          Info ('Další hledaná slova nebyla v nalezena');
          exit;
        end;
        // Nastaveni kurzoru na prvni znak
        reMain.SelStart := 0;
        Application.ProcessMessages;
//        FindInText;
      end;
    end;
  end;
end; { FindInText }


//..............................................................................
//                                                             dsMainDataChange
//..............................................................................
procedure TfMain.dsMainDataChange(Sender: TObject; Field: TField);
begin
//  ShowMail;
  tmShowMail.Enabled := false;
  tmShowMail.Interval := 100;
  tmShowMail.Enabled := true;
end;

procedure TfMain.grMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LineNum: integer;
begin
  if (Key = VK_UP) and (Shift = [ssAlt]) then begin
//    reMain.Perform (EM_LINESCROLL, 0, -1);
    ///LineNum := reMain.Perform (EM_LINEFROMCHAR, reMain.SelStart, 0);
    if (LineNum > 0) then begin
      dec (LineNum);
      ///reMain.SelStart := reMain.Perform (EM_LINEINDEX, wParam(LineNum), 0);
      ///reMain.Perform (EM_LINESCROLL, 0, -1);
//      reMain.Perform (EM_SCROLLCARET, 0, 0);
    end;

    Key := 0;
    exit;
  end;

  if (Key = VK_DOWN) and (Shift = [ssAlt]) then begin   ;
//    reMain.Perform (EM_LINESCROLL, 0, 1);
//    ShowMessage (IntToStr (reMain.Perform (EM_GETFIRSTVISIBLELINE, 0, 0)));
//    reMain.Perform (EM_GETFIRSTVISIBLELINE, 0, 0);
//    reMain.Perform (EM_SCROLLCARET, 0, 0);

//(*
    ///LineNum := reMain.Perform (EM_LINEFROMCHAR, reMain.SelStart, 0);
    if (LineNum < reMain.Lines.Count-3) then begin
      inc (LineNum);
      ///reMain.SelStart := reMain.Perform (EM_LINEINDEX, wParam(LineNum), 0);
      ///reMain.Perform (EM_LINESCROLL, 0, 1);
//      reMain.Perform (EM_SCROLLCARET, 0, 0);
    end;
//    reMain.SelLength := 10;

//    reMain.Perform (EM_SCROLLCARET, 0, 0);
//*)
(*
    reMain.SelStart := reMain.SelStart + 1;
    reMain.SelLength := 10;

    reMain.SetFocus;
    grMain.SetFocus;
*)
    Key := 0;
    exit;
  end;

  if (Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_PRIOR, VK_NEXT, VK_HOME, VK_END]) then
    KeyUp := false;

end;

procedure TfMain.grMainKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_PRIOR, VK_NEXT, VK_HOME, VK_END])
     and (Shift<>[ssAlt])  then begin
    KeyUp := true;
    ShowMail;
  end;
end;

procedure TfMain.tmShowMailTimer(Sender: TObject);
begin
  tmShowMail.Enabled := false;
  ShowMail;
end;

//------------------------------------------------------------------------------
//                                                                  SetEditAttr
//------------------------------------------------------------------------------
procedure TfMain.SetEditAttr (FN: TFont);
begin { SetEditAttr }
  with reMain.Font{.SelAttributes} do begin
    Color := FN.Color;
    Style := FN.Style;
    Charset := FN.Charset;
    Name := FN.Name;
    Size := FN.Size;
  end;
end;  { SetEditAttr }


//------------------------------------------------------------------------------
//                                                                     ShowMail
//------------------------------------------------------------------------------
procedure TfMain.ShowMail;
var
  S: string;
  i: integer;
  TextSize: integer;
  Big: Boolean;

procedure SetRowSyntax (S: string);
var
  i, j, Max, First, Len: integer;
  F, S1: string;

begin
  // Nastaveni pocatecniho stylu
  S1 := TrimLeft(S);  // osekneme
  if ((S1 <> '') and ((S1[1] = '>') or (S1[1] = '|'))) then fnOld := fnQuote
  else fnOld := fnNormal;
  SetEditAttr (fnOld);

//  reMain.Lines.Add (S);
//  (* To co nasleduje je funkcni, ale POOOOOMAAAAALEEEE
  reMain.Lines.Add ('');

  repeat
    // Nastaveni First
    Max := Length (S)+1;
    Len := 0;
    First := Max;

    // First podle vyhledavacich retezcu
    if (fSettings.cbColorFindWords.Checked) then begin
      for i := 0 to fFindInText.memFindWords.Lines.Count-1 do begin
        F := ANSIUpperCase (fFindInText.memFindWords.Lines[i]);
        if (Length (F) = 0) then continue;

        j := Pos (F, ANSIUpperCase (S));
        if ((j > 0) and (j<First)) then begin
            { Nasel se blizsi vzorek }
            First := j;
            Len := length (F);
        end; {nalezene}
      end; {for}
    end;

    // First podle http a ftp
    j := Pos ('HTTP://', ANSIUpperCase(S));
    if (j = 0) then j := Max;

    i := Pos ('FTP://', ANSIUpperCase(S));
    if (i = 0) then i := Max;

    if (i<j) then j := i;

    // Bude to odkaz
    if (j <= First) then First := j;

    // Rozdelime retezec na 2 kusy
    // 1. beze zmeny
    // 2. zvyrazneny + zbytek
    S1 := Copy (S, 1, First-1);
    S := Copy (S, First, Length (S)-First+1);
    // Vypiseme S1
    SetEditAttr (fnOld);

    reMain.SelStart := Length(reMain.Text);
    reMain.SelLength := 0;
    ///reMain.SelText := S1;
    if S1 <> '' then
     reMain.Lines.Add(S1);

    if (First = Max) then Continue;

    // Zjistime delku retezce, pokud se jedna o odkaz
    // a nastavime atributy
    if (j = First) then begin
      i := Pos (' ', S);
      if i <> 0 then Len := i-1
      else Len := Length (S);
      SetEditAttr (fnHref);
    end else
      SetEditAttr (fnFind);

    // Rozdelime retezec na 2 kusy
    // 1. zvyrazneny
    // 2. zbytek
    S1 := Copy (S, 1, Len);
    S := Copy (S, Len+1, Length (S)-Len);
    // Vypiseme S1
    reMain.SelStart := Length(reMain.Text);
    reMain.SelLength := 0;
    ///reMain.SelText := S1;
    if S1 <> '' then
      reMain.Lines.Add(S1);
  until S='';
//    *)

end;

begin { ShowMail }
  if (not KeyUp) then exit;
  ///if (not Table.Active) then exit;
  if (not qrMain.Active) then exit;
  tmShowMail.Enabled := false;  // aby se to pak neprekreslilo


//--- Jednoduche, rychle reseni bez barvicek: ---
//  reMain.Text := Table.FieldByName('MAIL').AsString;
//  exit;
//-----------------------------------------------

  reMain.Lines.BeginUpdate;
  reMain.Lines.Clear;

  slSyntax.Text := {Table}qrMain.FieldByName('MAIL').AsString;
  TextSize := Length (slSyntax.Text);
  ShowSize (TextSize);
  Big := (TextSize > 20000);
  if (Big) then begin
    WaitCur;
    if fStopRead = nil then fStopRead := TfStopRead.Create(Self);
    fStopRead.Stopped := false;

    fStopRead.Show;
    fStopRead.Update;
    fStopRead.SetFocus;
    Application.ProcessMessages;
  end;

  for i := 0 to slSyntax.Count-1 do begin
    try
      S := slSyntax.Strings[i];
      SetRowSyntax (S);
  (*
      // Quotovani
      if ((S <> '') and (S[1] = '>')) then SetEditAttr (fnQuote)
      else SetEditAttr (fnNormal);

      // http a ftp
      j := Pos ('http://', S);
      if (j=0) then j := Pos ('ftp://', S);

      if (j <> 0) then begin
        S1 := Copy (S, 1, j-1);
        S := Copy (S, j, Length (S)-j+1);

        // retezec pred
        reMain.Lines.Add (S1);

        OldColor := reMain.SelAttributes.Color;
        reMain.SelAttributes.Color := clBlue;
        reMain.SelAttributes.Style := [fsUnderline];

        j := Pos (' ', S);
        if j <> 0 then begin
          S1 := Copy (S, 1, j-1);
          reMain.Lines.Add (S1);
          S := Copy (S, j, Length (S)-j+1);
          reMain.SelAttributes.Color := OldColor;
          reMain.SelAttributes.Style := [];
          reMain.Lines.Add (S);
        end else begin
          reMain.Lines.Add (S);
          reMain.SelAttributes.Color := OldColor;
          reMain.SelAttributes.Style := [];
        end;

      end else
        reMain.Lines.Add (S);
  *)
      if (Big) then begin
        if ((i mod 50) = 0) then Application.ProcessMessages;
        if (fStopRead.Stopped) then Break;
      end;
    except
    end;
  end;

  reMain.SelStart := 0;
  reMain.Lines.EndUpdate;
  if (Big) then begin
    DefCur;
    fStopRead.Hide;
  end;
end;  { ShowMail }

procedure TfMain.TableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if (IsInFoundArray (DataSet['ID'])) then Accept := true
  else Accept := false;
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//                               ACTION LIST
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
procedure TfMain.acOpenDBUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := true;
end;

procedure TfMain.acOpenDBExecute(Sender: TObject);
begin
  odOpen.InitialDir := ReadPathFromIni('DataPath');
  odOpen.Filter := 'Databáze (*.db)|*.db|Všechny soubory (*.*)|*.*';
  if odOpen.Execute then
  begin
    OpenDB (odOpen.FileName);
    WritePathToIni('DataPath', ExtractFileDir(odOpen.FileName));
  end;
end;

procedure TfMain.acNewUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := true;
end;

procedure TfMain.acNewExecute(Sender: TObject);
begin
  CloseDB;

  // Nova databaze - je treba vytvorit tabulku
  sdSave.InitialDir := ReadPathFromIni('DataPath');
  sdSave.Filter := 'Databáze (*.db)|*.db|Všechny soubory (*.*)|*.*';
  if sdSave.Execute then
  begin
    WritePathToIni('DataPath', ExtractFileDir(sdSave.FileName));
    CreateNewTable (ChangeFileExt (sdSave.FileName, '.db'));
  end;
end;

procedure TfMain.acAddFileUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;

procedure TfMain.acAddFileExecute(Sender: TObject);
begin
  AddFileToDB;
end;

procedure TfMain.acExitUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := true;
end;

procedure TfMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.acFindUpdate(Sender: TObject);
begin
 (Sender as TAction).Enabled := (TableName <> '');
end;



procedure TfMain.acFindExecute(Sender: TObject);
begin
  FindInDB;
end;

procedure TfMain.acFindNextInTextUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;


procedure TfMain.acFindNextInTextExecute(Sender: TObject);
begin
  if (fFindInText.memFindWords.Text = '') then
    acFindInText.Execute
  else
    FindInText;
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//                                                                 QuickSearch
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
procedure TfMain.acGoToMailNumUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');// and (GetIndexName = '');
end;

procedure TfMain.acGoToMailNumExecute(Sender: TObject);
begin
  if fGetNum = nil then fGetNum := TfGetNum.Create(Self);
  if (GetIndexName = '') then begin
    fGetNum.edNum.Tag := Records;
    if (fGetNum.ShowModal <> mrOK) then Exit;

    ///Table.FindNearest([StrToInt (fGetNum.edNum.Text)]);
  end else begin
    edQuickSearch.Text := '';
    pnQuickSearch.Visible := true;
    edQuickSearch.SetFocus;
  end;
end;

procedure TfMain.edQuickSearchExit(Sender: TObject);
begin
  pnQuickSearch.Visible := false;
end;

procedure TfMain.edQuickSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then begin
    grMain.SetFocus;
    pnQuickSearch.Visible := false;
    Key := 0;
  end;
end;


procedure TfMain.edQuickSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    grMain.SetFocus;
    pnQuickSearch.Visible := false;
    Key := #0;
  end;
end;

procedure TfMain.edQuickSearchChange(Sender: TObject);
begin
  // Vyhledame nejblizsi odpovidajici zaznam zaznam
  ///Table.FindNearest([edQuickSearch.Text]);
//  Table.Locate ('AUTOR', const KeyValues: Variant; Options: TLocateOptions): Boolean; virtual;
end;



//..............................................................................
//                                                                    acAlways
//..............................................................................
procedure TfMain.acAlways(Sender: TObject);
begin
  (Sender as TAction).Enabled := true;
end;

procedure TfMain.acNever(Sender: TObject);
begin
  (Sender as TAction).Enabled := false;
end;


procedure TfMain.acInfoExecute(Sender: TObject);
begin
  with TFAbout.Create(Self) do
  begin
    ShowModal;
    Release;
  end;
end;


procedure TfMain.acSortIDUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;


procedure TfMain.acSettingsExecute(Sender: TObject);
begin
  if fSettings.ShowModal = mrOK then
    WriteToINI;
  ShowMail;
end;

procedure TfMain.acSortIDExecute(Sender: TObject);
var
  i: integer;
begin
  // Trideni dle ID
  for i := 0 to grMain.Columns.Count-1 do begin
    if (ANSIUpperCase (grMain.Columns[i].FieldName) <> 'ID') then
      grMain.Columns[i].Title.Font.Style := []
    else
      grMain.Columns[i].Title.Font.Style := [fsBold];
  end;


  Info ('Uspořádávám zprávy podle názvu...');
  WaitCur;
  acSortSubject.Checked := false;
  (Sender as TAction).Checked := true;
  SelectData;
  DefCur;
  Info ('');
end;

procedure TfMain.acSortSubjectExecute(Sender: TObject);
var
  i: integer;
begin
  // Trideni dle Subjectu
  for i := 0 to grMain.Columns.Count-1 do begin
    if (ANSIUpperCase (grMain.Columns[i].FieldName) <> 'SUBJECT') then
      grMain.Columns[i].Title.Font.Style := []
    else
      grMain.Columns[i].Title.Font.Style := [fsBold];
  end;


  Info ('Uspořádávám zprávy podle názvu...');
  WaitCur;
  acSortID.Checked := false;
  (Sender as TAction).Checked := true;
  SelectData;
  DefCur;
  Info ('');
end;

procedure TfMain.acTableOpenUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;

procedure TfMain.acHeaderExecute(Sender: TObject);
begin
  SetHeader (not ((Sender as TAction).Checked));
end;

procedure TfMain.acToolBarExecute(Sender: TObject);
begin
  SetToolBar (not ((Sender as TAction).Checked));
end;

//------------------------------------------------------------------------------
//                                                                   SetToolBar
//------------------------------------------------------------------------------
procedure TfMain.SetToolBar (Vis: boolean);
begin { SetToolBar }
  acToolBar.Checked := Vis;
  pnTool.Visible := Vis;
end;  { SetToolBar }

//------------------------------------------------------------------------------
//                                                                 SetStatusBar
//------------------------------------------------------------------------------
procedure TfMain.SetStatusBar (Vis: boolean);
begin { SetStatusBar }
  acStatusBar.Checked := Vis;
  sbMain.Visible := Vis;
end;  { SetStatusBar }

//------------------------------------------------------------------------------
//                                                                    SetHeader
//------------------------------------------------------------------------------
procedure TfMain.SetHeader (Vis: boolean);
begin { SetHeader }
  acHeader.Checked := Vis;
  pnInfo.Visible := Vis;
end;  { SetHeader }


procedure TfMain.acStatusBarExecute(Sender: TObject);
begin
  SetStatusBar (not ((Sender as TAction).Checked));
end;

procedure TfMain.acIDExecute(Sender: TObject);
begin
  SetID (not ((Sender as TAction).Checked))
end;



procedure TfMain.acAutorExecute(Sender: TObject);
begin
  SetAutor (not ((Sender as TAction).Checked))
end;


procedure TfMain.acDateExecute(Sender: TObject);
begin
  SetDate (not ((Sender as TAction).Checked))
end;

//------------------------------------------------------------------------------
//                                                                        SetID
//------------------------------------------------------------------------------
procedure TfMain.SetID (Vis: Boolean);
var
  i: integer;
begin { SetID }
  acID.Checked := Vis;
  i := GetColumnIndex('ID');
  if not Vis then
    grMain.Columns[i].Width := 0
  else
    grMain.Columns[i].Width := 43;
end;  { SetID }

//------------------------------------------------------------------------------
//                                                                     SetAutor
//------------------------------------------------------------------------------
procedure TfMain.SetAutor (Vis: Boolean);
begin { SetAutor }
  acAutor.Checked := Vis;
  grMain.Columns[GetColumnIndex('AUTOR')].Visible := Vis;
end;  { SetAutor }

//------------------------------------------------------------------------------
//                                                                      SetDate
//------------------------------------------------------------------------------
procedure TfMain.SetDate (Vis: Boolean);
begin { SetDate }
  acDate.Checked := Vis;
  grMain.Columns[GetColumnIndex('DATUM')].Visible := Vis;
end;  { SetDate }

procedure TfMain.acShowAllExecute(Sender: TObject);
begin
  (Sender as TAction).Checked := true;
  acShowFound.Checked := false;
  Filtruj (acShowFound.Checked);
end;

procedure TfMain.acShowFoundExecute(Sender: TObject);
begin
  (Sender as TAction).Checked := true;
  acShowAll.Checked := false;
  Filtruj (acShowFound.Checked);
end;

procedure TfMain.acShowAllUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled :=
    (TableName <> '') and (FoundRecCount > 0);
end;

//..............................................................................
//                                                                   FormResize
//..............................................................................
procedure TfMain.FormResize(Sender: TObject);
begin
  // Resize
  sbMain.Panels[pInfo].Width :=
    sbMain.Width
    - sbMain.Panels[pStatus].Width
    - sbMain.Panels[pCount].Width
    - sbMain.Panels[pSize].Width
    - 20;
end;

//..............................................................................
//                                                                     ShowHint
//..............................................................................
procedure TfMain.ShowHint(Sender: TObject);
begin
  sbMain.Panels [pInfo].Text := Application.Hint;
end;


//------------------------------------------------------------------------------
//                                                              SetRecordsCount
//------------------------------------------------------------------------------
function TfMain.ShowRecordsCount;
var
  Rec: integer;
begin { ShowRecordsCount }
  if (acShowFound.Checked) then begin
    // Filtrovani
    Rec := FoundRecCount;
  end else begin
    // Vsechny
    ///if (Table.Active) then begin
    ///  Rec := Table.RecordCount;
    if (qrMain.Active) then begin
      Rec := qrMain.RecordCount;
    end else
      Rec := 0;
  end;

  sbMain.Panels[pCount].Text := IntToStr (Rec);
  Result := Rec;
end;  { ShowRecordsCount }

//------------------------------------------------------------------------------
//                                                                     ShowSize
//------------------------------------------------------------------------------
procedure TfMain.ShowSize (N: integer);
var
  S: string;
begin { ShowSize }
//  if (N<1023) then S := Format ('%d b',[N])
//  else
  S := Format ('%.1f KB',[N / 1024]);
  sbMain.Panels[pSize].Text := S;
end;  { ShowSize }

//------------------------------------------------------------------------------
//                                                                      WaitCur
//------------------------------------------------------------------------------
procedure TfMain.WaitCur;
begin { WaitCur }
  Screen.Cursor := crHourGlass;
end;  { WaitCur }

//------------------------------------------------------------------------------
//                                                                       DefCur
//------------------------------------------------------------------------------
procedure TfMain.DefCur;
begin { DefCur }
  Screen.Cursor := crArrow;
end;  { DefCur }


procedure TfMain.Button2Click(Sender: TObject);
begin
//  Table.GoToBookmark (Book);
//  if not Table.Locate ('ID', 1000, []) then ShowMessage ('Nenalezeno');
end;

{----------------------------------------------------------------ReadFromINI---}
procedure TfMain.ReadFromINI;
var
  IniFile: TIniFile;
  Status, Count, i: Integer;
  S: string;
  SortID: Boolean;

begin { ReadFromINI }

  IniFile := TIniFile.Create (IniFileName);
  with IniFile do begin


    {-----------------------------}
    { Stav, velikost a souradnice }
    {-----------------------------}

    Status := ReadInteger ('Main Window','Status', 0);
    {Status = 0 <=> Neexistuje soubor.ini}
    {Status <>0 <=> Vse je OK}
    if Status <> 0 then
      begin
        { Souradnice a velikost hlavniho okna }
        Top := ReadInteger ('Main Window','Top', Top);
        Left := ReadInteger ('Main Window','Left', Left);
        Width := ReadInteger ('Main Window','Width', Width);
        Height := ReadInteger ('Main Window','Height', Height);
        case Status of
          1: WindowState := wsNormal;
          3: WindowState := wsMaximized;
        end; {case}
      end;

    {-----------------------------}
    { Nastaveni - Co zobrazovat   }
    {-----------------------------}

    SetToolBar (ReadBool ('View', 'ToolBar', true));
    SetStatusBar (ReadBool ('View', 'StatusBar', true));
    SetHeader (ReadBool ('View', 'Info', true));
    grMain.Width := ReadInteger ('View', 'Splitter', 240);

    // ID, Autor, Date
    SetID (ReadBool ('View', 'ID', true));
    SetAutor (ReadBool ('View', 'Autor', true));
    SetDate (ReadBool ('View', 'datum', true));
    for i := 0 to grMain.Columns.Count-1 do begin
      grMain.Columns[i].Width := ReadInteger ('View', grMain.Columns[i].FieldName+'_Width',
                                 grMain.Columns[i].Width);
    end;

    {-----------------------------}
    { Historie hledani            }
    {-----------------------------}
    (*
    Count := ReadInteger ('Find History', 'Find Count', 0);
    for i := 0 to Count-1 do begin
      fFind.cbFindWord.Items.Add (ReadString ('Find History', IntToStr (i+1), ''));
    end;
    *)

    {-----------------------------}
    { Nastaveni koncu zprav a RE  }
    {-----------------------------}

    Count := ReadInteger ('Settings', 'RE Count', 0);
    fSettings.lbRE.Items.Clear;
    if (Count = 0) then begin
       fSettings.SetDefaultRe;
    end else
      for i := 0 to Count-1 do begin
        S := OdUvozovkuj (IniFile.ReadString ('Settings', 'RE_' + IntToStr (i), ''));
        if (S = '') then Continue;
        { Je to nejaky retezec --> pokusime se jej pridat do list boxu}
        if (fSettings.lbRE.Items.IndexOf(S) = -1) then
          fSettings.lbRE.Items.Add (S);
      end;


    fSettings.lbEOM.Items.Clear;
    Count := ReadInteger ('Settings', 'EOM Count', 0);

    if (Count = 0) then begin
       fSettings.SetDefaultEOM;
    end else
    for i := 0 to Count-1 do begin
      S := OdUvozovkuj (IniFile.ReadString ('Settings', 'EOM_' + IntToStr (i), ''));
      if (S = '') then Continue;
      { Je to nejaky retezec --> pokusime se jej pridat do list boxu}
      if (fSettings.lbEOM.Items.IndexOf(S) = -1) then
        fSettings.lbEOM.Items.Add (S);
    end;

    fSettings.cbFindInNext.Checked := ReadBool ('Settings', 'FindInNext', false);

    //LoadBookmarksFromFile (IniFile, 'Bookmarks', 'Book', pmBookmark);

    // Sekce mejlu
    fSettings.edFrom.Text := ReadString ('Settings', 'SecFrom', 'From:');
    fSettings.edDate.Text := ReadString ('Settings', 'SecDate', 'Date:');
    fSettings.edSubj.Text := ReadString ('Settings', 'SecSubj', 'Subject:');

    {---------}
    { Fontici }
    {---------}
    LoadFont (fSettings.btNormal.Font, IniFile, 'Fonts', 'Normal');
    LoadFont (fSettings.btQuote.Font, IniFile, 'Fonts', 'Quote');
    LoadFont (fSettings.btHref.Font, IniFile, 'Fonts', 'Href');
    LoadFont (fSettings.btFind.Font, IniFile, 'Fonts', 'Find');

    {-----------------------------}
    { Nastaveni - Dalsi nastaveni }
    {-----------------------------}
    // --- Dle ceho sortit
    SortID := ReadBool ('Settings', 'SortByID', true);
    acSortID.Checked := SortID;
    acSortSubject.Checked := not SortID;

    fSettings.cbSaveAttach.Checked := ReadBool ('Settings', 'SaveAttach', false);
    fSettings.edAttach.Text := ReadString ('Settings', 'AttachDir', '');
    fSettings.cbColorFindWords.Checked := ReadBool ('Settings', 'ColorFindWords', true);

    {-----------------------------}
    {  Posledne oteverne soubory  }
    {-----------------------------}
    for i := sfMaxCount downto 1 do begin
      S := ReadString ('Files', IntToStr (i), '');
      if (S <> '') then AddFileToMenu (S);
    end;
  end; {with}

  IniFile.Free;

end;  { ReadFromINI }

{-----------------------------------------------------------------WriteToINI---}
procedure TfMain.WriteToINI;
var
  IniFile: TIniFile;
  Status, i, First, Last: integer;
  S: string;

begin { WriteToINI }
  IniFile := TIniFile.Create (IniFileName);
  try
    with IniFile do begin

      {-----------------------------}
      { Stav, velikost a souradnice }
      {-----------------------------}
      Status := 1;
      case WindowState of
        wsNormal, wsMinimized:
          begin
            Status := 1;
            WriteInteger ('Main Window','Top', Top);
            WriteInteger ('Main Window','Left', Left);
            WriteInteger ('Main Window','Width', Width);
            WriteInteger ('Main Window','Height', Height);
          end;
        wsMaximized: Status := 3;
      end; {case}
      WriteInteger ('Main Window','Status', Status);

      {-----------------------------}
      { Nastaveni - Co zobrazovat   }
      {-----------------------------}

      WriteBool ('View', 'ToolBar', tbMain.Visible);
      WriteBool ('View', 'StatusBar', sbMain.Visible);
      WriteBool ('View', 'Info', pnInfo.Visible);
      WriteInteger ('View', 'Splitter', Splitter.Left);
      // ID, Autor, Datum
      for i := 0 to grMain.Columns.Count-1 do begin
        // Visibility
        WriteBool ('View', grMain.Columns[i].FieldName,
                                   grMain.Columns[i].Visible);
        // Size
        Writeinteger ('View', grMain.Columns[i].FieldName+'_Width',
                                   grMain.Columns[i].Width);
      end;


      {-----------------------------}
      { Historie hledani            }
      {-----------------------------}
      (*
      Count := fFind.cbFindWord.Items.Count;
      WriteInteger ('Find History', 'Find Count', Count);
      for i := 0 to Count-1 do begin
        WriteString ('Find History', IntToStr (i+1),
                              fFind.cbFindWord.Items[i]);
      end;
      *)

      {-----------------------------}
      { Nastaveni koncu zprav a RE  }
      {-----------------------------}

      WriteInteger ('Settings', 'RE Count', fSettings.lbRE.Items.Count);
      for i := 0 to fSettings.lbRE.Items.Count-1 do begin
        WriteString ('Settings', 'RE_' + IntToStr (i),
          ZaUvozovkuj (fSettings.lbRE.Items[i]));
      end;

      WriteInteger ('Settings', 'EOM Count', fSettings.lbEOM.Items.Count);
      for i := 0 to fSettings.lbEOM.Items.Count-1 do begin
        WriteString ('Settings', 'EOM_' + IntToStr (i),
          ZaUvozovkuj (fSettings.lbEOM.Items[i]));
      end;


      // Sekce mejlu
      WriteString ('Settings', 'SecFrom', fSettings.edFrom.Text);
      WriteString ('Settings', 'SecDate', fSettings.edDate.Text);
      WriteString ('Settings', 'SecSubj', fSettings.edSubj.Text);


      WriteBool ('Settings', 'FindInNext', fSettings.cbFindInNext.Checked);

      //SaveBookmarksToFile (IniFile, 'Bookmarks', 'Book', pmBookmark);

      {---------}
      { Fontici }
      {---------}
      SaveFont (fSettings.btNormal.Font, IniFile, 'Fonts', 'Normal');
      SaveFont (fSettings.btQuote.Font, IniFile, 'Fonts', 'Quote');
      SaveFont (fSettings.btHref.Font, IniFile, 'Fonts', 'Href');
      SaveFont (fSettings.btFind.Font, IniFile, 'Fonts', 'Find');


      {-----------------------------}
      { Nastaveni - Dalsi nastaveni }
      {-----------------------------}
      // --- Dle ceho sortit
      WriteBool ('Settings', 'SortByID', acSortID.Checked);

      WriteBool ('Settings', 'SaveAttach', fSettings.cbSaveAttach.Checked);
      WriteBool ('Settings', 'ColorFindWords', fSettings.cbColorFindWords.Checked);
      WriteString ('Settings', 'AttachDir', fSettings.edAttach.Text);

      {-----------------------------}
      {  Posledne oteverne soubory  }
      {-----------------------------}
      First := mSoubor.IndexOf (miFileSeparator1)+1;
      Last := mSoubor.IndexOf (miFileSeparator2)-1;
      for i := First to Last do
        WriteString ('Files', IntToStr (i-First+1), mSoubor.Items[i].Hint);

      {-----------------------------}
      {  Ulozeni nastaveni do DBini }
      {-----------------------------}
      WriteToDBIni;
    end; // With
    {...No a jeste za sebou uklidime....}
    IniFile.UpdateFile;
  except
    MessageDlg ('Nepodařilo se uložit soubor s konfigurací '#13 + IniFileName, mtError, [mbOK], 0);
  end;
  IniFile.Free;
end;  { WriteToINI }

//------------------------------------------------------------------------------
//                                                                 WriteToDBIni
//------------------------------------------------------------------------------
procedure TfMain.WriteToDBIni;
var
  IniFile: TIniFile;
  i, Count: integer;
  DBIniName : string;


begin { WriteToINI }
  if (TableName = '') then exit;
//  DBIniName := ExtractFilePath (IniFileName) + TableName;
  ///DBIniName := IncludeTrailingBackslash(ExtractFilePath(DatabaseName)) + TableName;
  DBIniName := DatabaseName;
  DBIniName := ChangeFileExt (DBIniName, '.ini');

  IniFile := TIniFile.Create (DBIniName);
  try
    with IniFile do begin
      // Zapisovani...
      {-----------------------------}
      { Historie hledani            }
      {-----------------------------}

      Count := fFind.cbFindWord.Items.Count;
      WriteInteger ('Find History', 'Find Count', Count);
      for i := 0 to Count-1 do begin
        WriteString ('Find History', IntToStr (i+1),
                              fFind.cbFindWord.Items[i]);
      end;

      {-----------------}
      {    Bookmarky    }
      {-----------------}
      SaveBookmarksToFile (IniFile, 'Bookmarks', 'Book', pmBookmark);


      {-----------------------------}
      { Komentare k vlozenym datum  }
      {-----------------------------}
      Count := fDBInfo.reComment.Lines.Count;
      WriteInteger ('DB Comments', 'Comments Count', Count);
      for i := 0 to Count-1 do begin
        WriteString ('DB Comments', IntToStr (i+1), fDBInfo.reComment.Lines[i]);
      end;

    end;
    {...No a jeste za sebou uklidime....}
    IniFile.UpdateFile;
  except
    MessageDlg ('Nepodařilo se uložit soubor s konfigurací '#13 + DBIniName, mtError, [mbOK], 0);
  end;
  IniFile.Free;
end;  {WriteToDBIni}

//------------------------------------------------------------------------------
//                                                                ReadFromDBIni
//------------------------------------------------------------------------------
procedure TfMain.ReadFromDBIni;
var
  IniFile: TIniFile;
  i, Count: integer;
  DBIniName : string;

begin { ReadFromDBINI }
  ///DBIniName := IncludeTrailingBackslash(DatabaseName) + TableName;
  DBIniName := DatabaseName;
//  DBIniName := ExtractFilePath (IniFileName) + TableName;
  DBIniName := ChangeFileExt (DBIniName, '.ini');

  IniFile := TIniFile.Create (DBIniName);
  with IniFile do begin
    // Nacteni...
    {-----------------------------}
    { Historie hledani            }
    {-----------------------------}
    fFind.cbFindWord.Items.Clear;
    Count := ReadInteger ('Find History', 'Find Count', 0);
    for i := 0 to Count-1 do begin
      fFind.cbFindWord.Items.Add (ReadString ('Find History', IntToStr (i+1), ''));
    end;

    LoadBookmarksFromFile (IniFile, 'Bookmarks', 'Book', pmBookmark);


    {-----------------------------}
    { Komentare k vlozenym datum  }
    {-----------------------------}
    fDBInfo.reComment.Lines.Clear;
    Count := ReadInteger ('DB Comments', 'Comments Count', 0);
    for i := 0 to Count-1 do begin
      fDBInfo.reComment.Lines.Add (ReadString ('DB Comments', IntToStr (i+1), ''));
    end;
  end;
  {...No a jeste za sebou uklidime....}
  IniFile.Free;
end;  {ReadFromDBIni}


procedure TfMain.acAddBookmarkExecute(Sender: TObject);
var
  S: string;
begin
  // Pridani zalozky
  if fNewBookmark = nil then fNewBookmark := TfNewBookmark.Create(Self);
  fNewBookmark.edNazev.Text := Table.FieldByName ('Subject').AsString;
  S := NewBookmark.GetString ('Nová záložka', 'Název nové záložky:');
  if (S = '') then exit;

  AddBookItem (S+'|'+IntToStr (Table.FieldByName ('ID').AsInteger));
(*
  NewMenuItem := TMenuItem.Create (miBookmark);
  NewMenuItem.Caption := fNewBookmark.edNazev.Text;
  NewMenuItem.OnClick := miBookClick;
  NewMenuItem.Tag := Table.FieldByName ('ID').AsInteger;
  NewMenuItem.Hint := Format ('Skok na záloku "%s" (%d)',
    [NewMenuItem.Caption, NewMenuItem.Tag]);
*)

//  miBookmark.Insert (0, NewMenuItem);
end;

//..............................................................................
//                                                                  miBookClick
//..............................................................................
procedure TfMain.miBookClick (Sender: TObject);
begin { miBookClick }
  if not Table.Locate ('ID', (Sender as TMenuItem).Tag, []) then
    ShowMessage ('Záložka nebyla nalezena!');
end;  { miBookClick }


procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = [ssCtrl]) and (Key = $44)) then begin

    ///SendMessage (Handle, WM_MENUSELECT, 4+256*MF_POPUP, miBookmark.Handle);
//    SendMessage (Hwnd (Handle), WM_MENUCHAR, Ord('l')+256*(MF_POPUP), HMenu (miBookmark.Handle));
  end;
end;

procedure TfMain.miBookmarkClick(Sender: TObject);
var
  P: TPoint;
begin
//  miSeparator.Visible := (miBookmark.Count > 3);
//  if (GetWindowRect (miBookmark.Handle, Rect)) then ShowMessage ('OK');
  P := Point (grMain.Left, grMain.Top);
  P := Self.ClientToScreen (P);
  P := Point (grMain.Left, grMain.Top);
  P := Self.ClientToScreen (P);

//  ShowMessage (IntToStr (P.X) + ', ' + IntToStr (P.Y));
  pmBookmark.PopUp (P.X, P.Y);
end;

procedure TfMain.acBookmarkSettingExecute(Sender: TObject);
begin
  if fEditMenuBook = nil then fEditMenuBook := TfEditMenuBook.Create(Self);
  fEditMenuBook.ShowModal;
end;

procedure TfMain.acCopyUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (reMain.SelLength > 0);
end;

procedure TfMain.acCopyExecute(Sender: TObject);
begin
  reMain.CopyToClipboard;
end;

procedure TfMain.acSelectAllUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (Length (reMain.Text) > 0);
end;

procedure TfMain.acSelectAllExecute(Sender: TObject);
begin
  reMain.SelectAll;
end;

procedure TfMain.acPrintUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (Length (reMain.Text) > 0);
end;

procedure TfMain.acPrintExecute(Sender: TObject);
var
  PrnFile: TextFile;
  i: integer;
begin
  // Tisk prispevku
  if (not InitPrint (PrnFile)) then exit;

  for i := 0 to reMain.Lines.Count-1 do begin
    if (not PrintLine  (reMain.Lines [i], PrnFile)) then exit;
  end;

  CloseFile (PrnFile);
end;

procedure TfMain.acSaveToINIExecute(Sender: TObject);
begin
  try
    WriteToIni;
  except
    on E:Exception do begin
       Application.ShowException(E);
       Application.Terminate;
    end;
  end;
end;

procedure TfMain.miCopyClipClick(Sender: TObject);
begin
  ClipBoard.AsText := CopyText;
end;


procedure TfMain.lSubjectMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if not Table.Active then Exit; 
  if (Button = mbRight) then begin
    if (Sender is TDBText) then
      CopyText := Table.FieldByName (TDBText(Sender).DataField).AsString
    else
      ///if (Sender is TRichEdit) then
      ///  CopyText := TRichEdit (Sender).SelText;

    P.X := X; P.Y := Y;
    P := TControl (Sender).ClientToScreen (P);
    pmCopy.PopUp (P.X, P.Y);
  end;
end;

//------------------------------------------------------------------------------
//                                                                SetAttributes
//------------------------------------------------------------------------------
procedure TfMain.SetAttributes;
begin { SetAttributes }
  fnNormal := fSettings.btNormal.Font;
  fnQuote  := fSettings.btQuote.Font;
  fnHref   := fSettings.btHref.Font;
  fnFind   := fSettings.btFind.Font;
  fnOld    := fnNormal;
end;  { SetAttributes }

procedure TfMain.FormDestroy(Sender: TObject);
begin
  slFind.Free;
  slSyntax.Free;

  daFound := nil;
  daPomFound := nil;

  ClipBoard.Free;
end;


procedure TfMain.acBookmarksExecute(Sender: TObject);
var
  P: TPoint;
begin
  P := Point (grMain.Left, grMain.Top);
  P := Self.ClientToScreen (P);
  P := Point (grMain.Left, grMain.Top);
  P := Self.ClientToScreen (P);
  pmBookmark.PopUp (P.X, P.Y);
end;


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//
//          Zalozky
//
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//                                                                     FindItem
//------------------------------------------------------------------------------
function TfMain.FindItem (MI: TComponent; S: string): TMenuItem;
var
  i: integer;
begin { FindItem }
  if (MI is TMenuItem) then begin
    for i := 0 to TMenuItem (MI).Count-1 do
      if (ANSIUpperCase (TMenuItem (MI).Items[i].Caption) = UpperCase (S)) then begin
        Result := TMenuItem (MI).Items[i];
        Exit;
      end;
  end else begin
    for i := 0 to TPopUpMenu (MI).Items.Count-1 do
      if (ANSIUpperCase (TPopUpMenu (MI).Items[i].Caption) = UpperCase (S)) then begin
        Result := TPopUpMenu (MI).Items[i];
        Exit;
      end;
  end;

  Result := nil;
end;  { FindItem }


//------------------------------------------------------------------------------
//                                                                  AddBookItem
//------------------------------------------------------------------------------
procedure TfMain.AddBookItem (S: string);
const
  cMenuSep = '|';
var
  MM, M: TMenuItem;
  l, i, TT: integer;
  NewMenuItem: TMenuItem;
  S1: string;
begin { AddBookItem }

  i := Pos (cMenuSep, S);
  l := 0;
  M := nil;
  NewMenuItem := nil;

//  M := pm
  while (i <> 0) do begin
    S1 := Copy (S, 1, i-1);
    S := Copy (S, i+1, Length (S) - i);

    if (l = 0) then
      MM := FindItem (pmBookmark, S1)
    else
      MM := FindItem (M, S1);

    if (MM = nil) then begin
      // Vetev neexistuje - vytvorime novou
      NewMenuItem := TMenuItem.Create (pmBookmark);
      NewMenuItem.Caption := S1;
      NewMenuItem.ImageIndex := 15;      
      if (l = 0) then
        pmBookmark.Items.Add (NewMenuItem)
      else
        M.Add (NewMenuItem);

      M := NewMenuItem;
    end else begin
      // Vetev existuje - prejdeme do ni
      M := MM;
    end;

    inc (l);

    i := Pos (cMenuSep, S);
  end;
  try
    TT := StrToInt (S);
  except
    On EConvertError do TT := 0;
  end;

  if (NewMenuItem <> nil) then begin
    NewMenuItem.Tag := TT;
    NewMenuItem.OnClick := miBookClick;
    NewMenuItem.ImageIndex := 14;
  end;

end;  { AddBookItem }

//------------------------------------------------------------------------------
//                                                          SaveBookmarksToFile
//------------------------------------------------------------------------------
procedure TfMain.SaveBookmarksToFile (IniFile: TIniFile; Sec, Name: string; PM: TPopUpMenu);
var
  Total: integer;
  j: integer;
  S: string;

procedure SaveMenuItem (Item: TMenuItem; S: string);
var
  i: integer;
begin
  if (S <> '') then S := S + '|';
  S := S + Item.Caption;

  // Zjisti, zda je koncova polozka
  if (Item.Count = 0) then begin
    S := S + '|' + IntToStr (Item.Tag);
    IniFile.WriteString (Sec, Name+'_'+IntToStr (Total), S);
    inc (Total);
    Exit;
  end;

  // Neni to koncova - for cyklus
  for i := 0 to Item.Count -1 do
    SaveMenuItem (Item.Items[i], S);
end;

begin { SaveBookmarksToFile }
  // Ulozeni popup menu do souboru
  Total := 0;
  for j := 3 to PM.Items.Count-1 do begin
    SaveMenuItem (PM.Items[j], S);
  end;
  IniFile.WriteInteger (Sec, Name+'_Count', Total);
end;  { SaveBookmarksToFile }

//------------------------------------------------------------------------------
//                                                        LoadBookmarksFromFile
//------------------------------------------------------------------------------
procedure TfMain.LoadBookmarksFromFile (IniFile: TIniFile; Sec, Name: string; PM: TPopUpMenu);
var
  Total: integer;
  j: integer;
  S: string;
begin { LoadBookmarksFromFile }
  ClearBookmarks;
  Total := IniFile.ReadInteger (Sec, Name+'_Count', 0);
  for j := 0 to Total-1 do begin
    S := IniFile.ReadString (Sec, Name+'_'+IntToStr (j), '');
    if (S = '') then Continue;
    fMain.AddBookItem (S);
  end;
end;  { LoadBookmarksFromFile }

//------------------------------------------------------------------------------
//                                                               ClearBookmarks
//------------------------------------------------------------------------------
procedure TfMain.ClearBookmarks;
var
  j: integer;
begin { ClearBookmarks }
  for j := 3 to fMain.pmBookmark.Items.Count-1 do
    fMain.pmBookmark.Items.Delete (3);//pmBookmark.Clear;
end;  { ClearBookmarks }

(*
procedure TfMain.Button3Click(Sender: TObject);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create (ChangeFileExt (Application.ExeName, '.ini'));
  LoadBokmarksFromFile (IniFile, 'Menu', 'Delphi', pmBookmark);
  IniFile.Free;
end;

procedure TfMain.Button4Click(Sender: TObject);
begin
  fEditMenuBook.ShowModal;
end;


procedure TfMain.Button2Click(Sender: TObject);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create (ChangeFileExt (Application.ExeName, '.ini'));
  SaveBokmarksToFile (IniFile, 'Menu', 'Delphi', pmBookmark);
  IniFile.Free;
end;

*)


procedure TfMain.acWordWrapExecute(Sender: TObject);
begin
  TAction (Sender).Checked := not (TAction (Sender).Checked);
  reMain.WordWrap := TAction (Sender).Checked;
end;

//------------------------------------------------------------------------------
//                                                                AddFileToMenu
//------------------------------------------------------------------------------
procedure TfMain.AddFileToMenu (FileName: string);
var
  NewMI, MI: TMenuItem;
  First, Last, i: integer;
  S: string;

begin {AddFileToMenu}
  // Je to pridani --> zobrazime linku
//  miFileSeparator2.Visible := true;

  // Projedu Menu mSoubor od miFileSeparator1 do miFileSeparator1 a kouknu se,
  // zda tam takovato polozka je, nebo ne.
  First := mSoubor.IndexOf (miFileSeparator1)+1;
  Last := mSoubor.IndexOf (miFileSeparator2)-1;
  NewMI := nil;

  for i := First to Last do begin
    MI := mSoubor.Items[i];
    if (ANSIUpperCase (Copy (MI.Caption, sfPrefixLen+1, Length (MI.Caption)-sfPrefixLen)) =
        ANSIUpperCase (FileName)) then
    begin
      // Prehozeni tohoto s prvnim
      if (i = First) then exit; // je na prvnim miste --> nemam co resit
      NewMI := mSoubor.Items[i];
      mSoubor.Delete (i);
      Break;
    end;
  end;

  if (NewMI = nil) then begin
    // Nenalezeno --> Vytvorim novou polozku
    NewMI := TMenuItem.Create (Self);
    NewMI.Caption := MinimizeName(FileName, mSoubor.Bitmap.Canvas, 250);
    NewMI.Hint := FileName;
  end;
  NewMI.OnClick := miOldFileClick;

  // Pridame polozku na prvni misto
  mSoubor.Insert (First, NewMI);

  // A jeste precisluje nazvy a dodelame hotkeye
  First := mSoubor.IndexOf (miFileSeparator1)+1;
  Last := mSoubor.IndexOf (miFileSeparator2)-1;
  for i := First to Last do begin
    NewMI := mSoubor.Items[i];
    S := NewMI.Caption;
    if (S <> '') then
      if (S[1] = '&') then S := Copy (S, sfPrefixLen+1, Length (S)-sfPrefixLen);

    S := '&' + IntToStr(i-First+1) + '  ' + S;
    NewMI.Caption := S;
  end;


  if (Last-First >= sfMaxCount) then begin
    // Je jich tam moc -- promazeme to
    for i := sfmaxCount+1 to Last-First+1 do begin
      mSoubor.Delete (First+sfmaxCount);
    end;
  end
end;  {AddFileToMenu}

procedure TfMain.miOldFileClick(Sender: TObject);
begin
 OpenDB (TMenuItem (Sender).Hint);
end;

procedure TfMain.reMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  P: TPoint;
  Poz, Row, Col, Start, i: integer;
  S: string;
begin
  P.X := X;
  P.Y := Y;
  ///Poz := reMain.Perform (EM_CHARFROMPOS,0, longint (@P));
  // Dostanu pozici v textu
  // Prevedu to na radek a sloupec
  ///Row := reMain.Perform (EM_LINEFROMCHAR,Poz,0);
  ///Col  := Poz - reMain.Perform (EM_LINEINDEX, Row, 0) + 1;

  // Vytahnu prislusnej radek
  S := reMain.Lines[Row];
  if (Col > Length (S)) then begin
    Screen.Cursor := crArrow;
    CursorURL := '';
    exit;
  end;

  // Ted zjistim, zda stojim nad odkazem
  // Polezu doleva na nejblizsi mezeru
  Start := 1;
  for i := Col downto 1 do begin
    if (S[i] = ' ') or (S[i] = #9) then begin
      if (i=Col) then Start := i
      else Start := i+1;
      break;
    end
  end;

  // Zapamatuju si adresu (pro pripadnej skok)
  S := Copy (S, Start, Length(S) - Start +1);
  CursorURL := S;
  S := ANSIUpperCase (S);
  if (Pos ('FTP://', S) = 1) or (Pos ('HTTP://', S) = 1) then begin
    // Nastavim kurzor a adresu
    Screen.Cursor := crHandPoint;
  end else begin
    // Nastavim kurzor a adresu
    Screen.Cursor := crArrow;
    CursorURL := '';
  end;

end;

procedure TfMain.reMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then begin
    if ((Now - DBClickTime) < defDBClickTime) then
      if (CursorURL<>'') then begin
        reMain.SelLength := 0;
        acGoToURL.Execute;
      end;
    DBClickTime := Now;
  end;

end;

procedure TfMain.acGoToURLExecute(Sender: TObject);
var
  i: integer;
begin
  i := Pos (' ', CursorURL);
  if (i > 0) then
    CursorURL := Copy (CursorURL, 1, i-1);

//  ShowMessage ('--'+CursorURL+'--');
  ///if ( OpenDocument(PChar(CursorURL)) { *Převedeno z ShellExecute* } in [0,ERROR_FILE_NOT_FOUND,ERROR_PATH_NOT_FOUND,ERROR_BAD_FORMAT,
  ///    SE_ERR_ACCESSDENIED,SE_ERR_ASSOCINCOMPLETE,SE_ERR_DDEBUSY,SE_ERR_DDEFAIL,
  ///    SE_ERR_DDETIMEOUT,SE_ERR_DLLNOTFOUND,SE_ERR_FNF,SE_ERR_NOASSOC,SE_ERR_OOM,
  ///    SE_ERR_PNF,SE_ERR_SHARE]) then
    ShowMessage ('Nepodarilo se spustit prohlizec');
end;

procedure TfMain.acGoToURLUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (CursorURL <> '');
  (Sender as TAction).Visible := (CursorURL <> '');
end;



procedure TfMain.acCopyURLExecute(Sender: TObject);
var
  i: integer;
begin
  i := Pos (' ', CursorURL);
  if (i > 0) then
    CursorURL := Copy (CursorURL, 1, i-1);
  ClipBoard.AsText := CursorURL;
end;

procedure TfMain.acDBInfoExecute(Sender: TObject);
begin
  fDBInfo.ShowModal;
end;

procedure TfMain.acDBInfoUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;

function TfMain.TotalRecords (DBName, TBName: string): longint;
begin
  with qrPom do
  begin
    Close;
    DatabaseName := DBName;
    conDatabase.DatabaseName:= DBName;
    if not conDatabase.Connected then
      conDatabase.Connected := True;
    DataBase:=conDatabase;

    //Sql.Clear;
//    Sql.Add (Format ('Select ID from "%s"',[TBName]));
    Sql.Text := Format ('Select Count(*) as RC from "%s"',[TBName]);
    Open;
    Result := FieldByName('RC').AsInteger;
    Close;
  end; // with
end;

procedure TfMain.AddDBComment (Section,S: string);
var
  Pom: string;
begin
  // Kdybych to chtel nekdy barvit
  with fDBInfo.reComment do begin
    if (Section = '-') then
      Pom := '------------------------------------------------------'
    else if (Section = '') then
      Pom := S
    else
      Pom := Format ('%-25s %s',[Section+':', S]);

    Lines.Add (Pom);
  end;
end;

procedure TfMain.LastMailInDB (var ID: longint; var S: string);
begin
  with qrPom do begin
    DatabaseName := fMain.DatabaseName;

    Close;
    Sql.Clear;
    Sql.Add (Format (
      'select ID, AUTOR, SUBJECT from "%s" where id=(select max (id) from "%0:s")',
     [TableName]));
    Open;
    if (RecordCount > 0) then begin
      ID := FieldByName ('ID').AsInteger;
      S  := FieldByName ('SUBJECT').AsString + ' [' +
            FieldByName ('AUTOR').AsString + ']';
    end else begin
      ID := 0;
      S := '';
    end;
    Close;
  end; // with
end;

procedure TfMain.acSaveFilterExecute(Sender: TObject);
var
  FF: File of integer;
  i: integer;
  FileName: string;
begin
  sdSave.InitialDir := ReadPathFromIni('Selection');
  sdSave.Filter := 'Výběry (*.sel)|*.sel|Všechny soubory (*.*)|*.*';
  if sdSave.Execute then begin
    WritePathToIni('Selection', ExtractFileDir(sdSave.FileName));
    FileName := sdSave.FileName;
    if (ExtractFileExt (FileName) = '') then
      FileName := FileName + '.sel';

    AssignFile (FF, FileName);
    try
      Rewrite (FF);
      for i := 0 to FoundRecCount-1 do
        Write (FF, daFound[i]);
      CloseFile (FF);
    except
      ShowMessage ('Nepodařilo se uložit výběr');
    end; // try
  end;
end;

procedure TfMain.acLoadFilterExecute(Sender: TObject);
var
  FF: File of integer;
  ID: integer;
begin
  odOpen.InitialDir := ReadPathFromIni('Selection');
  odOpen.Filter := 'Výběry (*.sel)|*.sel|Všechny soubory (*.*)|*.*';
  if (odOpen.Execute) then
  begin
    WritePathToIni('Selection', ExtractFileDir(odOpen.FileName));
    Filtruj (false);
    AssignFile (FF, odOpen.FileName);
    try
      ClearArray (daFound, FoundRecCount);
      FoundRecCount := 0;

      Reset (FF);
      while not Eof(FF) do begin
        Read (FF, ID);
        if (FoundRecCount >= Length (daFound)) then
          SetLength (daFound, Length (daFound) + 100);
        daFound[FoundRecCount] := ID;
        inc (FoundRecCount);
      end;
      CloseFile (FF);
    except
      ShowMessage ('Nepodařilo se načíst výběr');
    end; // try
    Filtruj (true);
  end;
end;

procedure TfMain.acSaveFilterUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (FoundRecCount > 0) and (TableName <> '');
end;

procedure TfMain.acLoadFilterUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;

procedure TfMain.acBookmarksUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (TableName <> '');
end;

procedure TfMain.grMainKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    reMain.SetFocus;
    Key := #0;
  end;
end;

procedure TfMain.reMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP) and (Shift = [ssAlt]) then begin
    if Table.BOF then exit;
    Table.Prior;
    reMain.SelStart := 0;
  end;

  if (Key = VK_DOWN) and (Shift = [ssAlt]) then begin
    if Table.EOF then exit;
    Table.Next;
    reMain.SelStart := 0;
  end;
end;

procedure TfMain.acFindInTextExecute(Sender: TObject);
begin
  // Zobrazeni dialogu
  if fFindInText.ShowModal = mrOK then begin
    if (fFindInText.memFindWords.Lines.Count > 0) then
      acFindNextInText.Execute
    else
      ShowMessage ('Nebylo zadáno žádné slovo!');
  end;
  ShowMail;
end;

{-----------------------------------------------------------------
  Read path for OpenDialog from IniFile
------------------------------------------------------------------}
function TfMain.ReadPathFromIni(const PathName: string): string;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create (IniFileName);
  try
    Result := IniFile.ReadString('Path', PathName, ExtractFileDir(Application.ExeName));
  finally
    IniFile.Free;
  end;
end;

{-----------------------------------------------------------------
  Write path for OpenDialog to IniFile
------------------------------------------------------------------}
procedure TfMain.WritePathToIni(const PathName: string; const Path: string);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create (IniFileName);
  try
    IniFile.WriteString('Path', PathName, Path);
    IniFile.UpdateFile;
  except
    MessageDlg ('Nepodařilo uložit soubor s konfigurací '#13 + IniFileName, mtError, [mbOK], 0);
  end;
  IniFile.Free;
end;

{-----------------------------------------------------------------
  Update akce pro zobrazeni ID
------------------------------------------------------------------}
procedure TfMain.acIDUpdate(Sender: TObject);
begin
  acID.Checked := grMain.Columns[GetColumnIndex('ID')].Width > 0;
end;

{-----------------------------------------------------------------
  Vraci Index sloupce
------------------------------------------------------------------}
function TfMain.GetColumnIndex(const ColName: string): Integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to grMain.Columns.Count-1 do
    if (grMain.Columns[i].FieldName = ColName) then
    begin
      Result := i;
      Break;
    end;
end;

{-----------------------------------------------------------------
  Vytvoreni e-mailu na adresu autora
------------------------------------------------------------------}
procedure TfMain.acMailToAutorExecute(Sender: TObject);
var
  s, ss: string;
begin
  s := AnsiLowerCase(dsMain.DataSet.FieldByName('Autor').AsString);
  ss := 'Re: ' + dsMain.DataSet.FieldByName('Subject').AsString;
  ss := StringReplace(ss, ' ', '%20', [rfReplaceAll]);
  if Pos('<', s) > 0 then
  begin
    s := Copy(s, Pos('<', s) + 1, MaxInt);
    s := Copy(s, 1, Pos('>', s) - 1);
  end;
   OpenDocument(PChar('mailto:' + s + '?Subject='+ss)); { *Převedeno z ShellExecute* }
end;

{-----------------------------------------------------------------
  Povoleni poslani zpravy autorovi
------------------------------------------------------------------}
procedure TfMain.acMailToAutorUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := TableName <> '';
end;

end.


