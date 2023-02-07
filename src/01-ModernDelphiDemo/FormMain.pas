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
  DemoHelper;

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
    btnTupleTupleDemo: TButton;
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

{ Generics Demos }

procedure TFormDemoMain.btnDemoThreadedQueueClick(Sender: TObject);
begin
  // TODO: G #1
end;

procedure TFormDemoMain.btnDemoSuperObjectClick(Sender: TObject);
begin
  Console.Writeln('--- Super Object --------------------------------');
  // TODO: G #2
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoObjectContainerClick(Sender: TObject);
begin
  Console.Writeln('--- Object Container ----------------------------');
  // TODO: G #3
  Console.Writeln('');
end;

{ Anonymous Methods Demos }

procedure TFormDemoMain.btnDemoAnonymousThreadClick(Sender: TObject);
begin
  Console.Writeln('--- Anonymous Thread ----------------------------');
  // TODO: A #1
end;

procedure TFormDemoMain.btnDemoDataSetForEachClick(Sender: TObject);
begin
  Console.Writeln('--- DataSet For Each Row ------------------------');
  // TODO: A #2
  Console.Writeln('');
end;

{ Spring Collections Demos }

procedure TFormDemoMain.btnDemoEmployeeCollectionClick(Sender: TObject);
begin
  Console.Writeln('--- Employee Collection -------------------------');
  // TODO: SC #1
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoWeatherDictionaryClick(Sender: TObject);
begin
  Console.Writeln('--- Weather Dictionary --------------------------');
  // TODO: SC #2
  Console.Writeln('');
end;

{ Spring Base Demos }

procedure TFormDemoMain.btnRunTEnumDemoClick(Sender: TObject);
begin
  Console.Writeln('--- Spring TEnum<> ------------------------------');
  // TODO: SB #1
  Console.Writeln('');
end;

procedure TFormDemoMain.btnNullableDemoClick(Sender: TObject);
begin
  Console.Writeln('--- Spring Nullable<> ---------------------------');
  // TODO: SB #2
  Console.Writeln('');
end;

procedure TFormDemoMain.btnDemoLazyVariableClick(Sender: TObject);
begin
  Console.Writeln('--- Spring ILazy<> ------------------------------');
  // TODO: SB #3
  Console.Writeln('');
end;

procedure TFormDemoMain.btnTupleDemoClick(Sender: TObject);
begin
  Console.Writeln('--- Spring Tuple<> ----------------------------');
  // TODO: SB #4
  Console.Writeln('');
end;

procedure TFormDemoMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  InitializeDemo();
end;

end.
