program Server;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uSM in 'uSM.pas' {ServerMethods1: TDataModule},
  uSC in 'uSC.pas' {ServerContainer1: TDataModule},
  uWM in 'uWM.pas' {WebModule1: TWebModule},
  Cliente in 'Cliente.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
