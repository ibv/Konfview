object fFindInText: TfFindInText
  Left = 388
  Height = 205
  Top = 234
  Width = 276
  ActiveControl = memFindWords
  Anchors = []
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Vyhledávání v textu'
  ClientHeight = 205
  ClientWidth = 276
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnActivate = FormActivate
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object Label1: TLabel
    Left = 8
    Height = 14
    Top = 8
    Width = 246
    Caption = '&Hledané slova (každé slovo na nový řádek):'
    ParentColor = False
  end
  object memFindWords: TMemo
    Left = 8
    Height = 137
    Top = 24
    Width = 249
    OnKeyPress = memFindWordsKeyPress
    TabOrder = 0
  end
  object btOK: TButton
    Left = 101
    Height = 25
    Top = 172
    Width = 73
    Anchors = [akLeft, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 181
    Height = 25
    Top = 172
    Width = 75
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = '&Zrušit'
    ModalResult = 2
    TabOrder = 2
  end
end
