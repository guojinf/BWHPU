unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAboutForm = class(TForm)
    Memo1: TMemo;
    VersionLabel: TLabel;
    SWCHSLangButton: TButton;
    SWENGLangButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure SWCHSLangButtonClick(Sender: TObject);
    procedure SWENGLangButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Function GetBuildInfo: string;
  end;

var
  AboutForm: TAboutForm;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite = 'OK to overwrite %s';
  sUntitled = 'Untitled';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  RulerAdj = 4/3;
  GutterWid = 6;

  ENGLISH = (SUBLANG_ENGLISH_US shl 10) or LANG_ENGLISH;
  FRENCH  = (SUBLANG_FRENCH shl 10) or LANG_FRENCH;
  GERMAN  = (SUBLANG_GERMAN shl 10) or LANG_GERMAN;
  CHINESE = (SUBLANG_CHINESE_SIMPLIFIED shl 10) or LANG_CHINESE;

implementation

{$R *.dfm}

uses reinit;

procedure TAboutForm.FormShow(Sender: TObject);
begin
   VersionLabel.Caption:='Version: '+GetBuildInfo;
end;

Function TAboutForm.GetBuildInfo: string; //获取版本号

var

  verinfosize : DWORD;
  verinfo : pointer;

  vervaluesize : dword;

  vervalue : pvsfixedfileinfo;

  dummy : dword;

  v1,v2,v3,v4 : word;

begin

  verinfosize := getfileversioninfosize(pchar(paramstr(0)),dummy);

  if verinfosize = 0 then
  begin

    dummy := getlasterror;

    result := '0.0.0.0';

  end;

  getmem(verinfo,verinfosize);

  getfileversioninfo(pchar(paramstr(0)),0,verinfosize,verinfo);

  verqueryvalue(verinfo,'\',pointer(vervalue),vervaluesize);

  with vervalue^ do begin

    v1 := dwfileversionms shr 16;

    v2 := dwfileversionms and $ffff;

    v3 := dwfileversionls shr 16;

    v4 := dwfileversionls and $ffff;

  end;

  result := inttostr(v1) + '.' + inttostr(v2) + '.' + inttostr(v3) + '.' + inttostr(v4);

  freemem(verinfo,verinfosize);

end;
//切换至中文
procedure TAboutForm.SWCHSLangButtonClick(Sender: TObject);
begin
//
if LoadNewResourceModule(CHINESE) <> 0 then
begin
  ReInitializeForms();
end;
end;
//切换至英文
procedure TAboutForm.SWENGLangButtonClick(Sender: TObject);
begin
//
if LoadNewResourceModule(ENGLISH) <> 0 then
begin
  ReInitializeForms();
end;
end;

end.
