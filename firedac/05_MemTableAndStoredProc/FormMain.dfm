object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 458
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 453
    Top = 38
    Width = 5
    Height = 420
    Align = alRight
    ExplicitLeft = 455
    ExplicitTop = 36
    ExplicitHeight = 422
  end
  object DBGrid2: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 41
    Width = 450
    Height = 414
    Margins.Right = 0
    Align = alClient
    DataSource = DataSource2
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 640
    Height = 32
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitLeft = 8
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 121
      Height = 24
      Align = alLeft
      TabOrder = 0
      Text = 'USA'
      ExplicitLeft = 0
      ExplicitTop = 8
      ExplicitHeight = 33
    end
    object btnOpenMemTable: TButton
      AlignWithMargins = True
      Left = 131
      Top = 4
      Width = 121
      Height = 24
      Align = alLeft
      Caption = 'btnOpenMemTable'
      TabOrder = 1
      OnClick = btnOpenMemTableClick
      ExplicitTop = 8
      ExplicitHeight = 22
    end
    object btnApplyUpdates: TButton
      AlignWithMargins = True
      Left = 258
      Top = 4
      Width = 127
      Height = 24
      Align = alLeft
      Caption = 'btnApplyUpdates'
      TabOrder = 2
      OnClick = btnApplyUpdatesClick
      ExplicitHeight = 22
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 458
    Top = 41
    Width = 185
    Height = 414
    Margins.Left = 0
    Align = alRight
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitLeft = 453
    ExplicitTop = 39
    ExplicitHeight = 416
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandKind = skStoredProc
    CommandText.Strings = (
      'ListaKlientow')
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
        Value = 0
      end
      item
        Position = 2
        Name = '@Kraj'
        DataType = ftWideString
        ParamType = ptInput
        Size = 15
        Value = 'USA'
      end>
    Left = 184
    Top = 296
  end
  object FDTableAdapter1: TFDTableAdapter
    SelectCommand = FDCommand1
    UpdateCommand = FDCommand2
    Left = 248
    Top = 320
  end
  object FDMemTable1: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Adapter = FDTableAdapter1
    Left = 328
    Top = 320
  end
  object DataSource2: TDataSource
    DataSet = FDMemTable1
    Left = 80
    Top = 72
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_Demo'
      'MonitorBy=Custom')
    Left = 88
    Top = 296
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 88
    Top = 344
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    EventKinds = [ekCmdPrepare, ekCmdExecute]
    Left = 88
    Top = 400
  end
  object FDCommand2: TFDCommand
    Connection = FDConnection1
    CommandText.Strings = (
      
        'UPDATE Customers SET CompanyName = :CompanyName WHERE CustomerID' +
        ' = :CustomerID')
    ParamData = <
      item
        Name = 'COMPANYNAME'
        ParamType = ptInput
      end
      item
        Name = 'CUSTOMERID'
        ParamType = ptInput
      end>
    Left = 184
    Top = 360
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    OnOutput = FDMoniCustomClientLink1Output
    Left = 88
    Top = 248
  end
end
