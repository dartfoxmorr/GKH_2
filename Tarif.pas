unit Tarif;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TTarifFrm = class(TForm)
    pnlClient: TPanel;
    pnlTop: TPanel;
    btnAdd: TBitBtn;
    DBGridEh1: TDBGridEh;
    QueryTarif: TFDQuery;
    dsTarif: TDataSource;
    FDUpdateTarif: TFDUpdateSQL;
    QueryTariftypeid: TFDAutoIncField;
    QueryTarifNameType: TStringField;
    QueryTariftarif_gkh: TBCDField;
    QueryTarifHasPokaz: TBooleanField;
    QueryTarifnotinuse: TIntegerField;
    QueryTarifColColor: TStringField;
    QueryExec: TFDQuery;
    procedure DBGridEh1Exit(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure QueryTarifBeforeDelete(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    function OpenModal():boolean;

  end;


implementation
uses main,sysf;
{$R *.dfm}

{ TTarifFrm }
//------------------------------------------------------------------------------
procedure TTarifFrm.btnAddClick(Sender: TObject);
begin
  QueryTarif.Append;
end;
//------------------------------------------------------------------------------
procedure TTarifFrm.DBGridEh1Exit(Sender: TObject);
begin
  if QueryTarif.State in [dsEdit,dsInsert] then
    QueryTarif.Post;
end;
//------------------------------------------------------------------------------
procedure TTarifFrm.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_RETURN) Then
   begin
    if 	(TDBGridEh(Sender).DataSource.DataSet.State=dsEdit) Then
      TDBGridEh(Sender).DataSource.DataSet.Post;
    end;
end;
//------------------------------------------------------------------------------
procedure TTarifFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if QueryTarif.State in [dsEdit,dsInsert] then
    QueryTarif.Post;
end;

//------------------------------------------------------------------------------
function TTarifFrm.OpenModal: boolean;
begin
   RESULT:=false;
   QueryTarif.Close;
   QueryTarif.Open();
  if ShowModal=mrOk Then
    begin
      RESULT:=true;
    end;
end;
procedure TTarifFrm.QueryTarifBeforeDelete(DataSet: TDataSet);
begin
  queryExec.Close;
  queryExec.SQL.Clear;
  queryExec.SQL.Add('select count() cnt from gkh where type_gkh=:pid');
  queryExec.ParamByName('pid').AsInteger := QueryTarif.FieldByName('typeid').AsInteger;
  queryExec.Open;
  if queryExec['cnt']>0 then
    begin
      Application.MessageBox(PChar('Уже есть записи с таким типом.'),PChar('Ошибка'),MB_OK+MB_ICONERROR);
      abort;
    end;
end;

//------------------------------------------------------------------------------
end.
