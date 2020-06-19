object AboutForm: TAboutForm
  Left = 0
  Top = 0
  Caption = 'About'
  ClientHeight = 140
  ClientWidth = 165
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object VersionLabel: TLabel
    Left = 11
    Top = 79
    Width = 146
    Height = 13
    Caption = ' '
  end
  object Memo1: TMemo
    Left = 16
    Top = 16
    Width = 137
    Height = 41
    Color = clBtnFace
    Lines.Strings = (
      'BWHPU V1.0 '
      'With Fatek PLC')
    TabOrder = 0
  end
end
