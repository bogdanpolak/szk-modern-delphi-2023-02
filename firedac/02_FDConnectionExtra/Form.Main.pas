unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  Datasnap.Provider;

type
  TForm1 = class(TForm)
    btnErrorHandle: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnOpenCustomers: TButton;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    btnOnline: TButton;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure btnErrorHandleClick(Sender: TObject);
    procedure btnOpenCustomersClick(Sender: TObject);
    procedure FDConnection1Recover(ASender, AInitiator: TObject;
      AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure btnOnlineClick(Sender: TObject);
    procedure FDConnection1Error(ASender, AInitiator: TObject; var AException:
        Exception);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnErrorHandleClick(Sender: TObject);
begin
  FDConnection1.ConnectionDefName := 'MSSQL_Demo';
  // FDConnection1.ConnectionDefName := 'SQLite_Demo';
  FDConnection1.Open;
  try
    FDConnection1.ExecSQL('insert into tab1(id, name) values (:id, :name)',
      [100, 'Tokyo']);
  except
    on E: EFDDBEngineException do
    begin
      if E.Kind = ekUKViolated then
        ShowMessage('Please enter unique value !');
      raise;
    end;
  end;
end;

procedure TForm1.btnOnlineClick(Sender: TObject);
begin
  if FDConnection1.Ping then
    FDConnection1.Online
  else
    ShowMessage('Nie ma po³¹czenia');
end;

procedure TForm1.btnOpenCustomersClick(Sender: TObject);
begin
  FDConnection1.Close;
  FDConnection1.ConnectionDefName := 'MSSQL_Demo';
  // FDConnection1.ConnectionDefName := 'FB_Demo';
  FDConnection1.FetchOptions.RowsetSize := 10;
  FDConnection1.ResourceOptions.AutoReconnect := True;
  FDConnection1.OnRecover := FDConnection1Recover;
  FDQuery1.Open;
end;

procedure TForm1.FDConnection1Error(ASender, AInitiator: TObject; var
    AException: Exception);
begin
  // AException := nil;
end;

procedure TForm1.FDConnection1Recover(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
var
  iRes: Integer;
begin
  // AAction := FireDAC.Phys.Intf.TFDPhysConnectionRecoverAction.faOfflineAbort;
  iRes := MessageDlg
    ('Connection is lost. Offline - yes, Retry - ok, Fail - Cancel',
    mtConfirmation, [mbYes, mbOK, mbCancel], 0);
  case iRes of
    mrYes:
      AAction := faOfflineAbort;
    mrOk:
      AAction := faRetry;
    mrCancel:
      AAction := faFail;
  end;
  Caption := 'Connection is recovering';
end;

end.
