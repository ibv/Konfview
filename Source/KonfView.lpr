program KonfView;

{$MODE Delphi}

uses
  {$IFnDEF FPC}
  {$ELSE}
  cthreads,
    //cmem,
  Interfaces,
  {$ENDIF}
  Forms,
  Main in 'Main.pas' {fMain},
  AddFile in 'AddFile.pas' {fAddFile},
  Settings in 'Settings.pas' {fSettings},
  Utils in 'Utils.pas',
  About in 'About.pas' {fAbout},
  GetNum in 'GetNum.pas' {fGetNum},
  Find in 'Find.pas' {fFind},
  My_ac in 'My_ac.pas',
  Vyraz in 'Vyraz.pas',
  Wait in 'Wait.pas' {fWait},
  NewBookmark in 'NewBookmark.pas' {fNewBookmark},
  Tisk in 'tisk.pas',
  StopRead in 'StopRead.pas' {fStopRead},
  GetKindOfFile in 'GetKindOfFile.pas' {fGetKindOfFile},
  ///SelectDir in 'SelectDir.pas' {fSelectDir},
  EditMenuBook in 'EditMenuBook.pas' {fEditMenuBook},
  Filtr in 'filtr.pas',
  DBInfo in 'DBInfo.pas' {fDBInfo},
  FindInText in 'FindInText.pas' {fFindInText};
  ///uLocalize in 'uLocalize.pas',
  ///uException in 'uException.pas' {ExceptionDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
