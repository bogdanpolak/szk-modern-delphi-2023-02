object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 316
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    551
    316)
  PixelsPerInch = 96
  TextHeight = 13
  object btnErrorHandle: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = 'btnErrorHandle'
    TabOrder = 0
    OnClick = btnErrorHandleClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 104
    Width = 535
    Height = 204
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnOpenCustomers: TButton
    Left = 152
    Top = 8
    Width = 129
    Height = 25
    Caption = 'btnOpenCustomers'
    TabOrder = 2
    OnClick = btnOpenCustomersClick
  end
  object btnOnline: TButton
    Left = 152
    Top = 39
    Width = 129
    Height = 25
    Caption = 'btnOnline'
    TabOrder = 3
    OnClick = btnOnlineClick
  end
  object FDConnection1: TFDConnection
    OnError = FDConnection1Error
    Left = 48
    Top = 64
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from {id Customers}')
    Left = 136
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 216
    Top = 64
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 352
    Top = 72
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 360
    Top = 128
  end
end
