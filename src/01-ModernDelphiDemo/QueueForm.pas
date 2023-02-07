unit QueueForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  System.Threading,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  {-}
  System.SyncObjs,
  System.Generics.Collections;

type
  TFormQueue = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    btnAddThread: TButton;
    Memo1: TMemo;
    btnClearMemo: TButton;
    procedure btnAddThreadClick(Sender: TObject);
    procedure btnClearMemoClick(Sender: TObject);
    procedure FormClose(
      Sender: TObject;
      var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    fQueue: TThreadedQueue<byte>;
    fThreads: TObjectList<TThread>;
    fCaption: string;
  public
  end;

implementation

{$R *.dfm}

{ TDataLoaderThread }

type
  TDataLoaderThread = class(TThread)
  private
    fQueue: TThreadedQueue<byte>;
  protected
    procedure Execute; override;
  public
    constructor Create(aQueue: TThreadedQueue<byte>);
  end;

constructor TDataLoaderThread.Create(aQueue: TThreadedQueue<byte>);
begin
  fQueue := aQueue;
  inherited Create;
end;

procedure TDataLoaderThread.Execute;
begin
  while not Terminated do
  begin
    TThread.Sleep(200);
    fQueue.PushItem(Random(256));
  end;
end;

{ TFormQueue }

procedure TFormQueue.FormCreate(Sender: TObject);
begin
  fCaption := Caption + ' Threads: %d';
  Memo1.Lines.Text := '';
  fThreads := TObjectList<TThread>.Create(True);
  fQueue := TThreadedQueue<byte>.Create(10, { PushTimeout } 2,
    { PopTimeout } 2);
end;

procedure TFormQueue.FormClose(
  Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  fThreads.Free;
  fQueue.Free
end;

procedure TFormQueue.btnAddThreadClick(Sender: TObject);
var
  thread: TThread;
begin
  thread := TDataLoaderThread.Create(fQueue);
  fThreads.Add(thread);
  Caption := Format(fCaption, [fThreads.Count]);
end;

procedure TFormQueue.btnClearMemoClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TFormQueue.Timer1Timer(Sender: TObject);
var
  data: byte;
begin
  while fQueue.PopItem(data) <> TWaitResult.wrTimeout do
  begin
    Memo1.Lines.Text := Memo1.Lines.Text + ' ' + IntToHex(data);
  end;
end;

end.
