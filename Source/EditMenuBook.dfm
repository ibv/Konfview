object fEditMenuBook: TfEditMenuBook
  Left = 348
  Top = 207
  Width = 467
  Height = 375
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Editace záložek'
  Color = clBtnFace
  Constraints.MinHeight = 275
  Constraints.MinWidth = 355
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object tvBook: TTreeView
    Left = 6
    Top = 8
    Width = 364
    Height = 333
    Anchors = [akLeft, akTop, akRight, akBottom]
    DragMode = dmAutomatic
    HideSelection = False
    Indent = 19
    PopupMenu = pmEdBook
    TabOrder = 0
    ToolTips = False
    OnDragDrop = tvBookDragDrop
    OnDragOver = tvBookDragOver
    OnEditing = tvBookEditing
    OnStartDrag = tvBookStartDrag
  end
  object btNewFolder: TButton
    Left = 379
    Top = 112
    Width = 73
    Height = 25
    Hint = 'Vytvoří novou složku'
    Anchors = [akTop, akRight]
    Caption = '&Nová'
    TabOrder = 4
    OnClick = acbNewFolderExecute
  end
  object btOK: TButton
    Left = 379
    Top = 277
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 6
  end
  object btCancel: TButton
    Left = 379
    Top = 309
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Zrušit'
    ModalResult = 2
    TabOrder = 7
  end
  object btDel: TButton
    Left = 379
    Top = 144
    Width = 73
    Height = 25
    Hint = 'Smaže vybranou složku nebo záložku'
    Anchors = [akTop, akRight]
    Caption = '&Smazat'
    TabOrder = 5
    OnClick = acbDeleteExecute
  end
  object btLeft: TButton
    Left = 379
    Top = 8
    Width = 73
    Height = 25
    Hint = 'Posun o úroveň výše'
    Anchors = [akTop, akRight]
    Caption = 'Doleva'
    TabOrder = 1
    OnClick = acLeftExecute
  end
  object btUP: TButton
    Left = 379
    Top = 40
    Width = 73
    Height = 25
    Hint = 'Posun nahoru'
    Anchors = [akTop, akRight]
    Caption = '&Nahoru'
    TabOrder = 2
    OnClick = acUpExecute
  end
  object btDown: TButton
    Left = 379
    Top = 72
    Width = 73
    Height = 25
    Hint = 'Posun dolů'
    Anchors = [akTop, akRight]
    Caption = '&Dolù'
    TabOrder = 3
    OnClick = acDownExecute
  end
  object acBook: TActionList
    Left = 328
    Top = 8
    object acbRename: TAction
      Caption = '&Přejmenovat'
      Hint = 'Přejmenuje složku nebo záložku'
      ImageIndex = 2
      ShortCut = 113
      OnExecute = acbRenameExecute
      OnUpdate = acbRenameUpdate
    end
    object acbDelete: TAction
      Caption = '&Smazat'
      Hint = 'Smaže vybranou složku nebo záložku'
      ImageIndex = 3
      ShortCut = 46
      OnExecute = acbDeleteExecute
      OnUpdate = acbRenameUpdate
    end
    object acbNewFolder: TAction
      Caption = '&Nová složka'
      Hint = 'Vytvoří novou složku'
      ImageIndex = 1
      ShortCut = 45
      OnExecute = acbNewFolderExecute
    end
    object acUp: TAction
      Caption = '&Nahoru'
      Hint = 'Posun nahoru'
      ImageIndex = 5
      OnExecute = acUpExecute
      OnUpdate = acUpUpdate
    end
    object acDown: TAction
      Caption = '&Dolů'
      Hint = 'Posun dolů'
      ImageIndex = 4
      OnExecute = acDownExecute
      OnUpdate = acDownUpdate
    end
    object acLeft: TAction
      Caption = 'Doleva'
      Hint = 'Posun o úroveň výše'
      ImageIndex = 6
      OnExecute = acLeftExecute
      OnUpdate = acLeftUpdate
    end
  end
  object pmEdBook: TPopupMenu
    Left = 328
    Top = 40
    object Novsloka1: TMenuItem
      Action = acbNewFolder
    end
    object Pejmenovat1: TMenuItem
      Action = acbRename
    end
    object Smazat1: TMenuItem
      Action = acbDelete
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Doleva1: TMenuItem
      Action = acLeft
    end
    object Nahoru1: TMenuItem
      Action = acUp
    end
    object Dol1: TMenuItem
      Action = acDown
    end
  end
end
