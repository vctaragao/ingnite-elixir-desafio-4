defmodule FlightBooking.User.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys

  defstruct @keys
end