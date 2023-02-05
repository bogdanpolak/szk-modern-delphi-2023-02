unit Dialog.FilterItem;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Spring.Collections,
  Spring,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.AppEvnts, System.Actions, Vcl.ActnList,
  Model.Filters;

type
  TFilterItemDialog = class(TForm)
    cbxField: TComboBox;
    Label2: TLabel;
    cbxOperator: TComboBox;
    Label3: TLabel;
    edtValue: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ActionList1: TActionList;
    actAddFilter: TAction;
    procedure actAddFilterExecute(Sender: TObject);
    procedure ApplicationEvents1ActionUpdate(
      Action: TBasicAction;
      var Handled: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure cbxFieldChange(Sender: TObject);
  private
    fFilterItem: TDataFilter;
    fFilterFieldDefs: IList<TFilterFieldDef>;
    fFilterOperators: IDictionary<TFilterFieldType, string>;
    procedure InitializeFields(
      const aFilterItem: TDataFilter;
      const aModelFields: TArray<string>);
  public
    class function EditFilterItem(
      const aFilterItem: TDataFilter;
      const aModelFields: TArray<string>): Boolean;
  end;

implementation

{$R *.dfm}

procedure TFilterItemDialog.actAddFilterExecute(Sender: TObject);
var
  fieldType: TFilterFieldType;
  num: Integer;
  isValid: Boolean;
  dt: TDateTime;
begin
  fFilterItem.FieldName := cbxField.items[cbxField.ItemIndex];
  fFilterItem.FilterOperator := cbxOperator.items[cbxOperator.ItemIndex];
  fieldType := fFilterFieldDefs.First(
    function(const ffd: TFilterFieldDef): Boolean
    begin
      Result := ffd.Name = fFilterItem.FieldName;
    end).fieldType;
  if edtValue.Text = '' then
  begin
    ShowMessage('Filter value is required and current value is empty');
    exit;
  end;
  isValid := True;

  case fieldType of
    fftNumber:
      begin
        isValid := TryStrToInt(edtValue.Text, num);
        fFilterItem.Value := num;
      end;
    fftString:
      fFilterItem.Value := edtValue.Text;
    fftDate:
      begin
        isValid := TryStrToDate(edtValue.Text, dt);
        fFilterItem.Value := VarFromDateTime(dt);
      end;
  end;
  if isValid then
    ModalResult := mrOK
  else if fieldType=fftNumber then
    ShowMessage('Filter value has to be a number')
  else if fieldType=fftDate then
    ShowMessage('Filter value has to be a well formated date');
end;

procedure TFilterItemDialog.ApplicationEvents1ActionUpdate(
  Action: TBasicAction;
  var Handled: Boolean);
var
  isValidFilter: Boolean;
begin
  isValidFilter := (cbxField.ItemIndex >= 0) and (cbxOperator.ItemIndex >= 0)
    and (edtValue.Text <> '');
  actAddFilter.Enabled := isValidFilter;
end;

procedure TFilterItemDialog.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFilterItemDialog.cbxFieldChange(Sender: TObject);
var
  opers: TArray<string>;
  op: string;
  filterField: TFilterFieldDef;
  aFieldName: string;
begin
  aFieldName := cbxField.items[cbxField.ItemIndex];

  filterField := fFilterFieldDefs.First(
    function(const ff: TFilterFieldDef): Boolean
    begin
      Result := ff.Name = aFieldName;
    end);
  opers := fFilterOperators[filterField.fieldType].Split([',']);
  cbxOperator.items.Clear;
  for op in opers do
    cbxOperator.items.Add(op);
  cbxOperator.ItemIndex := 0;
end;

procedure TFilterItemDialog.InitializeFields(
  const aFilterItem: TDataFilter;
  const aModelFields: TArray<string>);
var
  filterFieldDef: TFilterFieldDef;
  idx: Integer;
begin
  fFilterFieldDefs := GetFilterFieldDefs(aModelFields);
  fFilterOperators := GetFilterOperators();

  // ---
  fFilterItem := aFilterItem;

  for filterFieldDef in fFilterFieldDefs do
    cbxField.items.Add(filterFieldDef.Name);

  idx := cbxField.items.IndexOf(fFilterItem.FieldName);
  if (aFilterItem.FieldName <> '') and (idx >= 0) then
    cbxField.ItemIndex := idx
  else
    cbxField.ItemIndex := 0;

  cbxField.Style := csDropDownList;

  cbxOperator.Clear;
  cbxOperator.Style := csDropDownList;

  if aFilterItem.Value = '' then
    edtValue.Text := ''
  else
    edtValue.Text := aFilterItem.Value;

  cbxFieldChange(nil);
  idx := cbxOperator.items.IndexOf(fFilterItem.FilterOperator);
  if (fFilterItem.FilterOperator <> '') and (idx >= 0) then
    cbxOperator.ItemIndex := idx;

end;

class function TFilterItemDialog.EditFilterItem(
  const aFilterItem: TDataFilter;
  const aModelFields: TArray<string>): Boolean;
var
  form: TFilterItemDialog;
begin
  form := TFilterItemDialog.Create(Application);
  try
    form.InitializeFields(aFilterItem, aModelFields);
    form.ShowModal;
    Result := form.ModalResult = mrOK;
  finally
    form.Free;
  end;
end;

end.
