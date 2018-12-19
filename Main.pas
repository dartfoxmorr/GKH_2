unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Vcl.StdCtrls, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Mask,
  DBCtrlsEh, DBLookupEh, Vcl.ExtCtrls, Vcl.Buttons, Export2xls;

type
  TMainFrm = class(TForm)
    MainConnection: TFDConnection;
    FDTransactionMain: TFDTransaction;
    QueryType: TFDQuery;
    DsType: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    pnlTop: TPanel;
    cbType: TDBLookupComboboxEh;
    txtYear: TDBNumberEditEh;
    QueryMonth: TFDQuery;
    dsMonth: TDataSource;
    cbMonth: TDBLookupComboboxEh;
    QueryGKH: TFDQuery;
    dsGKH: TDataSource;
    pnlButtons: TPanel;
    pnlClient: TPanel;
    DBGridEh1: TDBGridEh;
    btnDel: TBitBtn;
    btnAdd: TBitBtn;
    btnTarif: TBitBtn;
    FDCommandMain: TFDCommand;
    FDUpdateGKH: TFDUpdateSQL;
    cbnotinuse: TDBCheckBoxEh;
    Label2: TLabel;
    Label1: TLabel;
    Export2Excel1: TExport2Excel;
    btnExcel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cbChange(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cbnotinuseClick(Sender: TObject);
    procedure btnTarifClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
  private
    { Private declarations }
    NoRefresh: Boolean;
    procedure  refreshFilter;
    procedure connectDB;
    procedure refresh;
    procedure DeletePlat; //удалить платеж
    procedure AddPlat;    //добавить платеж
    procedure Tarif;      //вызов окна тарифы
    procedure notdeletedtype; //показывать или нет удаленные типы
    procedure TO_EXCEL;
  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}
uses AddPlat,sysf,Tarif;
{ TMainFrm }
//------------------------------------------------------------------------------
procedure TMainFrm.AddPlat;
var fl:boolean;
  vtype_gkh, vMonth_gkh, vyear_gkh, vLast_GKH, vpresent_GKH: integer;
  vsumm_gkh: double;
  vDate:TDate;
  myYear, myMonth, myDay : Word;
begin
  //автоматический выбор типа при создании платежа
  if cbType.Value<>null then
    vtype_gkh:=cbType.Value
  else
    vtype_gkh:=9;
  //определение года платежа (Берем год выборки)
  vyear_gkh:=txtYear.Value;
  vDate:=now();
  //определение месяца, берем текущий
  DecodeDate(vDate, myYear, myMonth, myDay);
  vMonth_gkh:= myMonth;
  //Открываем форму ввода платежа
  with TAddPlatFrm.Create(self) do
    try
      fl:=AddPlat(vtype_gkh, vMonth_gkh, vyear_gkh, vLast_GKH, vpresent_GKH,vsumm_gkh);
    finally
      Free;
    end;

  if not fl then exit;
  //Добавляем платеж
  try
    MainConnection.StartTransaction;
    QueryGKH.Insert;
    QueryGKH.FieldByName('type_gkh').Value:= vtype_gkh;
    QueryGKH.FieldByName('Month_gkh').Value:= vMonth_gkh;
    QueryGKH.FieldByName('year_gkh').Value:= vyear_gkh;
    QueryGKH.FieldByName('Last_GKH').Value:= vLast_GKH;
    QueryGKH.FieldByName('present_GKH').Value:= vpresent_GKH;
    QueryGKH.FieldByName('summ_gkh').Value:= vsumm_gkh;
    QueryGKH.FieldByName('dateoper').Value:= now();
    QueryGKH.Post;
    MainConnection.Commit;
  except
    MainConnection.Rollback;
    raise;
  end;
  //обновляем.
  refresh;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.btnAddClick(Sender: TObject);
begin
 addplat;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.btnDelClick(Sender: TObject);
begin
  DeletePlat;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.btnExcelClick(Sender: TObject);
begin
 TO_EXCEL;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.btnTarifClick(Sender: TObject);
begin
  Tarif;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.cbChange(Sender: TObject);
begin
  refresh;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.connectDB;
var
  vDate:TDate;
  myYear, myMonth, myDay : Word;
begin
  if not MainConnection.Connected then MainConnection.Connected:=true;
  vDate:=now();
  DecodeDate(vDate, myYear, myMonth, myDay);
  try
    NoRefresh:=true;
    txtYear.Value:= myYear;
    notdeletedtype;
    QueryMonth.Close;
    QueryMonth.Open();
  finally
    NoRefresh:=false;
  end;
  refresh;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.cbnotinuseClick(Sender: TObject);
begin
  try
    NoRefresh:=true;
    notdeletedtype;
    cbType.Value:=null;
  finally
    NoRefresh:=false;
  end;

  refresh;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  Background:TColor;
  grid:TDBGridEh;
begin
 grid:=TDBGridEh(Sender);
  if Column.FieldName='NameType' Then
    begin
      if grid.DataSource.DataSet.FieldByName('COLCOLOR').IsNull Then
        Background:=grid.Canvas.Brush.Color
      else
        Background:=StringToColor(grid.DataSource.DataSet.FieldByName('COLCOLOR').AsString);
      grid.Canvas.Brush.Color:=Background;
      grid.Canvas.Font.Color:=$000000;
      grid.Canvas.FillRect(Rect);
      grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  if Column.FieldName='nameMonth' Then
    begin
      if grid.DataSource.DataSet.FieldByName('COLCOLOR_M').IsNull Then
        Background:=grid.Canvas.Brush.Color
      else
        Background:=StringToColor(grid.DataSource.DataSet.FieldByName('COLCOLOR_M').AsString);
      grid.Canvas.Brush.Color:=Background;
      grid.Canvas.Font.Color:=$000000;
      grid.Canvas.FillRect(Rect);
      grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.DeletePlat;
begin
  if QueryGKH.IsEmpty then exit;

  if Application.MessageBox(PChar('Удалить запись?' +chr(10)+QueryGKH.FieldByName('nameType').asString
                                                    +' '+QueryGKH.FieldByName('year_gkh').asString
                                                    +' '+QueryGKH.FieldByName('namemonth').asString
                                                    +chr(10)+QueryGKH.FieldByName('summ_gkh').asString),'Вопрос',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>IDYES	Then
    Exit;
  try
    MainConnection.StartTransaction;
    FDCommandMain.Execute('delete from gkh where id = :pid',[QueryGKH.FieldByName('id').AsInteger]);
  except
    MainConnection.Rollback;
    raise;
  end;
  refresh;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.FormCreate(Sender: TObject);
begin
  connectDB;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.notdeletedtype;
begin
 if not cbnotinuse.Checked then
    begin
      QueryType.Close;
      QueryType.MacroByName('notin').DataType:=mdRaw;
      QueryType.MacroByName('notin').Value:=' and notinuse=0 ';
      QueryType.Open();
    end
  else
    begin
      QueryType.Close;
      QueryType.MacroByName('notin').Clear;
      QueryType.Open();

    end;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.refresh;
begin
 if NoRefresh then exit;
  refreshFilter;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.refreshFilter;
begin

  QueryGKH.Close;
  //год
  QueryGKH.ParamByName('pYEAR').AsInteger:=txtYear.Value;
  //месяц
  if cbMonth.Value<>null then
    begin
      QueryGKH.MacroByName('month').DataType:=mdRaw;
      QueryGKH.MacroByName('month').Value:=' and g.Month_gkh=:pmonth ';
      QueryGKH.ParamByName('pMonth').AsInteger:=cbMonth.Value;
    end
  else
    QueryGKH.MacroByName('month').Clear;
  //тип
  if cbType.Value<>null then
    begin
      QueryGKH.MacroByName('type').DataType:=mdRaw;
      QueryGKH.MacroByName('type').Value:=' and g.type_gkh=:ptype ';
      QueryGKH.ParamByName('pType').AsInteger:=cbType.Value;
    end
  else
    QueryGKH.MacroByName('type').Clear;

  QueryGKH.Open();
end;
//------------------------------------------------------------------------------
procedure TMainFrm.Tarif;
var
  fl:boolean;
begin
  with TTarifFrm.Create(self) do
    try
      fl:=OpenModal();
    finally
      Free;
    end;
  try
    NoRefresh:=true;
    notdeletedtype;
  finally
    NoRefresh:=false;
  end;
  refresh;
end;
//------------------------------------------------------------------------------
procedure TMainFrm.TO_EXCEL;
var tcur: TCursor;
begin
  if Assigned(DBGridEh1.DataSource) Then
    begin
      tcur:=Screen.Cursor;
      try
        Screen.Cursor:=crHourGlass;
        Export2Excel1.Execute;
      finally
        Screen.Cursor:=tcur;
      end;
    end;
end;
//------------------------------------------------------------------------------
end.
