object FormQueue: TFormQueue
  Left = 0
  Top = 0
  Caption = 'FormQueue'
  ClientHeight = 463
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 381
    Height = 41
    Align = alTop
    BevelOuter = bvLowered
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 0
    ExplicitLeft = 64
    ExplicitTop = 216
    ExplicitWidth = 185
    object btnAddThread: TButton
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 139
      Height = 29
      Align = alLeft
      Caption = 'btnAddThread'
      TabOrder = 0
      OnClick = btnAddThreadClick
    end
    object btnClearMemo: TButton
      AlignWithMargins = True
      Left = 151
      Top = 6
      Width = 106
      Height = 29
      Align = alLeft
      Caption = 'btnClearMemo'
      TabOrder = 1
      OnClick = btnClearMemoClick
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 381
    Height = 410
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 278
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 112
    Top = 72
  end
end