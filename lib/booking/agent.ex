defmodule FlightBooking.Booking.Agent do
  alias FlightBooking.Booking.Booking

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)
end
