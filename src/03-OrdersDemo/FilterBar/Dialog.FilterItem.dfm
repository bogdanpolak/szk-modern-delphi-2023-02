object FilterItemDialog: TFilterItemDialog
  Left = 0
  Top = 0
  Caption = 'FilterItemDialog'
  ClientHeight = 214
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label2: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 60
    Width = 391
    Height = 16
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Operator'
    ExplicitWidth = 51
  end
  object Label3: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 112
    Width = 391
    Height = 16
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Value'
    ExplicitWidth = 32
  end
  object Label1: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 8
    Width = 391
    Height = 16
    Margins.Left = 6
    Margins.Top = 8
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Field'
    ExplicitWidth = 27
  end
  object cbxField: TComboBox
    AlignWithMargins = True
    Left = 6
    Top = 27
    Width = 391
    Height = 24
    Margins.Left = 6
    Margins.Right = 6
    Align = alTop
    TabOrder = 0
    Text = 'cbxField'
    OnChange = cbxFieldChange
  end
  object cbxOperator: TComboBox
    AlignWithMargins = True
    Left = 6
    Top = 79
    Width = 391
    Height = 24
    Margins.Left = 6
    Margins.Right = 6
    Align = alTop
    TabOrder = 1
    Text = 'cbxOperator'
  end
  object edtValue: TEdit
    AlignWithMargins = True
    Left = 6
    Top = 131
    Width = 391
    Height = 24
    Margins.Left = 6
    Margins.Right = 6
    Align = alTop
    TabOrder = 2
    Text = 'edtValue'
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 166
    Width = 391
    Height = 40
    Margins.Left = 6
    Margins.Top = 8
    Margins.Right = 6
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    object Button1: TButton
      AlignWithMargins = True
      Left = 207
      Top = 3
      Width = 83
      Height = 34
      Action = actAddFilter
      Align = alRight
      Default = True
      TabOrder = 0
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 296
      Top = 3
      Width = 92
      Height = 34
      Align = alRight
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnActionUpdate = ApplicationEvents1ActionUpdate
    Left = 40
    Top = 160
  end
  object ActionList1: TActionList
    Left = 136
    Top = 160
    object actAddFilter: TAction
      Caption = 'Add'
      OnExecute = actAddFilterExecute
    end
  end
end
