unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,ParaSet,About, SPComm,TypeDef,Vardef,FileFunc,FatekPLC,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdModBusClient,AnsiStrings;

type
  TMainForm = class(TForm)
    ClientSocket1: TClientSocket;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Options_Item: TMenuItem;
    Quit_Item: TMenuItem;
    About_Item: TMenuItem;
    Bevel1: TBevel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    PumpGroupBox1: TGroupBox;
    PumpON_SpeedButton1: TSpeedButton;
    PumpOFF_SpeedButton1: TSpeedButton;
    PressureHI_SpeedButton1: TSpeedButton;
    PressureLow_SpeedButton1: TSpeedButton;
    PumpSta_Shape1: TShape;
    PressureSta_Shape1: TShape;
    ResetSta_Shape: TShape;
    Label1: TLabel;
    Filter_Shape1: TShape;
    Filter_Shape2: TShape;
    Filter_Shape3: TShape;
    Filter_Shape4: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PressureCaptionLabel: TLabel;
    PressureEdit: TEdit;
    PressureUnitLabel: TLabel;
    TemprEdit: TEdit;
    TemprUnitLabel: TLabel;
    TemprCaptionLabel: TLabel;
    HYLEdit: TEdit;
    HYLUnitLabel: TLabel;
    HYLCaptionLabel: TLabel;
    QEdit: TEdit;
    QUnitLabel: TLabel;
    QCaptionLabel: TLabel;
    PumpGroupBox2: TGroupBox;
    PumpON_SpeedButton2: TSpeedButton;
    PumpOFF_SpeedButton2: TSpeedButton;
    PressureHI_SpeedButton2: TSpeedButton;
    PressureLow_SpeedButton2: TSpeedButton;
    PumpSta_Shape2: TShape;
    PressureSta_Shape2: TShape;
    PumpGroupBox3: TGroupBox;
    PumpON_SpeedButton3: TSpeedButton;
    PumpOFF_SpeedButton3: TSpeedButton;
    PressureHI_SpeedButton3: TSpeedButton;
    PressureLow_SpeedButton3: TSpeedButton;
    PumpSta_Shape3: TShape;
    PressureSta_Shape3: TShape;
    PumpGroupBox4: TGroupBox;
    PumpON_SpeedButton4: TSpeedButton;
    PumpOFF_SpeedButton4: TSpeedButton;
    PressureHI_SpeedButton4: TSpeedButton;
    PressureLow_SpeedButton4: TSpeedButton;
    PumpSta_Shape4: TShape;
    PressureSta_Shape4: TShape;
    CommSta_Shape1: TShape;
    PLC_Comm: TComm;
    Button1: TButton;
    Label14: TLabel;
    ResetPanel: TPanel;
    DspTimer: TTimer;
    IdModBus_To_PLC: TIdModBusClient;
   
    procedure Quit_ItemClick(Sender: TObject);
    procedure Options_ItemClick(Sender: TObject);
    procedure About_ItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PLC_CommReceiveData(Sender: TObject; Buffer: Pointer;
      BufferLength: Word);
    procedure PumpON_SpeedButton1Click(Sender: TObject);
    procedure PumpOFF_SpeedButton1Click(Sender: TObject);
    procedure PressureLow_SpeedButton1Click(Sender: TObject);
    procedure PressureHI_SpeedButton1Click(Sender: TObject);
    procedure ResetPanelClick(Sender: TObject);
    procedure DspTimerTimer(Sender: TObject);
    Procedure Comm2PLC() ;
        Procedure ComDataTran();
    //--------通过ModbusTCP协议向FatekPLC发指令  通讯发起，Master
    Procedure ModbusTCP2PLC(PumpNum:Byte);
    Procedure DispConectStatus(Sender: TObject);
  private
    { Private declarations }

    Procedure DispAllHYPara();
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

  Function ModBusTcpSetHYACT(PumpNum:Byte):boolean;

implementation

{$R *.dfm}

uses LanguageFunc;

procedure TMainForm.About_ItemClick(Sender: TObject);
begin
  AboutForm.show;



end;

procedure TMainForm.Quit_ItemClick(Sender: TObject);
begin
  //是否选择了关软件时，关闭油泵，如选了，要先关油泵
  close;
end;

procedure TMainForm.ResetPanelClick(Sender: TObject);
var
  I: Integer;
begin
  if HYParaInfo.HYCMD.Reset_All=RESET_ALL_CMD then
  begin
    HYParaInfo.HYCMD.Reset_All:=0;
    MainForm.ResetPanel.Color:=ClBtnFace;
  end else
  begin
    HYParaInfo.HYCMD.Reset_All:=RESET_ALL_CMD;
    MainForm.ResetPanel.Color:=ClRed;
  end;


  for I := 1 to ParaInfo.PumpNum do
  begin
    HYParaInfo.HYCMD.Pump_OnOff[i]:=0;
    HYParaInfo.HYCMD.Pressure_HiLow[i]:=0;
  end;
  HYSetCMD_En:=True;   //指令有变，开始传送
  HYSetCMD_Num:=0;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
//tmpStr:string;
tmpAnsiStr:ansistring;
Pstr:PChar;
PAnsiStr:PansiChar;
tmpINt:Integer;
begin
   //SaveParaIniFile(HYParaFileName,ParaInfo);
  // tmpStr:='abcde';
  // tmpAnsiStr:='014603R00012';
  // Pstr:=Pchar(tmpStr);
 //  PansiStr:=PAnsiChar(tmpAnsiStr);
 //  tmpInt:=StrLen(Pstr);
  // Mainform.PLC_Comm.WriteCommData(PansiStr,TmpInt);
 //  FatekPLCForm.SendData2Plc(PansiStr,TmpInt,03) ;
  // FatekPLCForm.SetHYACT(1) ;
 // FatekPLCForm.GetHYStatus(1);
 SetLanguage(ExtractFilePath(ParamStr(0))+LanguageFileName, msgStr, $FF);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
i:byte;
begin
   //是否选择了关软件时，关闭油泵，如选了，要先关油泵
  if ParaInfo.PumpOff_ATSoftColse_EN then
  begin
    for I := 1 to ParaInfo.PumpNum do
    begin
      HYParaInfo.HYCMD.Pressure_HiLow[i]:=PRESSURE_LOW;
      HYParaInfo.HYCMD.Pump_OnOff[i]:=PUMP_OFF;
    end;

    HYSetCMD_En:=True;   //指令有变，开始传送
    HYSetCMD_Num:=0;
  end;
  if HYSetCMD_En then
  begin
    //i:=0;  //可以什么都不做
    CommFunc:=0;
    MainForm.ModbusTCP2PLC(ParaInfo.pumpNum);
  end;

  sleep(500);
  DspTimer.Enabled:=False;
  FatekPLCForm.PLCCOMFree();
  FreeMemory(PStr_Send2PLC);
 //  if IdModBus_To_PLC.Connected then
  begin
    IdModBus_To_PLC.Disconnect;
  end;

  PStr_Send2PLC:=Nil;
  FreeMemory(PMemAll.PComSendMem1);
  FreeMemory(PMemAll.PComSendMem2);
  PMemAll.PComSendMem1:=Nil;
  PMemAll.PComSendMem2:=Nil;
end;

procedure TMainForm.FormCreate(Sender: TObject);
Var
s:String;
begin
  GetDir(0,s);
  mDirName:=s+'\'; //获取当前目录
  //多语言设置
 LanguageFileName:=LANGUAGEFILE_D;
    DefineMsgStr();
//SetLanguage(ExtractFilePath(ParamStr(0))+LanguageFileName, msgStr, $FF);

//-----------------设备配置文件--------------------------------------
  HYParaFileName:=mDirName+'HYInitPara.Ini';      //读试验初始化文件
  if FileExists(HYParaFileName) then
  begin
    ParaInfo:=OpenParaIniFile(HYParaFileName);
    ParaInfoBak:=ParaInfo;//保存初始化文件备份
  end
  else
  begin
    showmessage(MSGStr[1]);    // '无HYInitPara.Ini配置文件！'
   if ParaInfo.CommType=COMMTYPE_COM then
    begin
      FatekPLCForm.PLCCOMDefault();
    end else
    if ParaInfo.CommType=COMMTYPE_NET then
    begin
       ParaInfo.NetPara.IPAddr:='192.168.1.3';
    end;
    //Application.Terminate;
  end;



end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
  VK_NUMPAD0:
    begin

    end; //end Num0
     VK_NUMPAD1:
    begin

      //Zero_CalButton.Click;
    end; //end Num1
     VK_NUMPAD2:
    begin

    end; //end Num2
     VK_NUMPAD3:
    begin

    end; //end Num3
     VK_NUMPAD4:
    begin
      //Motor_BackButton.Click;
    end; //end Num4
     VK_NUMPAD5:
    begin

    end; //end Num5
     VK_NUMPAD6:
    begin

     // Motor_GoButton.Click;
    end; //end Num6
     VK_NUMPAD7:
    begin
      // ParaSetForm.SmoothFilterCheckBoxClick(Sender); //切换是否平滑曲线

    end; //end Num7
     VK_NUMPAD8:
    begin

    end; //end Num8
     VK_NUMPAD9:
    begin
    //
    end; //end Num9
     VK_ADD:
    begin

    end; //end +
    VK_SUBTRACT:
    begin

    end; //end -
    VK_MULTIPLY:
    begin

    end; //end *
    VK_DIVIDE:
    begin

    end; //end /
    VK_DECIMAL:
    begin

    end; //end .


      end; //end case
end;

procedure TMainForm.FormShow(Sender: TObject);
begin

     //多语言设置
 // SetLanguage(ExtractFilePath(ParamStr(0))+LanguageFileName, msgStr, $FF);
 //SetLanguage(mDirName+LanguageFileName, msgStr, $FF);
 //
  PStr_Send2PLC:=GetMemory(BufferLength_Send2PLC);
  PMemAll.PComSendMem1:=GetMemory(128);
  PMemAll.PComSendMem2:=GetMemory(128);

  DispConectStatus(Sender);



  if not ParaInfo.ParaDispEN[1] then
  begin
    PressureCaptionLabel.Enabled:= ParaInfo.ParaDispEN[1];
    PressureUnitLabel.Enabled:=ParaInfo.ParaDispEN[1];
    PressureEdit.Enabled:= ParaInfo.ParaDispEN[1];
  end;
    TemprCaptionLabel.Enabled:= ParaInfo.ParaDispEN[2];
    TemprUnitLabel.Enabled:=ParaInfo.ParaDispEN[2];
    TemprEdit.Enabled:= ParaInfo.ParaDispEN[2];

    HYLCaptionLabel.Enabled:= ParaInfo.ParaDispEN[3];
    HYLUnitLabel.Enabled:=ParaInfo.ParaDispEN[3];
    HYLEdit.Enabled:= ParaInfo.ParaDispEN[3];

    QCaptionLabel.Enabled:= ParaInfo.ParaDispEN[4];
    QUnitLabel.Enabled:=ParaInfo.ParaDispEN[4];
    QEdit.Enabled:= ParaInfo.ParaDispEN[4];


  ResetPanel.SetFocus;



  Sleep(300);
  DspTimer.Enabled:=True;

end;

procedure TMainForm.Options_ItemClick(Sender: TObject);
begin
  //调用参数设置页面
  ParaSetForm.show;
 // DispConectStatus(Sender);
end;



procedure TMainForm.PLC_CommReceiveData(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  tmpArray    : array[0..4096] of ansichar;
  Errcode:integer;
  i : DWORD;
  FunCode,PLC_ID:Byte; //功能命令，PLC的机号
  Count       : DWORD;
  CurPos : DWORD; //当前位置
  HYStatus,HYStatus_tmp: DWord;
  tmpStr ,FunCodeStr,PLC_IDStr,HYStatus_str ,CheckSumStr    : ansistring;

  pStr,pstr1       : PansiChar;
  Temp1,Temp2,CheckSum:Byte;
begin
  //
  pStr := Buffer;
  tmpStr :=#02;// string(pStr);

  if BufferLength < 31 then     //一个油泵时的最小返回数据量
  begin
    exit;
  end;

  if ((BufferLength-31)/2 <> (ParaInfo.PumpNum-1)) then
  begin
    exit;
  end;


  for i:=0 to BufferLength-3 do   //没有LRC数据正常应该是从0至BufferLength-1
  begin
    tmpArray[i] := (pStr^);
    tmpstr:=tmpstr+ (tmpArray[i]);
    inc(pStr);
  end;
   Pstr1:=@tmpStr[1];

   PStr:=Buffer;
  FunCodeStr:=Copy(pStr,3,2);
  PLC_IDStr:=copy(pStr,1,2);
  CheckSumStr:=copy(pStr,BufferLength-1,2);

  CheckSum:=Byte(StrToInt('$'+CheckSumStr));

  if CheckSum=LRC_Check(Pstr1,AnsiStrings.StrLen(Pstr1)) then
  begin
  end else
  begin
    exit;
  end;

  if PLC_IDStr<>'' then
  begin
    PLC_ID:=Byte(StrToInt('$'+PLC_IDStr));
  end else
  begin
    PLC_ID:=$FF;
  end;

  if FunCodeStr<>'' then
  begin
    FunCode:=Byte(StrToInt('$'+FunCodeStr));
  end else
  begin
    FunCode:=$FF;
  end;

  if PLC_ID = ParaInfo.ComPara.ID  then    // ID正确
  begin
    if (PStr+4)^='0' then  //错误码为0
    begin
     // if CheckSum=checkLRC(Pstr1,StrLen(Pstr1)) then
      begin
      //此处应加入LRC检验正确
        Case FunCode of
          $46:
            begin
              //进行返回数据的解码，各状态及实时位移
              for I := 1 to ParaInfo.PumpNum do
              begin
                if ParaInfo.PumpNum=1 then
                begin
                  HYStatus_str:= Copy(Pstr,6,8); //油泵1状态 油源基础状态
                  HYStatus_tmp:=DWORD(StrToInt('$'+HYStatus_str));   //高16位暂未用
                  HYStatus:=HYStatus_tmp shR 16 + HYStatus_tmp shl 16;
                  HYParaInfo.HYStatus.Pressure_AnsiStr[1]:=Copy(Pstr,14,4);
                  HYParaInfo.HYStatus.Tempr_AnsiStr[1]:=Copy(Pstr,18,4);
                  HYParaInfo.HYStatus.LEvel_YW_AnsiStr[1]:=Copy(Pstr,22,4);
                  HYParaInfo.HYStatus.Flow_L_AnsiStr[1]:=Copy(Pstr,26,4);
                end else
                begin
                  HYStatus_str:= Copy(Pstr,30+4*(i-2),4); //油泵1状态 油源基础状态
                  HYStatus:=WORD(StrToInt('$'+HYStatus_str));
                  HYParaInfo.HYStatus.Pressure_AnsiStr[1]:=Copy(Pstr,14,4);
                  HYParaInfo.HYStatus.Tempr_AnsiStr[1]:=Copy(Pstr,18,4);
                  HYParaInfo.HYStatus.LEvel_YW_AnsiStr[1]:=Copy(Pstr,22,4);
                  HYParaInfo.HYStatus.Flow_L_AnsiStr[1]:=Copy(Pstr,26,4);
                end;

                //SFStatus 0位：泵1启停，3位：高低压，4位：滤油器
              if ((HYStatus and $0001)<>0)  then   //油泵状态，1运行0停止
              begin
                HYParaInfo.HYStatus.Pump_OnOff[i]:=1;
              end else
              begin
                HYParaInfo.HYStatus.Pump_OnOff[i]:=0;
              end;

               if ((HYStatus and $0002)<>0)  then   //冷却状态，1运行0停止
              begin
                HYParaInfo.HYStatus.CoolPump_OnOff[i]:=1;
              end else
              begin
                HYParaInfo.HYStatus.CoolPump_OnOff[i]:=0;
              end;

              if (HYStatus and $0004)<>0 then
              begin

              end   else
              begin

              end;

              if ((HYStatus and $0008)<>0)  then   //高低压状态，1高压，0低压
              begin
                HYParaInfo.HYStatus.Pressure_HiLow[i]:=1;
              end   else
              begin
                HYParaInfo.HYStatus.Pressure_HiLow[i]:=0;
              end;

              if (HYStatus and $00F0)<>0 then    //滤油器状态
              begin
                 HYParaInfo.HYStatus.Oil_Filter_Status[i]:=(HYStatus and $00F0) SHR 4;
              end   else
              begin

              end;



            end;   //end for I := 1 to ParaInfo.PumpNum

              


              // Val(CurPosStr,CurPos,Errcode);


            end;
          $47:
            begin

            end;
          $4E:
            begin

            end;
        end;//end Case FunCode
      end; //end if  CheckSum=checkLRC(Pstr1,StrLen(Pstr1))
    end; //end if PLC_ID=MotorPara.MheInfo.MotorID
  end else //end if (PStr+4)^='0'
  begin
    //显示错误码 "PLC通讯错误+(PStr+4)^ "
  end; // end  if PLC_ID=MotorPara.MheInfo.MotorID else
  pStr:=nil;
  pstr1:=nil;
end;

procedure TMainForm.PressureHI_SpeedButton1Click(Sender: TObject);
begin
  if HYParaInfo.HYStatus.Pump_OnOff[1]=1 then     //为1时油泵开启
  begin
    HYParaInfo.HYCMD.Pressure_HiLow[1]:=PRESSURE_HI;
    HYSetCMD_En:=True;   //指令有变，开始传送
    HYSetCMD_Num:=0;
  end else
  begin
    ShowMessage('请先开启油泵，再高压操作');
  end;
end;

procedure TMainForm.PressureLow_SpeedButton1Click(Sender: TObject);
begin
  HYParaInfo.HYCMD.Pressure_HiLow[1]:=PRESSURE_LOW;
  HYSetCMD_En:=True;   //指令有变，开始传送
  HYSetCMD_Num:=0;
end;

procedure TMainForm.PumpOFF_SpeedButton1Click(Sender: TObject);
begin
  HYParaInfo.HYCMD.Pump_OnOff[1]:=PUMP_OFF;
  HYSetCMD_En:=True;   //指令有变，开始传送
  HYSetCMD_Num:=0;
end;

procedure TMainForm.PumpON_SpeedButton1Click(Sender: TObject);
begin
  HYParaInfo.HYCMD.Pump_OnOff[1]:=PUMP_ON;
  HYParaInfo.HYCMD.Pressure_HiLow[1]:=PRESSURE_LOW;
  HYSetCMD_En:=True;   //指令有变，开始传送
  HYSetCMD_Num:=0;
end;

//-----
Procedure TMainForm.DispConectStatus(Sender: TObject);
begin
     case ParaInfo.CommType of
    COMMTYPE_COM:    //配置串口
    begin
      if FatekPLCForm.PLCCOMInit(ParaInfo.ComPara) then
      begin
        mainForm.CommSta_Shape1.Brush.Color:=ClGreen;
      end else
      begin
        mainForm.CommSta_Shape1.Brush.Color:=clActiveBorder;
      end;
      if ParaInfo.commType=COMMTYPE_COM then
      begin
        ParaInfo.ComPara.Enable:=True;
      end else
      begin
        ParaInfo.ComPara.Enable:=False;
      end;

      if IdModBus_To_PLC.Connected then
      begin
        IdModBus_To_PLC.Disconnect;
      end;
    end;
    COMMTYPE_NET:   //配置网口
    begin
      IdModBus_To_PLC.Host:=ParaInfo.NetPara.IPAddr;
      if not IdModBus_To_PLC.Connected then
      begin
        IdModBus_To_PLC.Connect;
        ParaInfo.NetPara.ReConnectCount:=ParaInfo.NetPara.ReConnectCount+1;
      end;

        if IdModBus_To_PLC.Connected then
      begin
        mainForm.CommSta_Shape1.Brush.Color:=ClGreen;
        ParaInfo.NetPara.Connected:=True;
        ParaInfo.NetPara.ReConnectCount:=0;
      end else
      begin
        mainForm.CommSta_Shape1.Brush.Color:=clActiveBorder;
        ParaInfo.NetPara.Connected:=False;
      end;

      FatekPLCForm.PLCCOMFree();

    end;
  end;

end;
//=======

//--------串口来的数据为字符串，转换一下
Procedure TMainForm.ComDataTran();
var
i:integer;
begin
   for I := 1 to ParaInfo.PumpNum do
  begin
    if HYParaInfo.HYStatus.Pressure_AnsiStr[i]='' then
    begin
      HYParaInfo.HYStatus.Pressure_AnsiStr[i]:='0';
    end;
    if HYParaInfo.HYStatus.Tempr_AnsiStr[i]='' then
    begin
      HYParaInfo.HYStatus.Tempr_AnsiStr[i]:='0';
    end;
    if HYParaInfo.HYStatus.LEvel_YW_AnsiStr[i]='' then
    begin
      HYParaInfo.HYStatus.LEvel_YW_AnsiStr[i]:='0';
    end;
    if HYParaInfo.HYStatus.Flow_L_AnsiStr[i]='' then
    begin
      HYParaInfo.HYStatus.Flow_L_AnsiStr[i]:='0';
    end;
    HYParaInfo.HYStatus.Pressure[i]:=SmallInt(StrToInt('$'+HYParaInfo.HYStatus.Pressure_AnsiStr[i]));
   // MainForm.PressureEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.Pressure[1])/100,ffFixed,4,2);
    HYParaInfo.HYStatus.Tempr[i]:=SmallInt(StrToInt('$'+HYParaInfo.HYStatus.Tempr_AnsiStr[i]));
   // MainForm.TemprEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.Tempr[1])/100,ffFixed,4,2);
    HYParaInfo.HYStatus.LEvel_YW[i]:=SmallInt(StrToInt('$'+HYParaInfo.HYStatus.LEvel_YW_AnsiStr[i]));
  //  MainForm.HYLEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.LEvel_YW[1])/100,ffFixed,4,2);
    HYParaInfo.HYStatus.Flow_L[i]:=SmallInt(StrToInt('$'+HYParaInfo.HYStatus.Flow_L_AnsiStr[i]));
  //  MainForm.QEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.Flow_L[1])/100,ffFixed,4,2);

  end;


end;

//======= 串口来的数据为字符串，转换一下

 //--------------------
Procedure TMainForm.DispAllHYPara();
var
i:integer;
begin
  for I := 1 to ParaInfo.PumpNum do
  begin
    if ParaInfo.ParaDispEN[1] then
    begin
      MainForm.PressureEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.Pressure[1])/100,ffFixed,4,2);
    end else
    begin
      MainForm.PressureEdit.text:='0';
    end;
    if ParaInfo.ParaDispEN[2] then
    begin
      MainForm.TemprEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.Tempr[1])/100,ffFixed,4,2);
    end else
    begin
      MainForm.TemprEdit.text:='0';
    end;
    if ParaInfo.ParaDispEN[3] then
    begin
      MainForm.HYLEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.LEvel_YW[1])/100,ffFixed,4,2);
    end else
    begin
      MainForm.HYLEdit.text:='0';
    end;
    if ParaInfo.ParaDispEN[4] then
    begin
       MainForm.QEdit.text:=FloatToStrF(Single(HYParaInfo.HYStatus.Flow_L[1])/100,ffFixed,4,2);
    end else
    begin
      MainForm.QEdit.text:='0';
    end;




  end;

  if HYParaInfo.HYStatus.Pump_OnOff[1]<>1 then
  begin
    MainForm.PumpSta_Shape1.Brush.Color:=clRed;
  end else
  begin
    MainForm.PumpSta_Shape1.Brush.Color:=clGreen;
  end;

  if HYParaInfo.HYStatus.Pressure_HiLow[1]<>1 then
  begin
    MainForm.PressureSta_Shape1.Brush.Color:=clRed;
  end else
  begin
    MainForm.PressureSta_Shape1.Brush.Color:=clGreen;
  end;


  if (HYParaInfo.HYStatus.Oil_Filter_Status[1] and $01)=0 then
  begin
    MainForm.Filter_Shape1.Brush.Color:=clRed;
  end else
  begin
    MainForm.Filter_Shape1.Brush.Color:=clGreen;
  end;

 if (HYParaInfo.HYStatus.Oil_Filter_Status[1] and $02)=0 then
  begin
    MainForm.Filter_Shape2.Brush.Color:=clRed;
  end else
  begin
    MainForm.Filter_Shape2.Brush.Color:=clGreen;
  end;

   if (HYParaInfo.HYStatus.Oil_Filter_Status[1] and $04)=0 then
  begin
    MainForm.Filter_Shape3.Brush.Color:=clRed;
  end else
  begin
    MainForm.Filter_Shape3.Brush.Color:=clGreen;
  end;
   if (HYParaInfo.HYStatus.Oil_Filter_Status[1] and $08)=0 then
  begin
    MainForm.Filter_Shape4.Brush.Color:=clRed;
  end else
  begin
    MainForm.Filter_Shape4.Brush.Color:=clGreen;
  end;
end;
//========

//-----通过ModBusTCP设置油泵动作
Function ModBusTcpSetHYACT(PumpNum:Byte):boolean;
var
i:integer;
REGNum:Word;
ADDR_ST:Word;
//HYStatus:Word;
HYFunc:WORD;
REGSDData:array of Word;
begin
  REGNUM:=6+PumpNum-1;
  ADDR_ST:=1001;
  SetLength(REGSDData, REGNUM);
  for i := 1 to PumpNum do
  begin
    HYFunc := HYParaInfo.HYCMD.Pump_OnOff[1] + HYParaInfo.HYCMD.Pressure_HiLow[1]
            +HYParaInfo.HYCMD.CoolPump_OnOff[1] + HYParaInfo.HYCMD.Reset_All;
    REGSDData[0]:=HYFunc;
    if i>1 then
    begin
      REGSDData[i]:= HYParaInfo.HYCMD.Pump_OnOff[i] + HYParaInfo.HYCMD.Pressure_HiLow[i]
            +HYParaInfo.HYCMD.CoolPump_OnOff[i]; //
    end else
    begin
     REGSDData[0]:=HYFunc; //
     REGSDData[1]:=HYFunc;
    end;

  end;
  if Mainform.IdModBus_To_PLC.WriteRegisters(ADDR_ST,REGSDData) then
  begin
     result:=true;
  end else
  begin
    Result:=False;
  end;
end;
//=====通过ModBusTCP设置油泵动作


//--------通过ModbusTCP协议向FatekPLC发指令  通讯发起，Master
//---有其它活较急，临时能用就可
Procedure TMainForm.ModbusTCP2PLC(PumpNum:Byte);
var
i:integer;
REGNum:Word;
ADDR_ST:Word;
HYStatus:Word;
REGRDData:array[0..4096] of Word;
begin
   //没有指令下传时，发读取油源状态指令

  CommFunc:=(CommFunc+1) mod 2;
  case CommFunc of
    CommFunc_GetPara:    //取油源状态指令
    begin
     // FatekPLCForm.GetHYStatus(ParaInfo.PumpNum);
      REGNUM:=6+PumpNum-1;
      ADDR_ST:=1101;
     // SetLength(REGData, REGNUM);
      IdModBus_To_PLC.Host:=ParaInfo.NetPara.IPAddr;
      if IdModBus_To_PLC.ReadHoldingRegisters(ADDR_ST,RegNum,REGRDData) then
      begin   //解析处理收到的数据
         //
         ParaInfo.NetPara.ReadErrNum:=0;
         for I := 1 to PumpNum do
         begin
           HYParaInfo.HYStatus.Pressure[1]:=REGRDData[2];
            HYParaInfo.HYStatus.Tempr[1]:=REGRDData[3];
            HYParaInfo.HYStatus.Level_YW[1]:=REGRDData[4];
            HYParaInfo.HYStatus.Flow_L[1]:=REGRDData[5];
           if I=1 then
           begin
             HYStatus:=REGRDData[0];
           end else
           begin
             //
             HYStatus:=REGRDData[i+4];
           end;
            //SFStatus 0位：泵1启停，3位：高低压，4位：滤油器
              if ((HYStatus and $0001)<>0)  then   //油泵状态，1运行0停止
              begin
                HYParaInfo.HYStatus.Pump_OnOff[i]:=1;
              end else
              begin
                HYParaInfo.HYStatus.Pump_OnOff[i]:=0;
              end;

               if ((HYStatus and $0002)<>0)  then   //冷却状态，1运行0停止
              begin
                HYParaInfo.HYStatus.CoolPump_OnOff[i]:=1;
              end else
              begin
                HYParaInfo.HYStatus.CoolPump_OnOff[i]:=0;
              end;

              if (HYStatus and $0004)<>0 then
              begin

              end   else
              begin

              end;

              if ((HYStatus and $0008)<>0)  then   //高低压状态，1高压，0低压
              begin
                HYParaInfo.HYStatus.Pressure_HiLow[i]:=1;
              end   else
              begin
                HYParaInfo.HYStatus.Pressure_HiLow[i]:=0;
              end;

              if (HYStatus and $00F0)<>0 then    //滤油器状态
              begin
                 HYParaInfo.HYStatus.Oil_Filter_Status[i]:=(HYStatus and $00F0) SHR 4;
              end   else
              begin
                 HYParaInfo.HYStatus.Oil_Filter_Status[i]:=0;
              end;

         end;


      end else
      begin
        //读取错误
        ParaInfo.NetPara.ReadErrNum:=ParaInfo.NetPara.ReadErrNum+1;
        IdModBus_To_PLC.Disconnect;
      //  if ParaInfo.NetPara.ReadErrNum>3 then
        begin

          ParaInfo.NetPara.Connected:=False;
        end;
      end;
    end;
    CommFunc_SetCMD:        //设置油源动作指令
    begin

      //连续传送指令3次后清除，
      if HYSetCMD_En then   //指令有变，开始传送
      begin

        if ModBusTcpSetHYACT(ParaInfo.PumpNum) then    //指令传送正确
        begin
          HYSetCMD_En:=False;
          HYSetCMD_Num:=0;
        end else
        begin
          HYSetCMD_Num:=HYSetCMD_Num+1;

        end;

        if HYSetCMD_Num>1 then
        begin
          HYSetCMD_En:=False;
          IdModBus_To_PLC.Disconnect;
          ParaInfo.NetPara.Connected:=False;
          for I := 1 to ParaInfo.PumpNum do
          begin
            HYParaInfo.HYCMD.Pump_OnOff[i]:=0;
            HYParaInfo.HYCMD.Pressure_HiLow[i]:=0;
          end;
        end;
      end;



    end else
    begin
      FatekPLCForm.GetHYStatus(ParaInfo.PumpNum);
    end;
  end;
end;

//=======通过ModbusTCP协议向FatekPLC发指令  通讯发起，Master$

//-----
Procedure TMainForm.Comm2PLC() ;
var
i:integer;
begin
  //没有指令下传时，发读取油源状态指令
  CommFunc:=(CommFunc+1) mod 2;
  case CommFunc of
    CommFunc_GetPara:
    begin
      FatekPLCForm.GetHYStatus(1);
    end;
    CommFunc_SetCMD:
    begin

      FatekPLCForm.SetHYACT(1) ;
      //连续传送指令3次后清除，
      if HYSetCMD_En then   //指令有变，开始传送
      begin
        HYSetCMD_Num:=HYSetCMD_Num+1;
        if HYSetCMD_Num>3 then
        begin
          HYSetCMD_En:=False;
          for I := 1 to ParaInfo.PumpNum do
          begin
            HYParaInfo.HYCMD.Pump_OnOff[i]:=0;
            HYParaInfo.HYCMD.Pressure_HiLow[i]:=0;
          end;
        end;
      end;



    end else
    begin
      FatekPLCForm.GetHYStatus(1);
    end;
  end;
end;
//======

procedure TMainForm.DspTimerTimer(Sender: TObject);
var
  I: Integer;
begin

//与油源通讯

  case ParaInfo.CommType of
  COMMTYPE_COM:
  begin
    Comm2PLC() ;
    ComDataTran();
  end;
  COMMTYPE_NET:
  begin
    if IdModBus_To_PLC.Connected then
    begin
      ModbusTCP2PLC(ParaInfo.PumpNum);
    end else
    begin
      ParaInfo.NetPara.Connected:=False;
    end;
    //根据连接状态显示
    if ParaInfo.NetPara.Connected then
    begin
      mainForm.CommSta_Shape1.Brush.Color:=ClGreen;

    end else
    begin
       mainForm.CommSta_Shape1.Brush.Color:=clActiveBorder;
    end;
  end;

  end;

  //与油源通讯
   DispAllHYPara();   //显示油源各参数


end;

end.
