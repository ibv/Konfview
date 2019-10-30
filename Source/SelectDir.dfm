object fSelectDir: TfSelectDir
  Left = 424
  Height = 295
  Top = 188
  Width = 248
  BorderStyle = bsDialog
  Caption = 'Výbìr adresáøe'
  ClientHeight = 295
  ClientWidth = 248
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object lPath: TLabel
    Left = 8
    Height = 13
    Top = 8
    Width = 233
    AutoSize = False
    Caption = 'P:\Exe5'
    ParentColor = False
  end
  object btOK: TButton
    Left = 86
    Height = 25
    Top = 264
    Width = 75
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object BitBtn2: TButton
    Left = 167
    Height = 25
    Top = 264
    Width = 75
    Cancel = True
    Caption = '&Zrušit'
    ModalResult = 2
    TabOrder = 1
  end
  object lbDirectory: TSelectDirectoryDialog
    FileName = '/mnt/data2/ivo/src/d/Prg/konfview/data'
    InitialDir = '/mnt/data2/ivo/src/d/Prg/konfview/'
    left = 8
    top = 32
  end
end
