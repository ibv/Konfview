object fFind: TfFind
  Left = 234
  Height = 199
  Top = 174
  Width = 312
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Vyhledávání'
  ClientHeight = 199
  ClientWidth = 312
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnActivate = FormActivate
  OnCreate = FormCreate
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object pcFind: TPageControl
    Left = 7
    Height = 153
    Top = 8
    Width = 298
    ActivePage = tsNormal
    MultiLine = True
    TabIndex = 0
    TabOrder = 2
    Options = [nboMultiLine]
    object tsNormal: TTabSheet
      Caption = 'Obecné'
      ClientHeight = 129
      ClientWidth = 296
      object Label1: TLabel
        Left = 8
        Height = 14
        Top = 16
        Width = 125
        Caption = '&Hledané slovo (výraz):'
        FocusControl = cbFindWord
        ParentColor = False
      end
      object cbFindWord: TComboBox
        Left = 8
        Height = 27
        Top = 32
        Width = 273
        ItemHeight = 0
        TabOrder = 0
      end
      object cbCaseSensitiv: TCheckBox
        Left = 8
        Height = 23
        Top = 56
        Width = 217
        Caption = 'Rozlišovat malá a velká písmenka'
        TabOrder = 1
      end
      object cbSubjectToo: TCheckBox
        Left = 8
        Height = 23
        Top = 72
        Width = 171
        Caption = 'Hledat i v subjectu zprávy'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbSpecial: TCheckBox
        Left = 8
        Height = 23
        Top = 88
        Width = 186
        Caption = 'Použít rozšířené vyhledávání'
        OnClick = cbSpecialClick
        TabOrder = 3
      end
    end
    object tsSpecial: TTabSheet
      Caption = 'Rozšířené'
      ClientHeight = 129
      ClientWidth = 296
      ImageIndex = 1
      object Label5: TLabel
        Left = 8
        Height = 14
        Top = 32
        Width = 43
        Caption = 'Nadpis:'
        Enabled = False
        ParentColor = False
      end
      object Label6: TLabel
        Left = 8
        Height = 14
        Top = 56
        Width = 34
        Caption = 'Autor:'
        Enabled = False
        ParentColor = False
      end
      object Label7: TLabel
        Left = 8
        Height = 14
        Top = 80
        Width = 41
        Caption = 'Datum:'
        Enabled = False
        ParentColor = False
      end
      object Label2: TLabel
        Left = 8
        Height = 14
        Top = 104
        Width = 190
        Caption = 'Nalézt pouze prvních X příspěvkù:'
        Enabled = False
        ParentColor = False
      end
      object edSubject: TEdit
        Left = 56
        Height = 25
        Top = 24
        Width = 161
        Enabled = False
        TabOrder = 1
      end
      object edFrom: TEdit
        Left = 56
        Height = 25
        Top = 48
        Width = 161
        Enabled = False
        TabOrder = 3
      end
      object edDate: TEdit
        Left = 56
        Height = 25
        Top = 72
        Width = 161
        Enabled = False
        TabOrder = 5
      end
      object neCount: TEdit
        Left = 224
        Height = 25
        Top = 96
        Width = 57
        Enabled = False
        TabOrder = 7
        Text = '1'
      end
      object cbSubject: TComboBox
        Left = 224
        Height = 27
        Top = 24
        Width = 57
        Enabled = False
        ItemHeight = 0
        Items.Strings = (
          'AND'
          'NOT'
        )
        Style = csDropDownList
        TabOrder = 2
      end
      object cbFrom: TComboBox
        Left = 224
        Height = 27
        Top = 48
        Width = 57
        Enabled = False
        ItemHeight = 0
        Items.Strings = (
          'AND'
          'NOT'
        )
        Style = csDropDownList
        TabOrder = 4
      end
      object cbDate: TComboBox
        Left = 224
        Height = 27
        Top = 72
        Width = 57
        Enabled = False
        ItemHeight = 0
        Items.Strings = (
          'AND'
          'NOT'
        )
        Style = csDropDownList
        TabOrder = 6
      end
      object cbSpec: TCheckBox
        Left = 8
        Height = 23
        Top = 7
        Width = 186
        Caption = 'Použít rozšířené vyhledávání'
        OnClick = cbSpecClick
        TabOrder = 0
      end
    end
    object tsMethod: TTabSheet
      Caption = 'Způsob'
      ClientHeight = 129
      ClientWidth = 296
      ImageIndex = 2
      object rgMethod: TRadioGroup
        Left = 8
        Height = 73
        Top = 16
        Width = 273
        AutoFill = True
        Caption = ' Způsob hledání '
        ChildSizing.LeftRightSpacing = 6
        ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
        ChildSizing.EnlargeVertical = crsHomogenousChildResize
        ChildSizing.ShrinkHorizontal = crsScaleChilds
        ChildSizing.ShrinkVertical = crsScaleChilds
        ChildSizing.Layout = cclLeftToRightThenTopToBottom
        ChildSizing.ControlsPerLine = 1
        ClientHeight = 58
        ClientWidth = 271
        ItemIndex = 0
        Items.Strings = (
          'Hledat ve všech příspěvcích'
          'Hledat pouze v těchto vybraných příspěvcích'
          'Pokračovat v hledání (dohledat další)'
        )
        TabOrder = 0
      end
    end
  end
  object btOK: TButton
    Left = 149
    Height = 25
    Top = 167
    Width = 73
    Anchors = [akLeft, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 229
    Height = 25
    Top = 167
    Width = 75
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = '&Zrušit'
    ModalResult = 2
    TabOrder = 1
  end
end
