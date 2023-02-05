program ModernOrdersApp;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {MainForm},
  Module.Orders.Impl in 'DataModules\Module.Orders.Impl.pas' {DataModuleOrders},
  Module.Orders in 'DataModules\Module.Orders.pas',
  Model.OrderTotal in 'DataModules\Model.OrderTotal.pas',
  Helper.TFDConnection in 'Helper.TFDConnection.pas',
  Dialog.FilterItem in 'FilterBar\Dialog.FilterItem.pas' {FilterItemDialog},
  Component.FilterBar in 'FilterBar\Component.FilterBar.pas',
  Model.Filters in 'FilterBar\Model.Filters.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
