object fGetKindOfFile: TfGetKindOfFile
  Left = 312
  Height = 108
  Top = 127
  Width = 448
  BorderStyle = bsDialog
  Caption = 'Výběr druhu vstupních dat'
  ClientHeight = 108
  ClientWidth = 448
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object rgKind: TRadioGroup
    Left = 8
    Height = 65
    Top = 8
    Width = 432
    AutoFill = True
    Caption = ' Výběr formátu vstupních dat '
    ChildSizing.LeftRightSpacing = 6
    ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
    ChildSizing.EnlargeVertical = crsHomogenousChildResize
    ChildSizing.ShrinkHorizontal = crsScaleChilds
    ChildSizing.ShrinkVertical = crsScaleChilds
    ChildSizing.Layout = cclLeftToRightThenTopToBottom
    ChildSizing.ControlsPerLine = 1
    ClientHeight = 50
    ClientWidth = 430
    ItemIndex = 0
    Items.Strings = (
      'Data z jednoho souboru (který byl vygenerován poštovním klientem)'
      'Data ve více souborech (ve formátu archívu na webu)'
    )
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 365
    Height = 25
    Top = 79
    Width = 75
    Cancel = True
    Caption = '&Zrušit'
    ModalResult = 2
    TabOrder = 2
  end
  object btOK: TButton
    Left = 285
    Height = 25
    Top = 79
    Width = 73
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
