unit SelectDir;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, Buttons, ExtCtrls;

type
  TfSelectDir = class(TForm)
    ///cbDrive: TDriveComboBox;
    ///lbDirectory: TDirectoryListBox;
    lPath: TLabel;
    btOK: TButton;
    BitBtn2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SelectDirectory (InitDir: string): string;
var
  fSelectDir: TfSelectDir;

implementation

{$R *.dfm}


//------------------------------------------------------------------------------
//                                                             SelectDirectory
//------------------------------------------------------------------------------
// Vybere adresar, pricemz jako vychozi pouzije InitDir.
function SelectDirectory (InitDir: string): string;
begin { SelectDirectory }
  Result := '';

  if fSelectDir = nil then fSelectDir := TfSelectDir.Create(nil);
  try
    ///fSelectDir.lbDirectory.Directory := InitDir;
    ///fSelectDir.lbDirectory.Update;
  except
    on EInOutError do begin
    end
  end;

  if (fSelectDir.ShowModal = mrOK) then
    ///Result := fSelectDir.lbDirectory.Directory;
  fSelectDir.Release;
  fSelectDir := nil;
end;  { SelectDirectory }


end.
