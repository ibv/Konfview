object fAbout: TfAbout
  Left = 486
  Height = 240
  Top = 188
  Width = 313
  BorderStyle = bsDialog
  Caption = 'Informace o aplikaci'
  ClientHeight = 240
  ClientWidth = 313
  Color = clBtnFace
  Font.CharSet = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnCreate = FormCreate
  Position = poMainFormCenter
  LCLVersion = '2.0.4.0'
  object lVerze: TLabel
    Left = 16
    Height = 14
    Top = 212
    Width = 36
    Caption = 'Verze:'
    ParentColor = False
  end
  object Panel1: TPanel
    Left = 8
    Height = 193
    Top = 8
    Width = 297
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ClientHeight = 193
    ClientWidth = 297
    TabOrder = 0
    object Label4: TLabel
      Left = 9
      Height = 14
      Top = 88
      Width = 83
      Caption = 'Petr Václavek'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Cursor = crHandPoint
      Left = 8
      Height = 14
      Top = 104
      Width = 157
      Caption = 'bla@atrey.karlin.mff.cuni.cz'
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      ParentColor = False
      ParentFont = False
      OnClick = Label10Click
      OnMouseUp = Label5MouseUp
    end
    object Label6: TLabel
      Cursor = crHandPoint
      Left = 8
      Height = 14
      Top = 120
      Width = 157
      Caption = 'http://vaclavek.hyperlinx.cz'
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = Label6DblClick
      OnDblClick = Label6DblClick
      OnMouseUp = Label5MouseUp
    end
    object Label2: TLabel
      Left = 80
      Height = 17
      Top = 38
      Width = 66
      Alignment = taCenter
      Caption = 'freeware'
      Font.Color = 14653050
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Height = 14
      Top = 152
      Width = 200
      Caption = 'Aktuální data konference Delphi.cz:'
      ParentColor = False
    end
    object Label9: TLabel
      Cursor = crHandPoint
      Left = 8
      Height = 14
      Top = 168
      Width = 221
      Caption = 'http://www.pspad.com/cz/konfview.htm'
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = Label6DblClick
      OnDblClick = Label6DblClick
    end
    object Label3: TLabel
      Left = 177
      Height = 14
      Top = 88
      Width = 53
      Caption = 'Jan Fiala'
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Cursor = crHandPoint
      Left = 176
      Height = 14
      Top = 104
      Width = 88
      Caption = 'jan.fiala@wo.cz'
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      ParentColor = False
      ParentFont = False
      OnClick = Label10Click
      OnMouseUp = Label5MouseUp
    end
    object Label10: TLabel
      Cursor = crHandPoint
      Left = 176
      Height = 14
      Top = 120
      Width = 126
      Caption = 'http://www.pspad.com'
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = Label6DblClick
      OnDblClick = Label6DblClick
      OnMouseUp = Label5MouseUp
    end
    object Panel2: TPanel
      Left = 64
      Height = 28
      Top = 8
      Width = 225
      BevelOuter = bvNone
      ClientHeight = 28
      ClientWidth = 225
      Color = 14653050
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 17
        Height = 19
        Top = 5
        Width = 182
        Caption = 'Prohlížeč konferencí'
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
    object Panel3: TPanel
      Left = 8
      Height = 57
      Top = 8
      Width = 65
      BevelOuter = bvNone
      ClientHeight = 57
      ClientWidth = 65
      Color = 14653050
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      object Image1: TImage
        Left = 13
        Height = 32
        Top = 13
        Width = 32
        AutoSize = True
        Picture.Data = {
          055449636F6EFE0200000000010001002020100000000000E802000016000000
          2800000020000000400000000100040000000000800200000000000000000000
          1000000000000000000000000000800000800000008080008000000080008000
          80800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00
          FFFF0000FFFFFF0000000000008FFFFFFFFFFFFF788800FF00000000008FFFFF
          FFFFFFF788800FFF00000000008FFFFFFFFFFF788800FFF000000000008FFFFF
          FFFFF788800FFF0000000000008FFFFFFFFF788800FFF00000000000008FFFFF
          FFF788800FFF000F000000000087777777788800FFF000FF0000000000888888
          8888800FFF000FFF000000008888888888880000F000FFFF0000008888888888
          88800000000FFFFF0000088800087F780000000F00FFFFFF0008880000000800
          000000F00FFFFFFF008880000FFFFFFF00000F00FFFFFFFF08800008FFFFF00F
          FF000000FFFFFFFF08000008FFFFFFF00FF0000FFFFFFFFF88000008FFFFFFFF
          F0FF000FFFFFFFFF80000008FFFFFFFFFFFFF000FFFFFFFF80000008FFFFFFFF
          FF0FF000FFFFFFFF000000088888888FFFFFFF000FFFFFFF0000000087FFFF87
          FFFFFF000FFFFFFF00000000087FFF87FFFFFF0008888888000000000087FF87
          FFFFFF00000000000000000000087F87FFFFFF00000000000000000000008787
          FFFFFF0000000000000000F000000887FFFFF000000000000000000000000088
          888880000000000000000000F00000000000000000000000000000000FFF000F
          00000000000000000000000000FFFF0000000000000000000000000000000000
          0000000000000000000000000087F78000000000000000000000000000008000
          0000000000000000FFC00000FFC00000FFC00000FFC00000FFC00000FFC00000
          FFC00000FFC00000FF000000FC000000F8000000E0000000C000000080000000
          86000000060000000E0000000E0000001E0000001F0000001F8000001FC0007F
          1FE0007F1FF0007F8DF800FF8FFC00FFC77FF1FFE38EE3FFF1C3C7FFF87F0FFF
          FC001FFFFF007FFF
        }
        Transparent = True
      end
    end
  end
  object BitBtn1: TButton
    Left = 240
    Height = 25
    Top = 208
    Width = 65
    Cancel = True
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
