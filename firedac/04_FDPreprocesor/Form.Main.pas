unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.OracleDef,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MySQL, FireDAC.Phys.Oracle,
  FireDAC.Phys.SQLite;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    ComboBox1: TComboBox;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FDConnection1.Close;
  FDConnection1.ConnectionDefName := ComboBox1.Text;
  FDQuery1.FetchOptions.AutoClose := False;   // by odczytaæ FDQuery1.Text
  FDQuery1.Open('select employeeID, lastname, '+
    '{lcase(firstname)} As FirstName, '+
    '{year(birthdate)} asBirthYear, '+
    'country, extension from {id Employees}');
  Self.Caption := FDQuery1.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FDConnection1.Close;
  FDConnection1.ConnectionDefName := ComboBox1.Text;
  FDQuery1.FetchOptions.AutoClose := False;   // by odczytaæ FDQuery1.Text
  FDQuery1.Open('select * from {id Orders} where OrderDate>{d 1998-05-01}');
  Self.Caption := FDQuery1.Text;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FDConnection1.Close;
  FDConnection1.ConnectionDefName := ComboBox1.Text;
  FDQuery1.FetchOptions.AutoClose := False;   // by odczytaæ FDQuery1.Text
  FDQuery1.Open('select * from {id Products} where Discontinued={l True}');
  Self.Caption := FDQuery1.Text;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  FDConnection1.Close;
end;

end.
