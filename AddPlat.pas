unit AddPlat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, DBGridEh, DBCtrlsEh,
  Vcl.StdCtrls, Vcl.Mask, DBLookupEh, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Buttons;

type
  TAddPlatFrm = class(TForm)
    DsType: TDataSource;
    QueryType: TFDQuery;
    QueryMonth: TFDQuery;
    dsMonth: TDataSource;
    QueryExec: TFDQuery;
    pnlBottom: TPanel;
    pnlClient: TPanel;
    cbType: TDBLookupComboboxEh;
    lblTarif: TLabel;
    cbMonth: TDBLookupComboboxEh;
    txtYear: TDBNumberEditEh;
    txtsumm: TDBNumberEditEh;
    pnlButtons: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlPokaz: TPanel;
    Label5: TLabel;
    txtPrev: TDBNumberEditEh;
    txtPres: TDBNumberEditEh;
    lblRashod: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure cbTypeChange(Sender: TObject);
    procedure txtPresChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure txtsummEnter(Sender: TObject);
  private
    { Private declarations }
    gTarif:double;
    procedure init(ptype_gkh,pMonth_gkh,pyear_gkh,pLast_GKH, ppresent_GKH:integer;psumm_gkh:double);
    procedure OkGo;
    function CheckResults:boolean;
  public
    { Public declarations }
    function AddPlat(var ptype_gkh,pMonth_gkh,pyear_gkh,pLast_GKH, ppresent_GKH:integer;var psumm_gkh:double):boolean;
  end;

implementation
uses main,sysf;
{$R *.dfm}

{ TAddPlatFrm }
//------------------------------------------------------------------------------
function TAddPlatFrm.AddPlat(var ptype_gkh, pMonth_gkh, pyear_gkh,pLast_GKH, ppresent_GKH: integer;
  var psumm_gkh: double): boolean;
begin
  RESULT:=false;
  init(ptype_gkh, pMonth_gkh, pyear_gkh, pLast_GKH, ppresent_GKH,psumm_gkh);
  if ShowModal=mrOk Then
    begin
      ptype_gkh:=cbType.Value;
      pMonth_gkh:=cbMonth.Value;
      pyear_gkh:=txtYear.Value;
      pLast_GKH:=varToInt(txtPrev.Value);
      ppresent_GKH:=varToInt(txtPres.Value);
      psumm_gkh:=txtsumm.Value;
      RESULT:=true;
    end;
end;
//------------------------------------------------------------------------------
procedure TAddPlatFrm.btnOKClick(Sender: TObject);
begin
  OkGo;
end;
//------------------------------------------------------------------------------
procedure TAddPlatFrm.cbTypeChange(Sender: TObject);
  function getPrev(pType:integer):integer;
  begin
    queryExec.Close;
    queryExec.SQL.Clear;
    queryExec.SQL.Add('select max(present_GKH) cnt from gkh where type_gkh=:pid');
    queryExec.ParamByName('pid').AsInteger := pType;
    queryExec.Open;
    RESULT:=queryExec['cnt'];
  end;
begin
  txtsumm.Value:=null;
  gTarif:=QueryType.FieldByName('tarif_gkh').AsFloat;
  lblTarif.Caption:=FloatToStr(gTarif)+'р.';
  if QueryType.FieldByName('haspokaz').AsBoolean then
    begin
      pnlPokaz.Visible:=true;
      {txtPrev.Visible:=true;
      txtPres.Visible:=true;
      lblRashod.Visible:=true; }
      txtPrev.Value:=getPrev(cbType.Value);
      txtPres.Value:=txtPrev.Value;
    end
  else
    begin
      pnlPokaz.Visible:=false;
      {txtPrev.Visible:=false;
      txtPres.Visible:=false;
      lblRashod.Visible:=false;}
      txtPrev.Value:=null;
      txtPres.Value:=null;
      txtsumm.Value:= gTarif;
    end;
end;
function TAddPlatFrm.CheckResults: boolean;
begin
  RESULT:=False;
  if cbType.Value=null then
    begin
      Application.MessageBox(PChar('Не выбран тип.'),PChar('Ошибка'),MB_OK+MB_ICONERROR);
      exit;
    end;
  if cbMonth.Value=null then
    begin
      Application.MessageBox(PChar('Не выбран месяц.'),PChar('Ошибка'),MB_OK+MB_ICONERROR);
      exit;
    end;
  if (VarToInt(txtYear.Value)<1990) or (VarToInt(txtYear.Value)>2190) then
    begin
      Application.MessageBox(PChar('Не выбран год.'),PChar('Ошибка'),MB_OK+MB_ICONERROR);
      exit;
    end;
  if FloatCompare(VarToDouble(txtsumm.Value),0) in [fcEquivalent,fcSlargest,fcError] then
    begin
      Application.MessageBox(PChar('Указана неверная сумма.'),PChar('Ошибка'),MB_OK+MB_ICONERROR);
      exit;
    end;
  RESULT:=true;
end;

//------------------------------------------------------------------------------
procedure TAddPlatFrm.init(ptype_gkh, pMonth_gkh, pyear_gkh,pLast_GKH, ppresent_GKH: integer; psumm_gkh
  : double);
begin
  QueryType.Close;
  QueryType.Open();
  QueryMonth.Close;
  QueryMonth.Open();
  if ptype_gkh<>0 then
    begin
      if not QueryType.Locate('typeid',ptype_gkh,[]) then
        cbType.Value:=null
      else
        cbType.Value:=ptype_gkh;
    end;
  if pMonth_gkh<>0 then
    cbMonth.Value:=pMonth_gkh;
  if pyear_gkh<>0 then
    txtYear.Value:=pyear_gkh;
end;
//------------------------------------------------------------------------------
procedure TAddPlatFrm.OkGo;
begin
  if CheckResults then
    self.ModalResult:=mrOk;
end;
//------------------------------------------------------------------------------
procedure TAddPlatFrm.txtPresChange(Sender: TObject);
begin
  if QueryType.FieldByName('haspokaz').AsBoolean then
    begin
      txtsumm.Value:=(VarToDouble(txtPres.Value)-VarToDouble(txtPrev.Value))*gTarif;
      lblRashod.Caption:=IntToStr(VarToInt(txtPres.Value)-VarToInt(txtPrev.Value));
    end;
end;
procedure TAddPlatFrm.txtsummEnter(Sender: TObject);
begin
  TDBNumberEditEh(Sender).SelectAll;
end;

//------------------------------------------------------------------------------
end.
