unit Module.Orders.Impl;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  System.Generics.Collections,
  Spring.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.WinXCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,
  FireDAC.VCLUI.Wait, FireDAC.DApt,
  {-}
  Module.Orders,
  Model.OrderTotal,
  Model.Filters;

type
  TDataModuleOrders = class(TForm, IDataModuleOrders)
    Image1: TImage;
    ActivityIndicator1: TActivityIndicator;
    FDConnection1: TFDConnection;
    fdsOrders: TFDQuery;
    fdsOrdersOrderID: TFDAutoIncField;
    fdsOrdersCustomerID: TWideStringField;
    fdsOrdersEmployeeID: TIntegerField;
    fdsOrdersRequiredDate: TSQLTimeStampField;
    fdsOrdersShippedDate: TSQLTimeStampField;
    fdsOrdersCompanyName: TWideStringField;
    fdsOrdersShipVia: TIntegerField;
    fdsOrdersFreight: TCurrencyField;
    fdsOrdersShipCity: TWideStringField;
    FDQuery1: TFDQuery;
    fdsOrdersTotal: TCurrencyField;
    procedure fdsOrdersCalcFields(DataSet: TDataSet);
  private
    fOrderFilter: string;
    fOrderTotals: IList<TOrderTotal>;
    function GetFieldModel(const ds: TDataSet): TArray<string>;
  public
    constructor Create(aOwner: TComponent); override;
    procedure SelectOrders(const aOdrerFilter: string = '');
    { -contract- }
    procedure ShowDataModule(const aLeft, aTop: Integer);
    function Login(const aUsername, aPassword: string): boolean;
    procedure Open();
    function GetOrdersDataSource(): TDataSource;
    function GetOrdersFieldModel: TArray<string>;
    procedure ChangeOrdersFilter(const Filters: IList<TDataFilter>);
    procedure CalculateOrderTotalsAndDiscounts();
    procedure Command2();
  end;

implementation

{$R *.dfm}

uses
  Helper.TFDConnection;

procedure TDataModuleOrders.ShowDataModule(const aLeft, aTop: Integer);
begin
  Self.Left := aLeft;
  Self.Top := aTop;
  Self.Show;
end;

procedure TDataModuleOrders.SelectOrders(const aOdrerFilter: string = '');
var
  recordCount: Integer;
  sqlSelectOrders: string;
  sqlCountOrders: string;
  whereClause: string;
begin
  whereClause := IfThen(aOdrerFilter = '', '', ' WHERE ' + aOdrerFilter);
  sqlSelectOrders := 'SELECT OrderID, CustomerID, EmployeeID, RequiredDate' +
    ', ShippedDate, Shippers.CompanyName As Shipper, ShipVia, Freight, ShipCity '
    + ' FROM { id Orders } As O ' +
    ' INNER JOIN Shippers On O.ShipVia = Shippers.ShipperId' + whereClause;
  sqlCountOrders := 'SELECT count(1) FROM {id Orders}' + whereClause;
  fdsOrders.Open(sqlSelectOrders);
  recordCount := FDConnection1.ExecSQLScalar(sqlCountOrders);
  fOrderFilter := aOdrerFilter;
  TMessageManager.DefaultManager.SendMessage(Self,
    TMessage<Integer>.Create(recordCount), True);
end;

procedure TDataModuleOrders.Open();
begin
  SelectOrders();
end;

procedure TDataModuleOrders.ChangeOrdersFilter(const Filters: IList<TDataFilter>);
var
  items: TArray<string>;
  idx: Integer;
  orderFilter: string;
begin
  SetLength(items, Filters.Count);
  for idx := 0 to Filters.Count - 1 do
    items[idx] := Filters[idx].ToSql();
  orderFilter := String.Join(' and ', items);
  SelectOrders(orderFilter);
end;

procedure TDataModuleOrders.CalculateOrderTotalsAndDiscounts;
begin
  fOrderTotals := FDConnection1.LoadData<TOrderTotal>
    ('SELECT OrderId,' +
    ' {fn round(UnitPrice*Quantity*(1-Discount),2)} as Total,' +
    ' {fn round(UnitPrice*Quantity*Discount,2)} as DiscountedValue ' +
    'FROM {id Order Details}');
  fdsOrders.Refresh;
end;

procedure TDataModuleOrders.Command2;
begin
  // x
end;

constructor TDataModuleOrders.Create(aOwner: TComponent);
begin
  inherited;
  fOrderTotals := TCollections.CreateList<TOrderTotal>(True);
end;

procedure TDataModuleOrders.fdsOrdersCalcFields(DataSet: TDataSet);
var
  OrderTotal: TOrderTotal;
begin
  OrderTotal := fOrderTotals.FirstOrDefault(
    function(const ot: TOrderTotal): boolean
    begin
      Result := ot.OrderId = fdsOrdersOrderID.Value;
    end);
  if OrderTotal = nil then
    fdsOrdersTotal.Clear
  else
    fdsOrdersTotal.Value := OrderTotal.Total;
end;

function TDataModuleOrders.GetOrdersDataSource: TDataSource;
begin
  Result := TDataSource.Create(Self);
  Result.DataSet := fdsOrders;
end;

function TDataModuleOrders.GetOrdersFieldModel: TArray<string>;
begin
  Result := GetFieldModel(fdsOrders);
end;

function TDataModuleOrders.Login(const aUsername, aPassword: string): boolean;
var
  userCount: Integer;
begin
  FDConnection1.Connected := True;
  userCount := FDConnection1.ExecSQLScalar('select count(1) from Employees ' +
    ' where FirstName+''.''+LastName = :Username and LastName = :Password',
    [aUsername, aPassword]);
  Result := (userCount=1);
end;

function TDataModuleOrders.GetFieldModel(const ds: TDataSet): TArray<string>;
begin
  Result := ['OrderID number', 'CustomerID number', 'EmployeeID number',
    'RequiredDate date', 'ShippedDate date', 'Shipper string', 'ShipVia number',
    'Freight number', 'ShipCity string'];
end;

end.
