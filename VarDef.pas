unit VarDef;

interface
  uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
       TypeDef;

  Var
  ParaInfo,ParaInfoBak:TParaInfo;
  mDirName:String;
  HYParaFileName:String;
  PMemAll:TMemAll;
  PStr_Send2PLC:PAnsiChar;
  HYParaInfo:THYParaInfo;
  CommFunc:Integer;
  HYSetCMD_En:boolean;   //指令有变，开始传送
  HYSetCMD_Num:Integer; //连续传送指令次数

  //多语言
// LangInfo:TLangInfo;
  msgStr:Array[1..10] of String;
   LanguageFileName:String;

implementation

end.
