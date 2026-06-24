object ParaSetForm: TParaSetForm
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'HPS CONFIG'
  ClientHeight = 365
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Tahoma'
  Font.Style = []
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 21
  object NetGroupBox: TGroupBox
    Left = 311
    Top = 12
    Width = 277
    Height = 228
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Net para'
    TabOrder = 3
    object Label6: TLabel
      Left = 36
      Top = 48
      Width = 55
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Dest IP'
    end
    object Label7: TLabel
      Left = 36
      Top = 84
      Width = 42
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'PORT'
    end
    object IPPortComboBox: TComboBox
      Tag = 255
      Left = 99
      Top = 84
      Width = 155
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 0
      Text = '502'
      Items.Strings = (
        '500'
        '502')
    end
    object IPMaskEdit: TMaskEdit
      Tag = 255
      Left = 99
      Top = 47
      Width = 155
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      EditMask = '999.999.999.999;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
      Text = '192.168.000.003'
    end
  end
  object ComGroupBox: TGroupBox
    Left = 312
    Top = 12
    Width = 278
    Height = 228
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Com para'
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 36
      Width = 33
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Com'
    end
    object Label2: TLabel
      Left = 24
      Top = 78
      Width = 27
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Bps'
    end
    object Label3: TLabel
      Left = 21
      Top = 117
      Width = 60
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Data bit'
    end
    object Label4: TLabel
      Left = 21
      Top = 158
      Width = 44
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Check'
    end
    object Label5: TLabel
      Left = 21
      Top = 197
      Width = 57
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Stop bit'
    end
    object SelCom_ComboBox: TComboBox
      Tag = 255
      Left = 96
      Top = 32
      Width = 129
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
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
      Left = 96
      Top = 72
      Width = 129
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
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
      Left = 96
      Top = 113
      Width = 129
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
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
      Left = 96
      Top = 153
      Width = 129
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
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
      Left = 96
      Top = 192
      Width = 129
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 4
      Text = '1'
      Items.Strings = (
        'sb1BITS'
        'sb1HALFBITS'
        'sb2BITS')
    end
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 12
    Width = 290
    Height = 98
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'HPS PARA'
    TabOrder = 0
    object Label8: TLabel
      Left = 17
      Top = 36
      Width = 77
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'HPS Count'
    end
    object Pump_Num_ComboBox: TComboBox
      Tag = 255
      Left = 120
      Top = 32
      Width = 98
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
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
    Left = 12
    Top = 249
    Width = 302
    Height = 26
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'All pump off when exit'#65292'Be Careful'#65281
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 177
    Top = 300
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Apply'
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 407
    Top = 300
    Width = 112
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Exit'
    TabOrder = 5
    OnClick = CancelButtonClick
  end
  object CommTypeRadioGroup1: TRadioGroup
    Left = 12
    Top = 123
    Width = 291
    Height = 117
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Select'
    Items.Strings = (
      'COM'
      'NET')
    TabOrder = 6
    OnClick = CommTypeRadioGroup1Click
  end
end
