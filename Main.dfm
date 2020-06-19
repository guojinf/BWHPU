object MainForm: TMainForm
  Left = 100
  Top = 100
  BorderWidth = 2
  Caption = 'POPWIL_HPU'
  ClientHeight = 211
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Tag = 255
    Left = 0
    Top = 24
    Width = 745
    Height = 1
  end
  object CommSta_Shape1: TShape
    Tag = 255
    Left = 8
    Top = -4
    Width = 12
    Height = 22
    Brush.Color = clActiveBorder
    Shape = stCircle
  end
  object Panel1: TPanel
    Tag = 255
    Left = 8
    Top = 24
    Width = 705
    Height = 202
    TabOrder = 0
    object GroupBox1: TGroupBox
      Tag = 255
      Left = 0
      Top = 0
      Width = 192
      Height = 193
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      object ResetSta_Shape: TShape
        Tag = 255
        Left = 102
        Top = 17
        Width = 30
        Height = 22
        Brush.Color = clGreen
        Shape = stCircle
        Visible = False
      end
      object Label1: TLabel
        Left = 16
        Top = 61
        Width = 24
        Height = 13
        Caption = 'Filter'
      end
      object Filter_Shape1: TShape
        Tag = 255
        Left = 69
        Top = 56
        Width = 12
        Height = 22
        Brush.Color = clGreen
        Shape = stCircle
      end
      object Filter_Shape2: TShape
        Tag = 255
        Left = 87
        Top = 56
        Width = 12
        Height = 22
        Brush.Color = clGreen
        Shape = stCircle
        Visible = False
      end
      object Filter_Shape3: TShape
        Tag = 255
        Left = 105
        Top = 56
        Width = 12
        Height = 22
        Brush.Color = clGreen
        Shape = stCircle
        Visible = False
      end
      object Filter_Shape4: TShape
        Tag = 255
        Left = 123
        Top = 56
        Width = 12
        Height = 22
        Brush.Color = clGreen
        Shape = stCircle
        Visible = False
      end
      object Label2: TLabel
        Left = 72
        Top = 45
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label3: TLabel
        Left = 90
        Top = 45
        Width = 6
        Height = 13
        Caption = '2'
        Visible = False
      end
      object Label4: TLabel
        Left = 108
        Top = 45
        Width = 6
        Height = 13
        Caption = '3'
        Visible = False
      end
      object Label5: TLabel
        Left = 126
        Top = 45
        Width = 6
        Height = 13
        Caption = '4'
        Visible = False
      end
      object PressureCaptionLabel: TLabel
        Left = 16
        Top = 93
        Width = 42
        Height = 13
        Caption = 'Pressure'
      end
      object PressureUnitLabel: TLabel
        Tag = 255
        Left = 152
        Top = 85
        Width = 20
        Height = 13
        Caption = 'MPa'
      end
      object TemprUnitLabel: TLabel
        Tag = 255
        Left = 152
        Top = 115
        Width = 12
        Height = 13
        Caption = #176'C'
      end
      object TemprCaptionLabel: TLabel
        Left = 16
        Top = 112
        Width = 30
        Height = 13
        Caption = 'Temp.'
      end
      object HYLUnitLabel: TLabel
        Tag = 255
        Left = 152
        Top = 134
        Width = 11
        Height = 13
        Caption = '%'
      end
      object HYLCaptionLabel: TLabel
        Left = 16
        Top = 134
        Width = 25
        Height = 13
        Caption = 'Level'
      end
      object QUnitLabel: TLabel
        Tag = 255
        Left = 152
        Top = 153
        Width = 25
        Height = 13
        Caption = 'L/min'
      end
      object QCaptionLabel: TLabel
        Left = 16
        Top = 156
        Width = 22
        Height = 13
        Caption = 'Flow'
      end
      object Label14: TLabel
        Tag = 255
        Left = 40
        Top = -16
        Width = 37
        Height = 13
        Caption = 'Label14'
      end
      object PressureEdit: TEdit
        Tag = 255
        Left = 66
        Top = 84
        Width = 69
        Height = 27
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '0.0'
      end
      object TemprEdit: TEdit
        Tag = 255
        Left = 66
        Top = 108
        Width = 69
        Height = 27
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = '10.0'
      end
      object HYLEdit: TEdit
        Tag = 255
        Left = 66
        Top = 130
        Width = 69
        Height = 27
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '50.0'
      end
      object QEdit: TEdit
        Tag = 255
        Left = 66
        Top = 152
        Width = 69
        Height = 27
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = '3.0'
      end
      object ResetPanel: TPanel
        Left = 40
        Top = 14
        Width = 105
        Height = 25
        BorderStyle = bsSingle
        Caption = 'Reset/All Stop'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = #21326#25991#20013#23435
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = ResetPanelClick
      end
    end
    object PumpGroupBox1: TGroupBox
      Left = 183
      Top = 0
      Width = 114
      Height = 193
      Caption = 'Pump1'
      TabOrder = 1
      object PumpON_SpeedButton1: TSpeedButton
        Left = 15
        Top = 68
        Width = 65
        Height = 22
        Caption = 'Pump ON'
        OnClick = PumpON_SpeedButton1Click
      end
      object PumpOFF_SpeedButton1: TSpeedButton
        Left = 15
        Top = 96
        Width = 65
        Height = 22
        Caption = 'Pump OFF'
        OnClick = PumpOFF_SpeedButton1Click
      end
      object PressureHI_SpeedButton1: TSpeedButton
        Left = 15
        Top = 124
        Width = 65
        Height = 22
        Caption = 'High'
        OnClick = PressureHI_SpeedButton1Click
      end
      object PressureLow_SpeedButton1: TSpeedButton
        Left = 15
        Top = 152
        Width = 65
        Height = 22
        Caption = 'Low'
        OnClick = PressureLow_SpeedButton1Click
      end
      object PumpSta_Shape1: TShape
        Tag = 255
        Left = 86
        Top = 68
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
      object PressureSta_Shape1: TShape
        Tag = 255
        Left = 86
        Top = 124
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
    end
    object PumpGroupBox2: TGroupBox
      Left = 286
      Top = 0
      Width = 138
      Height = 193
      Caption = #27833#27893'2'
      TabOrder = 2
      Visible = False
      object PumpON_SpeedButton2: TSpeedButton
        Left = 24
        Top = 68
        Width = 65
        Height = 22
        Caption = #27833#27893#24320
      end
      object PumpOFF_SpeedButton2: TSpeedButton
        Left = 24
        Top = 96
        Width = 65
        Height = 22
        Caption = #27833#27893#20851
      end
      object PressureHI_SpeedButton2: TSpeedButton
        Left = 24
        Top = 124
        Width = 65
        Height = 22
        Caption = #39640#21387
      end
      object PressureLow_SpeedButton2: TSpeedButton
        Left = 24
        Top = 152
        Width = 65
        Height = 22
        Caption = #20302#21387
      end
      object PumpSta_Shape2: TShape
        Tag = 255
        Left = 109
        Top = 68
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
      object PressureSta_Shape2: TShape
        Tag = 255
        Left = 109
        Top = 124
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
    end
    object PumpGroupBox3: TGroupBox
      Left = 423
      Top = 0
      Width = 138
      Height = 193
      Caption = #27833#27893'3'
      TabOrder = 3
      Visible = False
      object PumpON_SpeedButton3: TSpeedButton
        Left = 24
        Top = 68
        Width = 65
        Height = 22
        Caption = #27833#27893#24320
      end
      object PumpOFF_SpeedButton3: TSpeedButton
        Left = 24
        Top = 96
        Width = 65
        Height = 22
        Caption = #27833#27893#20851
      end
      object PressureHI_SpeedButton3: TSpeedButton
        Left = 24
        Top = 124
        Width = 65
        Height = 22
        Caption = #39640#21387
      end
      object PressureLow_SpeedButton3: TSpeedButton
        Left = 24
        Top = 152
        Width = 65
        Height = 22
        Caption = #20302#21387
      end
      object PumpSta_Shape3: TShape
        Tag = 255
        Left = 109
        Top = 68
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
      object PressureSta_Shape3: TShape
        Tag = 255
        Left = 109
        Top = 124
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
    end
    object PumpGroupBox4: TGroupBox
      Left = 567
      Top = 0
      Width = 138
      Height = 193
      Caption = #27833#27893'4'
      TabOrder = 4
      Visible = False
      object PumpON_SpeedButton4: TSpeedButton
        Left = 24
        Top = 68
        Width = 65
        Height = 22
        Caption = #27833#27893#24320
      end
      object PumpOFF_SpeedButton4: TSpeedButton
        Left = 24
        Top = 96
        Width = 65
        Height = 22
        Caption = #27833#27893#20851
      end
      object PressureHI_SpeedButton4: TSpeedButton
        Left = 24
        Top = 124
        Width = 65
        Height = 22
        Caption = #39640#21387
      end
      object PressureLow_SpeedButton4: TSpeedButton
        Left = 24
        Top = 152
        Width = 65
        Height = 22
        Caption = #20302#21387
      end
      object PumpSta_Shape4: TShape
        Tag = 255
        Left = 109
        Top = 68
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
      object PressureSta_Shape4: TShape
        Tag = 255
        Left = 109
        Top = 124
        Width = 12
        Height = 22
        Brush.Color = clRed
        Shape = stCircle
      end
    end
  end
  object Button1: TButton
    Left = 232
    Top = -1
    Width = 56
    Height = 26
    Caption = 'Button1'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object ClientSocket1: TClientSocket
    Tag = 255
    Active = False
    Address = '192.168.0.3'
    ClientType = ctNonBlocking
    Port = 502
    Left = 16
    Top = 200
  end
  object MainMenu1: TMainMenu
    Tag = 255
    Left = 64
    object N2: TMenuItem
      Tag = 255
      AutoHotkeys = maManual
      Caption = ' &Systerm'
      object Options_Item: TMenuItem
        Tag = 255
        Caption = '&Option'
        OnClick = Options_ItemClick
      end
      object Quit_Item: TMenuItem
        Tag = 255
        Caption = '&Quit'
        OnClick = Quit_ItemClick
      end
    end
    object N1: TMenuItem
      Tag = 255
      AutoHotkeys = maManual
      Caption = '&Help'
      object About_Item: TMenuItem
        Tag = 255
        Caption = '&About'
        OnClick = About_ItemClick
      end
    end
  end
  object PLC_Comm: TComm
    Tag = 255
    CommName = 'COM1'
    BaudRate = 9600
    ParityCheck = False
    Outx_CtsFlow = False
    Outx_DsrFlow = False
    DtrControl = DtrEnable
    DsrSensitivity = False
    TxContinueOnXoff = True
    Outx_XonXoffFlow = True
    Inx_XonXoffFlow = True
    ReplaceWhenParityError = False
    IgnoreNullChar = False
    RtsControl = RtsEnable
    XonLimit = 10
    XoffLimit = 10
    ByteSize = _8
    Parity = None
    StopBits = _1
    XonChar = #2
    XoffChar = #3
    ReplacedChar = #0
    ReadIntervalTimeout = 10
    ReadTotalTimeoutMultiplier = 0
    ReadTotalTimeoutConstant = 0
    WriteTotalTimeoutMultiplier = 0
    WriteTotalTimeoutConstant = 0
    OnReceiveData = PLC_CommReceiveData
    Left = 88
    Top = 200
  end
  object DspTimer: TTimer
    Tag = 255
    Enabled = False
    Interval = 300
    OnTimer = DspTimerTimer
    Left = 32
  end
  object IdModBus_To_PLC: TIdModBusClient
    Tag = 255
    ConnectTimeout = 3000
    IPVersion = Id_IPv4
    ReadTimeout = 3000
    TimeOut = 3000
    Left = 120
  end
end
