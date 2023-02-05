object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 385
  ClientWidth = 868
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 366
    Width = 868
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Disconnected'
        Width = 130
      end
      item
        Text = '  Orders:'
        Width = 150
      end>
  end
  object pnMain: TPanel
    Left = 0
    Top = 0
    Width = 561
    Height = 366
    Align = alLeft
    Caption = 'pnMain'
    Padding.Right = 15
    TabOrder = 1
    object pnDataFilterBar: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 48
      Width = 538
      Height = 50
      Align = alTop
      BevelOuter = bvLowered
      Caption = ' '
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 104
      Width = 538
      Height = 258
      Align = alClient
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object pnCommands: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 538
      Height = 38
      Align = alTop
      BevelOuter = bvLowered
      Caption = ' '
      TabOrder = 2
      object Label1: TLabel
        AlignWithMargins = True
        Left = 279
        Top = 4
        Width = 154
        Height = 30
        Align = alLeft
        AutoSize = False
        Caption = 'Returend Data'
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 359
      end
      object btnCalculateOrderTotals: TButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 141
        Height = 30
        Align = alLeft
        Caption = 'Calculate Order Totals'
        TabOrder = 0
        OnClick = btnCalculateOrderTotalsClick
      end
      object ButtonCommand2: TButton
        AlignWithMargins = True
        Left = 151
        Top = 4
        Width = 122
        Height = 30
        Align = alLeft
        Caption = 'ButtonCommand2'
        TabOrder = 1
        OnClick = ButtonCommand2Click
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 439
        Top = 4
        Width = 185
        Height = 30
        Align = alLeft
        Caption = 'Panel2'
        TabOrder = 2
        object Label2: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 9
          Width = 49
          Height = 17
          Margins.Top = 8
          Align = alLeft
          Caption = 'Progress: '
          ExplicitHeight = 13
        end
        object ProgressBar1: TProgressBar
          AlignWithMargins = True
          Left = 59
          Top = 4
          Width = 122
          Height = 22
          Align = alClient
          TabOrder = 0
        end
      end
    end
  end
  object pnLogin: TPanel
    Left = 561
    Top = 0
    Width = 307
    Height = 366
    Align = alClient
    Caption = ' '
    TabOrder = 2
    DesignSize = (
      307
      366)
    object Panel1: TPanel
      Left = 12
      Top = 88
      Width = 281
      Height = 201
      Anchors = []
      BevelOuter = bvLowered
      Caption = ' '
      Padding.Left = 5
      Padding.Top = 10
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object Label3: TLabel
        AlignWithMargins = True
        Left = 9
        Top = 19
        Width = 263
        Height = 13
        Margins.Top = 8
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Login'
        ExplicitWidth = 25
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 9
        Top = 67
        Width = 263
        Height = 13
        Margins.Top = 8
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Password'
        ExplicitWidth = 46
      end
      object edtLogin: TEdit
        AlignWithMargins = True
        Left = 9
        Top = 35
        Width = 263
        Height = 21
        Align = alTop
        TabOrder = 0
        Text = 'edtLogin'
      end
      object edtPassword: TEdit
        AlignWithMargins = True
        Left = 9
        Top = 83
        Width = 263
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'edtPassword'
      end
      object ButtonLogin: TButton
        AlignWithMargins = True
        Left = 9
        Top = 119
        Width = 263
        Height = 30
        Margins.Top = 12
        Align = alTop
        Caption = 'ButtonLogin'
        Default = True
        TabOrder = 2
        OnClick = ButtonLoginClick
      end
    end
  end
  object tmrStart: TTimer
    Interval = 1
    OnTimer = tmrStartTimer
    Left = 32
    Top = 128
  end
  object tmrIdle: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmrIdleTimer
    Left = 96
    Top = 128
  end
end
