object ExceptionDialog: TExceptionDialog
  Left = 363
  Height = 369
  Top = 284
  Width = 540
  ActiveControl = OkBtn
  BorderIcons = [biSystemMenu]
  Caption = 'ExceptionDialog'
  ClientHeight = 369
  ClientWidth = 540
  Color = clBtnFace
  Constraints.MinWidth = 200
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  Position = poMainFormCenter
  ShowHint = True
  LCLVersion = '2.0.0.4'
  object Bevel1: TBevel
    Left = 3
    Height = 9
    Top = 91
    Width = 536
    Anchors = [akTop, akLeft, akRight]
    Shape = bsTopLine
  end
  object OkBtn: TButton
    Left = 460
    Height = 25
    Top = 4
    Width = 75
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object DetailsMemo: TMemo
    Left = 4
    Height = 264
    Top = 101
    Width = 532
    Anchors = [akTop, akLeft, akRight, akBottom]
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object DetailsBtn: TButton
    Left = 460
    Height = 25
    Hint = 'Show or hide additional information|'
    Top = 60
    Width = 75
    Anchors = [akTop, akRight]
    Caption = '&Details'
    Enabled = False
    OnClick = DetailsBtnClick
    TabOrder = 2
  end
  object TextLabel: TMemo
    Left = 56
    Height = 75
    Hint = 'Use Ctrl+C to copy the report to the clipboard'
    Top = 8
    Width = 389
    Anchors = [akTop, akLeft, akRight]
    BorderStyle = bsNone
    Lines.Strings = (
      'TextLabel'
    )
    ParentColor = True
    ReadOnly = True
    TabOrder = 4
  end
  object bTerminate: TButton
    Left = 460
    Height = 25
    Top = 32
    Width = 75
    Anchors = [akTop, akRight]
    Caption = '&Terminate'
    OnClick = bTerminateClick
    TabOrder = 1
  end
end
