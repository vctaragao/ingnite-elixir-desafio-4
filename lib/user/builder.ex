defmodule FlightBooking.User.Builder do
  alias FlightBooking.User.User

  def build(name, email, cpf) when is_bitstring(cpf) and is_bitstring(email) do
    with {:ok, email} <- validate_email(email),
         {:ok, cpf} <- validate_cpf(cpf) do
      %User{id: UUID.uuid4(), name: name, cpf: cpf, email: email}
    end
  end

  def build(_name, _email, _cpf), do: {:error, "Parametros inválidos"}

  defp validate_email(email) do
    if not String.contains?(email, "@") do
      {:error, "E-mail inválido"}
    else
      {:ok, email}
    end
  end

  defp validate_cpf(cpf) do
    if String.length(cpf) != 11 do
      {:error, "Cpf inválido"}
    else
      {:ok, cpf}
    end
  end
end
