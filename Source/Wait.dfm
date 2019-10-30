object fWait: TfWait
  Left = 444
  Top = 280
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Vyhledávám...'
  ClientHeight = 160
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 217
    Height = 113
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 56
    Top = 40
    Width = 38
    Height = 13
    Caption = 'Celkem:'
  end
  object Label2: TLabel
    Left = 56
    Top = 56
    Width = 57
    Height = 13
    Caption = 'Prohledáno:'
  end
  object Label3: TLabel
    Left = 56
    Top = 72
    Width = 65
    Height = 13
    Caption = 'Vyhovujících:'
  end
  object lCelkem: TLabel
    Left = 136
    Top = 40
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lAktualni: TLabel
    Left = 136
    Top = 56
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lVyhovujici: TLabel
    Left = 136
    Top = 72
    Width = 8
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lWhat: TLabel
    Left = 16
    Top = 16
    Width = 201
    Height = 15
    Alignment = taCenter
    AutoSize = False
    WordWrap = True
  end
  object pbPos: TProgressBar
    Left = 16
    Top = 96
    Width = 201
    Height = 16
    BorderWidth = 1
    Min = 0
    Max = 100
    Position = 50
    Smooth = True
    Step = 1
    TabOrder = 1
  end
  object btZrusit: TButton
    Left = 80
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Stop'
    ModalResult = 2
    TabOrder = 0
    OnClick = btZrusitClick
  end
end
