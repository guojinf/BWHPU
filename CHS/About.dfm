object AboutForm: TAboutForm
  Left = 0
  Top = 0
  Caption = 'About'
  ClientHeight = 183
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VersionLabel: TLabel
    Left = 11
    Top = 79
    Width = 3
    Height = 13
    Caption = ' '
  end
  object Memo1: TMemo
    Left = 8
    Top = 16
    Width = 169
    Height = 41
    Color = clBtnFace
    Lines.Strings = (
      'BWHPU V1.0 '
      'With Fatek PLC')
    TabOrder = 0
  end
  object SWCHSLangButton: TButton
    Left = 8
    Top = 138
    Width = 53
    Height = 25
    Caption = 'CHINESE'
    TabOrder = 1
    OnClick = SWCHSLangButtonClick
  end
  object SWENGLangButton: TButton
    Left = 124
    Top = 138
    Width = 53
    Height = 25
    Caption = 'ENGLISH'
    TabOrder = 2
    OnClick = SWENGLangButtonClick
  end
end
