unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Phys.ODBCBase, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Moni.Base,
  FireDAC.Moni.RemoteClient, FireDAC.Moni.Custom;

type
  TForm1 = class(TForm)
    FDCommand1: TFDCommand;
    FDTableAdapter1: TFDTableAdapter;
    FDMemTable1: TFDMemTable;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    FDConnection1: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    Panel1: TPanel;
    Edit1: TEdit;
    btnOpenMemTable: TButton;
    btnApplyUpdates: TButton;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    FDCommand2: TFDCommand;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure btnApplyUpdatesClick(Sender: TObject);
    procedure btnOpenMemTableClick(Sender: TObject);
    procedure FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase; const
        AClassName, AObjName, AMessage: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnApplyUpdatesClick(Sender: TObject);
begin
  FDMoniCustomClientLink1.Tracing := True;
  FDMemTable1.ApplyUpdates();
  FDMoniCustomClientLink1.Tracing := False;
end;

procedure TForm1.btnOpenMemTableClick(Sender: TObject);
begin
  Memo1.Clear;
  FDMemTable1.Close;
  FDCommand1.Params.ParamByName('@Kraj').Value := Edit1.Text;
  FDMemTable1.Open;
end;

procedure TForm1.FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase;
    const AClassName, AObjName, AMessage: string);
begin
//  if (AObjName = FDCommand2.Name) then
//    Memo1.Lines.Add(AMessage);
end;

end.
