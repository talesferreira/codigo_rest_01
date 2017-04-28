unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Layouts, FMX.Memo, FMX.StdCtrls, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, Cliente, System.JSON, REST.Types, REST.Json,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarRESTClient;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
Var
  vCliente: TCliente;
  VJSONObject: TJSONObject;
  VJSONPAir: TJSONPair;
  VJsonArray: TJSONArray;
Begin
  Self.CarregarRESTClient;
  RESTRequest1.Resource := '/candidatos';
  RESTRequest1.Method := TRESTRequestMethod.rmGET;
  RESTRequest1.Execute;

  VJSONObject := RESTResponse1.JSONValue as TJSONObject;
  VJSONPair := VJSONObject.Get(0);
  ShowMessage(VJSONPair.ToString);

  VJsonArray :=  VJSONPair.JsonValue as TJSONArray;

  vCliente := TJson.JsonToObject<TCLiente>(VJsonArray.Get(0).ToString);
  Try
    Edit1.Text := vCliente.Id.ToString;
    Edit2.Text := vCliente.Nome;
  Finally
    vCliente.free;
  End;
end;

procedure TForm2.Button2Click(Sender: TObject);
Var
  vCliente: TCliente;
  VJSONObject: TJSONObject;
begin
  vCliente := TCliente.Create;
  try
    vCliente.Id := 2;
    vCliente.Nome := 'Gabriel';

    VJSONObject := TJson.ObjectToJsonObject(vCliente);

    Self.CarregarRESTClient;
    RESTRequest1.Resource := '/Clientes';
    RESTRequest1.Method := TRESTRequestMethod.rmGET;
    RESTRequest1.AddBody(VJSONObject.ToString, ContentTypeFromString('application/json'));
    RESTRequest1.Execute;
  finally
    vCliente.Free;
  end;

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Self.CarregarRESTClient();
  RESTRequest1.Resource := '/Clientes/{Id}';
  RESTRequest1.Method := TRESTRequestMethod.rmPUT;
  RESTRequest1.Params.AddUrlSegment('Id', Edit1.Text);
  RESTRequest1.Execute;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  Self.CarregarRESTClient();
  RESTRequest1.Resource := '/Clientes/{Id}';
  RESTRequest1.Method := TRESTRequestMethod.rmDELETE;
  RESTRequest1.Params.AddUrlSegment('Id', Edit1.Text);
  RESTRequest1.Execute;
end;

procedure TForm2.CarregarRESTClient;
begin
  RESTClient1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  //RESTClient1.BaseURL := 'http://localhost:211/datasnap/rest/TServerMethods1';
  RESTClient1.BaseURL := 'https://api.transparencia.org.br/api/v1';
  Memo1.Text := EmptyStr;
end;

end.
