object fAddFile: TfAddFile
  Tag = 1
  Left = 283
  Height = 231
  Top = 237
  Width = 287
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Načítám data...'
  ClientHeight = 231
  ClientWidth = 287
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnActivate = FormActivate
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object Bevel1: TBevel
    Left = 8
    Height = 65
    Top = 8
    Width = 273
    Shape = bsFrame
  end
  object llLine: TLabel
    Left = 88
    Height = 14
    Top = 40
    Width = 38
    Caption = 'Řádek:'
    ParentColor = False
  end
  object llMail: TLabel
    Left = 88
    Height = 14
    Top = 56
    Width = 45
    Caption = 'Zpráva:'
    ParentColor = False
  end
  object lLine: TLabel
    Left = 144
    Height = 14
    Top = 40
    Width = 8
    Caption = '0'
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lMail: TLabel
    Left = 144
    Height = 14
    Top = 56
    Width = 8
    Caption = '0'
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lFile: TLabel
    Left = 16
    Height = 13
    Top = 16
    Width = 257
    Alignment = taCenter
    AutoSize = False
    Caption = 'lFile'
    ParentColor = False
  end
  object Bevel2: TBevel
    Left = 8
    Height = 2
    Top = 32
    Width = 273
  end
  object lComment: TLabel
    Left = 8
    Height = 14
    Top = 152
    Width = 202
    Caption = 'Komentář k přidávaným záznamům:'
    ParentColor = False
  end
  object pbPos: TProgressBar
    Left = 8
    Height = 16
    Top = 130
    Width = 273
    BorderWidth = 1
    Smooth = True
    Step = 1
    TabOrder = 2
  end
  object edComment: TEdit
    Left = 8
    Height = 25
    Top = 168
    Width = 273
    TabOrder = 1
  end
  object btStop: TButton
    Left = 104
    Height = 25
    Top = 200
    Width = 81
    Caption = 'Stop'
    Default = True
    ModalResult = 3
    OnClick = btStopClick
    TabOrder = 0
  end
end
