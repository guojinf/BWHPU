unit FileFunc;
  //系统配置文件用IniFiles 文件格式保存
interface
uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,System.IniFiles,TypeDef,VarDef;


Function IntTo2Str(n:integer):string;
 //当Str不到Len长度时，在Str前面自动填充FillStr以补足长度
  Function FillString_Start(Const Str:String;Len:integer;FillStr:Char):string; //
  //当Str不到Len长度时，在Str后面自动填充FillStr以补足长度
  Function FillString_END(Const Str:String;Len:integer;FillStr:Char):string; //



  procedure SaveCommInitFile(InitFileName:String;TempInitInfo:TCommInitInfo);
  Function  OpenCommInitFile(InitFileName:string):TCommInitInfo;

  Procedure SaveParaIniFile(InitFileName:String;TempInitInfo:TParaInfo); //用iniFiles
  Function OpenParaIniFile(InitFileName:String):TParaInfo;   //用iniFiles


implementation

Procedure SaveParaIniFile(InitFileName:String;TempInitInfo:TParaInfo); //用iniFiles
Var
IniFile:TIniFile;
TmpStr:String;
i:integer;
Begin

  IniFile:=TiniFile.Create(InitFileName);
  Try


      //-----Para
      IniFile.WriteInteger('PARA','CommType',TempInitInfo.CommType);
      IniFile.WriteBool('PARA','PumpOff_ATSoftColse_EN',TempInitInfo.PumpOff_ATSoftColse_EN);
      for i := 1 to 4 do   //要显示的参数及所在PLC的地址
        begin
          IniFile.WriteBool('PARA','ParaDispEN'+IntToStr(i),TempInitInfo.ParaDispEN[i]);
          IniFile.WriteInteger('PARA','ParaDispAdd'+IntToStr(i),TempInitInfo.ParaDispAdd[i]);
        end;
      IniFile.WriteInteger('PARA','PLCType',TempInitInfo.PLCType);
      IniFile.WriteInteger('PARA','PUMPNUM',TempInitInfo.PumpNum);

    //----ComPara
      tmpStr:=TempInitInfo.ComPara.Name;
      IniFile.WriteString('SerialComPara','ComPortName',tmpStr);
      tmpStr:=TempInitInfo.ComPara.MODBusType;
      IniFile.WriteString('SerialComPara','ModBusType',tmpStr); //M Master S Slave

      IniFile.WriteBool('SerialComPara','ComPort_EN',TempInitInfo.ComPara.Enable);

      IniFile.WriteInteger('SerialComPara','ComPort',Ord(TempInitInfo.ComPara.ComPort));

      IniFile.WriteInteger('SerialComPara','BaseADD',TempInitInfo.ComPara.BaseADD);

      IniFile.WriteInteger('SerialComPara','ComPortID',TempInitInfo.ComPara.ID);

      IniFile.WriteInteger('SerialComPara','ComPortSpeed',Ord(TempInitInfo.ComPara.ComPortSpeed));

      IniFile.WriteInteger('SerialComPara','ComPortDataBits',Ord(TempInitInfo.ComPara.ComPortDataBits));

      IniFile.WriteInteger('SerialComPara','ComPortParity',Ord(TempInitInfo.ComPara.ComPortParity));
      IniFile.WriteInteger('SerialComPara','ComPortStopBits',Ord(TempInitInfo.ComPara.ComPortStopBits));
      IniFile.WriteInteger('SerialComPara','ProtocolType',(TempInitInfo.ComPara.ProtocolType));

    //NetPara
      Inifile.WriteString('NetPara','IPADDR',TempInitInfo.NetPara.IPAddr);
      Inifile.WriteInteger('NetPara','PORT',TempInitInfo.NetPara.Port);
      Inifile.WriteInteger('NetPara','Protocol',TempInitInfo.NetPara.ProtocolType);
  Finally
    IniFile.Free;
  End;


End;


Function OpenParaIniFile(InitFileName:String):TParaInfo;   //用iniFiles
Var
IniFile:TIniFile;
TmpStr:String;
i:integer;
begin
    //
  IniFile:=TiniFile.Create(InitFileName);
  Try
    Try
       //-----Para
      Result.CommType:=Byte( IniFile.ReadInteger('PARA','CommType',0));
      Result.PumpOff_ATSoftColse_EN:=IniFile.ReadBool('PARA','PumpOff_ATSoftColse_EN',False);
      //
      for i := 1 to 4 do
        begin
          Result.ParaDispEN[i]:=IniFile.ReadBool('PARA','ParaDispEN'+IntToStr(i),True);
          Result.ParaDispAdd[i]:=IniFile.ReadInteger('PARA','ParaDispAdd'+IntToStr(i),0);
        end;
      Result.PLCType:=IniFile.ReadInteger('PARA','PLCType',0);
      Result.PumpNum:=IniFile.ReadInteger('PARA','PUMPNUM',1);
      //----ComPara

      Result.ComPara.Name:=IniFile.ReadString('SerialComPara','ComPortName','COM1');
      TmpStr := IniFile.ReadString('SerialComPara','ModBusType','S');
      if TmpStr<>'' then
        Result.ComPara.MODBusType:=TmpStr[1]; //M Master S Slave

      Result.ComPara.Enable:= IniFile.ReadBool('SerialComPara','ComPort_EN',False);

      Result.ComPara.ComPort:= TComPortNumber(IniFile.ReadInteger('SerialComPara','ComPort',0));

      Result.ComPara.BaseADD:= (IniFile.ReadInteger('SerialComPara','BaseADD',0));

      Result.ComPara.ID := IniFile.ReadInteger('SerialComPara','ComPortID',0);

      Result.ComPara.ComPortSpeed:=TComPortBaudRate(IniFile.ReadInteger('SerialComPara','ComPortSpeed',6));

      Result.ComPara.ComPortDataBits:= TComPortDataBits(IniFile.ReadInteger('SerialComPara','ComPortDataBits',3));

      Result.ComPara.ComPortParity:= TComPortParity(IniFile.ReadInteger('SerialComPara','ComPortParity',0));
      Result.ComPara.ComPortStopBits:= TComPortStopBits(IniFile.ReadInteger('SerialComPara','ComPortStopBits',2));
      Result.ComPara.ProtocolType:= IniFile.ReadInteger('SerialComPara','ProtocolType',0);

      //NetPara
      Result.NetPARA.IPAddr:=IniFile.ReadString('NetPara','IPADDR','192.168.0.11');
      Result.NetPARA.Port:=IniFile.ReadInteger('NetPara','PORT',502);
      Result.NetPARA.ProtocolType:=IniFile.ReadInteger('NetPara','Protocol',0);

    Except
      On EconvertError do
      begin
        ShowMessage(InitFileName+'打开文件错误!');
      end;

    End;

  finally
    IniFile.Free;
  end;
end;


Function IntTo2Str(n:integer):string;
begin
    Result:=Inttostr(n);
  if length(Result)=1 then
  begin
    Insert('0',Result,0);
  end;
end;


Function FillString_Start(Const Str:String;Len:integer;FillStr:Char):string  ;
begin
  Result:=StringOfChar(FillStr,Len-Length(Str))+Str;
end;

Function FillString_End(Const Str:String;Len:integer;FillStr:Char):string  ;
begin
  Result:=Str+StringOfChar(FillStr,Len-Length(Str));
end;

procedure SaveCommInitFile(InitFileName:String;TempInitInfo:TCommInitInfo);
var
i:integer;
InitFile:Textfile;
begin
  filesetAttr(InitFileName,faArchive);
  AssignFile(Initfile,InitfileName);
  Rewrite(Initfile);
        begin
        Try
          for i:=1 to 2 do
          begin
            ///Writeln(InitFile,IntToStr(i)+ 'PCOMNAME      '+TempInitInfo.PCom[i].Name);
            //Writeln(InitFile,IntToStr(i)+ 'PCOMBASEADD   '+IntToStr(TempInitInfo.PCom[i].BaseADD));
          end;
          for i:=1 to 8 do
          begin
            Writeln(InitFile,IntToStr(i)+ 'SCOMNAME      '+TempInitInfo.SCom[i].Name);
            Writeln(InitFile,IntToStr(i)+ 'SCOM_MD_TYPE  '+TempInitInfo.SCom[i].MODBusType);
            Writeln(InitFile,IntToStr(i)+ 'SCOMPORTEN    '+boolToStr(TempInitInfo.SCom[i].Enable,True));
            Writeln(InitFile,IntToStr(i)+ 'SCOMBASEADD   '+IntToStr(TempInitInfo.SCom[i].BaseADD));
            Writeln(InitFile,IntToStr(i)+ 'SCOMID        '+IntToStr(TempInitInfo.SCom[i].ID));
            Writeln(InitFile,IntToStr(i)+ 'SCOMPORTN     '+IntToStr(Ord(TempInitInfo.SCom[i].ComPort)) );
            Writeln(InitFile,IntToStr(i)+ 'SCOMPORTSPD   '+IntToStr(Ord(TempInitInfo.SCom[i].ComPortSpeed)));
            Writeln(InitFile,IntToStr(i)+ 'SCOMPORTDBITS '+IntToStr(Ord(TempInitInfo.SCom[i].ComPortDataBits)));
            Writeln(InitFile,IntToStr(i)+ 'SCOMPORTPRTY  '+IntToStr(Ord(TempInitInfo.SCom[i].ComPortParity)));
            Writeln(InitFile,IntToStr(i)+ 'SCOMPTSTPBITS '+IntToStr(Ord(TempInitInfo.SCom[i].ComPortStopBits)));
          end;
            //  GetEnumName(TypeInfo(TComPortParity),1);

          Writeln(InitFile, 'end        ');
          except
          ShowMessage(InitFileName+'文件错误!');
          closefile(InitFile);
          end;
          end;
  closefile(InitFile);
  filesetAttr(InitFileName,faReadOnly); //只读属性
end;

Function  OpenCommInitFile(InitFileName:string):TCommInitInfo;
var
InitFile:TextFile;
Buf,tempstr:string;
i:integer;
begin
AssignFile(InitFile,InitFileName);
Reset(InitFile);
Readln(InitFile,buf);
while not Eof(InitFile) do
begin
try
//PCOMInfo
  for i:=1 to 2 do
  begin
    {if Pos(IntToStr(i)+'PCOMNAME',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.PCom[i].Name:=tempstr;
      end;
    if Pos(IntToStr(i)+'PCOMBASEADD',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.PCom[i].BaseADD:=StrToInt(trim(tempstr));
      end;
      }
  end;
  for i:=1 to 8 do
  begin
    if Pos(IntToStr(i)+'SCOMNAME',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].Name:=trim(tempstr);
      end;
    if Pos(IntToStr(i)+'SCOM_MD_TYPE',buf)>0 then
      begin
      tempStr:=Copy(buf,16,2);
      Result.SCom[i].MODBusType:=(tempstr[1]);
      end;
    if Pos(IntToStr(i)+'SCOMPORTEN',buf)>0 then
      begin
        tempstr:=Copy(buf,16,10);
        Result.SCom[i].Enable:=StrToBool(Trim(TempStr));
      end;
    if Pos(IntToStr(i)+'SCOMBASEADD',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].BaseADD:=StrToInt(trim(tempstr));
      end;
    if Pos(IntToStr(i)+'SCOMID',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].ID:=Byte(StrToInt(trim(tempstr)));
      end;
     if Pos(IntToStr(i)+'SCOMPORTN',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].ComPort:=TComPortNumber(StrToInt(trim(tempstr)));  //GetEnumName(TypeInfo(TComPortParity),1);
      end;
    if Pos(IntToStr(i)+'SCOMPORTSPD',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].ComPortSpeed:=TComPortBaudRate(StrToInt(trim(tempstr)));
      end;
    if Pos(IntToStr(i)+'SCOMPORTDBITS',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].ComPortDataBits:=TComPortDataBits(StrToInt(trim(tempstr)));  //GetEnumName(TypeInfo(TComPortParity),1);
      end;
    if Pos(IntToStr(i)+'SCOMPORTPRTY',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].ComPortParity:=TComPortParity(StrToInt(trim(tempstr)));
      end;
    if Pos(IntToStr(i)+'SCOMPTSTPBITS',buf)>0 then
      begin
      tempStr:=Copy(buf,16,10);
      Result.SCom[i].ComPortStopBits:=TComPortStopBits(StrToInt(trim(tempstr)));
      end;
  end;

    Readln(InitFile,buf);
except
  On EconvertError do
  begin
  ShowMessage(InitFileName+'打开文件错误!');
  closefile(InitFile);
  end;
end;
end;
closefile(InitFile);

end;

end.
