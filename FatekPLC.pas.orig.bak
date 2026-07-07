unit FatekPLC;
{ // 锟斤拷FatekPLC通讯
 //锟斤拷为锟斤拷锟斤拷模式锟斤拷锟斤拷锟斤拷展
 //写锟斤拷PLC指锟斤拷   锟斤拷写锟斤拷址为R1000~R1001
 // R1000 || Bit0:锟斤拷锟斤拷1锟斤拷bit1:锟截憋拷1 bit2:锟斤拷压1锟斤拷bit3: 锟斤拷压1, bit4:锟斤拷位
 //R1001 锟斤拷写锟斤拷锟斤拷预锟斤拷锟斤拷PLC R1000~R1199为PC写锟斤拷锟斤拷预锟斤拷
 //R1002 锟斤拷2指锟斤拷
 //R1003 锟斤拷3指锟斤拷
 //R1004 锟斤拷4指锟斤拷
 //R1005 锟斤拷5指锟斤拷
 //R1006 锟斤拷6指锟斤拷

 // 锟斤拷PLC锟斤拷锟斤拷  锟捷讹拷锟斤拷址为R1100~R1105 每锟斤拷一锟斤拷时应锟斤拷锟斤拷锟斤拷一锟斤拷
 //R1100 || bit0:锟斤拷源1状态锟斤拷bit1锟斤拷bit2, bit3:锟斤拷1锟斤拷压状态 锟斤拷bit4-Bit7:锟斤拷锟斤拷锟斤拷状态
 //R1101 锟斤拷预锟斤拷
 //R1102~R1105 锟街憋拷为压锟斤拷锟斤拷锟铰度ｏ拷液位锟斤拷锟斤拷锟斤拷值
 //R1106 锟斤拷2状态
 //R1107 锟斤拷3状态
 //R1108 锟斤拷4状态
  //R1109 锟斤拷5状态
 //R1110 锟斤拷6状态



}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,System.AnsiStrings;

type
  TFatekPLCForm = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    Function  PLCCOMInit(ComPortInfo:TComPara ):boolean;
    Procedure PLCCOMDefault( );
    Procedure PLCCOMFree(); //PLC锟斤拷锟斤拷锟酵凤拷
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
//--------锟斤拷取锟斤拷源锟斤拷锟斤拷指锟斤拷
Function TFatekPLCForm.GetHYStatus(PumpNum:Byte):Boolean;
Var
tmpData2PLC:AnsiString;
HYFunc:DWORD;
REGNUM:Byte;
ADDR_ST:AnsiString;
FatekFunc:Byte;
begin
  //锟斤拷 R1100~R1105 锟斤拷6锟斤拷Word
  ADDR_ST:='R01100';    //DR01000
  REGNUM:=6+PumpNum-1;    //6锟斤拷锟斤拷锟斤拷  R1100~R1105 每锟斤拷一锟斤拷锟酵泵ｏ拷锟斤拷一锟斤拷锟斤拷 锟斤拷示锟矫碉拷状态
  FatekFunc:=$46;
  Result:=ReadFromPlc_MR(ParaInfo.ComPara.ID,FatekFunc,ADDR_ST,REGNum);
end;
//=========锟斤拷取锟斤拷源锟斤拷锟斤拷指锟斤拷

//------ParaInfo.PumpNum  锟矫碉拷锟斤拷锟斤拷
//锟借定锟斤拷源锟斤拷锟叫ｏ拷写PLC
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
  //0位锟斤拷锟斤拷1锟斤拷锟斤拷1位锟斤拷锟斤拷1锟截ｏ拷2位锟斤拷锟斤拷压锟斤拷3位锟斤拷锟斤拷压锟斤拷4位锟斤拷锟斤拷位
  //  15 14 13 12位锟斤拷 1010 指锟斤拷锟斤拷效  8位锟斤拷锟节伙拷锟斤拷指锟斤拷锟斤拷锟斤拷锟轿狣IR,锟斤拷锟斤拷始锟斤拷锟姐方锟津，可诧拷锟斤拷
  ADDR_ST:='R01000';    //DR01000
  REGNUM:=2+PumpNum-1;    //锟斤拷锟斤拷锟斤拷锟斤拷  R1000 R1001
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
 // REGNUM:=Byte(System.AnsiStrings.StrLen(PansiChar(tmpData2PLC))/4);
  Result := WriteToPlc_MR(ParaInfo.ComPara.ID,$47,ADDR_ST,tmpData2PLC,REGNum) ;
end;

//==========

//----Fatek 锟斤拷取PLC锟叫碉拷锟斤拷锟斤拷
Function TFatekPLCForm.ReadFromPlc(PLCID:Byte;FUNCode:Byte;ADDR_Start:AnsiString;REG_Num:Byte):boolean;
Var
  tmpStr:AnsiString;
  str:string;
  DataPtr:PAnsiChar;
begin
  result:=False;
  Case FunCode of     //锟斤拷锟叫讹拷指锟斤拷
    $40:   //PLC锟斤拷锟斤拷系统状态锟斤拷取
      begin
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode]));
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $43:   //锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷/锟斤拷锟斤拷状态锟斤拷取
      begin      //ADDR_Start:锟斤拷锟斤拷锟街?Y0010' 5位
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $44:  //锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟阶刺拷锟饺?
      begin   //ADDR_Start:锟斤拷锟斤拷锟街?Y0010' 5位
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $46: //锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷荻锟饺?
      begin
        ReadFromPlc_MR(PLCID,FUNCode,ADDR_Start,REG_Num);
      end;
    $48:  //锟斤拷锟斤拷锟斤拷獾ワ拷锟阶刺拷蚧捍锟斤拷锟斤拷锟斤拷莼锟较讹拷取  //REG_NUM:01H--40H
      begin   //位锟斤拷址锟斤拷5位锟斤拷锟街碉拷址锟斤拷6位锟斤拷双锟街碉拷址锟斤拷7位 锟斤拷ADDR_Start:应锟斤拷锟斤拷锟斤拷锟叫的碉拷址
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $4E:  //锟斤拷锟皆回达拷 ,原锟侥凤拷锟斤拷
      begin   //ADDR_Start 应为实锟斤拷锟斤拷锟捷ｏ拷锟斤拷锟角碉拷址
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode]))+ADDR_Start;
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
      end;
    $53: //PLC 锟斤拷细状态
      begin
        tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode]));
        DataPtr:=PAnsiChar(tmpStr);
        Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
      end;

  end;
 // DataPtr:=nil;
end;
//=== Fatek 锟斤拷取PLC锟叫碉拷锟斤拷锟斤拷

//---锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟饺★拷锟斤拷锟斤拷锟斤拷耄?6  //PLCID:站锟脚ｏ拷FUNCode:锟斤拷锟斤拷锟诫；ADDR_Start:锟斤拷始锟斤拷址 REG_Num:要锟斤拷锟斤拷锟斤拷锟斤拷
//ADDR_Start:锟斤拷始锟斤拷锟斤拷锟斤拷锟斤拷6位'R00012'锟斤拷REG_Num:锟斤拷锟斤拷
Function TFatekPLCForm.ReadFromPlc_MR(PLCID:Byte;FUNCode:Byte;ADDR_Start:AnsiString;REG_Num:Byte):boolean;
var
tmpStr:AnsiString;
DataPtr1:PAnsiChar;
begin
 // ;    IntToStr(PLCID)  IntToStr(FUNCode)  IntToStr(REG_Num)
  tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start;
  DataPtr1:=PAnsiChar(tmpStr);   // @tmpStr[1];

  Result:=SendData2Plc(DataPtr1,System.AnsiStrings.StrLen(DataPtr1),FUNCode);
end;
//====锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟饺?

//---锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟叫达拷耄拷锟斤拷锟斤拷耄?7  //PLCID:站锟脚ｏ拷FUNCode:锟斤拷锟斤拷锟诫；
//ADDR_Start:锟斤拷始锟斤拷锟斤拷锟斤拷锟斤拷6位'R00012'锟斤拷7位锟斤拷6位为锟街ｏ拷7位为双锟街ｏ拷REG_Num:锟斤拷锟斤拷
Function TFatekPLCForm.WriteToPlc_MR(PLCID:Byte;FUNCode:Byte;ADDR_Start,WRData:AnsiString;REG_Num:Byte):boolean;
var
tmpStr:AnsiString;
DataPtr:PAnsiChar;
begin
 // ;    IntToStr(PLCID)  IntToStr(FUNCode)  IntToStr(REG_Num)
  tmpStr:=AnsiString(Format('%.2x',[PLCID])+Format('%.2x',[FUNCode])+Format('%.2x',[REG_Num]))+ADDR_Start+WRData;
  //GetMem(DataPtr,sizeof(char) * (1+StrLen(tmpStr)));
  DataPtr:= PAnsiChar(tmpStr);  // @tmpStr[1];
  Result:=SendData2Plc(DataPtr,System.AnsiStrings.StrLen(DataPtr),FUNCode);
end;
//====锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟饺?

//---锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷FatekPLC锟斤拷锟斤拷锟斤拷通讯锟斤拷使锟斤拷Fateck专锟斤拷协锟介，Port0锟斤拷
//--DataPtr锟斤拷只锟斤拷要锟斤拷锟酵碉拷锟斤拷锟捷ｏ拷锟斤拷锟斤拷锟斤拷始锟诫，校锟斤拷锟诫及锟斤拷止锟诫，锟斤拷锟斤拷锟斤拷锟节此猴拷锟斤拷锟叫硷拷锟斤拷
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
   PEtx :=#03; //锟斤拷锟斤拷锟街凤拷
   PStx:=#02; //锟斤拷始锟街凤拷
   System.AnsiStrings.StrCopy(PMemAll.PComSendMem1,PAnsiCHar(PStx));    //   tmpData1

   System.AnsiStrings.StrCat(PMemAll.PComSendMem1,DataPtr);   //   tmpData1
   CheckSum:=checkLRC(PMemAll.PComSendMem1,System.AnsiStrings.StrLen(PMemAll.PComSendMem1));  //   tmpData1

   tmpStr:= AnsiString(Format('%.2x',[CheckSum]));
   tmpData2:=Pansichar( tmpStr);     //
    System.AnsiStrings.StrCopy(PStr_Send2PLC,PMemAll.PComSendMem1);  ////   tmpData1
    System.AnsiStrings.StrCat(PStr_Send2PLC,tmpData2);
    System.AnsiStrings.StrCat(PStr_Send2PLC,PEtx);
    TempInt:=System.AnsiStrings.StrLen(PStr_Send2PLC);

      tmpresult:=Mainform.PLC_Comm.WriteCommData((PStr_Send2PLC),TempInt);

 end;
   Result:= tmpresult;
end;
//=====锟斤拷锟斤拷锟斤拷锟捷撅拷FatekPLC锟斤拷锟斤拷锟斤拷通讯

//-------锟斤拷PLC锟斤拷锟斤拷 锟斤拷锟斤拷锟矫达拷锟节诧拷锟斤拷
Function TFatekPLCForm.PLCCOMInit(ComPortInfo:TComPara ):boolean;
begin
  //
  MainForm.PLC_Comm.Outx_CtsFlow:=False;
  MainForm.PLC_Comm.Outx_DsrFlow:=False;
  //锟斤拷为2锟斤拷锟狡ｏ拷锟斤拷锟斤拷锟斤拷锟斤拷要锟斤拷为False ,锟斤拷锟斤拷XoffChar锟斤拷XonChar锟斤拷锟斤拷应锟斤拷锟街凤拷锟斤拷锟杰斤拷锟斤拷
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
           MainForm.PLC_Comm.Parity:= None; //锟斤拷偶锟斤拷锟斤拷锟斤拷
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
    MainForm.PLC_Comm.ByteSize :=TByteSize(ParaInfo.ComPara.ComPortDataBits);  //锟斤拷锟斤拷位7 _7
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
//========锟斤拷PLC锟斤拷锟斤拷 锟斤拷锟斤拷锟矫达拷锟节诧拷锟斤拷

//------------- 锟斤拷锟斤拷锟斤拷位锟斤拷PLC锟侥达拷锟斤拷默锟较诧拷锟斤拷锟斤拷锟斤拷PLC锟斤拷Port0只锟缴革拷锟侥诧拷锟斤拷锟斤拷
Procedure TFatekPLCForm.PLCCOMDefault( );
begin  //没锟斤拷锟斤拷锟斤拷锟侥硷拷时锟斤拷锟矫达拷默锟较诧拷锟斤拷
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
Procedure TFatekPLCForm.PLCCOMFree(); //PLC锟斤拷锟斤拷锟酵凤拷
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
//***********校锟斤拷锟?*******LRC?********
//*************************************

function LRC_Check(PCharData:PansiChar;itmp:integer):Byte;     //
var
 // arraybyte:array of byte;
  PbData:PByte;
  i:integer;
  PCharDataLen:integer;
  intback:byte;//integer;
begin //指锟斤拷要注锟解，锟斤拷要锟斤拷锟斤拷 ,锟节达拷要注锟解，锟斤拷Get锟斤拷要锟斤拷Free
  //GetMem(PbData,Sizeof(Byte)*(StrLen(PCharData)+1));
  PbData:=PByte(PCharData);
  PCharDataLen:=System.AnsiStrings.StrLen(PCharData);

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
begin //指锟斤拷要注锟解，锟斤拷要锟斤拷锟斤拷 ,锟节达拷要注锟解，锟斤拷Get锟斤拷要锟斤拷Free
  //GetMem(PbData,Sizeof(Byte)*(StrLen(PCharData)+1));
  PbData:=PByte(PCharData);
  PCharDataLen:=System.AnsiStrings.StrLen(PCharData);

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
