object Form1: TForm1
  Left = 382
  Top = 334
  Width = 315
  Height = 277
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1080' '#1092#1091#1085#1082#1094#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 72
    Top = 48
    Width = 161
    Height = 21
    AutoCloseUp = True
    ItemHeight = 13
    TabOrder = 0
    OnClick = ComboBox1Click
  end
  object Edit1: TEdit
    Left = 72
    Top = 48
    Width = 161
    Height = 21
    TabOrder = 1
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 104
    Top = 112
    Width = 81
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 152
    Top = 200
  end
  object Query1: TQuery
    DatabaseName = 
      'D:\Documents and Settings\Admin\'#1052#1086#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'\'#1055#1088#1086#1077#1082#1090#1099'\'#1055#1086#1089#1090#1088#1086#1080#1090#1077#1083 +
      #1100' '#1075#1088#1072#1092#1080#1082#1086#1074' 2.1.0'
    SQL.Strings = (
      '')
    Left = 120
    Top = 200
  end
end
