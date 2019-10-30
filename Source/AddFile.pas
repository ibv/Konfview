unit AddFile;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs,
  StdCtrls, filtr, Buttons, ExtCtrls, {Gauges,} ComCtrls, mimepart, sqldb;

type

  { TfAddFile }

  TfAddFile = class(TForm)
    llLine: TLabel;
    llMail: TLabel;
    lLine: TLabel;
    lMail: TLabel;
    Bevel1: TBevel;
    ///anPos: TAnimate;
    pbPos: TProgressBar;
    lFile: TLabel;
    Bevel2: TBevel;
    edComment: TEdit;
    lComment: TLabel;
    btStop: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btStopClick(Sender: TObject);
  private
    { Private declarations }
    RecordCountBefore: integer;
    LastIDBefore: integer;
    LastSubjectBefore: string;
    LineNum: longint;

    procedure Walk(const Sender: TMimePart);
  public
    { Public declarations }
    //    function AddFileToDB (FileName: string): boolean;
    function AddFileToDB(FileName, AttachDir: string): boolean;
    procedure SetBtOK;
  end;

var
  fAddFile: TfAddFile;
  AttachDirectory, Path: string;
  StopReading: boolean;
  Kind: integer;
  BodyList: TStringList;


implementation

uses Main, Utils, synachar, mimemess, {mimepart,} synautil;

{$R *.dfm}

procedure TfAddFile.SetBtOK;
begin
  btStop.Tag := 0;  {Kind := bkOK;}
  btStop.Caption := '&OK';
end;


procedure TfAddFile.Walk( const Sender: TMimePart);
begin
  Sender.DecodePart;
  if (Sender.Secondary='PLAIN') or (Sender.SubLevel=0) then
    BodyList.LoadFromStream(sender.DecodedLines);
end;

{----------------------------------------------------------------AddFileToDB---}

function TfAddFile.AddFileToDB(FileName, AttachDir: string): boolean;
var
  //  i: integer;
  F: System.Text;
  S, P, From, Subject, DT, Boundary, Cap, Charset, Encoding: string;
  MailNum: longint;
  EndOfMail: boolean;
  MyList: TStringList;
  FileLen, ActFilePos: longint;
  Refresh: integer;
  LoopCondition, BodyLoopCondition: boolean;

  MimeMess: TMimeMess;
  MimePart: TMimePart;
  i, j, n, cnt, spcnt: integer;

  PomRecCount: integer;

  procedure OnClose; // Co se deje pri ukoncovani (kdyz vyskoci z cyklu)
  begin
    System.Close(F);
    MyList.Free;
    BodyList.Free;
  end;

begin
  Result := False;
  LoopCondition := False;
  BodyLoopCondition := True;
  FileLen := 0;
  if (AttachDir <> '') and (AttachDir[Length(AttachDir)] <> '/') then
    AttachDir := AttachDir + '/';

  //------------------------
  // Inicializace
  //------------------------

  pbPos.Visible := True;
  ///anPos.Active := true;
  llLine.Caption := 'Řádek:';
  llMail.Caption := 'Zpráva';
  pbPos.Enabled := True;
  FileLen := MyGetFileSize(FileName);
  { Otevru soubor pro cteni }
  System.Assign(F, FileName);
      {$I-}
  reset(F);
{$I+}
  if IOResult <> 0 then
  begin
    MessageDlg('Nepodařilo se otevřít soubor!' + #13 + '(' + FileName + ')',
      mtError, [mbOK], 0);
    SetBtOK;
    exit;
  end;
  ActFilePos := 0;
  LineNum := 0;
  LoopCondition := not EOF(F);

  // Spolecna inicializace
  MailNum := 0;
  Refresh := 0;
  MyList := TStringList.Create;
  BodyList := TStringList.Create;
  MimeMess := TMimeMess.Create;

  //----------------------------
  //  CYKLUS pro jednotlive zpravy
  //----------------------------
  while (LoopCondition) do
  begin

    Inc(MailNum);  // Zvedne se pocet pridanych meiliku
    Inc(Refresh);  // Zvedne se refresh

    // Kontrola, zda uzivatel neche zrusit nacitani
    if (StopReading) then
    begin
      OnClose;
      exit;
    end;

    //-----------------------
    // Nacteni telicka MAILU
    //-----------------------
    MyList.Clear;
    MimeMess.Clear;

    repeat

      if (EOF(F)) then
      begin
        MessageDlg('Neočekávaný konec souboru (' + IntToStr(LineNum) + ')',
          mtError, [mbOK], 0);
        SetBtOK;
        System.Close(F);
        exit;
      end;

      System.ReadLn(F, S);

      // Zvyseni pozice
      Inc(Refresh);
      Inc(LineNum);
      ActFilePos := ActFilePos + length(S) + 2;

      if s = #10 then
        continue;
      //-----------------------
      // Refresh a zobrazeni
      //-----------------------
      if (Refresh > 50) then
      begin
        lMail.Caption := IntToStr(MailNum);

        lLine.Caption := IntToStr(LineNum);
        pbPos.Position :=
          longint(longint((longint(100) * longint
          (ActFilePos div 100))) div longint(FileLen div 100));

        Application.ProcessMessages;
        Refresh := 0;
      end;
      // koncova podminka
      EndOfMail := isMailEOM(S) and (LineNum <> 1);
      if (not EndOfMail) then
        MyList.Add(S);
      BodyLoopCondition := (EndOfMail) or EOF(F);
    until (BodyLoopCondition);

    MimeMess.Lines.Assign(MyList);
    MimeMess.DecodeMessage;

    From := MimeMess.Header.From;
    Subject := MimeMess.Header.Subject;
    // konvert do utf8
    if MimeMess.Header.CharsetCode<>UTF_8 then
    begin
      From := CharsetConversion(From, MimeMess.Header.CharsetCode, UTF_8);
      Subject := CharsetConversion(Subject, MimeMess.Header.CharsetCode, UTF_8);
    end;
    Dt := Rfc822DateTime(MimeMess.Header.Date);

    if BodyList <> nil then
       BodyList.Clear;

    MimeMess.MessagePart.OnWalkPart := Walk;
    MimeMess.MessagePart.WalkPart;

    { pripravime si Query pro kontrolu existence vety }
    fMain.qrPom.Close;
    ///fMain.qrPom.DatabaseName := fMain.DatabaseName;

    fMain.qrPom.SQL.Text := Format(
      'Select SUBJECT,AUTOR,DATUM from "%s" where' +
      ' (SUBJECT=:Subject and AUTOR=:Autor and DATUM=:Datum)', [fMain.TableName]);
    fMain.qrPom.Prepare;

    { pripravime si Query pro pridani mailu }
    fMain.qrMain.Close;
    ///fMain.qrMain.DatabaseName := fMain.DatabaseName;
    fMain.qrMain.SQL.Text := Format(
      'Insert into "%s" (SUBJECT, AUTOR, DATUM, MAIL)' +
      '        Values (:Subject, :Autor, :Datum, :Mail)', [fMain.TableName]);
    fMain.qrMain.Prepare;


    //-------------------
    // Vlozeni zaznamu
    //-------------------
    // Mam Subject, Autor, Datum a vlastni mail Mail
    // Upraveni Mailu
    //---------------------------------
    // pro test na jedinecnost zaznamu
    //---------------------------------
    fMain.qrPom.ParamByName('Subject').AsString := Subject;
    fMain.qrPom.ParamByName('Autor').AsString := From;
    fMain.qrPom.ParamByName('Datum').AsString := Dt;
    try
      fMain.qrPom.Open;
      PomRecCount := fMain.qrPom.RecordCount;
    except
      PomRecCount := 1;
    end;
    fMain.qrPom.Close;

    if PomRecCount < 1 then
    begin
      // -------------------------------
      //    ShowMessage ('---'+Subject+'---'+From+'---'+Dt+'---');
      ///PrepareMail (MyList, AttachDir, Boundary, Charset, Encoding);
      try
        ///Close;
        fMain.qrMain.ParamByName('Subject').AsString := Subject;
        fMain.qrMain.ParamByName('Autor').AsString := From;
        fMain.qrMain.ParamByName('Datum').AsString := Dt;
        fMain.qrMain.ParamByName('Mail').AsBlob := BodyList.Text;
        fMain.qrMain.ExecSQL;
        fMain.qrMain.Close;
      except
        ///on E:EDBEngineError do begin
        ///ShowMessage ('Chyba při vkládání záznamu do databáze:'+#13+#10+E.Message);
        fMain.SQLTransaction1.Rollback;
        ShowMessage('Chyba při vkládání záznamu do databáze:' + #13 +
          #10 + Subject + ' / ' + From + ' / ' + Dt);
        SetBtOK;
        System.Close(F);
        exit;
        ///end; // EDBEngineError
      end; //try
    end;  // PomRecCount<1

    // Obnova podminky cyklu
    LoopCondition := not EOF(F);
  end; {While}

  fMain.SQLTransaction1.CommitRetaining;
  MimeMess.Free;
  pbPos.Position := 100;
  ///OnClose;
  System.Close(F);
  ///anPos.Active := false;
  SetBtOK;

end;  { AddFileToDB }



{...............................................................FormActivate...}
procedure TfAddFile.FormActivate(Sender: TObject);
begin
  StopReading := False;
  lFile.Caption := Path;
  RecordCountBefore := fMain.TotalRecords(fMain.DatabaseName, fMain.TableName);
  fMain.LastMailInDB(LastIDBefore, LastSubjectBefore);

  AddFileToDB(Path, AttachDirectory);

end;

procedure TfAddFile.btStopClick(Sender: TObject);
var
  TotalRec: longint;
begin
  if btStop.Tag = 1 then
  begin
    SetBtOK;
    StopReading := True;
  end
  else
  begin
    // Jeste pridam komentare a podobne
    TotalRec := fMain.TotalRecords(fMain.DatabaseName, fMain.TableName);
    fMain.AddDBComment('-', '');
    fMain.AddDBComment('', FormatDateTime('d. mmmm yyyy (hh:nn:ss)', now));
    fMain.AddDBComment('-', '');
    fMain.AddDBComment('Soubor', Path);
    fMain.AddDBComment('Prispevku pred', IntToStr(RecordCountBefore));

    fMain.AddDBComment('Prispevku po', IntToStr(TotalRec));

    fMain.AddDBComment('Pridano prispevku',
      IntToStr(TotalRec - RecordCountBefore));

    fMain.AddDBComment('Zpracovanych radku', IntToStr(LineNum));

    fMain.AddDBComment('Posledni prispevek pred',
      Format('ID: %d (%s)', [LastIDBefore, LastSubjectBefore]));

    fMain.LastMailInDB(LastIDBefore, LastSubjectBefore);
    fMain.AddDBComment('Posledni prispevek po',
      Format('ID: %d (%s)', [LastIDBefore, LastSubjectBefore]));

    fMain.AddDBComment('Komentar', edComment.Text);
    fMain.AddDBComment('', '');
    Close;
  end;
end;

end.
