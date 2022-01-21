defmodule FlightBooking.User.Agent do
  alias FlightBooking.User.User

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  defp update_state(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)

  def check_user(user_id) when is_bitstring(user_id) do
    if get_by_user_id(user_id) != %{} do
      {:ok, user_id}
    else
      {:error, "Id de usuário inválido"}
    end
  end

  def get(cpf) do
    Agent.get(__MODULE__, fn state ->
      Map.filter(state, fn {cpf_key, _value} -> cpf_key == cpf end)
    end)
    |> Map.values()
    |> List.first()
  end

  defp get_by_user_id(user_id) do
    Agent.get(__MODULE__, fn state ->
      Map.filter(state, fn {_cpf, user} -> user_id == user.id end)
    end)
  end

  def clear(), do: Agent.update(__MODULE__, fn _state -> %{} end)
end
