unit FatekPLC;
{ // 与FatekPLC通讯
 //现为简易模式，待扩展
 //写入PLC指令   暂写地址为R1000~R1001
 // R1000 || Bit0:开泵1，bit1:关泵1 bit2:高压1，bit3: 低压1, bit4:复位
 //R1001 已写功能预留，PLC R1000~R1199为PC写入区预留
 //R1002 泵2指令
 //R1003 泵3指令
 //R1004 泵4指令
 //R1005 泵5指令
 //R1006 泵6指令

 // 读PLC参数  暂读地址为R1100~R1105 每增一泵时应该增读一字
 //R1100 || bit0:油源1状态，bit1，bit2, bit3:泵1高压状态 ，bit4-Bit7:滤油器状态
 //R1101 暂预留
 //R1102~R1105 分别为压力，温度，液位，流量值
 //R1106 泵2状态
 //R1107 泵3状态
 //R1108 泵4状态
  //R1109 泵5状态
 //R1110 泵6状态



}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,AnsiStrings;

type
  TFatekPLCForm = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    Function  PLCCOMInit(ComPortInfo:TComPara ):boolean;
    Procedure PLCCOMDefault( );
    Procedure PLCCOMFree(); //PLC串口释放
    Function SendData2Plc(DataPtr:PansiChar;DataLen:integer;FUNCode:byte):boolean;
    Function ReadFromPlc_MR(PLCID:Byte;FUNCode:Byte;ADDR_Start:AnsiString;REG_Num:Byte):boolean;
    Function ReadFromPlc(PLCID:Byte;FUNCode:Byte;ADDR_Start:AnsiString;REG_Num:Byte):boolean;
    Function WriteToPlc_MR(PLCID:Byte;FUNCode:Byte;ADDR_Start,WRData:AnsiString;REG_Num:Byte):boolean;
    Function SetHYACT(PumpNum:Byte):Boolean;
    Function GetHYStatus(PumpNum:Byte):Boolean;

  end;

  Procedure Delay(MSecs:longint);
  Function checkLRC(PCharData:PansiChar;itmp:integer):Byte;
  Function LRC_Check(PCharData:PansiChar;itmp:integer):Byte;

var
  FatekPLCForm: TFatekPLCForm;

implementation

uses main;

{$R *.dfm}
//--------读取油源参数指令
Function TFatekPLCForm.GetHYStatus(PumpNum:Byte):Boolean;
Var
tmpData2PLC:AnsiString;
HYFunc:DWORD;
REGNUM:Byte;
ADDR_ST:AnsiString;
FatekFunc:Byte;
begin
  //读 R1100~R1105 共6个Word
  ADDR_ST:='R01100';    //DR01000
  REGNUM:=6+PumpNum-1;    //6个单字  R1100~R1105 每多一个油泵，增一个字 显示泵的状态
  FatekFunc:=$46;
  Result:=ReadFromPlc_MR(ParaInfo.ComPara.ID,FatekFunc,ADDR_ST,REGNum);
end;
//=========读取油源参数指令

//------ParaInfo.PumpNum  泵的数量
//设定油源运行，写PLC
Function TFatekPLCForm.SetHYACT(PumpNum:Byte):Boolean;
Var
tmpData2PLC:AnsiString;
//tmpInt:DWORD;
HYFunc:DWORD;
REGNUM:Byte;
ADDR_ST:AnsiString;
//tmpResult:boolean;
i:byte;
begin
  // R1000
  //0位：泵1开；1位：泵1关；2位：高压；3位：低压；4位：复位
  //  15 14 13 12位： 1010 指令有效  8位：在回零指令进，暂为DIR,即初始回零方向，可不用
  ADDR_ST:='R01000';    //DR01000
  REGNUM:=2+PumpNum-1;    //两个单字  R1000 R1001
  //SFFunc:= dir shl 8;
   tmpData2PLC:='';
  for i := 1 to PumpNum do
  begin
    HYFunc := HYParaInfo.HYCMD.Pump_OnOff[1] + HYParaInfo.HYCMD.Pressure_HiLow[1]
            +HYParaInfo.HYCMD.CoolPump_OnOff[1] + HYParaInfo.HYCMD.Reset_All;
    if i>1 then
    begin
      tmpData2PLC:= tmpData2PLC+AnsiString(Format('%.4x',[HYFunc])); //
    end else
    begin
      tmpData2PLC:= tmpData2PLC+AnsiString(Format('%.4x',[HYFunc]))+AnsiString(Format('%.4x',[HYFunc])); //
    end;

  end;
 // REGNUM:=Byte(AnsiStrings.StrLen(PansiChar(tmpData2PLC))/4);
  Result := WriteToPlc_MR(ParaInfo.ComPara.ID,$47,ADDR_ST,tmpData2PLC,REGNum) ;
end;

//==========

//----Fatek 读取PLC中的数据
Function TFatekPLCForm.ReadFromPlc(PLCID:Byte;FUNCode:Byte;ADDR_Start:AnsiString;REG_Num:Byte):boolean;
Var
  tmpStr:AnsiString;
  str:string;
  DataPtr:PAnsiChar;
begin
  result:=False;
  Case FunCode of     //所有读指令
    $40:   //PLC概略系统状态读取
      begin
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode]));
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $43:   //多个连续单点的抑/致能状态读取
      begin      //ADDR_Start:单点地址'Y0010' 5位
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $44:  //多个连续单点状态读取
      begin   //ADDR_Start:单点地址'Y0010' 5位
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $46: //多个连续缓存器数据读取
      begin
        ReadFromPlc_MR(PLCID,FUNCode,ADDR_Start,REG_Num);
      end;
    $48:  //多个任意单点状态或缓存器数据混合读取  //REG_NUM:01H--40H
      begin   //位地址：5位；字地址：6位，双字地址：7位 ，ADDR_Start:应该是所有的地址
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $4E:  //测试回传 ,原文返回
      begin   //ADDR_Start 应为实发数据，不是地址
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $53: //PLC 详细状态
      begin
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode]));
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
      end;

  end;
 // DataPtr:=nil;
end;
//=== Fatek 读取PLC中的数据

//---多个连续缓存器读取，命令码：46  //PLCID:站号，FUNCode:命令码；ADDR_Start:起始地址 REG_Num:要读的数量
//ADDR_Start:起始缓存器号6位'R00012'；REG_Num:数量
Function TFatekPLCForm.ReadFromPlc_MR(PLCID:Byte;FUNCode:Byte;ADDR_Start:AnsiString;REG_Num:Byte):boolean;
var
tmpStr:AnsiString;
DataPtr1:PAnsiChar;
begin
 // ;    IntToStr(PLCID)  IntToStr(FUNCode)  IntToStr(REG_Num)
  tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
  DataPtr1:=PAnsiChar(tmpStr);   // @tmpStr[1];

  Result:=SendData2Plc(DataPtr1,AnsiStrings.StrLen(DataPtr1),FUNCode);
end;
//====多个连续缓存器读取

//---多个连续缓存器写入，命令码：47  //PLCID:站号，FUNCode:命令码；
//ADDR_Start:起始缓存器号6位'R00012'或7位，6位为字，7位为双字；REG_Num:数量
Function TFatekPLCForm.WriteToPlc_MR(PLCID:Byte;FUNCode:Byte;ADDR_Start,WRData:AnsiString;REG_Num:Byte):boolean;
var
tmpStr:AnsiString;
DataPtr:PAnsiChar;
begin
 // ;    IntToStr(PLCID)  IntToStr(FUNCode)  IntToStr(REG_Num)
  tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start+WRData;
  //GetMem(DataPtr,sizeof(char) * (1+StrLen(tmpStr)));
  DataPtr:= PAnsiChar(tmpStr);  // @tmpStr[1];
  Result:=SendData2Plc(DataPtr,AnsiStrings.StrLen(DataPtr),FUNCode);
end;
//====多个连续缓存器读取

//---发送数据至FatekPLC，发起通讯，使用Fateck专用协议，Port0口
//--DataPtr中只含要发送的数据，不含起始码，校验码及终止码，这三码在此函数中加上
Function TFatekPLCForm.SendData2Plc(DataPtr:PansiChar;DataLen:integer;FUNCode:byte):boolean;
var
tmpData2:PansiChar;
PEtx:Pansichar;
PStx:Pansichar;
CheckSum:Byte;
tmpresult:boolean;
TempInt:integer;
tmpStr:Ansistring;
begin
///---------20181208

  tmpresult:=False;
  if (MainForm.PLC_Comm.Handle<>INVALID_HANDLE_VALUE) and ParaInfo.ComPara.Enable then
  begin
   PEtx :=#03; //结束字符
   PStx:=#02; //起始字符
   AnsiStrings.StrCopy(PMemAll.PComSendMem1,PAnsiCHar(PStx));    //   tmpData1

   AnsiStrings.StrCat(PMemAll.PComSendMem1,DataPtr);   //   tmpData1
   CheckSum:=checkLRC(PMemAll.PComSendMem1,AnsiStrings.StrLen(PMemAll.PComSendMem1));  //   tmpData1

   tmpStr:= AnsiString(Format('%.2x',[CheckSum]));
   tmpData2:=Pansichar( tmpStr);     //
    AnsiStrings.StrCopy(PStr_Send2PLC,PMemAll.PComSendMem1);  ////   tmpData1
    AnsiStrings.StrCat(PStr_Send2PLC,tmpData2);
    AnsiStrings.StrCat(PStr_Send2PLC,PEtx);
    TempInt:=AnsiStrings.strLen(PStr_Send2PLC);

      tmpresult:=Mainform.PLC_Comm.WriteCommData((PStr_Send2PLC),TempInt);

 end;
   Result:= tmpresult;
end;
//=====发送数据经FatekPLC，发起通讯

//-------打开PLC串口 并设置串口参数
Function TFatekPLCForm.PLCCOMInit(ComPortInfo:TComPara ):boolean;
begin
  //
  MainForm.PLC_Comm.Outx_CtsFlow:=False;
  MainForm.PLC_Comm.Outx_DsrFlow:=False;
  //如为2进制，以下两项要设为False ,否则XoffChar和XonChar所对应的字符不能接收
  MainForm.PLC_Comm.Inx_XonXoffFlow := True;
  MainForm.PLC_Comm.Outx_XonXoffFlow := True;
  MainForm.PLC_Comm.XoffChar:=#02;
  MainForm.PLC_Comm.XOnChar:=#03 ;


  if ParaInfo.ComPara.Enable then
  begin
    //MainForm.PLC_Comm.BaudRate := ParaInfo.ComPara.ComPortSpeed
    //ParaInfo.ComPara.ComPortSpeed

     Case ParaInfo.ComPara.ComPortSpeed of
       br9600:
         begin
           MainForm.PLC_Comm.BaudRate:=9600;
         end;
       br19200:
         begin
           MainForm.PLC_Comm.BaudRate:=19200;
         end;
       br38400:
         begin
           MainForm.PLC_Comm.BaudRate:=38400;
         end;
       br57600:
         begin
           MainForm.PLC_Comm.BaudRate:=57600;
         end;
       br115200:
         begin
           MainForm.PLC_Comm.BaudRate:=115200;
         end else
         begin
           MainForm.PLC_Comm.BaudRate:=9600;
         end;
     end;  //end case ComPortInfo.ComPortSpeed

     Case ParaInfo.ComPara.ComPort of
       pnCOM1:
         begin
           MainForm.PLC_Comm.commName:='COM1';
         end;
       pnCOM2:
         begin
           MainForm.PLC_Comm.commName:='COM2';
         end;
       pnCOM3:
         begin
           MainForm.PLC_Comm.commName:='COM3';
         end;
       pnCOM4:
         begin
           MainForm.PLC_Comm.commName:='COM4';
         end;
       pnCOM5:
         begin
           MainForm.PLC_Comm.commName:='COM5';
         end;
       pnCOM6:
         begin
           MainForm.PLC_Comm.commName:='COM6';
         end else
         begin
           MainForm.PLC_Comm.commName:='COM1';
         end;
     end; //end case ComPortInfo.ComPort
      Case ComPortInfo.ComPortParity of
       ptNONE:
         begin
           MainForm.PLC_Comm.Parity:= None; //奇偶检验无
         end;
       ptODD:
         begin
           MainForm.PLC_Comm.Parity:= Odd;
         end;
       ptEVEN:
         begin
           MainForm.PLC_Comm.Parity:= Even;
         end;
       ptMARK:
         begin
           MainForm.PLC_Comm.Parity:= Mark;
         end;
       ptSPACE:
         begin
           MainForm.PLC_Comm.Parity:= Space;
         end else
         begin
           MainForm.PLC_Comm.Parity:= Even;
         end;

     end; //end  Case ComPortInfo.ComPortParity
    //MainForm.PLC_Comm.Parity :=  TParity( ParaInfo.ComPara.ComPortParity);
    MainForm.PLC_Comm.ByteSize :=TByteSize(ParaInfo.ComPara.ComPortDataBits);  //数据位7 _7
    MainForm.PLC_Comm.StopBits:=TStopBits(ParaInfo.ComPara.ComPortStopBits);  //停止位1 _1
    MainForm.PLC_Comm.StopComm;
    delay(300);
    MainForm.PLC_Comm.ReadIntervalTimeout:= 25 ;
    MainForm.PLC_Comm.StartComm;
    delay(300);

    if MainForm.PLC_Comm.Handle=INVALID_HANDLE_VALUE then
    begin
        MainForm.PLC_Comm.StopComm;
        MainForm.PLC_Comm.ReadIntervalTimeout:= 25 ;
        MainForm.PLC_Comm.StartComm;
       delay(1);
    end;
  end;
  if MainForm.PLC_Comm.Handle=INVALID_HANDLE_VALUE then
  begin
    Result:=False;
  end else
  begin
    result:=true;
  end;



end;
//========打开PLC串口 并设置串口参数

//------------- 连至下位机PLC的串口默认参数，用PLC的Port0只可更改波特率
Procedure TFatekPLCForm.PLCCOMDefault( );
begin  //没有配置文件时调用此默认参数
  ParaInfo.ComPara.ComPort:=pnCOM1;
  ParaInfo.ComPara.ComPortSpeed:=br9600;
  ParaInfo.ComPara.ComPortStopBits:=sb1BITS;
  ParaInfo.ComPara.ComPortDataBits:=db7BITS;
  ParaInfo.ComPara.ComPortParity:=ptEven;
  //Mainform.ModbusM1.Functioncode:=3;
  if ParaInfo.ComPara.Enable then
  begin
    PLCCOMInit(ParaInfo.ComPara);
  end;

end;
//=======

//--------
Procedure TFatekPLCForm.PLCCOMFree(); //PLC串口释放
begin
   if MainForm.PLC_Comm.Handle<>INVALID_HANDLE_VALUE then
    begin
       MainForm.PLC_Comm.stopcomm;
       delay(1);
    end;
end;
//==========

Procedure Delay(MSecs:longint);
var
FirstTickCount,CurrentTickCount:longint;
begin
  FirstTickCount:=GetTickCount();
Repeat
  Application.ProcessMessages;
  CurrentTickCount:=GetTickCount();
  Until(CurrentTickCount-FirstTickCount>=MSecs)or(CurrentTickCount<FirstTickCount);
end;



//*************************************
//***********校验和********LRC?********
//*************************************

function LRC_Check(PCharData:PansiChar;itmp:integer):Byte;     //
var
 // arraybyte:array of byte;
  PbData:PByte;
  i:integer;
  PCharDataLen:integer;
  intback:byte;//integer;
begin //指针要注意，不要超限 ,内存要注意，有Get就要有Free
  //GetMem(PbData,Sizeof(Byte)*(StrLen(PCharData)+1));
  PbData:=PByte(PCharData);
  PCharDataLen:=AnsiStrings.StrLen(PCharData);

  intback:=0; //arraybyte[i];
  for i:=1 to PCharDataLen do
  begin
    begin
      intback:=PbData^ + intback;
    end;
    Inc(PbData);
  end;
 // PbData:=nil;
  result:=intback;
end;

function checkLRC(PCharData:PansiChar;itmp:integer):Byte;     //
var
 // arraybyte:array of byte;
  PbData:PByte;
  i:integer;
  PCharDataLen:integer;
  intback:byte;//integer;
begin //指针要注意，不要超限 ,内存要注意，有Get就要有Free
  //GetMem(PbData,Sizeof(Byte)*(StrLen(PCharData)+1));
  PbData:=PByte(PCharData);
  PCharDataLen:=AnsiStrings.StrLen(PCharData);

  intback:=0; //arraybyte[i];
  for i:=1 to PCharDataLen do
  begin
    begin
      intback:=PbData^ + intback;
    end;
    Inc(PbData);
  end;
  //PbData:=nil;
  result:=intback;
end;


end.
