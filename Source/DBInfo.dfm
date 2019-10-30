object fDBInfo: TfDBInfo
  Left = 275
  Height = 338
  Top = 185
  Width = 507
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderWidth = 1
  Caption = 'Informace o databázi'
  ClientHeight = 338
  ClientWidth = 507
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
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
    Width = 40
    Caption = 'Název:'
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Height = 14
    Top = 25
    Width = 38
    Caption = 'Cesta:'
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lName: TLabel
    Left = 117
    Height = 14
    Top = 8
    Width = 36
    Caption = 'lName'
    ParentColor = False
  end
  object lPath: TLabel
    Left = 117
    Height = 14
    Top = 25
    Width = 28
    Caption = 'lPath'
    ParentColor = False
  end
  object Label5: TLabel
    Left = 8
    Height = 14
    Top = 72
    Width = 162
    Caption = 'Záznamy o plnění databáze:'
    ParentColor = False
  end
  object Label3: TLabel
    Left = 8
    Height = 14
    Top = 42
    Width = 96
    Caption = 'Počet záznamů:'
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lRecordCount: TLabel
    Left = 117
    Height = 14
    Top = 42
    Width = 76
    Caption = 'lRecordCount'
    ParentColor = False
  end
  object Bevel1: TBevel
    Left = 0
    Height = 64
    Top = 1
    Width = 497
    Anchors = [akTop, akLeft, akRight]
  end
  object BitBtn1: TButton
    Left = 413
    Height = 25
    Top = 271
    Width = 75
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object reComment: TMemo
    Left = 0
    Height = 176
    Top = 88
    Width = 497
    Anchors = [akTop, akLeft, akRight, akBottom]
    Font.CharSet = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    HideSelection = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssAutoBoth
    TabOrder = 1
    WantReturns = False
    WordWrap = False
  end
end
