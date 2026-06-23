unit ParaSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,Vardef,TypeDef,
  Vcl.ExtCtrls,System.Math,FileFunc;

type
  TParaSetForm = class(TForm)
    GroupBox1: TGroupBox;
    PumpCheckBox1: TCheckBox;
    ComGroupBox: TGroupBox;
    NetGroupBox: TGroupBox;
    Label1: TLabel;
    SelCom_ComboBox: TComboBox;
    BpsComboBox: TComboBox;
    Label2: TLabel;
    DataBitComboBox: TComboBox;
    Label3: TLabel;
    ParityComboBox: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    StopBitComboBox: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    IPPortComboBox: TComboBox;
    Pump_Num_ComboBox: TComboBox;
    Label8: TLabel;
    IPMaskEdit: TMaskEdit;
    OKButton: TButton;
    CancelButton: TButton;
    CommTypeRadioGroup1: TRadioGroup;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CommTypeRadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ParaSetForm: TParaSetForm;

implementation

{$R *.dfm}

uses Main;

procedure TParaSetForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TParaSetForm.CommTypeRadioGroup1Click(Sender: TObject);
begin
  case CommTypeRadioGroup1.ItemIndex of
    0:begin    //����
      ComGroupBox.Visible:= True;
      NetGroupBox.Visible:= False;
    end;
    1:begin     //����
      ComGroupBox.Visible:= False;
      NetGroupBox.Visible:= True;
    end;
  end;
end;

procedure TParaSetForm.FormShow(Sender: TObject);
begin

  Pump_Num_ComboBox.Text := IntToStr(ParaInfo.PumpNum);
  PumpCheckBox1.Checked := ParaInfo.PumpOff_ATSoftColse_EN;
  //COMmu para
  SelCom_ComboBox.ItemIndex :=  Ord(ParaInfo.ComPara.ComPort);
  CommTypeRadioGroup1.ItemIndex := Ord(ParaInfo.CommType);
  if ParaInfo.commType=COMMTYPE_COM then
  begin
    ParaInfo.ComPara.Enable:=True;
  end else
  begin
    ParaInfo.ComPara.Enable:=False;
  end;
  BpsComboBox.ItemIndex := Ord(ParaInfo.ComPara.ComPortSpeed);
  DataBitComboBox.ItemIndex := Ord(ParaInfo.ComPara.ComPortDataBits);
  ParityComboBox.ItemIndex := Ord(ParaInfo.ComPara.ComPortParity);
  StopBitComboBox.ItemIndex := Ord(ParaInfo.ComPara.ComPortStopBits);

  //net Para
  IPMaskEdit.Text := ParaInfo.NetPara.IPAddr;
  IPPortComboBox.Text := IntToStr(ParaInfo.NetPara.Port);

//
 // SelCom_ComboBox.Items:=
// max(TComPortNumber);
end;

procedure TParaSetForm.OKButtonClick(Sender: TObject);
var
i:integer;
begin
  //��������ֵ
  With ParaInfo do
  begin
    ParaInfo.PumpNum:=StrToInt(Pump_Num_ComboBox.Text); //������
    //ParaInfo.PLCType:=StrToInt         //�ı�������    PLC����
    ParaInfo.PumpOff_ATSoftColse_EN:=PumpCheckBox1.Checked; //�������Ƿ���ͱã�1��
    //ParaInfo.ParaDispEN[i]:=        //�ı�������  �Ƿ���ʾ����
    //ParaInfo.ParaDispAdd[i]:=       //�ı�������      ��PLC�еĵ�ַ

    //Comm232para
    ParaInfo.CommType:=CommTypeRadioGroup1.ItemIndex;   //����ͨѶ��ʽ
    ParaInfo.ComPara.ComPort := TComPortNumber((SelCom_ComboBox.ItemIndex));
    ParaInfo.ComPara.ComPortSpeed := TComPortBaudRate(BpsComboBox.ItemIndex);
    ParaInfo.ComPara.ComPortDataBits := TComPortDataBits(DataBitComboBox.ItemIndex );
    ParaInfo.ComPara.ComPortParity := TComPortParity(ParityComboBox.ItemIndex );
    ParaInfo.ComPara.ComPortStopBits := TComPortStopBits(StopBitComboBox.ItemIndex );
    //netpara
    ParaInfo.NetPara.IPAddr := IPMaskEdit.Text;
    ParaInfo.NetPara.Port := StrToInt(IPPortComboBox.Text);
   // ParaInfo.NetPara.ProtocolType := StrToInt(          //���ı������� ͨѶЭ��
    if ParaInfo.commType=COMMTYPE_COM then
    begin
      ParaInfo.ComPara.Enable:=True;
    end else
    begin
      ParaInfo.ComPara.Enable:=False;
    end;
  end;

  ParaInfoBak:=ParaInfo;
  SaveParaIniFile(HYParaFileName,ParaInfo);
  MainForm.DispConectStatus(Sender);
end;

end.
