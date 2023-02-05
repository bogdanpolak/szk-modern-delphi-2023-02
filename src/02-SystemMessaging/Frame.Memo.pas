unit Frame.Memo;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFrameMemo = class(TFrame)
    tmrStart: TTimer;
    Memo1: TMemo;
    Panel1: TPanel;
    btnCloseFrame: TButton;
    procedure btnCloseFrameClick(Sender: TObject);
    procedure tmrStartTimer(Sender: TObject);
  private
    fSubscriptionId1: Integer;
    fSubscriptionId2: Integer;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

constructor TFrameMemo.Create(aOwner: TComponent);
begin
  inherited;
  fSubscriptionId1 := TMessageManager.DefaultManager.SubscribeToMessage
    (TMessage<string>,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      Memo1.Lines.Add(TMessage<string>(M).Value);
    end);
  fSubscriptionId2 := TMessageManager.DefaultManager.SubscribeToMessage
    (TMessage<TDateTime>,
    procedure(const Sender: TObject; const M: TMessage)
    var
      msg: string;
    begin
      msg := FormatDateTime('hh:nn:s:z', TMessage<TDateTime>(M).Value);
      TThread.Queue(nil,
        procedure
        begin
          Memo1.Lines.Add(msg);
        end);
    end);
end;

destructor TFrameMemo.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TMessage<String>,
    fSubscriptionId1);
  TMessageManager.DefaultManager.Unsubscribe(TMessage<TDateTime>,
    fSubscriptionId2);
  inherited;
end;

procedure TFrameMemo.btnCloseFrameClick(Sender: TObject);
begin
  Self.Free;
end;

procedure TFrameMemo.tmrStartTimer(Sender: TObject);
begin
  tmrStart.Enabled := false;
  Memo1.Align := alClient;
  Memo1.Color := RGB(128 + random(128), 128 + random(128), 128 + random(128));
  Memo1.Clear;
end;

end.
