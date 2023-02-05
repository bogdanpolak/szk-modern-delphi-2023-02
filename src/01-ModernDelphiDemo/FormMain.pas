unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  {-}
  DemoHelper,
  QueueForm,
  Exercises.Generics,
  Exercises.Anonymous,
  Exercises.Spring4D.Collections,
  Exercises.Spring4D.Base;

type
  TFormDemoMain = class(TForm)
    PanelCommands: TPanel;
    btnDemoThreadedQueue: TButton;
    btnDemoSuperObject: TButton;
    btnDemoObjectContainer: TButton;
    btnDemoDataSetForEach: TButton;
    btnDemoAnonymousThread: TButton;
    btnDemoEmployeeCollection: TButton;
    btnDemoWeatherDictionary: TButton;
    btnRunTEnumDemo: TButton;
    btnNullableDemo: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    btnDemoLazyVariable: TButton;
    procedure btnDemoAnonymousThreadClick(Sender: TObject);
    procedure btnDemoDataSetForEachClick(Sender: TObject);
    procedure btnDemoEmployeeCollectionClick(Sender: TObject);
    procedure btnDemoLazyVariableClick(Sender: TObject);
    procedure btnDemoThreadedQueueClick(Sender: TObject);
    procedure btnDemoSuperObjectClick(Sender: TObject);
    procedure btnDemoObjectContainerClick(Sender: TObject);
    procedure btnDemoWeatherDictionaryClick(Sender: TObject);
    procedure btnNullableDemoClick(Sender: TObject);
    procedure btnRunTEnumDemoClick(Sender: TObject);
    procedure btnTupleDemoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormDemoMain: TFormDemoMain;

implementation

{$R *.dfm}

procedure TFormDemoMain.btnDemoAnonymousThreadClick(Sender: TObject);
begin
  Console.Writeln('--- Anonymous Thread ----------------------------');
  TAnonymousDemo.RunAnonymousThread(Console);
end;

procedure TFormDemoMain.btnDemoDataSetForEachClick(Sender: TObject);
begin
  Console.Writeln('--- DataSet For Each Row ------------------------');
  TAnonymousDemo.RunDataSetForEach(Console, Self);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoEmployeeCollectionClick(Sender: TObject);
begin
  Console.Writeln('--- Employee Collection -------------------------');
  TSpringCollectionsDemo.RunEmployeeCollection(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoLazyVariableClick(Sender: TObject);
begin
  Console.Writeln('--- Spring ILazy<> ------------------------------');
  TSpringBaseDemo.RunLazyVariableDemo(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoThreadedQueueClick(Sender: TObject);
begin
  TFormQueue.Create(Self).Show;
end;

procedure TFormDemoMain.btnDemoSuperObjectClick(Sender: TObject);
begin
  Console.Writeln('--- Super Object --------------------------------');
  TGenericsDemo.RunSuperObject(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoObjectContainerClick(Sender: TObject);
begin
  Console.Writeln('--- Object Container ----------------------------');
  TGenericsDemo.RunObjectContainer(Console, Self);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoWeatherDictionaryClick(Sender: TObject);
begin
  Console.Writeln('--- Weather Dictionary --------------------------');
  TSpringCollectionsDemo.RunWeatherDictionary(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnNullableDemoClick(Sender: TObject);
begin
  Console.Writeln('--- Spring Nullable<> ---------------------------');
  TSpringBaseDemo.RunNullableDemo(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnRunTEnumDemoClick(Sender: TObject);
begin
  Console.Writeln('--- Spring TEnum<> ------------------------------');
  TSpringBaseDemo.RunTEnumDemo(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.btnTupleDemoClick(Sender: TObject);
begin
  Console.Writeln('--- Spring Tupple<> ----------------------------');
  TSpringBaseDemo.RunTuppleDemo(Console);
  Console.Writeln('');
end;

procedure TFormDemoMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  InitializeDemo();
end;

end.
