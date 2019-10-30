unit Tisk;

{$MODE Delphi}

interface
  function InitPrint (var PrnFile: TextFile): Boolean;
  function PrintLine (S: string; var F: TextFile): Boolean;

implementation
uses
  Printers, Graphics, SysUtils, LCLIntf, LCLType, LMessages, Dialogs;

//------------------------------------------------------------------------------
//                                                                    InitPrint
//------------------------------------------------------------------------------
// Nastaveni fontu, jeho vysky a podobne
function InitPrint (var PrnFile: TextFile): Boolean;
begin { InitPrint }
  Result := false;

  if Printer.Printers.Count = 0 then begin
    ShowMessage ('Nemáte nainstalovanou žádnou tiskárnu.');
    exit;
  end;



  try
    ///AssignPrn (PrnFile);
    Rewrite (PrnFile);
  except
    ///On EWin32Error do begin
    ///  MessageDlg('Nepodařilo se inicializovat tiskarnu', mtError, [mbOK], 0);
      exit;
    ///end;
  end;

  ///with Printer do begin
  ///  with Canvas.Font do begin
  ///    Charset := {238;//}EASTEUROPE_CHARSET;// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
  ///    Name := 'Courier';
  ///    Pitch := fpDefault;
  ///    Size := 11;
  ///    Style := [];
  ///  end;
  ///end;

  Result := true;
end;  { InitPrint }


//------------------------------------------------------------------------------
//                                                                    PrintLine
//------------------------------------------------------------------------------
function PrintLine (S: string; var F: TextFile): Boolean;
begin { PrintLine }
  {$I-}
  Writeln (F, S);
  {$I+}
  if (IOResult <> 0) then begin
    MessageDlg ('Chyba tisku', mtError ,[mbOK], 0);
    CloseFile (F);
    Result := false;
    exit;
  end;
  Result := true;
end;  { PrintLine }

end.
