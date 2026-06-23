object ParaSetForm: TParaSetForm
  Left = 0
  Top = 0
  Caption = 'HPS CONFIG'
  ClientHeight = 243
  ClientWidth = 472
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
  object NetGroupBox: TGroupBox
    Left = 207
    Top = 8
    Width = 185
    Height = 152
    Caption = 'Net para'
    TabOrder = 3
    object Label6: TLabel
      Left = 24
      Top = 32
      Width = 35
      Height = 13
      Caption = 'Dest IP'
    end
    object Label7: TLabel
      Left = 24
      Top = 56
      Width = 27
      Height = 13
      Caption = 'PORT'
    end
    object IPPortComboBox: TComboBox
      Tag = 255
      Left = 66
      Top = 56
      Width = 103
      Height = 21
      TabOrder = 0
      Text = '502'
      Items.Strings = (
        '500'
        '502')
    end
    object IPMaskEdit: TMaskEdit
      Tag = 255
      Left = 66
      Top = 31
      Width = 103
      Height = 19
      EditMask = '999.999.999.999;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
      Text = '192.168.000.003'
    end
  end
  object ComGroupBox: TGroupBox
    Left = 208
    Top = 8
    Width = 185
    Height = 152
    Caption = 'Com para'
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 21
      Height = 13
      Caption = 'Com'
    end
    object Label2: TLabel
      Left = 16
      Top = 52
      Width = 17
      Height = 13
      Caption = 'Bps'
    end
    object Label3: TLabel
      Left = 14
      Top = 78
      Width = 38
      Height = 13
      Caption = 'Data bit'
    end
    object Label4: TLabel
      Left = 14
      Top = 105
      Width = 29
      Height = 13
      Caption = 'Check'
    end
    object Label5: TLabel
      Left = 14
      Top = 131
      Width = 37
      Height = 13
      Caption = 'Stop bit'
    end
    object SelCom_ComboBox: TComboBox
      Tag = 255
      Left = 64
      Top = 21
      Width = 86
      Height = 21
      TabOrder = 0
      Text = 'Com1'
      Items.Strings = (
        'pnCOM1'
        'pnCOM2'
        'pnCOM3'
        'pnCOM4'
        'pnCOM5'
        'pnCOM6')
    end
    object BpsComboBox: TComboBox
      Tag = 255
      Left = 64
      Top = 48
      Width = 86
      Height = 21
      TabOrder = 1
      Text = '9600'
      Items.Strings = (
        'br110'
        'br300'
        'br600'
        'br1200'
        'br2400'
        'br4800'
        'br9600'
        'br14400'
        'br19200'
        'br38400'
        'br56000'
        'br57600'
        'br115200'
        'br128000'
        'br256000')
    end
    object DataBitComboBox: TComboBox
      Tag = 255
      Left = 64
      Top = 75
      Width = 86
      Height = 21
      TabOrder = 2
      Text = '8'
      Items.Strings = (
        'db5BITS'
        'db6BITS'
        'db7BITS'
        'db8BITS')
    end
    object ParityComboBox: TComboBox
      Tag = 255
      Left = 64
      Top = 102
      Width = 86
      Height = 21
      TabOrder = 3
      Text = '0'
      Items.Strings = (
        'ptNONE'
        'ptODD'
        'ptEVEN'
        'ptMARK'
        'ptSPACE')
    end
    object StopBitComboBox: TComboBox
      Tag = 255
      Left = 64
      Top = 128
      Width = 86
      Height = 21
      TabOrder = 4
      Text = '1'
      Items.Strings = (
        'sb1BITS'
        'sb1HALFBITS'
        'sb2BITS')
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 65
    Caption = 'HPS PARA'
    TabOrder = 0
    object Label8: TLabel
      Left = 11
      Top = 24
      Width = 51
      Height = 13
      Caption = 'HPS Count'
    end
    object Pump_Num_ComboBox: TComboBox
      Tag = 255
      Left = 80
      Top = 21
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '1'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6')
    end
  end
  object PumpCheckBox1: TCheckBox
    Left = 8
    Top = 166
    Width = 201
    Height = 17
    Caption = 'All pump off when exit'#65292'Be Careful'#65281
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 118
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 271
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 5
    OnClick = CancelButtonClick
  end
  object CommTypeRadioGroup1: TRadioGroup
    Left = 8
    Top = 82
    Width = 194
    Height = 78
    Caption = 'Select'
    Items.Strings = (
      'COM'
      'NET')
    TabOrder = 6
    OnClick = CommTypeRadioGroup1Click
  end
end
