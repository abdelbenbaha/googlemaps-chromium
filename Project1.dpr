program Project1;

uses
  Forms,
  uCEFApplication,
  Unit1 in 'Unit1.pas' {frmMain},
  Unit2 in 'Unit2.pas' {frmEdit};

{$R *.res}

begin
  CreateGlobalCEFApp;
  if GlobalCEFApp.StartMainProcess then
  begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEdit, frmEdit);
  Application.Run;
  end;
  DestroyGlobalCEFApp;
end.
