object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 381
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 177
    Height = 145
    Caption = 'Sample 1'
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 23
      Width = 157
      Height = 39
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 
        'Nawi'#261'zanie po'#322'aczenia. U'#380'ycie TFDConnection.Open z tekstem po'#322'ac' +
        'zeniowym'
      WordWrap = True
      ExplicitWidth = 155
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 10
      Top = 78
      Width = 157
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 191
    Top = 8
    Width = 194
    Height = 145
    Caption = 'Sample 2'
    TabOrder = 1
    object Label2: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 23
      Width = 174
      Height = 26
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Nawiazanie po'#322#261'czenia. U'#380'ycie GUIxLoginDialog z t'#322'umaczeniem'
      WordWrap = True
      ExplicitWidth = 154
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 10
      Top = 65
      Width = 174
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Button2'
      TabOrder = 0
      OnClick = Button2Click
      ExplicitLeft = 12
    end
  end
  object GroupBox3: TGroupBox
    Left = 391
    Top = 8
    Width = 185
    Height = 145
    Caption = 'Sample 3'
    TabOrder = 2
    object Label3: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 23
      Width = 165
      Height = 13
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Label3'
      WordWrap = True
      ExplicitWidth = 31
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 10
      Top = 52
      Width = 165
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Button3'
      TabOrder = 0
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      AlignWithMargins = True
      Left = 10
      Top = 93
      Width = 165
      Height = 21
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      TabOrder = 1
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 200
    Width = 185
    Height = 105
    Caption = 'Sample 4'
    TabOrder = 3
    object Label4: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 23
      Width = 165
      Height = 26
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Tworzenie nowej tabeli i dodawnie wierszy do niej'
      WordWrap = True
      ExplicitWidth = 164
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 10
      Top = 65
      Width = 165
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Button4'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 384
    Top = 280
  end
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Left = 48
    Top = 128
  end
  object FDConnection2: TFDConnection
    Left = 216
    Top = 112
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 384
    Top = 328
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 304
    Top = 112
  end
  object FDConnection3: TFDConnection
    Left = 456
    Top = 144
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 304
    Top = 160
  end
  object FDConnection4: TFDConnection
    Left = 80
    Top = 304
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 384
    Top = 224
  end
end
