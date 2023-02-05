unit Exercises.Spring4D.Collections;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  Spring,
  Spring.Collections,
  DemoHelper;

type
  TSpringCollectionsDemo = class
    class procedure RunEmployeeCollection(const aConsole: IConsole);
    class procedure RunWeatherDictionary(const aConsole: IConsole);
  end;

implementation

{ TEmployee }

type
  TEmployee = class
    FirstName: string;
    LastName: string;
    Salary: double;
    constructor Create(
      const aName: string;
      aSalary: double);
  end;

constructor TEmployee.Create(
  const aName: string;
  aSalary: double);
var
  nameArray: TArray<string>;
begin
  nameArray := aName.Split([' ']);
  FirstName := nameArray[0];
  LastName := nameArray[1];
  Salary := aSalary;
end;

{ TWeather }

type
  TWeather = class
    Location: string;
    Teperature: integer; { -50°C .. 50°C }
    RealFeelTeperature: integer; { -50°C .. 50°C }
    // MaxUvIndex: integer; { 0 .. 11+ }
    WindDirection: string; { N E S W, NE, SE, SW, NW }
    WindSpeed: integer; { km/h }
    Humidity: integer; {%}
    CloudCover: integer; {%}
    Pressure: integer; { mb / hPa }
    Visibility: integer; { km }
    CloudCeiling: integer; { m }
    function ToText: string;
  end;

function TWeather.ToText: string;
begin
  Result := Format('Teperature: %d°C, RealFeelTeperature: %d°C, ' +
    'WindDirection: %s, WindSpeed: %d km/h, Humidity: %d%%, ' +
    'CloudCover %d%%, Pressure %d hPa, Visibility: %d km, ' +
    'CloudCeiling: %d m',
    { } [Teperature, RealFeelTeperature, WindDirection, WindSpeed,
    { } Humidity, CloudCover, Pressure, Visibility, CloudCeiling]);
end;

{ TWeatherGenerator }

type
  TWeatherGenerator = class
  strict private
    class function BuildWeather(
      const aLocation: string;
      const data: TArray<Variant>): Shared<TWeather>;
    class function BuildRandomWeather(const aLocation: string)
      : Shared<TWeather>;
  public
    class function GetWeather(const aLocation: string): IShared<TWeather>;
  end;

class function TWeatherGenerator.BuildWeather(
  const aLocation: string;
  const data: TArray<Variant>): Shared<TWeather>;
begin
  Result := TWeather.Create;
  with Result.Value do
  begin
    Location := aLocation;
    Teperature := data[0];
    RealFeelTeperature := data[1];
    WindDirection := data[2];
    WindSpeed := data[3];
    Humidity := data[4];
    CloudCover := data[5];
    Pressure := data[6];
    Visibility := data[7];
    CloudCeiling := data[8];
  end;
end;

function RandomFromArray(const aValues: TArray<string>): string;
begin
  Result := aValues[Random(Length(aValues))];
end;

class function TWeatherGenerator.BuildRandomWeather(const aLocation: string)
  : Shared<TWeather>;
begin
  Result := TWeather.Create;
  with Result.Value do
  begin
    Location := aLocation;
    Teperature := Random(42) - 10;
    RealFeelTeperature := Teperature + Random(5) - 4;
    // MaxUvIndex := Random(8);
    WindDirection := RandomFromArray(['N', 'E', 'S', 'W', 'NE', 'SE', 'SW',
      'NW', 'NNE', 'NNW', 'ESE', 'SSW']);
    WindSpeed := Random(100);
    Humidity := 60 + Random(41);
    CloudCover := Random(101);
    Pressure := 980 + Random(46);
    Visibility := 5 + Random(20);
    CloudCeiling := 300 + Random(4000);
  end;
end;

class function TWeatherGenerator.GetWeather(const aLocation: string)
  : IShared<TWeather>;
begin
  if aLocation = 'poland/warsaw' then
    Result := BuildWeather(aLocation, [3 { °C } , -1 { °C } , 'SW',
      13 { km/h } , 86 { Humidity:% } , 91, 1003 { Pressure : hPa } ,
      16 { Visibility : km } , 1000 { CloudCeiling : m } ])
  else if aLocation = 'germany/berlin' then
    Result := BuildWeather(aLocation, [4 { °C } , -4 { °C } , 'WNW',
      52 { km/h } , 82 { Humidity:% } , 95, 1012 { Pressure : hPa } ,
      16 { Visibility : km } , 600 { CloudCeiling : m } ])
  else if aLocation = 'uk/edinburgh' then
    Result := BuildWeather(aLocation, [10 { °C } , 3 { °C } , 'WSW',
      52 { km/h } , 88 { Humidity:% } , 100, 1015 { Pressure : hPa } ,
      10 { Visibility : km } , 500 { CloudCeiling : m } ])
  else if aLocation = 'australia/sydney' then
    Result := BuildWeather(aLocation, [27 { °C } , 28 { °C } , 'E',
      30 { km/h } , 71 { Humidity:% } , 37, 991 { Pressure : hPa } ,
      16 { Visibility : km } , 6000 { CloudCeiling : m } ])
  else if aLocation = 'usa/san-francisco' then
    Result := BuildWeather(aLocation, [14 { °C } , 14 { °C } , 'NE',
      11 { km/h } , 69 { Humidity:% } , 18, 1023 { Pressure : hPa } ,
      19 { Visibility : km } , 12200 { CloudCeiling : m } ])
  else
    Result := BuildRandomWeather(aLocation);
end;

{ TSpringCollectionsDemo }

function CompareCurrency(const aLeft, aRight: currency): integer;
begin
  if (aLeft < aRight) then
    Result := -1
  else if (aLeft > aRight) then
    Result := 1
  else
    Result := 0;
end;

class procedure TSpringCollectionsDemo.RunEmployeeCollection(const aConsole
  : IConsole);
var
  employees: IList<TEmployee>;
  emp: TEmployee;
begin
  employees := TCollections.CreateList<TEmployee>(True);
  employees.Add(TEmployee.Create('Jan Kowalski', 9800));
  employees.Add(TEmployee.Create('Tomasz Jankowski', 6300));
  employees.Add(TEmployee.Create('Ewa Tomaszewska', 8500));
  employees.Sort(
    function(const e1, e2: TEmployee): integer
    begin
      Result := CompareCurrency(e1.Salary, e2.Salary);
    end);
  for emp in employees do
    aConsole.Writeln('  %s %s : %f', [emp.FirstName, emp.LastName, emp.Salary]);
end;

var
  fLoadedWeathers: IDictionary<string, IShared<TWeather>>;

class procedure TSpringCollectionsDemo.RunWeatherDictionary(const aConsole
  : IConsole);
{ - }
  function GetLoacation(const Location: string): IShared<TWeather>;
  begin
    if not fLoadedWeathers.ContainsKey(Location) then
    begin
      fLoadedWeathers.Add(Location, TWeatherGenerator.GetWeather(Location));
    end;
    Result := fLoadedWeathers[Location];
  end;

var
  warsaw: string;
  berlin: string;
begin
  fLoadedWeathers := TCollections.CreateDictionary<string, IShared<TWeather>>;
  warsaw := GetLoacation('poland/warsaw').ToText;
  berlin := GetLoacation('germany/berlin').ToText;
  aConsole.Writeln('[poland/warsaw]  '+warsaw);
  aConsole.Writeln('[germany/berlin]  '+berlin);
end;

end.
