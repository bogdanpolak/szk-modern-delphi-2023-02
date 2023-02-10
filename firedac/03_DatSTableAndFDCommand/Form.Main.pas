unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, Vcl.StdCtrls,
  FireDAC.Comp.Client, Data.DB, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDCommand1: TFDCommand;
    Button1: TButton;
    ListBox1: TListBox;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure Button1Click(Sender: TObject);
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
var
  datS: TFDDatSTable;
  i: Integer;
begin
  FDConnection1.ConnectionDefName := 'MSSQL_Demo';
  // FDConnection1.ConnectionDefName := 'SQLite_Demo';
  FDConnection1.Open();
  FDCommand1.CommandKind := skSelect;
  FDCommand1.CommandText.Text := 'select * from {id Customers}';
  datS := FDCommand1.Define();
  FDCommand1.Open();
  FDCommand1.Fetch(datS);
  FDCommand1.Close();
  for i := 0 to datS.Rows.Count - 1 do
    ListBox1.Items.Add(datS.Rows[i].GetData('CompanyName'));
end;

end.
