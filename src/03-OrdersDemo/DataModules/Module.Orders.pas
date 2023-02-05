unit Module.Orders;

interface

uses
  System.Classes,
  Data.DB,
  Spring.Collections,
  {-}
  Model.Filters;

type
  IDataModuleOrders = interface
    ['{23B88040-0B67-479B-A36C-8C6C802B04FE}']
    procedure ShowDataModule(const aLeft,aTop: Integer);
    { - }
    function Login(const aUsername, aPassword: string): boolean;
    procedure Open();
    function GetOrdersDataSource(): TDataSource;
    function GetOrdersFieldModel: TArray<string>;
    procedure ChangeOrdersFilter(const filters: IList<TDataFilter>);
    procedure CalculateOrderTotalsAndDiscounts();
    procedure Command2();
  end;

function CreateDataModule1(const aOwner: TComponent): IDataModuleOrders;

implementation

uses
  Module.Orders.Impl;

function CreateDataModule1(const aOwner: TComponent): IDataModuleOrders;
begin
  Result := TDataModuleOrders.Create(aOwner);
end;

end.
