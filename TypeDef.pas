unit TypeDef;

interface

Const
  //PLC类型 不同厂家通讯协议有可能不同
  PLCTYPE_NONE = 0 ;
  PLCTYPE_FATEK = 1 ;
  PLCTYPE_SIMENS = 2 ;
  //通讯协议
  PROTOCOL_NONE = 0;
  PROTOCOL_MODBUS_RTU = 1;
  PROTOCOL_MODBUS_ASCII = 2;
  PROTOCOL_MODBUSTCP_RTU = 3;
  PROTOCOL_MODBUSTCP_ASCII = 4;
  PROTOCOL_FATEK =5 ; //永宏自己的协议
  //0 串口通讯 1 网口通讯
  COMMTYPE_COM =0;
  COMMTYPE_NET =1;
  BufferLength_Send2PLC=128;
  //指令类别
  CommFunc_GetPara =0;
  CommFunc_SetCMD =1;

  PUMP_ON = 1 ;
  PUMP_OFF = 2 ;
  PRESSURE_HI = 4 ;
  PRESSURE_LOW = 8 ;
  RESET_ALL_CMD = 16;

  RECONNECTCOUNTCONST=5;

  MAXLANGSNUM=10;  //软件中用到的多语言String 数量

LANGUAGEFILE_C='HPULangChinese.ini';   //中文
LANGUAGEFILE_E='HPULangEnglish.ini';   //英语
LANGUAGEFILE_O='HPULangOthers.ini';   //其它

LANGUAGEFILE_D='HPULangDefault.ini';

LanguageType_C=0;
LanguageType_E=1;
LanguageType_O=2;

Type
 // arreglo de bytes que conforman el mensaje modbus y un puntero al mismo
  TDataByte = array of byte;
  PByte     = ^byte;

  // COM Port Baud Rates
  TComPortBaudRate = ( br110, br300, br600, br1200, br2400, br4800,
                       br9600, br14400, br19200, br38400, br56000,
                       br57600, br115200, br128000, br256000 );
  // COM Port Numbers
  TComPortNumber = ( pnCOM1, pnCOM2, pnCOM3, pnCOM4, pnCOM5, pnCOM6 );
  // COM Port Data bits
  TComPortDataBits = ( db5BITS, db6BITS, db7BITS, db8BITS );
  // COM Port Stop bits
  TComPortStopBits = ( sb1BITS, sb1HALFBITS, sb2BITS );
  // COM Port Parity
  TComPortParity = ( ptNONE, ptODD, ptEVEN, ptMARK, ptSPACE );
  // COM Port Hardware Handshaking
  TComPortHwHandshaking = ( hhNONE, hhRTSCTS );
  // COM Port Software Handshaking
  TComPortSwHandshaking = ( shNONE, shXONXOFF );

  TComPara =  record
  //串口参数  串口号，波特率，数据位，校验方式，停止位，协议
    Name:string;
    MODBusType:char;  //M S
    Enable:boolean;     //串口使能
    ComPort:TComPortNumber;     //串口号
    BaseADD:WORD;               //基地址 ，串口不用
    ID:Byte;                     // 所连设备ID
    ComPortSpeed:TComPortBaudRate;  //波特率
    ComPortDataBits:TComPortDataBits;  //数据位数
    ComPortParity:TComPortParity;        //校验方式
    ComPortStopBits:TComPortStopBits;   //停止位 1，1.5，2
    ProtocolType:Byte; //通讯协议
  end;

   TNetPara = record
    //网口参数  服务器IP地址，端口号，协议，
    IPAddr:String; //IP地址
    Port: Word; //端口号
    ProtocolType:Byte; //协议
    ReConnectCount:Byte;
    ReadErrNum:byte;
    Connected:Boolean; //连上为True，没连上为False
  end;

  TParaInfo = record
    ComPara:TComPara;  //串口参数
    NetPara:TNetPara;  //网口参数
    CommType:Byte; //通讯口选择   串口OR网口
    PumpOff_ATSoftColse_EN:Boolean; //关软件是否关泵
    ParaDispEN:array[0..10] of Boolean; //压力、温度、液位、流量显示哪几种 ,为True时显示
    ParaDispAdd:array[0..10] of Integer; //压力、温度、液位、流量 在PLC中所在的地址
    PLCType:Byte;  // PLC类型 0无，1Fatek 2
    PumpNum:Byte; //泵的数量

  end;

  THYStatus = Record
    Pump_OnOff : array[0..10] of Byte;
    Pressure_HiLow : array[0..10] of Byte;
    CoolPump_OnOff : array[0..10] of Byte;
    Oil_Filter_Status: array[0..10] of Byte;                   //为0正常，不为0堵塞
    Pressure: array[0..10] of Integer;    //压力
    Pressure_AnsiStr: array[0..10] of AnsiString;    //压力
    Tempr: array[0..10] of Integer;   //温度
    Tempr_AnsiStr: array[0..10] of AnsiString; //温度
    Level_YW : array[0..10] of Integer; //液位
    LEvel_YW_AnsiStr: array[0..10] of AnsiString; //液位
    Flow_L:  array[0..10] of Integer; //流量
    Flow_L_AnsiStr:  array[0..10] of AnsiString; //流量
  End;
  THYCMD = Record
    Pump_OnOff : array[0..10] of Byte;    //油泵启停指令
    Pressure_HiLow : array[0..10] of Byte;   //高低压指令
    CoolPump_OnOff : array[0..10] of Byte;    //冷却指令，未用
    Reset_All: Byte;  //复位全停 指令
  End;

  THYParaInfo = Record
    HYStatus:THYStatus;
    HYCMD:THYCMD;

  End;



TCommInitInfo = Record
  SCom:array[1..8] of TComPara;
End;

TMemAll=record
  PComSendMem1,PComSendMem2,PComSendMem3,PComSendMem4:PAnsiChar;
end;




implementation

end.
