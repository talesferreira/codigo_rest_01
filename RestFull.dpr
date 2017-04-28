program RestFull;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  uPrincipal in 'Cliente\uPrincipal.pas' {Form2},
  Cliente in 'Server\Cliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
