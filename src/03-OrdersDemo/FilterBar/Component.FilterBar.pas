unit Component.FilterBar;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.Hash,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.Buttons,
  Spring.Collections,
  Model.Filters,
  Dialog.FilterItem;

type
  TFilterBarComponent = class(TComponent)
  private
    fMainPanel: TPanel;
    fFilters: IList<TDataFilter>;
    fModelFields: TArray<string>;
    procedure AddFilterBox(const aFilterItem: TDataFilter);
    procedure OnAddFilter(Sender: TObject);
    procedure OnClearAllFilters(Sender: TObject);
    procedure OnEditFilter(Sender: TObject);
    procedure OnRemoveFilter(Sender: TObject);
  public
    constructor Create(aOwner: TComponent); override;
    procedure Initialize(
      const aMainPanel: TPanel;
      const aModelFields: TArray<string>);
    property Filters: IList<TDataFilter> read fFilters;
    function GetFilterHash(): string;
  end;

implementation

function CreateButton(
  const aOwner: TWinControl;
  const aCaption: string;
  const aWidth: Integer;
  aOnClick: TNotifyEvent): TButton;
begin
  Result := TButton.Create(aOwner);
  with Result do
  begin
    Left := 9999;
    Width := aWidth;
    Align := alLeft;
    AlignWithMargins := True;
    Caption := aCaption;
    Parent := aOwner;
    OnClick := aOnClick;
  end;
end;

function CreatePanel(
  const aOwner: TWinControl;
  const aCaption: string;
  const aWidth: Integer;
  aOnClick: TNotifyEvent): TPanel;
begin
  Result := TPanel.Create(aOwner);
  with Result do
  begin
    Left := 9999;
    Width := aWidth;
    Align := alLeft;
    AlignWithMargins := True;
    Caption := aCaption;
    Parent := aOwner;
    OnClick := aOnClick;
  end;
end;

constructor TFilterBarComponent.Create(aOwner: TComponent);
begin
  inherited;
  fFilters := TCollections.CreateList<TDataFilter>(True);
end;

function TFilterBarComponent.GetFilterHash: string;
var
  filter: TDataFilter;
  s: string;
begin
  s:='';
  for filter in fFilters do
  begin
    s := IfThen(s<>'',' and ','')+filter.ToText();
  end;
  Result := THashMD5.GetHashString(s);
end;

procedure TFilterBarComponent.Initialize(
  const aMainPanel: TPanel;
  const aModelFields: TArray<string>);
begin
  fMainPanel := aMainPanel;
  fModelFields := aModelFields;
  with CreateButton(fMainPanel, '-', 20, OnClearAllFilters) do
  begin
    Margins.Right := 0;
  end;
  with CreateButton(fMainPanel, '+', 32, OnAddFilter) do
  begin
    Font.Style := [TFontStyle.fsBold];
    Font.Height := 20;
  end;

  AddFilterBox(TDataFilter.Create('ShipCity', '=', 'Portland'));
  AddFilterBox(TDataFilter.Create('ShipVia', '=', 3));
end;

procedure TFilterBarComponent.AddFilterBox(const aFilterItem: TDataFilter);
var
  panel: TPanel;
  btn: TSpeedButton;
  lbl: TLabel;
begin
  fFilters.Add(aFilterItem);

  panel := CreatePanel(fMainPanel, ' ', 140, nil);
  btn := TSpeedButton.Create(panel);
  btn.Width := 20;
  btn.Caption := 'X';
  btn.Align := alRight;
  btn.Parent := panel;
  btn.OnClick := OnRemoveFilter;

  lbl := TLabel.Create(panel);
  lbl.Align := alClient;
  lbl.AlignWithMargins := True;
  lbl.Margins.Left := 4;
  lbl.Margins.Right := 0;
  lbl.WordWrap := True;
  lbl.Layout := tlCenter;
  lbl.Caption := aFilterItem.ToText();
  lbl.Parent := panel;
  lbl.OnClick := OnEditFilter;
end;

procedure TFilterBarComponent.OnRemoveFilter(Sender: TObject);
var
  idx: Integer;
begin
  idx := (Sender as TControl).Parent.TabOrder - 2;
  fFilters.Delete(idx);
  (Sender as TControl).Parent.Free;
end;

procedure TFilterBarComponent.OnEditFilter(Sender: TObject);
var
  idx: Integer;
begin
  idx := (Sender as TControl).Parent.TabOrder - 2;
  if TFilterItemDialog.EditFilterItem(fFilters[idx],fModelFields) then
  begin
    (Sender as TLabel).Caption := fFilters[idx].ToText();
  end;
end;

procedure TFilterBarComponent.OnAddFilter(Sender: TObject);
var
  item: TDataFilter;
begin
  item := TDataFilter.CreateNew;
  if TFilterItemDialog.EditFilterItem(item,fModelFields) then
  begin
    AddFilterBox(item);
  end
  else
    item.Free;
end;

procedure TFilterBarComponent.OnClearAllFilters(Sender: TObject);
begin
  while fMainPanel.ComponentCount>2 do
  begin
    fMainPanel.Components[2].Free;
  end;
end;

end.
