object fNewBookmark: TfNewBookmark
  Left = 307
  Top = 319
  BorderStyle = bsDialog
  Caption = 'Nová záložka'
  ClientHeight = 89
  ClientWidth = 170
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 99
    Height = 13
    Caption = 'Název nové záložky:'
  end
  object edNazev: TEdit
    Left = 8
    Top = 24
    Width = 153
    Height = 21
    TabOrder = 0
  end
  object btOK: TButton
    Left = 8
    Top = 56
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 88
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Zružit'
    ModalResult = 2
    TabOrder = 2
  end
end
