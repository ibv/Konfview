unit My_ac;

{$MODE Delphi}

{-----------------------------------------------------------------------------}
interface
{-----------------------------------------------------------------------------}
  procedure InicializaceAutomatu;
  procedure PridejSlovo (S: string);
  procedure SpoctiF (S: string);
  procedure Find (T: string);

const
  nStav = 200;     { Maximalni pocet stavu }
  AbcBegin = #0;   { Zacatek a konec abecedy }
  AbcEnd = #255;
  fail = -1;

type
  tStav    = -1..nStav;           { Stav automatu      -1 = fail }
  tAbeceda = AbcBegin..AbcEnd;    { Abeceda }

  tG = array [tStav, tAbeceda] of tStav;  { Dopredna funkce }
  tF = array [tStav] of tStav;            { Zpetna funkce }
  tVystup = array [tStav] of Byte;        { Oznaceni vystupnich stavu }

var
  F: tF;
  G: tG;
  Vystup: tVystup;
  LastStav: tStav;

{-----------------------------------------------------------------------------}
implementation
{-----------------------------------------------------------------------------}

{-------------------------------------------------------InicializaceAutomatu---}
procedure InicializaceAutomatu;
var
  i: tStav;
  j: tAbeceda;
begin { InicializaceAutomatu }
  { Vynuluje se automat (F, G, Vystup, Pocet stavu) }
  for i := 0 to nStav do begin
    for j := AbcBegin to AbcEnd do
      G [i, j] := -1;
    F [i] := -1;
    Vystup [i] := 0;
  end;
  LastStav := 0;

  { Zpetna funkce pro q0 = q0 }
  F[0] := 0;

  for j := AbcBegin to AbcEnd do
    G [0, j] := 0;
end; { InicializaceAutomatu }

{-----------------------------------------------------------------SpoctiF---}
{ Spocte pro vsechny stavy zadaneho slova zpetnou funkci F }
procedure SpoctiF (S: string);
var
  i, N: Byte;
  P, Q: tStav;
begin { SpoctiF }
  N := Length (S);

  Q := G[0, S[1]];
  F[Q] := 0;
  { Zpetna fce pro q0 je q0, pro vsechny stavy vzdalene od q0 o jednotku je
    to taktez q0.
    Pro ostatni stavy se to spocte nasledovne:

      P           Q
      o---------->o
            x

    f (Q) := g(f(P), x)
  }

  for i := 2 to N do begin
    P := Q;
    Q := G[P, S[i]];
    F [Q] := G [F[P], S[i]];
    if (F[Q] = fail) then F[Q] := 0;
  end;
end; { SpoctiF }

{-------------------------------------------------------------PridejSlovo---}
{ Prida slovo do automatu }
procedure PridejSlovo (S: string);
var
  Q: tStav;
  i, j, N: Byte;
begin { PridejSlovo }
  Q := 0;
  i := 1;
  N := Length (S);

  { Dokud existuje cesta .... jsu po ni }
  while (i <= N) and (G[Q, S[i]] > 0) do begin
    Q := G[Q, S[i]];
    inc (i);
  end;

  if (i > N) then begin
    { Cele slovo je podslovem nejakeho vetsiho slova, ktere je jiz v automatu }
    Vystup [Q] := 1;
    Exit;
  end;

  { Zaradime zbytek slova do automatu }
  for j := i to N do begin
    inc (LastStav);
    G [Q, S[j]] := LastStav;
    Q := LastStav;
  end;
  Vystup [LastStav] := 1;
end; { PridejSlovo }

{-----------------------------------------------------------------VypisGF---}
{ toto je fce pouzitelna pouze v DOSu pro vypis fci G, F a Vystup }
procedure VypisGF;
var
  i: tStav;
  j: tAbeceda;
begin { VypisGF }
  Write ('  ');
  for j := AbcBegin to AbcEnd do
    Write (j:2,' ');
  Writeln;

  for i := 0 to LastStav do begin
    Write (i, ':');
    for j := AbcBegin to AbcEnd do
      if (G [i, j] <> -1) then
        Write (G [i, j]:2,'_')
      else
        Write ('___');
    Writeln (F[i]:3, ' ', Vystup[i]);
  end;
end;  { VypisGF }


{----------------------------------------------------------------------Delta---}
{ Prechodova fce }
function Delta (Q:tStav; X: tAbeceda): tStav;
begin { Delta }
  { Dokud s novym pismenkem fejluju, hledam jiny stav }
  while G[Q, X] = fail do
    Q := F[Q];
  Delta := G[Q, X];
end;  { Delta }

procedure VypisNalez (Q: tStav);
begin
  if (Vystup[Q]<>0) then Vystup[Q] := 2;
  repeat
    Q := F[Q];
    if (Vystup[Q]<>0) then Vystup[Q] := 2;
  until Q = 0;
end;



{-----------------------------------------------------------------------Find---}
// T je retezec, kde se vyhledava
procedure Find (T: string);
var
  Q: tStav;
  i, N: longint;
begin { ACFind }
  Q := 0;
  N := length (T);
  for i := 1 to N do begin
    Q := Delta (Q,T[i]);       // prechodova funkce
    VypisNalez (Q);            // nastavi, ze to nasel
  end;
end; { Find }

{---------------------------------------------------------------------ACFind---}
{ Vstup - seznam hledanych slov }
procedure ACFind;
begin { ACFind }

end;  { ACFind }


{===========================================================================}
begin
(*
  Writeln ('----------------');
  VytvorAutomat;
  PridejSlovo ('he');
  PridejSlovo ('she');
  PridejSlovo ('his');
  PridejSlovo ('hers');

  SpoctiF ('he');
  SpoctiF ('she');
  SpoctiF ('his');
  SpoctiF ('hers');

{  VypisGF;}
  Writeln ('====================');
  Find ('hjktfvhedc,tgvt,v ftjmdeujrxderdridherfdkfdrfffdrkfrtftrfktftgtfsherstgt');
  *)
end.
