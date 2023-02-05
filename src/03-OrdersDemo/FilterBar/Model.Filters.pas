unit Model.Filters;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Spring.Collections,
  Spring;

type
  TDataFilter = class
  private
    function ValueToSql: string;
    function OperatorToSql: string;
    function ValueToText: string;
  public
    FieldName: string;
    FilterOperator: string;
    Value: Variant;
    constructor Create(
      const aFieldName: string;
      const aFilterOperator: string;
      const aValue: Variant);
    constructor CreateNew();
    function ToText(): string;
    function ToSql(): string;
  end;

type
  TFilterFieldType = (fftNumber, fftString, fftDate);

  TFilterFieldDef = class
    Name: string;
    FieldType: TFilterFieldType;
    constructor Create(
      const aName: string;
      const aFieldType: string);
  end;

function GetFilterFieldDefs(const aModelFields: TArray<string>)
  : IList<TFilterFieldDef>;
function GetFilterOperators(): IDictionary<TFilterFieldType, string>;

implementation

const
  Operators: array of string = [
  { } 'number =,≠,≥,≤,>,<',
  { } 'string contains,not_contains,=,≠',
  { } 'date =,≠,≥,≤,>,<,in_range,has_year'];

function GetFilterFieldType(const aFieldType: string): TFilterFieldType;
begin
  if aFieldType = 'number' then
    Result := fftNumber
  else if aFieldType = 'string' then
    Result := fftString
  else if aFieldType = 'date' then
    Result := fftDate
  else
    raise EArgumentOutOfRangeException.CreateFmt('Argument %s is out of range. '
      + 'Expected one of: number,string or date, but actual is %s',
      ['aFieldType', aFieldType]);

end;

function GetFilterFieldDefs(const aModelFields: TArray<string>)
  : IList<TFilterFieldDef>;
var
  s: string;
  items: TArray<string>;
begin
  Result := TCollections.CreateList<TFilterFieldDef>(True);
  for s in aModelFields do
  begin
    items := s.Split([' ']);
    Result.Add(TFilterFieldDef.Create(items[0], items[1]));
  end;
end;

function GetFilterOperators(): IDictionary<TFilterFieldType, string>;
var
  s: string;
  items: TArray<string>;
  FieldType: TFilterFieldType;
begin
  Result := TCollections.CreateDictionary<TFilterFieldType, string>();
  for s in Operators do
  begin
    items := s.Split([' ']);
    FieldType := GetFilterFieldType(items[0]);
    Result.Add(FieldType, items[1]);
  end;
end;

{ TFilterFieldDef }

constructor TFilterFieldDef.Create(const aName, aFieldType: string);
begin
  Guard.CheckTrue(aName <> '',
    Format('Argument aName is required to create %s.',
    [TFilterFieldDef.ClassName]));
  self.Name := aName;
  FieldType := GetFilterFieldType(aFieldType);
end;

{ TFilterItem }

constructor TDataFilter.Create(
  const aFieldName, aFilterOperator: string;
  const aValue: Variant);
begin
  FieldName := aFieldName;
  FilterOperator := aFilterOperator;
  Value := aValue;
end;

constructor TDataFilter.CreateNew;
begin

end;

function TDataFilter.ValueToSql(): string;
var
  vt: Word;
  dt: TDateTime;
  dateFormat: string;
begin
  vt := VarType(Value);
  case vt of
    varString, varUString:
      if (FilterOperator = 'contains') or (FilterOperator = 'not_contains') then
        Exit(QuotedStr('%' + Value + '%'))
      else
        Exit(QuotedStr(Value));
    varSmallint, varInteger, varByte .. varUInt64:
      Exit(Integer(Value).ToString);
    varDate:
      begin
        dt := VarToDateTime(Value);
        dateFormat := IfThen(Frac(dt) > 0, 'yyyy-mm-dd', 'yyyy-mm-dd hh:nn:ss');
        Exit(Format('CDATE(''%s'')', [FormatDateTime(dateFormat, dt)]));
      end
  else
    Result := Value;
  end;
end;

function TDataFilter.OperatorToSql(): string;
begin
  if FilterOperator = 'contains' then
    Result := 'like'
  else if FilterOperator = 'not_contains' then
    Result := 'not like'
  else if FilterOperator = '≠' then
    Result := '<>'
  else if FilterOperator = '≥' then
    Result := '>='
  else if FilterOperator = '≤' then
    Result := '<='
  else
    Result := FilterOperator;
end;

function TDataFilter.ToSql: string;
var
  sqlValue: string;
  sqlOperator: string;
begin
  sqlOperator := OperatorToSql();
  sqlValue := ValueToSql();
  Result := Format('%s %s %s', [FieldName, sqlOperator, sqlValue])
end;

function TDataFilter.ValueToText: string;
var
  vt: Word;
begin
  vt := VarType(Value);
  case vt of
    varString, varUString:
      Result := QuotedStr(Value);
    varSmallint, varInteger, varShortInt, varByte, varWord,
      varLongWord, varInt64:
      Result := Value;
    varDate:
      Result := DateToStr(VarToDateTime(Value));
  else
    Result := Value;
  end;
end;

function TDataFilter.ToText: string;
begin
  Result := FieldName + ' ' + FilterOperator + ' ' + ValueToText();
end;

end.
