unit Utils;

{$MODE Delphi}



{===========================================================================}
interface
{===========================================================================}


const
  cSmallLetters   : set of char = ['a'..'z'];
  cCapitalLetters : set of char = ['A'..'Z'];
  cDecode = 23;


  {---Textove operace-----------------------}
  function NSpaces (N: byte): string;
  function SkipEndSpaces (S: string): string;
  function SkipBegSpaces (S: string): string;
  function SkipAllSpaces (S: string): string;
  function Zarovnej (S: string; Kolik: integer): string;

  function IsDigit (Z: char): boolean;

  function BeginWith (S,Beg: string; CS: Boolean): Boolean;
  function NotCSPos (SubStr, S: string): Integer;
  function MyPos (SubStr, S: string; CS: Boolean): Integer;


  function DownCase (Z: Char): Char;
  function StrDownCase (S: string): string;
  function StrUpCase (S: string): string;

  function MySetLength (S: string; N: integer): string;
  function ZaUvozovkuj (S: string): string;
  function OdUvozovkuj (S: string): string;

  function DecodeChar (Ch: Char): Char;
  function DecodeStr (S: string): string;


  // Souborive operace
  function MyGetFileSize (FN: string): integer;
  function ExistsDir (Dir: string): Boolean;


{===========================================================================}
implementation
uses
  SysUtils;

{===========================================================================}


{---------------------------------------------------------------------------}
{                  ************************************                     }
{                  *******   TEXTOVE OPERACE   ********                     }
{                  ************************************                     }
{---------------------------------------------------------------------------}



{-----------------------------------------------------------------NSpaces---}
{ Fce vraci retezec obsahujici N mezer }
function NSpaces (N: byte): string;
var i : byte;
    Pom : string;
begin {NSpaces}
  Pom := '';
  for i := 1 to N do Pom := Pom + ' ';
  NSpaces := Pom;
end; {NSpaces}


{-----------------------------------------------------------SkipEndSpaces---}
function SkipEndSpaces (S: string): string;
var
  i: Byte;
begin { SkipEndSpaces }
  i := Length (S);
  while (i>0) and (S[i] = ' ') do Dec (i);

  SkipEndSpaces := Copy (S,1,i);
end;  { SkipEndSpaces }


{-----------------------------------------------------------SkipBegSpaces---}
function SkipBegSpaces (S: string): string;
var
  i, N: Byte;
begin { SkipBegSpaces }
  i := 1;
  N := Length (S);
  while (i < N) and (S[i] = ' ') do Inc (i);
  SkipBegSpaces := Copy (S, i, N-i+1);
end;  { SkipBegSpaces }


{-----------------------------------------------------------SkipAllSpaces---}
function SkipAllSpaces (S: string): string;
var
  i, N: Byte;
  Pom : string;
begin { SkipAllSpaces }
  N := Length (S);
  Pom := '';
  for i := 1 to N do
    if S[i] <> ' ' then Pom := Pom + S[i];
  SkipAllSpaces := Pom;
end;  { SkipAllSpaces }


{-----------------------------------------------------------------IsDigit---}
function IsDigit (Z: char): boolean;
begin {}
  if ((Z >= '0') and (Z <= '9')) then IsDigit := true
  else isDigit := false;
end; {}


{---------------------------------------------------------------BeginWith---}
function BeginWith (S,Beg: string; CS: Boolean): Boolean;
var
  PomS, PomBeg: string;
begin
  BeginWith := false;
  if (Length (S) < Length (Beg)) then exit;

  if (CS) then begin
    BeginWith := ((Pos (Beg, S)) = 1);
    exit;
  end;

  { Neni to CaseSensitif }
  PomS := StrUpcase (S);
  PomBeg := StrUpcase (Beg);
  BeginWith := ((Pos (PomBeg, PomS)) = 1);
end;

{------------------------------------------------------------------NotCSPos---}
{ NECaseSensitivni obdoba fce POS}
function NotCSPos (SubStr, S: string): Integer;
var
  PomSubStr, PomS: string;
begin { NotCSPos }
  PomSubStr := StrUpCase (SubStr);
  PomS := StrUpCase (S);
  NotCSPos := Pos (PomSubStr, PomS);
end;  { NotCSPos }

{-------------------------------------------------------------------MyPos---}
function MyPos (SubStr, S: string; CS: Boolean): Integer;
begin { MyPos }
  if (CS) then MyPos := Pos (SubStr, S)
  else MyPos := NotCSPos (SubStr, S);
end;  { MyPos }


{----------------------------------------------------------------DownCase---}
function DownCase (Z: Char): Char;
var
  Pom : Byte;
  aADiff: Byte;

begin { DownCase }
  aADiff := Ord ('a') - Ord('A');

  if Z in cCapitalLetters then
    begin {}
      Pom := Ord (Z);
      Inc (Pom, aADiff);
      Z := Chr (Pom);
    end; {}
  DownCase := Z;
end;  { DownCase }

{-------------------------------------------------------------StrDownCase---}
{ Zmeni vsechna velka pismenka na male, ostatni znaky necha byt }
function StrDownCase (S: string): string;
var
  i, N: byte;
  Word: string;
begin {StrDownCase}
  N := length (S);
  Word := '';
  for i := 1 to N do
    Word := Word + DownCase (S[i]);
  StrDownCase := Word;
end;  {StrDownCase}

{---------------------------------------------------------------StrUpCase---}
{ Zmeni vsechna mala pismenka na velke, ostatni znaky necha byt }
function StrUpCase (S: string): string;
var i, N: word;
    W: string;
begin {StrUpCase}
  N := length (S);
  W := '';
  for i := 1 to N do
    W := W + UpCase (S [i]);
  StrUpCase := W;
end;  {StrDownCase}

{-------------------------------------------------------------MySetLength---}
{ Zarovna vstupni retezec S na N znaku - pokud to prebyva, tak to ufikne,
  pokud to chybi, tak to doplni nulama }
function MySetLength (S: string; N: integer): string;
var
  Len: integer;
  SS: string;
begin { MySetLength }
  Len := Length (S);
  if (Len > N) then {Ufikneme}
    SS := Copy (S, 1, N);
  if (Len < N) then {Dopnime}
    SS := S + NSpaces (N-Len);
  if (Len = N) then {Nechame}
    SS := S;

  Result := SS;
end;  { MySetLength }

{-------------------------------------------------------------------Zarovnej---}
function Zarovnej (S: string; Kolik: integer): string;
begin { Zarovnej }
  Result := format ('%-*.*s',[Kolik, Kolik, S]);
end;  { Zarovnej }

{----------------------------------------------------------------ZaUvozovkuj---}
function ZaUvozovkuj (S: string): string;
begin { ZaUvozovkuj }
  Result := '"' + S + '"';
end;  { ZaUvozovkuj }

{----------------------------------------------------------------OdUvozovkuj---}
function OdUvozovkuj (S: string): string;
var
  N: integer;
begin { OdUvozovkuj }
  Result := '';
  if S = '' then exit;
  if (S[1] = '"') then S := Copy (S, 2, Length (S)-1);
  if S = '' then exit;

  N := Length (S);
  if (S[N] = '"') then S := Copy (S, 1, N-1);

  Result := S;
end;  { OdUvozovkuj }


{------------------------------------------------------------------DecodeStr---}
function DecodeStr (S: string): string;
var
  i: integer;
begin { DecodeStr }
  for i := 1 to Length (S) do S[i] := DecodeChar (S[i]);
  Result := S;
end;  { DecodeStr }

{-----------------------------------------------------------------DecodeChar---}
function DecodeChar (Ch: Char): Char;
var
  C: Char;
const
  // Ktere znaky ma nechati na pokoji
  ///Nechat : set of char = [#13, #10, #26];//, #246, #243, #230];
  Nechat : set of char = [#10, #26];//, #246, #243, #230];
begin {DecodeChar}
  C := Ch;
  if ((C in Nechat) or (Chr (Ord (C) xor cDecode) in Nechat)) then
    Result := C
  else
    Result := Chr (Ord (C) xor cDecode);
{
  if (not (C in Nechat)) then
    C := Chr (256 - Ord(Ch));
}
end;  {DecodeChar}

{---------------------------------------------------------------------------}
{         ****************************************************              }
{         *******   OSTATNI DROBNE PROCEDURKY A FCE   ********              }
{         ****************************************************              }
{---------------------------------------------------------------------------}

//------------------------------------------------------------------------------
//                                                                MyGetFileSize
//------------------------------------------------------------------------------
function MyGetFileSize (FN: string): integer;
var
  Res: integer;
  SR: TSearchRec;

begin { MyGetFileSize }
  Res := FindFirst (FN, faAnyFile - faDirectory, SR);
  if (Res <> 0) then Result := -1
  else Result := SR.Size;
  FindClose (SR);
end;  { MyGetFileSize }

//------------------------------------------------------------------------------
//                                                                    ExistsDir
//------------------------------------------------------------------------------
function ExistsDir (Dir: string): Boolean;
var
  SR: TSearchRec;
begin { ExistsDir }
  if (Dir [Length (Dir)] <> '/') then Dir := Dir + '/';
  Result := (FindFirst (Dir+'*.*', faAnyFile, SR) = 0);
  FindClose (SR);
end;  { ExistsDir }




{===========================================================================}
begin
end.
