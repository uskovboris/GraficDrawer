object Bilder: TBilder
  Left = 490
  Top = 271
  Width = 285
  Height = 338
  BorderStyle = bsSizeToolWin
  Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1077#1083#1100' '#1074#1099#1088#1072#1078#1077#1085#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 16
    Top = 8
    Width = 233
    Height = 65
    HelpContext = 6
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 96
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = '+'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 64
    Top = 96
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = '-'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 112
    Top = 96
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = '*'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button4: TButton
    Left = 160
    Top = 96
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = '/'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button5: TButton
    Left = 208
    Top = 96
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = 'X'
    TabOrder = 5
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 152
    Width = 105
    Height = 65
    HelpContext = 6
    ItemHeight = 13
    Items.Strings = (
      'SIN'
      'COS'
      'TAN'
      'ATN'
      'LOG'
      'EXP'
      'SQR'
      'ABS')
    TabOrder = 6
    OnClick = ListBox1Click
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 240
    Width = 57
    Height = 33
    HelpContext = 6
    TabOrder = 7
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 176
    Top = 240
    Width = 73
    Height = 33
    HelpContext = 6
    TabOrder = 8
    Kind = bkCancel
  end
  object Button6: TButton
    Left = 152
    Top = 152
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = '('
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button7: TButton
    Left = 200
    Top = 152
    Width = 33
    Height = 33
    HelpContext = 6
    Caption = ')'
    TabOrder = 10
    OnClick = Button1Click
  end
end
