object Form1: TForm1
  Left = 280
  Top = 487
  Width = 833
  Height = 591
  AutoSize = True
  Caption = 'GraficDrawer v. 2.1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 0
    Top = 9
    Width = 23
    Height = 24
    Caption = 'Y='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Pole: TImage
    Left = 223
    Top = 0
    Width = 586
    Height = 513
    AutoSize = True
  end
  object GroupBox3: TGroupBox
    Left = 9
    Top = 344
    Width = 207
    Height = 161
    Caption = #1058#1072#1073#1091#1083#1103#1094#1080#1103' '#1092#1091#1085#1082#1094#1080#1080
    TabOrder = 7
    object Tabulation: TStringGrid
      Left = 20
      Top = 22
      Width = 166
      Height = 123
      ColCount = 2
      DefaultColWidth = 80
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 57
    Width = 207
    Height = 240
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1089#1077#1081
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 13
      Width = 112
      Height = 13
      Caption = #1054#1089#1100' '#1072#1073#1089#1094#1080#1089#1089' ('#1054#1089#1100' OX)'
    end
    object Label2: TLabel
      Left = 7
      Top = 118
      Width = 111
      Height = 13
      Caption = #1054#1089#1100' '#1086#1088#1076#1080#1085#1072#1090' ('#1054#1089#1100' OY)'
    end
    object StepX: TLabeledEdit
      Left = 91
      Top = 46
      Width = 36
      Height = 21
      Hint = #1064#1072#1075' '#1075#1088#1072#1076#1091#1080#1088#1086#1074#1072#1085#1080#1103' '#1086#1089#1080' '#1072#1073#1089#1094#1080#1089#1089
      HelpContext = 3
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = #1064#1072#1075
      TabOrder = 2
    end
    object XminEdit: TLabeledEdit
      Left = 12
      Top = 46
      Width = 34
      Height = 21
      Hint = #1053#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1100' '#1080#1085#1090#1077#1088#1072#1074#1083#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1072#1088#1075#1091#1084#1077#1085#1090#1072' '#1092#1091#1085#1082#1094#1080#1080
      HelpContext = 1
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Xmin'
      TabOrder = 0
    end
    object XmaxEdit: TLabeledEdit
      Left = 52
      Top = 46
      Width = 34
      Height = 21
      Hint = #1042#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1100' '#1080#1085#1090#1077#1088#1072#1074#1083#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1072#1088#1075#1091#1084#1077#1085#1090#1072' '#1092#1091#1085#1082#1094#1080#1080
      HelpContext = 1
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Xmax'
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 7
      Top = 86
      Width = 189
      Height = 14
      HelpContext = 3
      Caption = #1055#1088#1086#1075#1088#1072#1076#1091#1080#1088#1086#1074#1072#1090#1100' '#1086#1089#1100' '#1072#1073#1089#1094#1080#1089#1089
      TabOrder = 3
    end
    object CheckBox2: TCheckBox
      Left = 7
      Top = 184
      Width = 189
      Height = 20
      HelpContext = 3
      Caption = #1055#1088#1086#1075#1088#1072#1076#1091#1080#1088#1086#1074#1072#1090#1100' '#1086#1089#1100' '#1086#1088#1076#1080#1085#1072#1090
      TabOrder = 7
    end
    object StepY: TLabeledEdit
      Left = 91
      Top = 157
      Width = 38
      Height = 21
      Hint = #1064#1072#1075' '#1075#1088#1072#1076#1091#1080#1088#1086#1074#1072#1085#1080#1103' '#1086#1089#1080' '#1086#1088#1076#1080#1085#1072#1090
      HelpContext = 3
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = #1064#1072#1075
      TabOrder = 6
    end
    object YminEdit: TLabeledEdit
      Left = 11
      Top = 157
      Width = 35
      Height = 21
      Hint = #1053#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1100' '#1080#1085#1090#1077#1088#1072#1074#1083#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1092#1091#1085#1082#1094#1080#1080
      HelpContext = 2
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Ymin'
      TabOrder = 4
    end
    object YmaxEdit: TLabeledEdit
      Left = 52
      Top = 157
      Width = 36
      Height = 21
      Hint = #1042#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1100' '#1080#1085#1090#1077#1088#1072#1074#1083#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1092#1091#1085#1082#1094#1080#1080
      HelpContext = 2
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Ymax'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 9
    Top = 293
    Width = 207
    Height = 53
    Caption = #1062#1074#1077#1090' '#1075#1088#1072#1092#1080#1082#1072
    TabOrder = 2
    object ColorBox: TColorBox
      Left = 15
      Top = 20
      Width = 150
      Height = 22
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1094#1074#1077#1090' '#1075#1088#1072#1092#1080#1082#1072' '#1074' '#1088#1072#1089#1082#1088#1099#1074#1072#1102#1097#1077#1084#1089#1103' '#1089#1087#1080#1089#1082#1077
      DefaultColorColor = clRed
      Style = [cbStandardColors, cbPrettyNames]
      DropDownCount = 10
      ItemHeight = 16
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object BitBtn2: TBitBtn
    Left = 362
    Top = 472
    Width = 92
    Height = 33
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 4
    Visible = False
    OnClick = BitBtn2Click
  end
  object Button1: TButton
    Left = 49
    Top = 264
    Width = 113
    Height = 25
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 465
    Top = 472
    Width = 97
    Height = 33
    HelpContext = 5
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
    TabOrder = 5
    Visible = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 569
    Top = 472
    Width = 97
    Height = 33
    HelpContext = 5
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
    TabOrder = 6
    Visible = False
    WordWrap = True
  end
  object BitBtn3: TBitBtn
    Left = 752
    Top = 504
    Width = 73
    Height = 33
    TabOrder = 8
    Visible = False
    OnClick = BitBtn3Click
    Kind = bkHelp
  end
  object ComboBox1: TComboBox
    Left = 32
    Top = 8
    Width = 161
    Height = 21
    AutoCloseUp = True
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 9
    OnClick = ComboBox1Click
  end
  object InputPole: TEdit
    Left = 32
    Top = 8
    Width = 161
    Height = 25
    HelpContext = 4
    TabOrder = 0
    OnChange = InputPoleChange
  end
  object SaveDialog1: TSaveDialog
    Filter = #1060#1072#1081#1083#1099' '#1089#1086#1093#1088#1072#1085#1077#1085#1085#1099#1093' '#1087#1088#1086#1077#1082#1090#1086#1074'|*.gdr'
    Left = 192
    Top = 512
  end
  object OpenDialog1: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' '#1089#1086#1093#1088#1072#1085#1077#1085#1085#1099#1093' '#1087#1088#1086#1077#1082#1090#1086#1074'|*.gdr'
    Left = 144
    Top = 512
  end
  object MainMenu1: TMainMenu
    Left = 96
    Top = 512
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N4: TMenuItem
        Caption = #1053#1086#1074#1086#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1077
        OnClick = N4Click
      end
      object N2: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = N3Click
      end
      object N5: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object N7: TMenuItem
      Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077
      object N8: TMenuItem
        Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1103
        OnClick = N9Click
      end
    end
    object N10: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N11: TMenuItem
        Caption = #1056#1091#1082#1086#1074#1086#1076#1089#1090#1074#1086
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N12Click
      end
    end
  end
  object Table1: TTable
    Left = 232
    Top = 512
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 64
    Top = 512
  end
  object Query1: TQuery
    BeforeOpen = Query1BeforeOpen
    SQL.Strings = (
      '')
    Left = 32
    Top = 512
  end
  object PopupMenu1: TPopupMenu
    Left = 280
    Top = 504
    object N13: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N13Click
    end
  end
end
