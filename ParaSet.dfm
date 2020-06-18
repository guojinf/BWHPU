object ParaSetForm: TParaSetForm
  Left = 0
  Top = 0
  Caption = #26234#33021#27833#28304#21442#25968#35774#32622
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
  object ComGroupBox: TGroupBox
    Left = 208
    Top = 8
    Width = 185
    Height = 152
    Caption = #20018#21475#21442#25968
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 24
      Height = 13
      Caption = #20018#21475
    end
    object Label2: TLabel
      Left = 16
      Top = 52
      Width = 36
      Height = 13
      Caption = #27874#29305#29575
    end
    object Label3: TLabel
      Left = 14
      Top = 78
      Width = 36
      Height = 13
      Caption = #25968#25454#20301
    end
    object Label4: TLabel
      Left = 14
      Top = 105
      Width = 24
      Height = 13
      Caption = #26657#39564
    end
    object Label5: TLabel
      Left = 14
      Top = 131
      Width = 36
      Height = 13
      Caption = #20572#27490#20301
    end
    object SelCom_ComboBox: TComboBox
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
  object NetGroupBox: TGroupBox
    Left = 207
    Top = 8
    Width = 185
    Height = 152
    Caption = #32593#32476#21442#25968
    TabOrder = 3
    object Label6: TLabel
      Left = 24
      Top = 32
      Width = 34
      Height = 13
      Caption = #30446#26631'IP'
    end
    object Label7: TLabel
      Left = 24
      Top = 56
      Width = 36
      Height = 13
      Caption = #31471#21475#21495
    end
    object IPPortComboBox: TComboBox
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 65
    Caption = #27833#27893#25968#37327
    TabOrder = 0
    object Label8: TLabel
      Left = 16
      Top = 24
      Width = 48
      Height = 13
      Caption = #27833#27893#25968#37327
    end
    object Pump_Num_ComboBox: TComboBox
      Left = 70
      Top = 21
      Width = 75
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
    Width = 185
    Height = 17
    Caption = #36864#20986#26102#20851#38381#27833#28304#65292#35831#35880#24910#36873#25321#65281
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 118
    Top = 200
    Width = 75
    Height = 25
    Caption = #24212#29992
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 271
    Top = 200
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 5
    OnClick = CancelButtonClick
  end
  object CommTypeRadioGroup1: TRadioGroup
    Left = 8
    Top = 82
    Width = 194
    Height = 78
    Caption = #36890#35759#21442#25968
    Items.Strings = (
      #20018#21475#36890#35759
      #32593#21475#36890#35759)
    TabOrder = 6
    OnClick = CommTypeRadioGroup1Click
  end
end
