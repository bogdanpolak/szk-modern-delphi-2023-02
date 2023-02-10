unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  Data.DB,
  {*******}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.VCLUI.Login, FireDAC.Comp.UI,
  FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  {*******}
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteWrapper.Stat,
  {*******}
  FireDAC.Phys.IBDef, FireDAC.Phys.IBBase, FireDAC.Phys.IB,
  {}
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConnection1: TFDConnection;
    GroupBox2: TGroupBox;
    Button2: TButton;
    FDConnection2: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    Label3: TLabel;
    Button3: TButton;
    FDConnection3: TFDConnection;
    FDQuery1: TFDQuery;
    ComboBox1: TComboBox;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Button4: TButton;
    FDConnection4: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  count: Variant;
  fdc: TFDConnection;
begin
  fdc := FDConnection2;
  fdc.ConnectionDefName := 'MSSQL_Demo';
  fdc.LoginDialog := FDGUIxLoginDialog1;
  FDGUIxLoginDialog1.Caption := 'Po³aczenie z serwerem SQL';
  with FDGUIxLoginDialog1.VisibleItems do
  begin
    Clear;
    Add('User_Name=U¿ytkownik');
    Add('Password=Has³o');
  end;
  fdc.Open;
  count := fdc.ExecSQLScalar('SELECT count(*) ' +
    'FROM "Orders" o, "Customers" c ' +
    'where (o.CustomerID=c.CustomerID) and Country= :Country', ['Poland']);
  (Sender as TButton).Caption := count;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  CustNo: Variant;
begin
  FDConnection1.Open(
    { } 'DriverID=MSSQL;Server=.;Database=Szkolenie_FireDAC;OSAuthent=Yes');
  CustNo := FDConnection1.ExecSQLScalar('select count(*) from Customers');
  (Sender as TButton).Caption := CustNo;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  ds: TDataSet;
begin
  FDConnection3.ConnectionDefName := 'MSSQL_Demo';
  // FDConnection3.ConnectionDefName := 'SQLite_Demo';
  // *************
  FDConnection3.LoginPrompt := False;
  FDConnection3.ExecSQL('select distinct Country from {id Customers}', ds);
  ComboBox1.OnChange := nil;
  try
    ComboBox1.Style := csDropDownList;
    ComboBox1.Items.Clear;
    ComboBox1.Sorted := True;
    ComboBox1.Items.Add('< wybierz pañstwo >');
    while not ds.Eof do
    begin
      ComboBox1.Items.Add(ds.FieldByName('Country').AsString);
      ds.Next;
    end;
    ComboBox1.ItemIndex := 0;
  finally
    ComboBox1.OnChange := ComboBox1Change;
    ds.Free;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  { -- $DEFINE PLATFORM_SQLLITE }
{$DEFINE PLATFORM_SQL_SERVER}
  { }
{$IFDEF PLATFORM_SQLLITE}
  with FDConnection4 do
  begin
    ConnectionDefName := 'SQLite_Demo';
    ExecSQL('drop table if exists tab1');
    ExecSQL('create table tab1 (id int primary key not null, name varchar(50))');
    StartTransaction;
    ExecSQL('insert into tab1 values (:id,:name)', [1, 'BP']);
    ExecSQL('insert into tab1 values (:id,:name)', [2, 'BSC']);
    Commit;
  end;
{$ENDIF}
{$IFDEF PLATFORM_IBFB}
  with FDConnection4 do
  begin
    ConnectionDefName := 'IB_Demo';
    ExecSQL('drop table tab1', True);
    ExecSQL('create table tab1 (id int not null primary key, name varchar(50))');
    StartTransaction;
    ExecSQL('insert into tab1 values (:id,:name)', [1, 'BP']);
    ExecSQL('insert into tab1 values (:id,:name)', [2, 'BSC']);
    Commit;
  end;
{$ENDIF}
{$IFDEF PLATFORM_SQL_SERVER}
  with FDConnection4 do
  begin
    ConnectionDefName := 'MSSQL_Demo';
    ExecSQL('DROP TABLE IF EXISTS tab1', False);
    ExecSQL('create table tab1 (id int not null primary key, name varchar(50))');
    StartTransaction;
    ExecSQL('insert into tab1 values (:id,:name)', [1, 'BP']);
    ExecSQL('insert into tab1 values (:id,:name)', [2, 'BSC']);
    Commit;
  end;
{$ENDIF}
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  info: Variant;
  country: String;
begin
  if ComboBox1.ItemIndex = 0 then
    info := ''
  else
  begin
    country := ComboBox1.Text;
    info := FDConnection3.ExecSQLScalar('SELECT count(*) ' +
      'FROM "Orders" o, "Customers" c ' +
      'where (o.CustomerID=c.CustomerID) and Country= :Country', [country]);
  end;
  Button3.Caption := info;
end;

end.
