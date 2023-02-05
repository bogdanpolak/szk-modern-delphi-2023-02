object FrameMemo: TFrameMemo
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 248
  Height = 240
  TabOrder = 0
  object Memo1: TMemo
    Left = 24
    Top = 112
    Width = 185
    Height = 89
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 248
    Height = 41
    Align = alTop
    BevelOuter = bvLowered
    Caption = ' '
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 104
    ExplicitWidth = 185
    object btnCloseFrame: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 125
      Height = 33
      Align = alLeft
      Caption = 'btnCloseFrame'
      TabOrder = 0
      OnClick = btnCloseFrameClick
    end
  end
  object tmrStart: TTimer
    Interval = 1
    OnTimer = tmrStartTimer
    Left = 16
    Top = 56
  end
end
