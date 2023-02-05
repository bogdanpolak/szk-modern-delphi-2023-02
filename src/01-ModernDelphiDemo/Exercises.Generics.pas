unit Exercises.Generics;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  {-}
  DemoHelper;

type
  TGenericsDemo = class
    class procedure RunSuperObject(const aConsole: IConsole);
    class procedure RunObjectContainer(
      const aConsole: IConsole;
      const aOwner: TComponent);
  end;

implementation

uses
  superobject;

type
  TData = record
    str: string;
    int: Integer;
    bool: Boolean;
    flt: Double;
  end;

class procedure TGenericsDemo.RunSuperObject(const aConsole: IConsole);
var
  ctx: TSuperRttiContext;
  data: TData;
  superObj: ISuperObject;
  jsonText: string;
begin
  ctx := TSuperRttiContext.Create;
  try
    superObj := SO('[{str: "foo", int: 123, bool: true, flt: 1.23}]');
    data := ctx.AsType<TData>(superObj.AsArray.N[0]);
    jsonText := ctx.AsJson<TData>(data).AsString;
  finally
    ctx.Free;
  end;
  aConsole.Writeln('  item[%d] = (str=%s int=%d bool=%s flt=%f)',
    [superObj.AsArray.Length, data.str, data.int, BoolToStr(data.bool, true),
    data.flt]);
  aConsole.Writeln('  ctx.AsJson<TData>(data).AsString = ' + jsonText);
end;

type
  TObjectContainer<T: class, constructor> = class(TComponent)
  strict private
    fObj: T;
  public
    property Obj: T read fObj;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

constructor TObjectContainer<T>.Create(aOwner: TComponent);
begin
  inherited;
  fObj := T.Create();
end;

destructor TObjectContainer<T>.Destroy;
begin
  fObj.Free;
  inherited;
end;

class procedure TGenericsDemo.RunObjectContainer(
  const aConsole: IConsole;
  const aOwner: TComponent);
var
  container: TObjectContainer<TStringList>;
begin
  container := TObjectContainer<TStringList>.Create(aOwner);
  container.Obj.Add('3. three');
  container.Obj.Add('1. one');
  container.Obj.Insert(0, '2. two');
  container.Obj.Sort;
  aConsole.Writeln('  container.Obj.CommaText = ' + container.Obj.CommaText);
end;

end.
