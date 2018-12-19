unit sysF;

interface
uses Windows,SysUtils,DateUtils,forms ,Ora,DBGridEh,Buttons,frxClass,Classes,
      DB,Dialogs,Types,Grids,
      Graphics,GridsEh,frxExportRTF,frxExportPDF,frxExportImage,frxExportCSV,
      ShlObj,Variants,MemTableEh,MemTreeEh,MemTableDataEh,math,Menus;
type
  TTimeString = class
    type TdType =  (dtLong, dtShort,dtCustom1);
    const
        Month1: Array [1..12] of String = ('Янв.', 'Фев.', 'Мар.', 'Апр.', 'Май.', 'Июн.', 'Июл.', 'Авг.', 'Сен.', 'Окт.', 'Ноя.', 'Дек.');
        Week1: Array [0..6] of String = ('Вос', 'Пон', 'Вто', 'Сре', 'Чет', 'Пят', 'Суб');
    private
      Time: TDateTime;
    public
      constructor Create;
      Function GetFullDateTimeString:string;
      function GetDateString:string;
      function GetTimeString:string;
      function GetDayOfWeekString(dType:TdType):string;
      function GetMonthOfYearString(dType:TdType):string;
  end;
type
  TSepArr = array of string; // массив "записей"

  TSepRec = record
    Rec: TSepArr;   // сами "записи"
    Max: integer;   // количество полученных "записей"
end;
type TLinePlace =  (lpLeft, lpRight, lpBoth);
type TCrossCell =  (CcBoth,CcLeft,CcRight);
type TExportType =  (etXLS, etRTF, etPDF,etJPG);
type TFloatCompare = (fcEquivalent,fcFlargest,fcSlargest,fcError);
type
  TMyDBGrid = class(TDBGridEh);  {Это попытка победить дрыганье грида...}

type ScreenThread = class(TThread)  //поток для всплывающих сообщений
private
  secToWait : integer;

Public
  constructor Create(CreateSuspended:boolean;lsecToWait : integer);
  Procedure Execute; Override;
End;

type TCopyPastNomenk = procedure(pOraQueryFrom,pOraQueryBufer:TOraQuery) of object; //тип указатель на процедуру, для копирования из Query в буферный Query
//------------ Тип для прокси карт(для конвертера)
type
TSingleByte = record
  b1:byte;
  b2:byte;
  b3:byte;
  b4:byte;
  b5:byte;
end;
TCardCode = record
  case int64 of
    0:(CardCode_int:int64);
    1:(SingleBytes:TSingleByte);
end;
//------------
//------------------------------------------------------------------------------
{datetime}
function getLongDateTimeString:string;
function getDateString:string;
function getTimeString:string;
{float}
function isEquallyFloat(Vfirst,VSecond:single;eps:Single =0.001 ):bool; //сравнение чисел с плавающей точкой
function FloatCompare (vFirst,vSecond:single;eps:Single =0.001):TFloatCompare;
function TruncTo(AValue:Extended;ADigit:integer):Extended;
{ строки }
{аналог StringReplace( Result, ' ', '', [rfReplaceAll] );}
function Replace(Str, X, Y: string): string;  //замена подстроки в строке
// Замена разных вариантов перевода строки на #13#10
function Replace1310(pStr: string): string;

function AddToStrSpisok(var pSpisok:string;pNewVal:string;cSeparator: char = ','):boolean;//добавляет к строке вида 1,2,5,6 новое значение (Если значение первое то не ставит запятую)
function FormatNumAtStr(const Num: Integer; const Words: array of string;const Template: string='%0:d %1:s'): string;
{записи}
function GetSeparatorRec(const sRows: string;cSeparator: char = ','): TSepRec;
                                                          {
                                                            разбиваем строку на массив
                                                            с произвольным разделителем,
                                                             возвращает контейнер
                                                          }
function  SortRecASC( tmp: TSepRec): TSepRec;//сортировать записи в контейнере по возрастающей
function GetRecFromStr( str: string): TSepRec;//Убираем пробелы, разделитель запятая, сортируем по возрастанию
function RecToStr( tmp: TSepRec;cSeparator: char = ','):string;
function AddToRect(var tmp: TSepRec;pnewVal:string):boolean;
function isStrInRec(tmp: TSepRec;pfindVal:string):boolean;
{--controls--}

{кнопка}
procedure stdAddToBtnName   (    lBtn:TBitBtn;  lAddtxt:string; lExistText:string;  lResize:boolean = true);  //меняем текст кнопки, дописыванием

{базы данных}
function getStrFromDBRows(TmpQuery:TOraQuery;FieldName:string;separator:string):string; //Получаем строку из записей базы данных.
function GetMaxNpp(tmpDS:TDataSet;fieldname:string):integer;Overload;//Ищим максимальное значение; Уже не используется...
function GetMaxNpp(tmpDS:TDataSet;fieldname:string;var lVal:integer):bool;Overload;//Ищим максимальное значение;{на будущее, чтобы перегружать для integer}
function GetMaxNpp(tmpDS:TDataSet;fieldname:string;var lVal:Single):bool;Overload;//Ищим максимальное значение;{на будущее, чтобы перегружать для single}

{отчеты}
function LoadReportFromDB(idRep: integer; frxRep: TfrxReport;pOraSession:TOraSession;owner: TComponent): Boolean;   //загружаем отчет из БД

{грид}
procedure SetFieldCaption(TmpGrid:TDBGridEh;fieldName:string;CaptionTxt:string);  //изменяет название колонки у грида
procedure DrawLineInGrid      (
                              const Rect: TRect; DataCol: Integer; Column: TColumnEh;
                              State: GridsEh.TGridDrawState;
                              tmpGrid:TDBGridEh;LineWidth:integer;
                              LColor:TColor;LineType:TLinePlace
                              );    {
                                    рисование бордюров колонок
                                     Rect
                                     DataCol
                                     Column
                                     State
                                     все это стандартные параметры DrawColumnCell

                                     tmpGrid - грид где рисуем
                                    LineWidth ширина в пикселях
                                    LColor    цвет
                                    LineType  тип рисования  lpLeft, lpRight, lpBoth
                                    }
procedure DrawDIAGLineInGrid      (
                              const Rect: TRect; DataCol: Integer; Column: TColumnEh;
                              State: GridsEh.TGridDrawState;
                              tmpGrid:TDBGridEh;
                              LColor:TColor; LCrossCell:TCrossCell
                              );    {
                                    рисование Зачеркнутых ячеек колонок
                                     Rect
                                     DataCol
                                     Column
                                     State
                                     все это стандартные параметры DrawColumnCell

                                     tmpGrid - грид где рисуем

                                    LColor    цвет
                                    LCrossCell тип зачеркивания (CcBoth,CcLeft,CcRight);
                                    }
procedure GridSelectAll(Grid: TDBGridEh);//выбрать все записи
procedure ScrollActiveToRow(Grid : TDBGridEh; ARow : Integer);{побеждаем дрыганье грида}
{tree}
procedure CollapseLevel(mTbl: TMemTableEh; pLevel: integer);
{forms}
function IsCreateForm(formClass: TComponentClass): boolean;
function IndexOfForm (const AClassName: String; const FromIndex: Word):Integer;
function FindCreateForm(formClass: TComponentClass): TForm;
{Reports}
function ExportReport(Owner:TComponent;tmpReport:TFRXReport;expType:TExportType):boolean;
//экспорт из TFRXReport  в  (etXLS, etRTF, etPDF,etJPG)
{Messages}
Procedure SendMessageToScr(lText:string;lTimeToWait:integer;lFontSize:integer);

{proxy card конвертер}
function GetIntFromCardCode_4Byte(pCardCode:int64):integer;
function GetIntFromCardCode_2Byte(pCardCode:int64):integer;
function GetIntFromCardCode_1Byte(pCardCode:int64):integer;

function GetStrFromCardCode_4Byte(pCardCode:int64):string;
function GetStrFromCardCode_2Byte(pCardCode:int64):string;
function GetStrFromCardCode_1Byte(pCardCode:int64):string;

{Функции из дата модуля}
function GetMultiId(grid: TDBGridEh; var SelName: string;
                    FieldId,FiledCaption: string;
                    pRazdel: string = ', '): string;

function StrToFRVar(const ps: string): string;
function VarToInt(const v: Variant): integer;
function VarToDouble(const v: Variant): double;
function VarToStr(const v: Variant):string;
function IntToVar(const i: integer):variant; //если 0, то NULL
function IntToStrok(pCount: integer): string;

{------------------------------------------------------------------------------}
{функции для работы с датой}

//начало квартала
function StartOfKvartal(const AValue: TDateTime): TDateTime;
//Конец квартала (время 23:59:59)
function EndOfKvartal(const AValue: TDateTime): TDateTime;
//День недели строкой по дате
function DayOfWeekRus(S: TDateTime; IsShort:boolean=false):string;

{------------------------------------------------------------------------------}
function GetLocalComputerName: String;//имя компьютера
{------------------------------------------------------------------------------}
{PopUpMenu}
Function FindMenuItemByTag(pMenu:TPopupMenu;pTag:integer):TMenuItem;
implementation
//------------------------------------------------------------------------------
        {TTimeString}
        constructor TTimeString.Create;
        begin
          inherited;
          Time:=now();
        end;
        //----------------------------------------------------------------------
        Function TTimeString.GetFullDateTimeString:string;
        begin
          RESULT:= GetDayOfWeekString(dtLong) + ' '+GetDateString+ ' ' +GetTimeString;
        end;
        //----------------------------------------------------------------------
        function TTimeString.GetDateString:string;
        begin
          RESULT:=DateToStr(Time);
        end;
        //----------------------------------------------------------------------
        function TTimeString.GetTimeString:string;
        begin
          Time:=now();
          RESULT:=TimeToStr(Time);
        end;
        //----------------------------------------------------------------------
        function TTimeString.GetDayOfWeekString(dType:TdType):string;
         begin
          case dType of
            dtLong: RESULT:=SysUtils.FormatSettings.LongDayNames[DayOfWeek(Time)];
            dtShort: RESULT:=SysUtils.FormatSettings.ShortDayNames[DayOfWeek(Time)];
            dtCustom1: RESULT:=week1[DayOfWeek(Time)];
          end;
        end;
        //----------------------------------------------------------------------
        function TTimeString.GetMonthOfYearString(dType:TdType):string;
        begin
         case dType of
            dtLong: RESULT:=SysUtils.FormatSettings.LongMonthNames[MonthOfTheYear(Time)];
            dtShort: RESULT:=SysUtils.FormatSettings.ShortMonthNames[MonthOfTheYear(Time)];
            dtCustom1: RESULT:=Month1[MonthOfTheYear(Time)];
          end;
        end;
//------------------------------------------------------------------------------
function getLongDateTimeString:string;
var tmp :TTimeString;
begin
  tmp:=TTimeString.Create;
  RESULT:=tmp.GetFullDateTimeString;
  FreeAndNil(tmp);
end;
//------------------------------------------------------------------------------
function getDateString:string;
var tmp :TTimeString;
begin
  tmp:=TTimeString.Create;
  RESULT:=tmp.GetDateString;
  FreeAndNil(tmp);
end;
//------------------------------------------------------------------------------
function getTimeString:string;
var tmp :TTimeString;
begin
  tmp:=TTimeString.Create;
  RESULT:=tmp.GetTimeString;
  FreeAndNil(tmp);
end;
{forms}
//------------------------------------------------------------------------------
function IsCreateForm(formClass: TComponentClass): boolean;
var r: integer;
begin
  r:=IndexOfForm(formClass.ClassName,0);
  if r=-1 Then
    begin
      Result:=false;
    end
  else
    Result:=true;
end;
//----------------------------------------------------------
function IndexOfForm (const AClassName: String; const FromIndex: Word):Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := FromIndex to Screen.FormCount-1 do
    if (CompareText(Screen.Forms[i].ClassName, AClassName) = 0) then
    begin
      Result := i;
      Break;
    end;
end;
//----------------------------------------------------------
function FindCreateForm(formClass: TComponentClass): TForm;
var Instance: TComponent;
    r: integer;
begin
  r:=IndexOfForm(formClass.ClassName,0);
  if r=-1 Then
    begin
      Instance := TComponent(formClass.NewInstance);
      Instance.Create(Application);
      Result:=TForm(Instance);
    end
  else
    Result:=Screen.Forms[r];
end;
//----------------------------------------------------------
//------------------------------------------------------------------------------
function FloatCompare (vFirst,vSecond:single;eps:Single):TFloatCompare;
begin
  //fcEquivalent - равно,fcFlargest - первое больше,fcSlargest - 2 больше,fcError - ошибка
  Result:=fcError;
  try
    if abs(vFirst-vSecond)<eps  then begin result:=fcEquivalent;  exit; end;
    if vFirst>vSecond           then begin result:=fcFlargest;    exit; end;
    if vFirst<vSecond           then begin result:=fcSlargest;    exit; end;
  except
    raise;
  end;
end;
//------------------------------------------------------------------------------
function isEquallyFloat(Vfirst,VSecond:single;eps:single):bool;
begin
  Result:=false;
  try
    if (abs(Vfirst-VSecond) < eps) then
    begin
      Result:=true;
    end;
  except
    raise Exception.Create('Ошибка сравнения. Обратитесь к разработчику.');
  end;
end;
//------------------------------------------------------------------------------
function TruncTo(AValue:Extended;ADigit:integer):Extended;
var
  tmp:double;
  toDecem:double;
  //-------------------------------------
  function getDecemTo(pADigit:integer):integer;
  var i,j:integer;
  begin
    j:=1;
    for I := 1 to pADigit do
    begin
      j:=j*10;
    end;
    RESULT:=j;
  end;
  //-------------------------------------
begin
  toDecem:=getDecemTo(ADigit);
  if ADigit>0 then
    begin
      tmp:=trunc(RoundTo(AValue*toDecem,0))/toDecem;
    end
  else if ADigit<0 then
    begin
      tmp:=trunc(AValue/toDecem)*toDecem;
    end
  else
    tmp:=trunc(AValue);
  RESULT:=tmp;
end;
//------------------------------------------------------------------------------
Procedure SendMessageToScr(lText:string;lTimeToWait:integer;lFontSize:integer);
var
Canvas:TCanvas;
ScreenDC:HDC;
threadtmp: ScreenThread;
begin
  ScreenDC := GetDC(0);
  Canvas:=TCanvas.Create();
  Canvas.Handle:=ScreenDC;

  //SetBkMode(Canvas.Handle, TRANSPARENT); // Рисуем на прозрачном фоне,
  Canvas.Font.Size:=lFontSize;
  Canvas.Font.Style:=[fsBold];
  Canvas.Brush.Color:=clMenuHighlight;
  settextcolor(Canvas.Handle,clLime);
  Canvas.TextOut(5,5,lText);

  ReleaseDC(0,ScreenDC);
  Canvas.Free;
  threadtmp:=ScreenThread.Create(False,lTimeToWait);
end;
//------------------------------------------------------------------------------
function GetRecFromStr( str: string): TSepRec;
var
 R: TSepRec;
 Rd: TSepRec;
 Rez:TSepRec;
 i:integer;
 n:integer;
 num:integer;
 j:integer;
begin
  str:=StringReplace( str, ' ', '', [rfReplaceAll] );
  R := GetSeparatorRec(str, ',');
  i:=1;
  n:=1;
  Rez.Max:=1;
  while i<=R.Max do
  begin
    Rd := GetSeparatorRec(r.rec[i], '-');
    if   Rd.Max>1 then
      begin
          num:=strToInt(Rd.Rec[2])-strToInt(Rd.Rec[1]);
          j:=0;
          while j<=num do
          begin
          SetLength(Rez.Rec, Rez.Max + 1);
          Rez.Rec[n]:=IntToStr(strToInt(Rd.Rec[1])+j);
          Rez.Max:=Rez.Max+1;
          Rez.Rec[0]:=intToStr(Rez.Max);
          n:=n+1;
          j:=j+1;
          end;
      end
    else
    begin
    SetLength(Rez.Rec, Rez.Max + 1);
    Rez.Rec[n]:=R.rec[i];
    Rez.Max:=Rez.Max+1;
    Rez.Rec[0]:=intToStr(Rez.Max);
    n:=n+1;
    end;
  i:=i+1;
  end;
Rez.Max:=Rez.Max-1;
Rez.Rec[0]:=IntToStr(Rez.Max);

rez:=SortRecASC(Rez);
Result:=Rez;
end;
//-----------------------------------------------------------
function RecToStr( tmp: TSepRec;cSeparator: char = ','):string;
var tmpStr:string;
 i:integer;
begin
  i:=1;
  while i<=tmp.Max do
    begin
    AddToStrSpisok(tmpStr,tmp.Rec[i],cSeparator);
    i:=i+1;
    end;
  RESULT:=tmpstr;
end;
//------------------------------------------------------------------------------
function AddToRect(var tmp: TSepRec;pnewVal:string):boolean;
var
  i: integer;
begin
  if tmp.rec=nil then
     i:=0
  else
    i:=strToInt(tmp.rec[0]);
  SetLength(tmp.Rec, i + 2);
  tmp.Rec[0] := IntToStr(i+1);
  tmp.Rec[i+1]:=pnewVal;
  tmp.Max:=i+1;
  result:=true;
end;
//------------------------------------------------------------------------------
function isStrInRec(tmp: TSepRec;pfindVal:string):boolean;
var
  i: integer;
begin
  RESULT:=false;
  if tmp.rec=nil then
     exit;
  i:=1;
  while i<=tmp.Max do
    begin
      if pfindVal = tmp.Rec[i] then
        begin
          RESULT:=true;
          exit;
        end;
      i:=i+1;
    end;
end;
//------------------------------------------------------------------------------
procedure GridSelectAll(Grid: TDBGridEh);
begin
  Grid.SelectedRows.Clear;
  with Grid.Datasource.DataSet do
  begin
    First;
    DisableControls;
    try
      while not EOF do
      begin
        Grid.SelectedRows.CurrentRowSelected := True;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;
//------------------------------------------------------------------------------
{
var
   OldRow: Integer;
begin
...
 OldRow := TMyDBGrid( свой грид ).Row;
...
Тут делаем какой хотим Locate с Disable/Enable-Controls и т.п.
...
 ScrollActiveToRow( свой грид , OldRow);
end;
ОБЯЗАТЕЛЬНО ПОСЛЕ  Enable-Controls
}
procedure ScrollActiveToRow(Grid : TDBGridEh; ARow : Integer);
 var FTitleOffset, SDistance : Integer;
     NewRect : TRect;
     //RowHeight : Integer;
     NewRow : Integer;
begin
 with TMyDBGrid(Grid) do begin
   NewRow:= Row;
   FTitleOffset:= 0;
   if dgTitles in Options then inc(FTitleOffset);
   if ARow = NewRow then Exit;
   with DataLink, DataSet do
    try
      BeginUpdate;
      Scroll(NewRow - ARow);
      if (NewRow - ARow) < 0 then ActiveRecord:= 0
                             else ActiveRecord:= VisibleRowCount - 1;
      SDistance:= MoveBy(NewRow - ARow);
      NewRow:= NewRow - SDistance;
      MoveBy(ARow - ActiveRecord - FTitleOffset);
      RowHeight:= DefaultRowHeight;
      NewRect:= BoxRect(0, FTitleOffset, ColCount - 1, 1000);
      ScrollWindowEx(Handle, 0, - RowHeight * SDistance, @NewRect, @NewRect, 0, nil, SW_Invalidate);
      MoveColRow(Col, NewRow, False, False);
    finally
      EndUpdate;
    end;
 end;
end;
//------------------------------------------------------------------------------
procedure CollapseLevel(mTbl: TMemTableEh; pLevel: integer);
//var //cur_lvl: integer;
//    nd: TBaseTreeNodeEh;
  //  tr: TMemoryTreeListEh;
begin
  if mTbl=nil Then
    Exit;
    //нифига не работает
 { tr:=mTbl.RecordsView.MemoryTreeList;

  nd:=tr.GetFirstVisible;
  while nd<>nil do
    begin
      cur_lvl:=(nd as TMemRecViewEh).NodeLevel;
      if cur_lvl=pLevel Then
        tr.Collapse(nd,False)
      else if cur_lvl<pLevel then
        tr.Expand(nd,False);

      nd:=tr.GetNextVisible(nd,True);
    end;   }
end;
//------------------------------------------------------------------------------
function Replace(Str, X, Y: string): string;
{Str - строка, в которой будет производиться замена.
 X - подстрока, которая должна быть заменена.
 Y - подстрока, на которую будет произведена заменена}
var
  buf1, buf2, buffer: string;
begin
  buf1 := '';
  buf2 := Str;
  Buffer := Str;

  while Pos(X, buf2) > 0 do
  begin
    buf2 := Copy(buf2, Pos(X, buf2), (Length(buf2) - Pos(X, buf2)) + 1);
    buf1 := Copy(Buffer, 1, Length(Buffer) - Length(buf2)) + Y;
    Delete(buf2, Pos(X, buf2), Length(X));
    Buffer := buf1 + buf2;
  end;

  Replace := Buffer;
end;

//------------------------------------------------------------------------------

// Замена разных вариантов перевода строки на #13#10
function Replace1310(pStr: string): string;
begin
  Result:=StringReplace(pStr,#13#10,#14,[rfReplaceAll]);
  Result:=StringReplace(Result,#10,#14,[rfReplaceAll]);
  Result:=StringReplace(Result,#13,#14,[rfReplaceAll]);

  Result:=StringReplace(Result,#14,#13#10,[rfReplaceAll]);
end;
//------------------------------------------------------------------------------
function AddToStrSpisok(var pSpisok:string;pNewVal:string;cSeparator: char = ','):boolean;//добавляет к строке вида 1,2,5,6 новое значение (Если значение первое то не ставит запятую)
begin
  try
    if Length(pSpisok)>0 then
      begin
        pSpisok:=pSpisok+cSeparator+ pNewVal;
      end
    else
      begin
        pSpisok:=pNewVal;
      end;
    RESULT:=true;
  except
    RESULT:=false;
  end;
end;
//-----------------------------------------------------------
function GetSeparatorRec(const sRows: string;
  cSeparator: char = ','): TSepRec;
var
  cCol: array of integer;
  i, j: integer;
  bSTRING: boolean;
begin
  Result.Max := -1;

  j := 1;
  bSTRING := False;
  SetLength(cCol, j);
  cCol[0] := 0;
  for i := 1 to Length(sRows) do
  begin
    if sRows[i] = '"' then
      bSTRING := not bSTRING;
    if (sRows[i] = cSeparator) and (not bSTRING) then
    begin
      j := j + 1;
      SetLength(cCol, j);
      cCol[j - 1] := i;
    end;
  end;
  j := j + 1;
  SetLength(cCol, j);
  cCol[j - 1] := Length(sRows) + 1;

  Result.Max := High(cCol);
  if Result.Max > 0 then
  begin
    SetLength(Result.Rec, Result.Max + 1);
    Result.Rec[0] := IntToStr(Result.Max);
    for i := 1 to Result.Max do
    begin
      Result.Rec[i] := Copy(sRows, cCol[i - 1] + 1, cCol[i] - cCol[i - 1] - 1);
    end;
  end;
end;
//------------------------------------------------------------------------------
//FormatNumAtStr(Count, ['запись', 'записи', 'записей'], ' %d %s ');
function FormatNumAtStr(const Num: Integer; const Words: array of string;
  const Template: string='%0:d %1:s'): string;
var
  d: Integer;
  function retval(pz:integer):string;
    begin
      if (pos('%d',Template)>0) and (pos('%s',Template)>0) then
        Result:=Format(Template, [Num, Words[pz]])
      else if (pos('%s',Template)>0) then
        Result:=Format(Template, [Words[pz]])
      else
        raise Exception.Create('Неверный формат');
    end;
begin
  if Length(Words)<>3 then
    raise Exception.Create('Ожидается 3 строковых значения.');
  d:=Num mod 100;
  if (d>=11) and (d<=14) then
    RESULT:=retval(2)
  else
    case d mod 10 of
      1:  RESULT:=retval(0);
      2..4: RESULT:=retval(1);
    else
      RESULT:=retval(2);
    end;
end;
//------------------------------------------------------------------------------
function SortRecASC( tmp: TSepRec): TSepRec;
var
  i, j, b_val, b_j: integer;
begin
 if tmp.Max > 1 then
    for i := 1 to tmp.Max-1  do
    begin
      b_val := StrToInt(tmp.rec[i]);
      b_j := i;
      for j := i + 1 to tmp.Max  do
      begin
        if StrToInt(tmp.rec[j]) < b_val then
        begin
          b_val := StrToInt(tmp.rec[j]);
          b_j := j;
        end;
      end;
      tmp.rec[b_j] := tmp.rec[i];
      tmp.rec[i] := IntToStr(b_val);
    end;
Result:=tmp;
end;
//-----------------------------------------------------------
function  getStrFromDBRows(TmpQuery:TOraQuery;FieldName:string;separator:string):string;
var
i:integer;
begin
    TmpQuery.First;
    while not TmpQuery.Eof do
    begin
    if (not TmpQuery.FieldByName(FieldName).IsNull) then
    begin
    if not (TmpQuery.FieldByName(FieldName).AsString='') then
      Result:=Result+TmpQuery.FieldByName(FieldName).AsString+separator;
    end;
    TmpQuery.Next;
    end;
    i:=0;
    if Result='' then exit;
    while i<Length(separator)do
    begin
      Result[Length(Result)-i]:=#0;
      i:=i+1;
    end;
    Result:=StringReplace( Result, ' ', '', [rfReplaceAll] );
end;
//-----------------------------------------------------------
function GetMaxNpp(tmpDS:TDataSet;fieldname:string):integer;
var
maxNPP,npp:integer;
begin
  maxNPP:=0;
  try
    maxNPP:=0;
    tmpDS.DisableControls;
    tmpDS.First;
    while not tmpDS.Eof  do
    begin
      if  not(VarType(tmpDS.FieldByName(fieldname).Value) in [varNull,varEmpty])then
        npp:=tmpDS.FieldByName(fieldname).AsInteger
      else
        npp:=0;
      if maxNPP<npp then maxNpp:=npp;
      tmpDS.Next;
    end;
  finally
    tmpDS.EnableControls;
    Result:=maxNPP;
  end;
end;
//-----------------------------------------------------------
function GetMaxNpp(tmpDS:TDataSet;fieldname:string;var lVal:integer):bool;Overload;//Ищим максимальное значение;
var
npp:integer;
begin
  RESULT:=false;
  try
    lVal:=0;
    tmpDS.DisableControls;
    tmpDS.First;
    while not tmpDS.Eof  do
    begin
      if  not(VarType(tmpDS.FieldByName(fieldname).Value) in [varNull,varEmpty])then
        npp:=tmpDS.FieldByName(fieldname).AsInteger
      else
        npp:=0;
      if lVal<npp then lVal:=npp;
      tmpDS.Next;
    end;
    Result:=true;
  finally
    tmpDS.EnableControls;
  end;
end;
//-----------------------------------------------------------
function GetMaxNpp(tmpDS:TDataSet;fieldname:string;var lVal:Single):bool;Overload;//Ищим максимальное значение;
var
npp:Single;
begin
  RESULT:=false;
  try
    lVal:=0;
    tmpDS.DisableControls;
    tmpDS.First;
    while not tmpDS.Eof  do
    begin
      if  not(VarType(tmpDS.FieldByName(fieldname).Value) in [varNull,varEmpty])then
        npp:=tmpDS.FieldByName(fieldname).asFloat
      else
        npp:=0;
      if lVal<npp then lVal:=npp;
      tmpDS.Next;
    end;
    Result:=true;
  finally
    tmpDS.EnableControls;
  end;
end;
//-----------------------------------------------------------
procedure SetFieldCaption(TmpGrid:TDBGridEh;fieldName:string;CaptionTxt:string);
begin
  TmpGrid.FieldColumns[fieldName].Title.Caption:=CaptionTxt;
end;
//------------------------------------------------------------------------------
procedure stdAddToBtnName(lBtn:TBitBtn;lAddtxt:string;  lExistText:string;   lResize:boolean = true);
begin
  lBtn.Caption:=lExistText+lAddtxt;
  if lResize then
  begin
    lBtn.Width:=Length(lExistText+lAddtxt)*10;
  end;
end;
//------------------------------------------------------------------------------
function LoadReportFromDB(idRep: integer; frxRep: TfrxReport;pOraSession:TOraSession;owner: TComponent): Boolean;
var
  MS: TMemoryStream;
  OQReportFrm:TOraQuery;
  OQReportFrmREPORTSAVE: TBlobField;
begin
  Result:=False;
  try
    OQReportFrm:=TOraQuery.Create(owner);
    OQReportFrm.SQL.Add('select id,reportSave from SKL_REPORTFORM where id=:idR');
    OQReportFrm.ParamByName('idR').AsInteger:=idRep;
    OQReportFrm.Session:=pOraSession;
    OQReportFrm.Active:=True;
    OQReportFrmREPORTSAVE:=TBlobField(OQReportFrm.FieldByName('reportSave'));
    if OQReportFrm.IsEmpty Then
      begin
        ShowMessage('Не найден шаблон документа. Обратитесь к разработчикам.');
        Exit;
      end;
    MS := TMemoryStream.Create;
    try
      OQReportFrmREPORTSAVE.SaveToStream(MS);
      MS.Seek(0, soFromBeginning);
      frxRep.LoadFromStream(MS);
    finally
      MS.Free;
    end;
    Result:=True;
  except
    on E: Exception do begin ShowMessage(E.Message); REsult:=False; end;
  end;
end;
//----------------------------------------------------------
procedure DrawLineInGrid( const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: GridsEh.TGridDrawState;
  tmpGrid: TDBGridEh;LineWidth:integer;LColor:TColor;LineType:TLinePlace);
var
  R: TRect;
begin
  R:=Rect;
  if (LineType=lpLeft)  or (LineType=lpBoth) then r.Left:=Rect.Left+LineWidth;
  if (LineType=lpRight) or (LineType=lpBoth) then  r.Right:=Rect.Right-LineWidth;

  tmpGrid.DefaultDrawColumnCell(r, DataCol, Column,State);

  if (LineType=lpLeft) or (LineType=lpBoth) then
  begin
  R:=Rect;
  r.Right:=Rect.Left+LineWidth;

  tmpGrid.Canvas.brush.color := LColor ;
  tmpGrid.Canvas.FillRect(r);
  end;
  if (LineType=lpRight) or (LineType=lpBoth) then
  begin
  R:=Rect;

  r.Left:=Rect.Right-LineWidth;
  tmpGrid.Canvas.brush.color := LColor ;
  tmpGrid.Canvas.FillRect(r);
  end;
end;
//----------------------------------------------------------
procedure DrawDIAGLineInGrid( const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: GridsEh.TGridDrawState;
  tmpGrid: TDBGridEh;LColor:TColor; LCrossCell:TCrossCell);
var
  R: TRect;
begin
  R:=Rect;
  tmpGrid.Canvas.Pen.Style := psSolid;
  tmpGrid.Canvas.Pen.color := LColor ;
  if LCrossCell=CcBoth then
    begin
      tmpGrid.Canvas.MoveTo(r.Left,r.Top);
      tmpGrid.Canvas.LineTo(r.Right,r.Bottom);
      tmpGrid.Canvas.MoveTo(r.Right,r.Top);
      tmpGrid.Canvas.LineTo(r.Left,r.Bottom);
    end
  else if LCrossCell=CcLeft then
    begin
      tmpGrid.Canvas.MoveTo(r.Left,r.Top);
      tmpGrid.Canvas.LineTo(r.Right,r.Bottom);
    end
  else if LCrossCell=CcRight then
    begin
      tmpGrid.Canvas.MoveTo(r.Right,r.Top);
      tmpGrid.Canvas.LineTo(r.Left,r.Bottom);
    end
end;
//----------------------------------------------------------
function ExportReport(Owner:TComponent;tmpReport:TFRXReport;expType:TExportType):boolean;
var
    tmpXLS: TfrxCSVExport;
    tmpRTF: TfrxRTFExport;
    tmpPDF: TfrxPDFExport;
    tmpJPG: TfrxJPEGExport;
begin
  RESULT:=false;
  tmpReport.PrepareReport();
  case expType of
    etXLS:
      begin
        tmpXLS:=TfrxCSVExport.Create(Owner);
        tmpXLS.ShowProgress:=true;
        tmpXLS.OpenAfterExport:=true;
        RESULT:=tmpReport.Export(tmpXLS);
        tmpXLS.Free;
      end;
    etRTF:
      begin
        tmpRTF:=TfrxRTFExport.Create(Owner);
        tmpRTF.ShowProgress:=true;
        tmpRTF.OpenAfterExport:=true;
        RESULT:=tmpReport.Export(tmpRTF);
        tmpRTF.Free;
      end;
    etPDF:
      begin
        tmpPDF:=TfrxPDFExport.Create(Owner);
        tmpPDF.OpenAfterExport:=true;
        RESULT:=tmpReport.Export(tmpPDF);
        tmpPDF.Free;
      end;
    etJPG:
      begin
        tmpJPG:=TfrxJPEGExport.Create(Owner);
        tmpJPG.JPEGQuality:=900;
        RESULT:=tmpReport.Export(tmpJPG);
        tmpJPG.Free;
      end;
  end;
end;
//----------------------------------------------------------

{ ScreenThread }

constructor ScreenThread.Create(CreateSuspended: boolean;
  lsecToWait: integer);
begin
  secToWait:=lsecToWait;
  inherited Create(CreateSuspended);
end;
//----------------------------------------------------------
procedure ScreenThread.Execute;
begin
  inherited;
  sleep(secToWait*1000);
  InvalidateRect(0,nil,false);
  InvalidateRect(0,nil,true);
end;
//----------------------------------------------------------
function GetIntFromCardCode_4Byte(pCardCode: int64): integer;
var
  lCode: TCardCode;
begin
  lCode.CardCode_int:=pCardCode;
  Result:=StrToInt('$'+
                      intToHex(lCode.SingleBytes.b4,2)
                      +
                      intToHex(lCode.SingleBytes.b3,2)
                      +
                      intToHex(lCode.SingleBytes.b2,2)
                      +
                      intToHex(lCode.SingleBytes.b1,2))
end;
//----------------------------------------------------------
function GetIntFromCardCode_2Byte(pCardCode: int64): integer;
var
  lCode: TCardCode;
begin
  lCode.CardCode_int:=pCardCode;
  Result:=StrToInt('$'+
                      intToHex(lCode.SingleBytes.b2,2)
                      +
                      intToHex(lCode.SingleBytes.b1,2))
end;
//----------------------------------------------------------
function GetIntFromCardCode_1Byte(pCardCode: int64): integer;
var
  lCode: TCardCode;
begin
  lCode.CardCode_int:=pCardCode;
  Result:=StrToInt('$'+
                      intToHex(lCode.SingleBytes.b1,2))
end;
//----------------------------------------------------------
function GetStrFromCardCode_1Byte(pCardCode: int64): string;
var
  lCode: TCardCode;
  lng,i:integer;
  rVal:string;
begin
  lCode.CardCode_int:=pCardCode;
  rVal:=IntToStr(StrToInt('$'+
                      intToHex(lCode.SingleBytes.b1,2)));
  lng:=4-Length(rVal);
  i:=0;
  while i<lng do
  begin
    rVal:='0'+rVal;
    i:=i+1;
  end;
  Result:=rVal;
end;
//----------------------------------------------------------
function GetStrFromCardCode_2Byte(pCardCode: int64): string;
var
  lCode: TCardCode;
  lng,i:integer;
  rVal:string;
begin
  lCode.CardCode_int:=pCardCode;
  rVal:=IntToStr(StrToInt('$'+
                      intToHex(lCode.SingleBytes.b2,2)
                      +
                      intToHex(lCode.SingleBytes.b1,2)));
  lng:=5-Length(rVal);
  i:=0;
  while i<lng do
  begin
    rVal:='0'+rVal;
    i:=i+1;
  end;
  Result:=rVal;
end;
//----------------------------------------------------------
function GetStrFromCardCode_4Byte(pCardCode: int64): string;
var
  lCode: TCardCode;
  lng,i:integer;
  rVal:string;
begin
  lCode.CardCode_int:=pCardCode;
  rVal:=IntToStr(StrToInt('$'+
                      intToHex(lCode.SingleBytes.b4,2)
                      +
                      intToHex(lCode.SingleBytes.b3,2)
                      +
                      intToHex(lCode.SingleBytes.b2,2)
                      +
                      intToHex(lCode.SingleBytes.b1,2)));
  lng:=10-Length(rVal);
  i:=0;
  while i<lng do
  begin
    rVal:='0'+rVal;
    i:=i+1;
  end;
  Result:=rVal;
end;

//----------------------------------------------------------
function GetMultiId(grid: TDBGridEh; var SelName: string;
                    FieldId,FiledCaption: string;
                    pRazdel: string = ', '): string;
var i: integer;
    r: string;
begin
  Result:='='; r:='';
  for i := 0 to grid.SelectedRows.Count -1 do
    begin
      grid.DataSource.Dataset.GotoBookmark(pointer(grid.SelectedRows.Items[i]));
      Result:=Result
             +grid.DataSource.Dataset.FieldByName(FieldId).AsString
             +'=';
      SelName:=SelName+r+grid.DataSource.Dataset.FieldByName(FiledCaption).AsString;
      r:=pRazdel;
    end;
end;
//----------------------------------------------------------
function VarToInt(const v: Variant): integer;
begin

  if VarType(v) in [varNull,varEmpty] Then
    Result:=0
  else
    try
      Result:=v
    except
      result:=0;
    end;
end;
//----------------------------------------------------------
function VarToDouble(const v: Variant): double;
begin
  if VarType(v) in [varNull,varEmpty] Then
    Result:=0
  else
    try
      Result:=v
    except
      result:=0;
    end;
end;
//----------------------------------------------------------
function VarToStr(const v: Variant):string;
begin
  if VarType(v) in [varNull,varEmpty] Then
    Result:=''
  else
    try
      Result:=v
    except
      result:='';
    end;
end;
//----------------------------------------------------------
function IntToVar(const i: integer):variant;
begin
  if i=0 Then
    Result:=null
  else
    Result:=i;
end;
//----------------------------------------------------------
function IntToStrok(pCount: integer): string;
var ts: string;
    d2,d1: integer;
begin
  // 'строку' 1,21,31...101,121,131
  // 'строки' 2,3,4,22,23,24,32,33,34
  d2:=pCount mod 100; d1:=d2 mod 10;
  if (d2>4) AND (d2<21) Then
    ts:=''
  else if d1=1 then
    ts:='у'
  else if (d1>1) AND (d1<5) then
    ts:='и'
  else
    ts:='';
  Result:=IntToStr(pCount)+' строк'+ts;
end;

//----------------------------------------------------------
function StrToFRVar(const ps: string): string;
begin
  Result:=''''+StringReplace(ps,#13#10,'''#13#10+''',[rfReplaceAll])+'''';
end;

{------------------------------------------------------------------------------}
{ функции для работы с датой }

//начало квартала
function StartOfKvartal(const AValue: TDateTime): TDateTime;
var m: Word;
begin
  m:=((MonthOf(AValue)-1) div 3)*3 + 1;
  Result:=EncodeDate(YearOf(AValue), m, 1);
end;

//Конец квартала (время 23:59:59)
function EndOfKvartal(const AValue: TDateTime): TDateTime;
var m: Word;
begin
  m:=((MonthOf(AValue)-1) div 3)*3 + 3;
  Result:=EndOfAMonth(YearOf(AValue), m);
end;
//День недели строкой по дате
function DayOfWeekRus(S: TDateTime; IsShort:boolean=false):string;
const
  week:array[1..7] of string = ('Воскресенье','Понедельние','Вторник','Среда','Четверг','Пятница','Суббота');
  week_SH:array[1..7] of string = ('Вс','Пн','Вт','Ср','Чт','Пт','Сб');
var
  day:integer;
begin
  try
    day:=DayOfWeek(S);
    if isShort then
      RESULT:=week_SH[day]
    else
      RESULT:=week_SH[day];
  except
    RESULT:='';
  end;
end;
//----------------------------------------------------------имя компьютера
function GetLocalComputerName: String;
var
  L : LongWord;
begin
  L := MAX_COMPUTERNAME_LENGTH + 2;
  SetLength(Result, L);
  if Windows.GetComputerName(PChar(Result), L) and (L > 0) then
    SetLength(Result, StrLen(PChar(Result))) else
    Result := '';
end;
//----------------------------------------------------------
Function FindMenuItemByTag(pMenu:TPopupMenu;pTag:integer):TMenuItem;
var i:integer;
begin
  //Пока без вложений
  RESULT:=nil;
  for i := 0 to pMenu.Items.Count-1 do
  begin
    if  pMenu.Items[i].Tag=pTag then
      RESULT:=pMenu.Items[i];
  end;
end;
//------------------------------------------------------------------------------
end.
