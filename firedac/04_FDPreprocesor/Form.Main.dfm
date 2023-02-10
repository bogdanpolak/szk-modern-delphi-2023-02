object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 201
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    509
    201)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 83
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 493
    Height = 154
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 97
    Top = 8
    Width = 83
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 356
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 3
    Text = 'FB_Demo'
    OnChange = ComboBox1Change
    Items.Strings = (
      'IB_Demo'
      'FB_Demo'
      'SQLite_Demo'
      'MSSQL_Demo'
      'Ora_Demo'
      'MySQL_Demo')
  end
  object Button3: TButton
    Left = 186
    Top = 8
    Width = 83
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
  object FDConnection1: TFDConnection
    Left = 120
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 192
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 264
    Top = 48
  end
end
