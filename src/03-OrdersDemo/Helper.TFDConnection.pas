unit Helper.TFDConnection;

interface

uses
  System.SysUtils,
  System.Rtti,
  Data.DB,
  FireDAC.Comp.Client,
  Spring.Collections;

type
  EDataMapperError = class(Exception);

  TFDConnectonHelper = class helper for TFDConnection
  public
    function LoadData<T: class, constructor>(const sql: string): IList<T>;
  end;

implementation

// ----------------------------------------------------------------------
// TFDConnectonHelper
// ----------------------------------------------------------------------

function TFDConnectonHelper.LoadData<T>(const sql: string): IList<T>;
var
  ds: TDataSet;
  dataField: TField;
  obj: T;
  rttiType: TRttiType;
  RttiContext: TRttiContext;
  rttiField: TRttiField;
  fieldName: string;
  valueOfField: TValue;
  field: TField;
begin
  self.ExecSQL(sql, ds);
  try
    Result := TCollections.CreateList<T>(True);
    while not ds.Eof do
    begin
      obj := T.Create();
      Result.Add(obj);
      // ------------------------------------------------
      // MapDataSetRowToObject
      rttiType := RttiContext.GetType(obj.ClassType);
      for rttiField in rttiType.GetFields do
      begin
        fieldName := rttiField.Name;
        field := ds.FindField(fieldName);
        if field <> nil then
        begin
          if field is TBlobField then
            valueOfField := TValue.From((field as TBlobField).Value)
          else
            valueOfField := TValue.From(field.Value);
          rttiField.SetValue(TObject(obj), valueOfField);
        end;
      end;
      // ------------------------------------------------
      ds.Next;
    end;
  finally
    ds.Free;
  end;
end;

end.
