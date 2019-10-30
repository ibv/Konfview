object fGetNum: TfGetNum
  Left = 340
  Height = 73
  Top = 297
  Width = 168
  BorderStyle = bsDialog
  Caption = 'Skok na zprávu'
  ClientHeight = 73
  ClientWidth = 168
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object Label1: TLabel
    Left = 8
    Height = 14
    Top = 16
    Width = 73
    Caption = 'Číslo zprávy:'
    ParentColor = False
  end
  object edNum: TEdit
    Left = 80
    Height = 20
    Top = 8
    Width = 81
    TabOrder = 2
    Text = '1'
  end
  object btOK: TButton
    Left = 6
    Height = 25
    Top = 43
    Width = 75
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 86
    Height = 25
    Top = 43
    Width = 75
    Cancel = True
    Caption = '&Zrušit'
    ModalResult = 2
    TabOrder = 1
  end
end
