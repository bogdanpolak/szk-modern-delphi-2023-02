unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  Data.DB,
  Spring.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Module.Orders,
  Dialog.FilterItem,
  Component.FilterBar;

type
  TMainForm = class(TForm)
    tmrStart: TTimer;
    pnCommands: TPanel;
    ButtonLogin: TButton;
    btnCalculateOrderTotals: TButton;
    ButtonCommand2: TButton;
    Label1: TLabel;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    pnDataFilterBar: TPanel;
    tmrIdle: TTimer;
    pnMain: TPanel;
    pnLogin: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    edtLogin: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCalculateOrderTotalsClick(Sender: TObject);
    procedure ButtonCommand2Click(Sender: TObject);
    procedure ButtonLoginClick(Sender: TObject);
    procedure tmrIdleTimer(Sender: TObject);
    procedure tmrStartTimer(Sender: TObject);
  private
    fSubscriptionId: Integer;
    fDataModuleOrdes: IDataModuleOrders;
    fFilterBarComponent: TFilterBarComponent;
    fFilterHash: string;
    procedure OnMessageUpdateOrdersCounter(
      const aSender: TObject;
      const aMsg: TMessage<Integer>);
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  pnMain.Visible := False;
  pnLogin.Visible := True;

  fDataModuleOrdes := CreateDataModule1(Application);
  fFilterBarComponent := TFilterBarComponent.Create(self);

  fSubscriptionId := TMessageManager.DefaultManager.SubscribeToMessage
    (TMessage<Integer>,
    procedure(const Sender: TObject; const Msg: TMessage)
    begin
      OnMessageUpdateOrdersCounter(Sender, Msg as TMessage<Integer>);
    end);
end;

procedure TMainForm.OnMessageUpdateOrdersCounter(
  const aSender: TObject;
  const aMsg: TMessage<Integer>);
begin
  StatusBar1.Panels[1].Text := Format('  Orders: %d', [aMsg.Value]);
end;

procedure TMainForm.btnCalculateOrderTotalsClick(Sender: TObject);
begin
  fDataModuleOrdes.CalculateOrderTotalsAndDiscounts();
end;

procedure TMainForm.ButtonCommand2Click(Sender: TObject);
begin
  fDataModuleOrdes.Command2();
end;

procedure TMainForm.ButtonLoginClick(Sender: TObject);
begin
  if fDataModuleOrdes.Login(edtLogin.Text, edtPassword.Text) then
  begin
    pnLogin.Visible := False;
    pnMain.Align := alClient;
    pnMain.Visible := True;
    pnMain.Padding.Right := 0;
    fDataModuleOrdes.Open;
    DBGrid1.DataSource := fDataModuleOrdes.GetOrdersDataSource();
  end;
end;

procedure TMainForm.tmrIdleTimer(Sender: TObject);
var
  hash: string;
begin
  hash := fFilterBarComponent.GetFilterHash();
  if (fFilterHash <> hash) then
  begin
    fFilterHash := hash;
    fDataModuleOrdes.ChangeOrdersFilter(fFilterBarComponent.Filters)
  end;
end;

procedure TMainForm.tmrStartTimer(Sender: TObject);
var
  model: TArray<string>;
begin
  tmrStart.Enabled := False;
  tmrIdle.Enabled := True;

  edtLogin.Text := 'Steven.Buchanan';
  edtPassword.Text := 'Buchanan';

  model := fDataModuleOrdes.GetOrdersFieldModel();
  fFilterBarComponent.Initialize(pnDataFilterBar, model);
  fDataModuleOrdes.ShowDataModule(self.Left + self.Width + 8, self.Top);
  Self.SetFocus;
end;

end.
