defmodule FlightBooking.User.User do
  alias FlightBooking.User.Agent, as: UserAgent

  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys

  defstruct @keys

  def save_or_update(%__MODULE__{} = user) do
    UserAgent.save(user)
    {:ok, "Usuário salvo ou atualizado"}
  end
end
