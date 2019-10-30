unit Vyraz;

{$MODE Delphi}

interface
uses
  Classes;
{  function Odzavorkuj (var S: string): boolean;
  function NajdiSpojku (Spojka: Char;
                        var S, S1, S2: string): boolean;
}
  procedure Vyhodnot (S: string; List: TStringList);
  function Vycisli (List: TStringList): Byte;
  procedure NajdiSpojky (var S: string);

var
  vError : integer;

implementation

uses
  SysUtils;

{-----------------------------------------------------------------Odzavorkuj---}
{ odstrani prebytecnou vnejsi zavorku }
function Odzavorkuj (var S: string): boolean;
var
  i, N: integer;
  PocZ: integer;
begin { Odzavorkuj }
  Result := false;

  S := TrimLeft (S);
  S := TrimRight (S);
  N := length (S);

  if N<2 then exit;
  if (S[1] = '(') and (S[n] = ')') then begin
    PocZ := 0;
    for i := 2 to N-1 do
      case S[i] of
        '(': inc (PocZ);
        ')': if (PocZ = 0) then exit
             else dec (PocZ);
      end;

    S := Copy (S, 2, N-2);
    Result := true;
  end;
end; { Odzavorkuj }

{----------------------------------------------------------------NajdiSpojku---}
{ hleda ,,volnou'' spojku, pokud ji najde rozdeli vyraz na dva podvyrazy }
function NajdiSpojku (Spojka: Char;
                      var S, S1, S2: string): boolean;
var
  i, N, PocZ: integer;
begin { NajdiSpojku }
  Result := false;

  while (Odzavorkuj (S)) do ;

  N := Length (S);
  if (N=0) then Exit;

  PocZ := 0;

  for i := 1 to N do
    case S[i] of
     '(': inc (PocZ);
     ')': if (PocZ = 0) then begin
            vError := 1;
            exit;
          end else dec (PocZ);
      else
          if ((PocZ = 0) and (S[i] = Spojka)) then begin
            S1 := Copy (S, 1, i-1);
            S2 := Copy (S, i+1, N-i);
            S := '';
            Result := true;
            Exit;
          end;
    end; {case}
end; { NajdiSpojku }



procedure InsertItem (S: string; List: TStringList);
begin
  List.Add (S);
end;


{-------------------------------------------------------------------Vyhodnot---}
{ Vyhodnoti vyraz - zapise jej v polske notaci do string listu }
procedure Vyhodnot (S: string; List: TStringList);
var
  S1, S2: string;
begin  { Vyhodnot }
  if NajdiSpojku ('|', S, S1, S2) then begin
    InsertItem ('|',List);
    Vyhodnot (S1, List);
    Vyhodnot (S2, List);
  end;

  if NajdiSpojku ('&', S, S1, S2) then begin
    InsertItem ('&',List);
    Vyhodnot (S1, List);
    Vyhodnot (S2, List);
  end;

  if NajdiSpojku ('!', S, S1, S2) then begin
    InsertItem ('!',List);
    Vyhodnot (S2, List);
  end;

  if (S = '') then Exit;
  InsertItem (S,List);
end;  { Vyhodnot }

function GetItem (var T: string; List: TStringList): boolean;
begin
  Result := false;
  if (List.Count = 0) then exit;
  T := List.Strings[0];
  List.Delete (0);
  Result := true;
end;


{--------------------------------------------------------------------Vycisli---}
{ Vycisli vyraz v polske notaci, ktery se sklada ze spojek (&, |, !) a cisel
  (0, 1)
}
function Vycisli (List: TstringList): Byte;
var
  T: string;
begin
  Result := 0;
  if (not GetItem (T,List)) then exit;
  case T[1] of
    '&': Result := Vycisli (List) and Vycisli (List);
    '|': Result := Vycisli (List) or Vycisli (List);
    '!': Result := 1 - Vycisli (List);
    '0': Result := 0;
    '1': Result := 1;
  end;
end;


{----------------------------------------------------------------NajdiSpojky---}
{ prevede vsechny spojky and, not, or na jednoznakove ekvivalenty (&, !, |)    }
procedure NajdiSpojky (var S: string);
var
  i, N: integer;
begin { NajdiSpojky }

  N := length (S);
  i := 1;
  while i < N - 2+1 do begin
    if (UpperCase (copy (S, i, 2)) = 'OR') and
       ((i = 1) or (S[i-1] = ' ') or (S[i-1] = '(')) and
       ((i+1 = N) or (S[i+2] = ' ') or (S[i+2] = ')')) then begin
         Delete (S, i, 2);
         Insert ('|', S, i);
         i := 1;
         N := length (S);
    end;
    inc (i);
  end;

  N := length (S);
  i := 1;
  while i < N - 3+1 do begin
    if (UpperCase (copy (S, i, 3)) = 'AND') and
       ((i = 1) or (S[i-1] = ' ') or (S[i-1] = '(')) and
       ((i+1 = N) or (S[i+3] = ' ') or (S[i+3] = ')')) then begin
         Delete (S, i, 3);
         Insert ('&', S, i);
         i := 1;
         N := length (S);
    end;
    inc (i);
  end;

  N := length (S);
  i := 1;
  while i < N - 3+1 do begin
    if (UpperCase (copy (S, i, 3)) = 'NOT') and
       ((i = 1) or (S[i-1] = ' ') or (S[i-1] = '(')) and
       ((i+1 = N) or (S[i+3] = ' ') or (S[i+3] = ')')) then begin
         Delete (S, i, 3);
         Insert ('!', S, i);
         i := 1;
         N := length (S);
    end;
    inc (i);
  end;
end; { NajdiSpojky }

begin
end.