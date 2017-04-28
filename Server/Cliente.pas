unit Cliente;

interface
Type
TCliente = class
  private
    FId: Integer;
    FNome: String;
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: String);
  Public
    property Id: Integer read FId write SetId;
    Property Nome: String read FNome write SetNome;

end;

implementation

{ TCliente }

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
