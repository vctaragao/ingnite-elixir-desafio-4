defmodule ReservaVoos.UserBuilder do
  alias ReservaVoos.User

  def build(name, email, cpf) do
    %User{id: UUID.uuid1(), name: name, cpf: cpf, email: email}
  end
end
