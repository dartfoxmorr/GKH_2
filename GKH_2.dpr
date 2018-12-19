program GKH_2;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainFrm},
  sysf in 'sysf.pas',
  EhlibFireDAC in 'EhlibFireDAC.pas',
  AddPlat in 'AddPlat.pas' {AddPlatFrm},
  Tarif in 'Tarif.pas' {TarifFrm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
