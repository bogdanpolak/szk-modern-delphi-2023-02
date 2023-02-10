object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 278
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 73
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object DBEdit1: TDBEdit
      Left = 128
      Top = 10
      Width = 225
      Height = 21
      DataField = 'CompanyName'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBNavigator1: TDBNavigator
      Left = 128
      Top = 40
      Width = 240
      Height = 25
      DataSource = DataSource1
      TabOrder = 2
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 73
    Width = 541
    Height = 205
    Align = alClient
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_Demo')
    Connected = True
    LoginPrompt = False
    Left = 456
    Top = 88
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select CustomerID, CompanyName, Country from {id Customers}')
    Left = 224
    Top = 80
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 456
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 288
    Top = 80
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = FDQuery2
    Left = 120
    Top = 208
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 208
    Top = 208
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet1
    Left = 280
    Top = 208
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select CustomerID, CompanyName, Country from {id Customers}')
    Left = 48
    Top = 208
  end
end
