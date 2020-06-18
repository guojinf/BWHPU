program HPU;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  ParaSet in 'ParaSet.pas' {ParaSetForm},
  About in 'About.pas' {AboutForm},
  VarDef in 'VarDef.pas',
  TypeDef in 'TypeDef.pas',
  FileFunc in 'FileFunc.pas',
  FatekPLC in 'FatekPLC.pas' {FatekPLCForm},
  IdModbusClient in 'IdModbusClient.pas',
  ModbusConsts in 'ModbusConsts.pas',
  ModBusTcp_C in 'ModBusTcp_C.pas',
  ModbusTypes in 'ModbusTypes.pas',
  ModbusUtils in 'ModbusUtils.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook<>0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TParaSetForm, ParaSetForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TFatekPLCForm, FatekPLCForm);
  Application.Run;
end.
