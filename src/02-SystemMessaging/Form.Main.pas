unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  System.Threading,
  System.Diagnostics,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnSendMessage: TButton;
    Panel1: TPanel;
    btnAddMemo: TButton;
    ScrollBox1: TScrollBox;
    btnStartTask: TButton;
    procedure btnSendMessageClick(Sender: TObject);
    procedure btnAddMemoClick(Sender: TObject);
    procedure btnStartTaskClick(Sender: TObject);
    procedure FormClose(
      Sender: TObject;
      var Action: TCloseAction);
  private
    fSubscriptionId: integer;
    fTask: ITask;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Frame.Memo;

{$R *.dfm}

procedure TForm1.btnSendMessageClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self,
    TMessage<string>.Create('Message: ' + FormatDateTime('nn:ss:zzz', Now)));
end;

procedure TForm1.btnAddMemoClick(Sender: TObject);
begin
  with TFrameMemo.Create(Self) do
  begin
    Left := 999;
    Align := alLeft;
    Name := Format('FrameMemo%d', [ScrollBox1.Tag + 1]);
    Parent := ScrollBox1;
  end;
  ScrollBox1.Tag := ScrollBox1.Tag + 1;
end;

{ TTaskHelper }

type
  TTaskHelper = class helper for TTask
    class procedure SleepWithCancelation(
      const aMiliseconds: integer;
      const aTask: ITask);
  end;

class procedure TTaskHelper.SleepWithCancelation(
  const aMiliseconds: integer;
  const aTask: ITask);
var
  sw: TStopwatch;
begin
  sw := sw.StartNew;
  while (aTask.Status <> TTaskStatus.Canceled) and
    (sw.ElapsedMilliseconds < aMiliseconds-15) do
  begin
    TThread.Sleep(10);
  end;
end;

procedure TForm1.btnStartTaskClick(Sender: TObject);
var
  x: integer;
begin
  if Assigned(fTask) then
    exit;
  x := 0;
  fTask := TTask.Create(
    procedure
    begin
      while (fTask.Status <> TTaskStatus.Canceled) do
      begin
        TMessageManager.DefaultManager.SendMessage(Self,
          TMessage<TDateTime>.Create(Now));
        TTask.SleepWithCancelation(2000, fTask);
      end;
      fTask := nil;
    end);
  fTask.Start;
end;

procedure TForm1.FormClose(
  Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(fTask) then
    fTask.Cancel;
  while Assigned(fTask) do;
end;

end.
