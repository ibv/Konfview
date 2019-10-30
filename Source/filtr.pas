
unit Filtr;

{$MODE Delphi}


interface {--------------------------------------------------------------------}
uses
  Classes;

const
  cNField = 20;
  MaxDay = 31;
  MaxMonth = 12;

const
  tBase64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  encQuoted = 0;
  encBase64 = 1;

type
  tBuffer = array [0..71] of Byte;

const
  {Mesice}
  cMonths: array [1..MaxMonth] of string =
    ('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC');

  {Oznaceni jednotlivych sekci mailu}
//  cFrom = 'From: ';
//  cSubj = 'Subject: ';
//  cDate = 'Date: ';

  {Oznaceni jednotlivych sekci html}
  cBodyBeg = '<body>';
  cBodyEnd = '</body>';
  cHtmlFrom = '"AUTHOR"';
  cHtmlDate = '"DATE"';
  cHtmlSubjBeg = '<title>';
  cHtmlSubjEnd = '</title>';
  cHtmlTagBeg = 'content="';
  cHtmlTagEnd = '">';


  {pojmenovani html stranek}
  cHtmlPrefix  = 'dlf';
  cHtmlPostFix = '.htm';

  function ReadMailHeader (var F: text; var From, Subj, DT, Boundary, Charset, Encoding: string;
                       var LineNum, ActFilePos: longint): integer;
  function IsMailEOM (S: string): boolean;

  function NextHtmlFile (Path: string;
                         var Month, Day, FileNum: integer): string;

  function ReadHtmlHeader (var F: text; var From, Subj, Dt: string): integer;
  function IsHtmlBodyEnd (S: string): boolean;
  procedure TrimSubj (var Subj: string);

  function ConvertSubjAutor (S: string): string;
  procedure PrepareMail (SL: TStringList; AttachDir, Boundary, CharSet, Code: string);
  procedure PrepareMail2 (SL: TStringList; AttachDir, Boundary: string);


//  procedure PrepareMail (SL: TStringList; AttachDir: string);

implementation {---------------------------------------------------------------}
uses
  SysUtils, Settings, Utils, Dialogs, Controls,
  AddFile, synachar, mimemess,mimepart ;

var
  PomList: TStringList;
  LogLineNum: integer;

{***************************************************************************}

procedure AddLog (S: string);
begin
//     if (LogLineNum > 43000) then
//    fAddFile.RichEdit1.Lines.Add (S);
end;


{------------------------------------------------------------------IsMailEOM---}
{ Zjisti, jestli retezec S znamena konec mejla}
function IsMailEOM (S: string): boolean;
var
  i: integer;
begin {}
  Result := false;
  AddLog (S);

  for i := 0 to fSettings.lbEOM.Items.Count-1 do
//    if (UpperCase (S) = UpperCase (fSettings.lbEOM.Items[i])) then
// pro test na konec zpravy
    if Pos(UpperCase (fSettings.lbEOM.Items[i]),UpperCase(s))<>0 then
// ------------------------
    begin
      Result := true;
      Exit;
    end;
end; {IsMailEOM}

{-----------------------------------------------------------------IsMailFrom---}
function IsMailFrom (S: string; var From: string): boolean;
var
  Eq: boolean;
  N_FROM: integer;
begin {}
  Eq := BeginWith (S, fSettings.edFrom.Text{cFrom}, true);

  if (Eq) then begin
    N_FROM := length (fSettings.edFrom.Text{cFrom});
    From := copy (S, N_FROM+1, length (S) - N_FROM);
    From := SkipBegSpaces (From);
  end;

  Result := Eq;
end; {IsMailFrom}

{-------------------------------------------------------------------IsMailRe---}
function IsMailRe (var S: string): Boolean;
var
  i, l: Integer;
begin

  for i := 0 to fSettings.lbRe.Items.Count-1 do
    if BeginWith (S, fSettings.lbRe.Items[i], false) then begin
      l := Length (fSettings.lbRe.Items[i]);
      S := copy (S, l+1, Length (S)-l);
      Result := true;
      exit;
    end;

  Result := false;
end;
{-----------------------------------------------------------------IsMailSubj---}
function IsMailSubj (S: string; var Subj: string): boolean;
var
  Eq: boolean;
  N_SUBJ: integer;
begin {}
  Eq := BeginWith (S,fSettings.edSubj.Text{cSubj}, true);

  if (Eq) then begin
    N_SUBJ := length (fSettings.edSubj.Text{cSubj});
    Subj := copy (S, N_SUBJ+1, length (S) - N_SUBJ);
    Subj := SkipBegSpaces (Subj);
  end;
  Result := Eq;
end; {IsMailSubj}

{-----------------------------------------------------------------IsMailDate---}
function IsMailDate (S: string; var Date: string): boolean;
var
  Eq: boolean;
  N_DATE: integer;
begin {}
  Eq := BeginWith (S, fSettings.edDate.Text{cDate}, true);

  if (Eq) then begin
    N_DATE := length (fSettings.edDate.Text{cDate});
    Date := copy (S, N_DATE+1, length (S) - N_DATE);
    Date := SkipBegSpaces (Date);
  end;
  Result := Eq;
end; {IsMailDate}



function IsMailCharset (S: string; var Charset: string): boolean;
var
  j: integer;
begin
  result:=false;
  j := NotCSPos ('CHARSET=', S);
  if j > 0 then
  begin
    Charset := OdUvozovkuj(Copy(s,j+8,length(s)));
    result:=true;
  end;
end;


function IsMailEncoding (S: string; var Code: string): boolean;
var
  j: integer;
begin
  result:=false;
  j := NotCSPos ('CONTENT-TRANSFER-ENCODING:', S);
  if j > 0 then
  begin
    Code := Copy (S, 28, Length (S));
    result:=true;
  end;
end;


//------------------------------------------------------------------------------
//                                                               ReadMailHeader
//------------------------------------------------------------------------------
{ Pokusi se nacist informace o jednom mejliku }
{ Vraci:
    0...OK
    1...Neocekavany konec souboru
}
function ReadMailHeader (var F: text; var From, Subj, Dt, Boundary, Charset, Encoding: string;
                         var LineNum, ActFilePos: longint): integer;
var
  S, Date, Pom, ChSet, Code: string;
  j: integer;

  procedure ReadLine (var S: string);
  begin
    Readln (F, S);
    LogLineNum := LineNum;
    AddLog (S);
    inc (LineNum);
    ActFilePos := ActFilePos + length (S) + 2;
  end;

begin { ReadMailHeader }
  Result := 1;
  Boundary := '';

  { Preskocime prazdne radky na zacatku }
  repeat
    if eof (F) then exit;
    Readline (S);
  until (S<>'');

  {---Nacitani hlavicky--------------}
  while (S <> '') do begin
    if (IsMailFrom (S, Pom)) then
      From := Pom;

    if (IsMailSubj (S, Pom)) then
      Subj := Pom;

    if (IsMailDate (S, Date)) then
      Dt := Date;

    if (IsMailCharset (S, ChSet)) then
      Charset := ChSet;
    if (IsMailEncoding (S, Code)) then
      Encoding := Code;


    if (Pos ('BOUNDARY=', UpperCase (TrimLeft (S))) <> 0) then begin
      Boundary := TrimLeft (S);
      j := Pos ('BOUNDARY=', UpperCase (Boundary));
      Boundary := Copy (Boundary, j+9, Length (Boundary)-(j+8));
      Boundary := OdUvozovkuj (Boundary);
    end;

    if eof (F) then exit;
    ReadLine (S)
  end; {nacitani hlavicky}
  Result := 0;
end;   { ReadMailHeader }

//------------------------------------------------------------------------------
//                                                                  GetHtmlName
//------------------------------------------------------------------------------
// vraci X-ty nazev html souboru v adresari
// 0 ty nazev je 'dlfaaaaa.htm'
// 27my nazev je 'dlfaaaba.htm'
// pokud dojde k preteceni, vraci ''
function GetHtmlName (X: integer): string;
var
  S: string;
  A, i: integer;
begin  { GetHtmlName }
  S := 'aaaaa';
  A := Ord ('a');
  for i := 5 downto 1 do begin
    S [i] := Chr (A + (X mod 26));
    X := X div 26;
  end;

  S := cHtmlPrefix + S + cHtmlPostfix;
  if (X <> 0) then S := '';   // preteceni
  Result := S;
end;   { GetHtmlName }



//------------------------------------------------------------------------------
//                                                                 NextHtmlFile
//------------------------------------------------------------------------------
// Pokusi se otevrit prislusny html soubor odpovidajici zadanemu dni, nebo dni
// nasledujicimu
function NextHtmlFile (Path: string;
                       var Month, Day, FileNum: integer): string;
var
  M, D, K: integer;
  Dir, FileName: string;
begin  { NextHtmlFile }
  Result := '';
  for M := Month to MaxMonth do begin
    for D := Day to MaxDay do begin
      // Koukne se zda existuje adresar pro dany den
      Dir := Path + cMonths[M] + '\';
      if (D < 10) then Dir := Dir + '0';
      Dir := Dir + IntToStr (D) + '\';

      if (ExistsDir (Dir)) then begin
        // Pokud existuje adresar, koukne se na dalsi soubor
        for k := 1 to 5 do begin // kdyby byla nejaka vynechavka
          FileName := Dir+GetHtmlName (FileNum);
          if (FileExists (FileName)) then begin
            // Nasli jsme jej!!
            Result := FileName;
            inc (FileNum);
            Month := M;
            Day := D;
            exit;
          end;
          inc (FileNum);
        end;
      end;
      FileNum := 0;
    end;
    Day := 1;
  end;

  // Pokud dojdeme az sem, tak to znamena ze dalsi neexistujou
  Result := '';
end;   { NextHtmlFile }

{-----------------------------------------------------------------IsHtmlBody---}
function IsHtmlBody (S: string): boolean;
begin {IsHtmlBody}
  Result := (NotCSPos (cBodyBeg, S) <> 0);
end; {IsHtmlBody}

{--------------------------------------------------------------IsHtmlBodyEnd---}
function IsHtmlBodyEnd (S: string): boolean;
begin {IsHtmlBodyEnd}
  Result := (NotCSPos (cBodyEnd, S) <> 0);
end; {IsHtmlBodyEnd}

{-----------------------------------------------------------------IsHtmlSubj---}
//
//  <title>Uvodni zprava</title>
//
function IsHtmlSubj (S: string; var Subj: string): boolean;
var
  i, j: integer;

begin {IsHtmlSubj}
  i := NotCSPos (cHtmlSubjBeg, S);
  Result := (i <> 0);
  if (i <> 0) then begin
    i := i + Length (cHtmlSubjBeg);
    S := Copy (S, i, Length (S)-i+1);
    j := NotCSPos (cHtmlSubjEnd, S);
    if (j <> 0) then
      Subj := Copy (S, 1, j-1)
    else
      Subj := Copy (S, 1, Length (S));
  end;
end; {IsHtmlSubj}

{-----------------------------------------------------------------IsHtmlFrom---}
//
// <meta name="AUTHOR" content="d.vodnansky@x400.icl.co.uk">
//
function IsHtmlFrom (S: string; var From: string): boolean;
var
  i, j, k: integer;
begin {IsHtmlFrom}
  i := NotCSPos (cHtmlFrom, S);
  Result := (i <> 0);
  if (i <> 0) then begin
    i := i + Length (cHtmlFrom);
    S := Copy (S, i, Length (S)-i+1);
    j := NotCSPos (cHtmlTagBeg, S);
    if (j <> 0) then begin
      j := j + Length (cHtmlTagBeg);
      S := Copy (S, j, Length (S) - j+1);
    end;

    k := NotCSPos (cHtmlTagEnd, S);
    if (k <> 0) then
      From := Copy (S, 1, k-1)
    else
      From := S;
  end;
end; {IsHtmlFrom}

{-----------------------------------------------------------------IsHtmlDate---}
//
// <meta name="AUTHOR" content="d.vodnansky@x400.icl.co.uk">
//
function IsHtmlDate (S: string; var Dt: string): boolean;
var
  i, j, k: integer;
begin {IsHtmlDate}
  i := NotCSPos (cHtmlDate, S);
  Result := (i <> 0);
  if (i <> 0) then begin
    i := i + Length (cHtmlDate);
    S := Copy (S, i, Length (S)-i+1);
    j := NotCSPos (cHtmlTagBeg, S);
    if (j <> 0) then begin
      j := j + Length (cHtmlTagBeg);
      S := Copy (S, j, Length (S) - j+1);
    end;

    k := NotCSPos (cHtmlTagEnd, S);
    if (k <> 0) then
      Dt := Copy (S, 1, k-1)
    else
      Dt := S;
  end;
end; {IsHtmlDate}

//------------------------------------------------------------------------------
//                                                               ReadHtmlHeader
//------------------------------------------------------------------------------
{ Pokusi se nacist informace o jednom mejliku }
{ Vraci:
    0...OK
    1...Neocekavany konec souboru
}
function ReadHtmlHeader (var F: text; var From, Subj, Dt: string): integer;
var
  S: string;
  Pom: string;

begin { ReadHtmlHeader }
  From := '';
  Subj := '';
  Dt := '';

  repeat
    Readln (F, S);

    if (From = '') then
      if (IsHtmlFrom (S, Pom)) then
        From := Pom;

    if (Subj = '') then
      if (IsHtmlSubj (S, Pom)) then
        Subj := Pom;

    if (Dt = '') then
      if (IsHtmlDate (S, Pom)) then
        Dt := Pom;

  until (IsHtmlBody (S) or Eof (F));

  if (Eof (F)) then Result := 1
  else Result := 0;

end;   { ReadHtmlHeader }

//------------------------------------------------------------------------------
//                                                                     TrimSubj
//------------------------------------------------------------------------------
procedure TrimSubj (var Subj: string);
begin
  Subj := SkipBegSpaces (Subj);
  while (IsMailRe (Subj)) do Subj := SkipBegSpaces (Subj);
end;

(*
//------------------------------------------------------------------------------
//                                                                ConvertBase64
//------------------------------------------------------------------------------
function ConvertBase64 (S: string): string;
var
  i, j: integer;
  R, RR: string;
  Pom: Integer;

begin { ConvertBase64 }

  R := '';
  for i := 1 to length (S) div 4 do begin
    RR := '';
    j := (i-1)*4 + 1;   // j je skutecny index do retezce

    Pom := Pos (string (S[j]),  tBase64)-1;
    Pom := Pom shl 6;
    if (S[j+1] <> '=') then
      Pom := Pom + Pos (string (S[j+1]),  tBase64)-1;
    Pom := Pom shl 6;

    if (S[j+2] <> '=') then
      Pom := Pom + Pos (string (S[j+2]),  tBase64)-1;
    Pom := Pom shl 6;

    if (S[j+3] <> '=') then
      Pom := Pom + Pos (string (S[j+3]),  tBase64)-1;

    RR := Chr (Pom and 255) + RR;
    Pom := Pom shr 8;
    RR := Chr (Pom and 255) + RR;
    Pom := Pom shr 8;
    RR := Chr (Pom and 255) + RR;
    R := R + RR;
  end;

  Result := R;
end;  { ConvertBase64----------------------------------------------------------}

//------------------------------------------------------------------------------
//                                                        ConvertFileBase64Line
//------------------------------------------------------------------------------
// Vstup zakodovany radek, vystup skutecna delka dekodovaneho retezce
// a dekodovany retezec
function ConvertFileBase64Line (S: string; var Len: integer): tBuffer;

var
  i, j, k: integer;
  R: tBuffer;
  Pom: Integer;

begin { ConvertFileBase64Line }
  k := 0;                            // pozice ve vystupnim bufferu
  Len := (Length (S) div 4) * 3;     // skutecna delka vystupniho bufferu

  for i := 1 to length (S) div 4 do begin
    j := (i-1)*4 + 1;                // j je skutecny index do retezce

    // Nacteme do Pom (integer) 4 znaky ze vstupniho retezce
    Pom := Pos (string (S[j]),  tBase64)-1;
    Pom := Pom shl 6;

    if (S[j+1] <> '=') then
      Pom := Pom + Pos (string (S[j+1]),  tBase64)-1
    else
      Len := k;

    Pom := Pom shl 6;

    if (S[j+2] <> '=') then
      Pom := Pom + Pos (string (S[j+2]),  tBase64)-1
    else
      Len := k+1;

    Pom := Pom shl 6;

    if (S[j+3] <> '=') then
      Pom := Pom + Pos (string (S[j+3]),  tBase64)-1
    else
      Len := k+2;

    // dekodovani cisla (ze 4 znaku) na 3 znakovy retezec
    R[k+2] := (Pom and 255);
    Pom := Pom shr 8;
    R[k+1] := (Pom and 255);
    Pom := Pom shr 8;
    R[k] := (Pom and 255);
    k := k + 3;
  end;
  Result := R;
end;  { ConvertFileBase64Line--------------------------------------------------}

//------------------------------------------------------------------------------
//                                                                ConvertQuoted
//------------------------------------------------------------------------------
function ConvertQuoted (S: string): string;
const
  sHexa = '1234567890ABCDEF';

var
  R, Pom: string;
  i, Hex: integer;

begin { ConvertQuoted }
  // Mame orezany retezec
  R := '';
  i := 1;

  while (i <= length (S)) do begin
    if (i < length (S)-1) and (S[i] = '=') then begin
      Pom := copy (S, i+1, 2);
      if ((Pos (Pom[1], sHexa) <> 0) and
          (Pos (Pom[2], sHexa) <> 0)) then begin
        Hex := StrToInt ('$'+Pom);
        R := R + Chr (Hex);
        i := i + 3;
        Continue;
      end;
    end;

    if (i <= length (S)-1) and (S[i] = '?') and (S[i+1] = '=') then begin
      i := i + 2;
      Continue;
    end;

    if (S[i] = '_') then R := R + ' '
    else R := R + S[i];
    inc (i);
  end;
  Result := R;

end;  { ConvertQuoted ---------------------------------------------------------}

*)

//------------------------------------------------------------------------------
//                                                                ConvertBase64
//------------------------------------------------------------------------------
function ConvertBase64 (S: string): string;
var
  i, j: integer;
  R, RR: string;
  Pom: Integer;

begin { ConvertBase64 }
  R := '';
  for i := 1 to length (S) div 4 do begin
    RR := '';
    j := (i-1)*4 + 1;   // j je skutecny index do retezce

    Pom := Pos (string (S[j]),  tBase64)-1;
    Pom := Pom shl 6;
    if (S[j+1] <> '=') then
      Pom := Pom + Pos (string (S[j+1]),  tBase64)-1;
    Pom := Pom shl 6;

    if (S[j+2] <> '=') then
      Pom := Pom + Pos (string (S[j+2]),  tBase64)-1;
    Pom := Pom shl 6;

    if (S[j+3] <> '=') then
      Pom := Pom + Pos (string (S[j+3]),  tBase64)-1;

    RR := Chr (Pom and 255) + RR;
    Pom := Pom shr 8;
    RR := Chr (Pom and 255) + RR;
    Pom := Pom shr 8;
    RR := Chr (Pom and 255) + RR;
    R := R + RR;
  end;

  Result := R;
end;  { ConvertBase64----------------------------------------------------------}

//------------------------------------------------------------------------------
//                                                        ConvertFileBase64Line
//------------------------------------------------------------------------------
// Vstup zakodovany radek, vystup skutecna delka dekodovaneho retezce
// a dekodovany retezec
function ConvertFileBase64Line (S: string; var Len: integer): tBuffer;

var
  i, j, k: integer;
  R: tBuffer;
  Pom: Integer;

begin { ConvertFileBase64Line }
  k := 0;                            // pozice ve vystupnim bufferu
  Len := (Length (S) div 4) * 3;     // skutecna delka vystupniho bufferu

  for i := 1 to length (S) div 4 do begin
    j := (i-1)*4 + 1;                // j je skutecny index do retezce

    // Nacteme do Pom (integer) 4 znaky ze vstupniho retezce
    Pom := Pos (string (S[j]),  tBase64)-1;
    Pom := Pom shl 6;

    if (S[j+1] <> '=') then
      Pom := Pom + Pos (string (S[j+1]),  tBase64)-1
    else
      Len := k;

    Pom := Pom shl 6;

    if (S[j+2] <> '=') then
      Pom := Pom + Pos (string (S[j+2]),  tBase64)-1
    else
      Len := k+1;

    Pom := Pom shl 6;

    if (S[j+3] <> '=') then
      Pom := Pom + Pos (string (S[j+3]),  tBase64)-1
    else
      Len := k+2;

    // dekodovani cisla (ze 4 znaku) na 3 znakovy retezec
    R[k+2] := (Pom and 255);
    Pom := Pom shr 8;
    R[k+1] := (Pom and 255);
    Pom := Pom shr 8;
    R[k] := (Pom and 255);
    k := k + 3;
  end;
  Result := R;
end;  { ConvertFileBase64Line--------------------------------------------------}

//------------------------------------------------------------------------------
//                                                                ConvertQuoted
//------------------------------------------------------------------------------
function ConvertQuoted (S: string; var CutLine: Boolean): string;
const
  sHexa = '1234567890ABCDEF';

var
  R, Pom: string;
  i, Hex: integer;

begin { ConvertQuoted }
  // Mame orezany retezec
  CutLine := false;
  R := '';
  i := 1;

  while (i <= length (S)) do begin
    if (i < length (S)-1) and (S[i] = '=') then begin
      Pom := copy (S, i+1, 2);
      if ((Pos (Pom[1], sHexa) <> 0) and
          (Pos (Pom[2], sHexa) <> 0)) then begin
        Hex := StrToInt ('$'+Pom);
        R := R + Chr (Hex);
        i := i + 3;
        Continue;
      end;
    end;

{      if (Pom[1] = #13) and (Pom[2] = #10) then begin
        i := i + 3;
        CutLine := true;
        Continue;
      end;
}
    if (i = Length (S)) and (S[i] = '=') then begin
      CutLine := true;
      inc (i);
      Continue;
    end;

    if (i <= length (S)-1) and (S[i] = '?') and (S[i+1] = '=') then begin
      i := i + 2;
      Continue;
    end;

    if (S[i] = '_') then R := R + ' '
    else R := R + S[i];
    inc (i);
  end;
  Result := R;

end;  { ConvertQuoted ---------------------------------------------------------}

//------------------------------------------------------------------------------
//                                                             ConvertSubjAutor
//------------------------------------------------------------------------------
function ConvertSubjAutor (S: string): string;
const
  nCSCount = 4;
  csISO_8859_1 = 0;
  csISO_8859_2 = 1;
  csWin_1250   = 2;
  csUS_Ascii   = 3;

  sCSNames: array [0..nCSCount-1] of string = (
    '=?ISO-8859-1',
    '=?ISO-8859-2',
    '=?WINDOWS-1250',
    '=?US-ASCII'
  );

  nSkipCount = 2;
  sToSkip: array [0..nSkipCount-1] of string = (
    '?Q?',
    '?B?'
  );

var
  Coding: integer;
  i, j: integer;
  Cut: Boolean;

begin { ConvertSubjAutor }

  // Zjistim, co to je za kodovani
  Coding := -1;
  Result := S;
  S := TrimLeft (S);
  for i := 0 to nCSCount-1 do begin
    if (Pos (sCSNames[i], UpperCase (S)) = 1) then begin
      S := Copy (S, Length (sCSNames[i]) + 1, Length (S) - Length (sCSNames[i]));
      Coding := i;
      Break;
    end;
  end;

  // Zadne zname kodovani, necham to bejt
  if (Coding = -1) then exit;

  // No pokud je na konci ?= tak to zrusim taky
  if (Length (S) > 1) and
     (S[Length (S)-1] = '?') and
     (S[Length (S)] = '=') then S := Copy (S, 1, Length (S)-2);

  // Preskocim jeste ten nesmysl ?Q? pripadne ?B?
  // Q....Quoted printable
  // B....Base64
  for i := 0 to nSkipCount-1 do begin
    j := Pos (sToSkip[i], UpperCase (S));
    if (j = 1) then begin
      S := Copy (S, Length (sToSkip[i]) + 1, Length (S) - Length (sToSkip[i]));
      case i of
        0: S := ConvertQuoted (S, Cut);
        1: S := ConvertBase64 (S);
      end; //case
      Break;
    end;
  end;

  Result := S;
end; { ConvertSubjAutor -------------------------------------------------------}

(*
//------------------------------------------------------------------------------
//                                                                  PrepareMail
//------------------------------------------------------------------------------
// Co se tu bude dit?
//  - Vyhazeni poznamek o formatovani
//  - Vyhazeni html casti
//  - Vyhazeni Attachmentu
procedure PrepareMail (SL: TStringList; AttachDir: string);
begin { PrepareMail }

end;  { PrepareMail }
*)





//====================================

(*
//------------------------------------------------------------------------------
//                                                                      Convert
//------------------------------------------------------------------------------
function Convert (S: string): string;
const
  nCSCount = 4;
  csISO_8859_1 = 0;
  csISO_8859_2 = 1;
  csWin_1250   = 2;
  csUS_Ascii   = 3;

  sCSNames: array [0..nCSCount-1] of string = (
    '=?ISO-8859-1',
    '=?ISO-8859-2',
    '=?WINDOWS-1250',
    '=?US-ASCII'
  );

  nSkipCount = 2;
  sToSkip: array [0..nSkipCount-1] of string = (
    '?Q?',
    '?B?'
  );

var
  Coding: integer;
//  R, Pom: string;
  i, j{, Hex}: integer;
  Cut: Boolean;

begin { Convert }

  // Zjistim, co to je za kodovani
  Coding := -1;
  Result := S;
  for i := 0 to nCSCount-1 do begin
    if (Pos (sCSNames[i], UpperCase (S)) = 1) then begin
      S := Copy (S, Length (sCSNames[i]) + 1, Length (S) - Length (sCSNames[i]));
      Coding := i;
      Break;
    end;
  end;

  // Zadne zname kodovani, necham to bejt
  if (Coding = -1) then exit;

  // No pokud je na konci ?= tak to zrusim taky
  if (Length (S) > 1) and
     (S[Length (S)-1] = '?') and
     (S[Length (S)] = '=') then S := Copy (S, 1, Length (S)-2);

  // Preskocim jeste ten nesmysl ?Q? pripadne ?B?
  // Q....Quoted printable
  // B....Base64
  for i := 0 to nSkipCount-1 do begin
    j := Pos (sToSkip[i], UpperCase (S));
    if (j = 1) then begin
      S := Copy (S, Length (sToSkip[i]) + 1, Length (S) - Length (sToSkip[i]));
      case i of
        0: S := ConvertQuoted (S, Cut);
        1: S := ConvertBase64 (S);
      end; //case
      Break;
    end;
  end;

  Result := S;
end; { Convert ----------------------------------------------------------------}
*)

//------------------------------------------------------------------------------
//                                                                  GetEncoding
//------------------------------------------------------------------------------
function GetEncoding (S: string): integer;
const
  nEncoding = 2;
  sEncoding: array [0..nEncoding-1] of string = (
    'QUOTED-PRINTABLE',
    'BASE64'
  );

var
  i: integer;

begin { GetEncoding }
  for i := 0 to nEncoding-1 do begin
    if (Pos (sEncoding[i], UpperCase (S)) = 1) then begin
      Result := i;
      Exit;
    end;
  end;

  Result := -1;
end;  { GetEncoding -----------------------------------------------------------}

//------------------------------------------------------------------------------
//                                                                   IsBoundary
//------------------------------------------------------------------------------
function IsBoundary (S, Boundary: string): Boolean;

const
  nNextPart = 3;
  sNextPart : array [0..nNextPart-1] of string = (
    '------=_NEXTPART',
    '------ =_NEXTPART',
    '------_=_NEXTPART'
  );

var
  Found: Boolean;
  j: integer;
begin { IsBoundary }
  Found := false;
  ///if ((Boundary<>'') and
  ///    (Pos (Boundary, UpperCase (S)) <> 0)) then Found := true;
  if Pos ('------=', UpperCase (S)) <> 0 then Found := true;

  if not Found then begin
    for j := 0 to nNextPart-1 do
      if (Pos (sNextPart[j], UpperCase (S)) = 1) then begin
        Found := true;
        Break;
      end;
  end;

  Result := Found;
end;  { IsBoundary ------------------------------------------------------------}

//------------------------------------------------------------------------------
//                                                                   SaveAttach
//------------------------------------------------------------------------------
procedure SaveAttach (SL: TStringList; var FileName: string;
                      Boundary: string; var i: integer;
                      Encoding: integer);
var
  FS: TFileStream;
  Len: integer;
  Cut, EOList, DontWrite : Boolean;
  S: string;
  Buf: tBuffer;
  Pom: string;

begin  { SaveAttach }
  while FileExists (FileName) do begin
    Pom := ExtractFilePath (FileName);
    FileName := ExtractFileName (FileName);
    FileName := '_' + FileName;
    FileName := Pom + FileName;
  end;

  // Otevreme FileStream
  DontWrite := false;
  try
    FS := TFileStream.Create (FileName, fmCreate);
  except
    MessageDlg ('Nepodařilo se uložit přílohu do souboru '+FileName, mtError, [mbOK], 0);
    FS := nil;    
    DontWrite := true;
  end;

  EOList := (i >= SL.Count);

  while not EOList do begin
    S := SL [i];
    if IsBoundary (S, Boundary) then begin
      dec (i);
      EOList := true;
      continue;
    end;

    case Encoding of
      encBase64: begin
        if (S = '') then begin  // Konec prilohy
          EOList := true;
          Continue;
        end;

        Buf := ConvertFileBase64Line (S, Len);
        if not DontWrite then
          FS.WriteBuffer (Buf, Len);
      end;

      encQuoted: begin
        Cut := false;
        S := ConvertQuoted (S, Cut);
        if not Cut then S := S + #13 + #10;

        if not DontWrite then
          FS.WriteBuffer (Pointer(S)^, Length (S));
      end;

      else begin
        S := S + #13 + #10;
        if not DontWrite then
          FS.WriteBuffer (Pointer(S)^, Length (S));
      end;
    end; // case
    inc (i);
    if (i >= SL.Count) then EOList := true;
  end;

  // Zrusime to...
  FS.Free;
end;   { SaveAttach -----------------------------------------------------------}


//------------------------------------------------------------------------------
//                                                                  PrepareMail
//------------------------------------------------------------------------------
// Co se tu bude dit?
//  - Vyhazeni poznamek o formatovani
//  - Vyhazeni html casti
//  - Vyhazeni Attachmentu
procedure PrepareMail2 (SL: TStringList; AttachDir, Boundary: string);
var
  MimeMess:TMimeMess;
  MimePart:TMimePart;
  i,j,cnt,spcnt:integer;
  s: string;
begin
  MimeMess:=TMimeMess.Create;
  MimeMess.Lines.Assign(Sl);
  MimeMess.DecodeMessage;
  PomList.Clear;
  spcnt:=MimeMess.MessagePart.GetSubPartCount();
  if spcnt>0 then
  begin
    //get all parts
    for cnt:=0 to spcnt-1 do
    begin
      MimePart:=MimeMess.MessagePart.GetSubPart(cnt);
      MimePart.DecodePart;
      PomList.Append(MimePart.Primary+' ; '+MimePart.Secondary);
      setlength(s,MimePart.DecodedLines.Size);
      MimePart.DecodedLines.Read(s[1],length(s));
      PomList.Add(s);
    end
  end
  else
    //print body
    PomList.AddStrings(MimeMess.MessagePart.Lines);
  MimeMess.Free;
  SL.Text := PomList.Text;
end;

procedure PrepareMail (SL: TStringList; AttachDir, Boundary, Charset, Code: string);
const
  nMimeInfo = 4;
  sMimeInfo : array [0..nMimeInfo-1] of string = (
    'TOTO JE ZPRÁVA VE FORMÁTU MIME OBSAHUJÍCÍ NĚKOLIK ČÁSTÍ.',
    'TOTO JE ZPRAVA VE FORMATU MIME OBSAHUJMCM NLKOLIK HASTM.',
    'TOTO JE VÍCEDÍLNÁ ZPRÁVA FORMÁTU MIME.',
    'THIS IS A MULTI-PART MESSAGE IN MIME FORMAT.'
  );

var
  i, j: integer;
  S, Typ, FileName: string;
  Found: Boolean;
  Encoding: integer;
  Content, Cut, AddToEnd: Boolean;

begin { PrepareMail }
  Boundary := UpperCase (Boundary);
  PomList.Clear;
  Content := false;
  FileName := '';
  Typ := 'TEXT/PLAIN';
  Encoding := -1;
  Cut := false;
  AddToEnd := false;

  i := -1;
  Encoding := GetEncoding (Code);
  while i < SL.Count-1 do begin
    inc (i);
    S := SL[i];

    S := StringReplace(S , #9,  '' ,[rfReplaceAll, rfIgnoreCase]);

    // Info hlaska o MIME formatu
    if (i = 0) then begin  // pokud je to prvni radek
      Found := false;
      for j := 0 to nMimeInfo-1 do
        if (Pos (sMimeInfo[j], UpperCase (S)) = 1) then Found := true;

      if (Found) then begin
        if (i < SL.Count-1) and (SL[i+1] = '') then inc (i); // Vynechani prazdneho radku
        Continue;
      end;  
    end;

    // Hledani noveho oddilu

    Found := IsBoundary (S, Boundary);
    if Found then begin
      Content := true;  // Jsme v Contentu (hlavicka jedne casti)
      FileName := '';
      Typ := 'TEXT/PLAIN';
      Encoding := -1;
      Cut := false;
      AddToEnd := false;
      continue;         // Vynechani tohoto radku
    end;

    if (Content) then
    begin
      // Neni konec Contentu??? Neboli prazdna radka?
      if (S = '') then begin
        Content := false;
        Continue;
      end;

      // Zjistime pouzite kodovani
      if (Pos ('CONTENT-TRANSFER-ENCODING: ', UpperCase (S)) = 1) then begin
        S := Copy (S, 28, Length (S)-27);
        Encoding := GetEncoding (S);
        Continue;
      end;

      // Jmeno souboru, kam se ma pripadne frknout atachment
      j := Pos ('FILENAME=', UpperCase (TrimLeft (S)));
      if (j <> 0) then begin
        S := TrimLeft (S);
        S := Copy (S, j + 9, Length (S)-(j + 8));
        FileName := OdUvozovkuj (S);
        FileName := ConvertSubjAutor (FileName);
        Continue;
      end;

      // Typ nasledujici casti
      // Content-Type: text/html; charset=utf-8
      if (Pos ('CONTENT-TYPE: ', UpperCase (S)) = 1) then
      begin
        Typ := Copy (S, 15, Length (S)-14);
        j := Pos (';', Typ);
        if (j <> 0) then
          Typ := copy (Typ, 1, j-1);

        Typ := UpperCase (Typ);

        ///if Pos ('alternative', LowerCase (S)) > 0 then
        ///   Content := true;

        {j := Pos ('alternative=', LowerCase (S));
        if ( j <> 0) then
        begin
          Charset := OdUvozovkuj(Copy(s,j+8,length(s)));
          if UpperCase(Charset) <> 'ISO-8859-2' then
            Charset:='';
        end;}
        Continue;
      end;

      Continue;
    end; // Content

    // Podle typu se rozhodnu co dal...
    if (Typ='TEXT/HTML') then Continue;
    if (Typ='TEXT/PLAIN') then
    begin
      // Dekodujeme retezec, pokud je to v nejakem znamem kodovani
      case Encoding of
        encQuoted: S := ConvertQuoted (S, Cut);
        encBase64: S := ConvertBase64 (S);
      end;

      if UpperCase(Charset) = 'ISO-8859-2' then
        s := CharsetConversion(s, ISO_8859_2, UTF_8);

      ///s := DecodeStr(s);

      if (AddToEnd and (PomList.Count > 0)) then begin
        PomList[PomList.Count-1] := PomList[PomList.Count-1] + S;
        AddToEnd := false;
      end else
        PomList.Add (S);
      if Cut then begin
        AddToEnd := true;
        Cut := false;
      end;
    end else begin
      // Jiny format - ulozim atachment

      if (FileName <> '') then begin
        FileName := AttachDir+FileName;
        if (AttachDir <> '') then
          SaveAttach (SL, FileName, Boundary, i, Encoding);
        // Po ulozeni prilohy prihodime do mailu, ze ma dany soubor prilohu
        PomList.Insert (0, '[Příloha v souboru: '+ExtractFileName (FileName)+']');
        inc (i); // abych nejel stejny radek znovu
        FileName := '';
      end;
    end;


  end; // while
  SL.Text := PomList.Text;
end;  { PrepareMail }

(*
procedure TForm1.Button5Click(Sender: TObject);
var
  SL: TStringList;
begin
  // Dalsi prevod
  SL := TStringList.Create;
  mmDestMail.Lines.Clear;
  SL.Text := mmSourceMail.Text;
  PrepareMail (SL, (edBound.Text <> ''),'L:\attach\', edBound.Text);
  mmDestMail.Text := SL.Text;
  SL.Free;
end;
*)

//=======================



{---------------------------------------------------------------------------}
initialization
  PomList := TStringList.Create;
finalization
  PomList.Free;
end.
