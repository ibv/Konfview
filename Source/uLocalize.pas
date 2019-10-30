unit uLocalize;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, LMessages, SysUtils{, Consts};

const
  rs_Error = 'Chyba';
  rs_Question = 'Potvrzení';
  rs_Warning = 'Varování';
  rs_Exclamation = 'Upozornìní';
  rs_Asterisk = 'Informace';
  rs_Yes = '&Ano';
  rs_No = '&Ne';
  rs_Cancel = '&Storno';
  rs_All = '&Ve';
  rs_OK = '&OK';

type
  TLocalizeResString = record
    ResString: PResStringRec;
    LocalizedText: string;
  end;

{ lokalizace dialogu MessageDlg }
procedure LocalizeDialogs;

implementation

{-----------------------------------------------------------------
  Prepsani resource v dialozich
------------------------------------------------------------------}
procedure LocalizeResStrings(const Strings: array of TLocalizeResString);
var
  I: Integer;
  OldProtect, Dummy: DWORD;
begin
  for I := Low(Strings) to High(Strings) do
    with Strings[I] do
    begin
      Win32Check(VirtualProtect(ResString, SizeOf(TResStringRec),
          PAGE_READWRITE, OldProtect));
      try
        ResString^.Identifier := Integer(PChar(LocalizedText));
      finally
        VirtualProtect(ResString, SizeOf(TResStringRec), OldProtect, Dummy);
      end;
    end;
end;

{-----------------------------------------------------------------
  Lokalizace dialogu
------------------------------------------------------------------}
procedure LocalizeDialogs;
var
  ResStrings: array[0..7] of TLocalizeResString;
begin
  ResStrings[0].ResString := @SMsgDlgYes;
  ResStrings[0].LocalizedText := rs_Yes;
  ResStrings[1].ResString := @SMsgDlgNo;
  ResStrings[1].LocalizedText:= rs_No;
  ResStrings[2].ResString := @SMsgDlgWarning;
  ResStrings[2].LocalizedText:= rs_Warning ;
  ResStrings[3].ResString := @SMsgDlgError;
  ResStrings[3].LocalizedText:= rs_Error;
  ResStrings[4].ResString := @SMsgDlgInformation;
  ResStrings[4].LocalizedText:= rs_Asterisk;
  ResStrings[5].ResString := @SMsgDlgConfirm;
  ResStrings[5].LocalizedText:= rs_Question;
  ResStrings[6].ResString := @SMsgDlgAll;
  ResStrings[6].LocalizedText:= rs_All;
  ResStrings[7].ResString := @SMsgDlgCancel;
  ResStrings[7].LocalizedText:= rs_Cancel;
  LocalizeResStrings(ResStrings);
end;

end.
 