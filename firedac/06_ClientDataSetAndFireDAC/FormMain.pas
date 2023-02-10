unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.ODBCBase, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, Datasnap.DBClient, Datasnap.Provider;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Button1: TButton;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    DataSource2: TDataSource;
    FDQuery2: TFDQuery;
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
  sql: string;
begin
  // open:
  FDQuery3.FetchOptions.Mode := fmAll;
  FDQuery3.Open(sql);
  FDQuery3.Indexes
  // update:
  FDQuery3.ApplyUpdates();

  FDConnection1.ConnectionName := 'MSSQL_Demo';
  FDQuery1.FetchOptions.Unidirectional := true;
  sql := 'select * from Customers';
  FDQuery1.Open(sql);

  FDQuery2.SQL.Text := sql;
  ClientDataSet1.Open;
  FDQuery1.Open();
end;

end.
