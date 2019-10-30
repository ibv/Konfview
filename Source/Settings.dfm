object fSettings: TfSettings
  Left = 315
  Height = 507
  Top = 184
  Width = 570
  BorderStyle = bsDialog
  Caption = 'Nastavení'
  ClientHeight = 507
  ClientWidth = 570
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object GroupBox1: TGroupBox
    Left = 8
    Height = 177
    Top = 8
    Width = 193
    Caption = ' Filtrování odpovědí '
    ClientHeight = 162
    ClientWidth = 191
    TabOrder = 0
    object lExample: TLabel
      Left = 8
      Height = 15
      Top = 7
      Width = 177
      AutoSize = False
      Caption = '""'
      Font.CharSet = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Fixedsys'
      ParentColor = False
      ParentFont = False
    end
    object lbRe: TListBox
      Left = 8
      Height = 129
      Top = 25
      Width = 113
      Font.CharSet = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Items.Strings = (
        ':'
        'Re'
        '(2)'
        '(3)'
        '(4)'
        '(5)'
        '[2]'
        '[3]'
        '[4]'
        '[5]'
        '(2x)'
        '(3x)'
        '(4x)'
        '(5x)'
        'Re-'
        'Re.'
        'FWD'
        'FW'
        '(Fwd)'
        '(Delphi)'
        '[dt]'
        '"FWD"'
        '>'
        '['
        '2'
        '3'
        '4'
        '5'
      )
      ItemHeight = 20
      OnClick = lbReClick
      ParentFont = False
      ScrollWidth = 98
      TabOrder = 0
    end
    object edRe: TEdit
      Left = 128
      Height = 25
      Top = 129
      Width = 57
      TabOrder = 1
    end
    object btAdd: TButton
      Left = 128
      Height = 25
      Top = 97
      Width = 57
      Caption = '&Přidej'
      OnClick = btAddClick
      TabOrder = 4
    end
    object btDel: TButton
      Left = 128
      Height = 25
      Top = 65
      Width = 57
      Caption = '&Smaž'
      OnClick = btDelClick
      TabOrder = 3
    end
    object Button1: TButton
      Left = 128
      Height = 25
      Top = 33
      Width = 57
      Caption = 'Pů&vodní'
      OnClick = Button1Click
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 208
    Height = 184
    Top = 8
    Width = 356
    Caption = ' Nastavení konce zpráv '
    ClientHeight = 169
    ClientWidth = 354
    TabOrder = 1
    object lbEOM: TListBox
      Left = 8
      Height = 121
      Top = 7
      Width = 274
      Font.CharSet = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Items.Strings = (
        '---------- End of message ----------'
        '-- End --'
        '==============================================================================='
      )
      ItemHeight = 20
      ParentFont = False
      ScrollWidth = 563
      TabOrder = 0
    end
    object btAddEOM: TButton
      Left = 288
      Height = 25
      Top = 97
      Width = 60
      Caption = '&Přidej'
      OnClick = btAddEOMClick
      TabOrder = 4
    end
    object btDelEOM: TButton
      Left = 288
      Height = 25
      Top = 65
      Width = 60
      Caption = '&Smaž'
      OnClick = btDelEOMClick
      TabOrder = 3
    end
    object edEOM: TEdit
      Left = 8
      Height = 25
      Top = 129
      Width = 274
      TabOrder = 1
    end
    object Button2: TButton
      Left = 288
      Height = 25
      Top = 33
      Width = 60
      Caption = 'Pů&vodní'
      OnClick = Button2Click
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Height = 185
    Top = 192
    Width = 374
    Caption = ' Další nastavení '
    ClientHeight = 170
    ClientWidth = 372
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Height = 14
      Top = 89
      Width = 113
      Caption = '&Adresář pro přílohy:'
      FocusControl = edAttach
      ParentColor = False
    end
    object btClearHistory: TButton
      Left = 8
      Height = 25
      Top = 135
      Width = 144
      Caption = 'Smazat historii hledání'
      OnClick = btClearHistoryClick
      TabOrder = 4
    end
    object cbFindInNext: TCheckBox
      Left = 8
      Height = 32
      Top = 9
      Width = 364
      Caption = 'Pokud není slovo nalezeno v aktuálním  příspěvku, '#10'hledá se v dalším (při vyhledávání v příspěvku klávesou F3)'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object edAttach: TEdit
      Left = 8
      Height = 25
      Top = 106
      Width = 313
      TabOrder = 2
    end
    object cbSaveAttach: TCheckBox
      Left = 8
      Height = 23
      Top = 53
      Width = 155
      Caption = 'Ukládat přílohy na disk'
      OnClick = cbSaveAttachClick
      TabOrder = 1
    end
    object btAttach: TButton
      Left = 320
      Height = 22
      Top = 109
      Width = 23
      Caption = '...'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'System'
      OnClick = btAttachClick
      ParentFont = False
      TabOrder = 3
    end
  end
  object GroupBox4: TGroupBox
    Left = 387
    Height = 185
    Top = 192
    Width = 177
    Caption = ' Barvičky '
    ClientHeight = 170
    ClientWidth = 175
    TabOrder = 3
    object cbColorFindWords: TCheckBox
      Left = 8
      Height = 23
      Top = 144
      Width = 161
      Caption = 'Zvýraznit hledaná slova'
      TabOrder = 4
    end
    object btNormal: TButton
      Left = 8
      Height = 25
      Top = 16
      Width = 137
      Caption = 'Normální'
      OnClick = btNormalClick
      TabOrder = 0
    end
    object btQuote: TButton
      Left = 8
      Height = 25
      Top = 48
      Width = 137
      Caption = '> Quotace'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      OnClick = btNormalClick
      ParentFont = False
      TabOrder = 1
    end
    object btHref: TButton
      Left = 8
      Height = 25
      Top = 80
      Width = 137
      Caption = 'Odkaz'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      OnClick = btNormalClick
      ParentFont = False
      TabOrder = 2
    end
    object btFind: TButton
      Left = 8
      Height = 25
      Top = 112
      Width = 137
      Caption = 'Hledané slovo'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      OnClick = btNormalClick
      ParentFont = False
      TabOrder = 3
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Height = 114
    Top = 384
    Width = 201
    Caption = ' Označení sekcí '
    ClientHeight = 99
    ClientWidth = 199
    TabOrder = 4
    object Label3: TLabel
      Left = 16
      Height = 14
      Top = 24
      Width = 32
      Caption = 'From:'
      ParentColor = False
    end
    object Label4: TLabel
      Left = 16
      Height = 14
      Top = 48
      Width = 30
      Caption = 'Date:'
      ParentColor = False
    end
    object Label5: TLabel
      Left = 16
      Height = 14
      Top = 72
      Width = 46
      Caption = 'Subject:'
      ParentColor = False
    end
    object edFrom: TEdit
      Left = 64
      Height = 25
      Top = 16
      Width = 121
      TabOrder = 0
    end
    object edDate: TEdit
      Left = 64
      Height = 25
      Top = 40
      Width = 121
      TabOrder = 1
    end
    object edSubj: TEdit
      Left = 64
      Height = 25
      Top = 64
      Width = 121
      TabOrder = 2
    end
  end
  object btOK: TButton
    Left = 409
    Height = 25
    Top = 473
    Width = 75
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btCancel: TButton
    Left = 489
    Height = 25
    Top = 473
    Width = 75
    Cancel = True
    Caption = 'Storno'
    ModalResult = 2
    TabOrder = 6
  end
  object fdFont: TFontDialog
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    MinFontSize = 0
    MaxFontSize = 0
    left = 296
    top = 400
  end
  object DirectoryDlg: TSelectDirectoryDialog
    left = 384
    top = 400
  end
end
