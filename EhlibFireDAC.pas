unit EhlibFireDAC;

interface
uses
  DbUtilsEh, FireDAC.Comp.Client,FireDAC.Comp.DataSet;

implementation

uses Classes;

initialization
  RegisterDatasetFeaturesEh(TSQLDatasetFeaturesEh, TFDDataset);
end.
