unit Exercises.Anonymous;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  Datasnap.DBClient,
  Data.DB,
  {-}
  DemoHelper;

type
  TAnonymousDemo = class
    class procedure RunAnonymousThread(const aConsole: IConsole);
    class procedure RunDataSetForEach(
      const aConsole: IConsole;
      const aOwner: TComponent);
  end;

implementation

type
  TVariantArray = array of Variant;

  TDatasetBuilder = class
    class function CreatePlaces(
      fOwner: TComponent;
      const Data: TArray<TVariantArray>): TDataSet;
  end;

  { TDatasetBuilder }

class function TDatasetBuilder.CreatePlaces(
  fOwner: TComponent;
  const Data: TArray<TVariantArray>): TDataSet;
var
  dataset: TClientDataSet;
  idx: Integer;
  j: Integer;
begin
  dataset := TClientDataSet.Create(fOwner);
  with dataset do
  begin
    FieldDefs.Add('id', ftInteger);
    FieldDefs.Add('city', ftWideString, 30);
    FieldDefs.Add('rank', ftFloat);
    FieldDefs.Add('visited', ftDateTime);
    FieldDefs[0].Required := True;
    FieldDefs[1].Required := True;
    CreateDataSet;
    FieldByName('id').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate]
  end;
  for idx := 0 to High(Data) do
  begin
    dataset.Append;
    for j := 0 to High(Data[idx]) do
      dataset.Fields[j].Value := Data[idx][j];
    dataset.Post;
  end;
  dataset.First;
  Result := dataset;
end;

{ DatasetForEachRow }

procedure DatasetForEachRow(
  const aDataset: TDataSet;
  const aActionProc: TProc<Integer>);
var
  Bookmark: TBookmark;
  idx: Integer;
begin
  Bookmark := aDataset.GetBookmark;
  aDataset.DisableControls;
  try
    aDataset.First;
    idx := 0;
    while not aDataset.Eof do
    begin
      aActionProc(idx);
      aDataset.Next;
      inc(idx);
    end;
  finally
    if aDataset.BookmarkValid(Bookmark) then
      aDataset.GotoBookmark(Bookmark);
    aDataset.FreeBookmark(Bookmark);
    aDataset.EnableControls;
  end;
end;

{ TAnonymousDemo }

class procedure TAnonymousDemo.RunAnonymousThread(const aConsole: IConsole);
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      Data: string;
    begin
      Sleep(500);
      Data := 'From the Thread';
      TThread.Synchronize(nil,
        procedure
        begin
          aConsole.Writeln('  Data: ' + Data);
        end);
    end).Start;
  aConsole.Writeln('  Thread started');
  aConsole.Writeln('  ...');
end;

class procedure TAnonymousDemo.RunDataSetForEach(
  const aConsole: IConsole;
  const aOwner: TComponent);
var
  trips: TArray<string>;
  dataset: TDataSet;
  count: Integer;
  rankSum: Extended;
begin
  dataset := TDatasetBuilder.CreatePlaces(aOwner, [
  { } [1, 'Edinburgh', 5.5, EncodeDate(2018, 05, 28)],
  { } [2, 'Glassgow', 4.1, EncodeDate(2015, 09, 13)],
  { } [3, 'Cracow', 5.8, EncodeDate(2019, 01, 01)],
  { } [4, 'Prague', 4.7, EncodeDate(2013, 06, 21)],
  { } [5, 'Venzia']]);
  count := 0;
  rankSum := 0;
  DatasetForEachRow(dataset,
    procedure(aIdx: Integer)
    begin
      if dataset.FieldByName('visited').IsNull then
        exit;
      trips := trips + ['"' + FormatDateTime('yyyy-mm',
        dataset.FieldByName('visited').AsDateTime) + '"'];
      inc(count);
      rankSum := rankSum + dataset.FieldByName('rank').AsExtended;
    end);
  aConsole.Writeln('  {"trips": [%s]}', [String.Join(', ', trips)]);
  if count > 0 then
    aConsole.Writeln('  Average Rank = %.2f', [rankSum / count]);
end;

end.
