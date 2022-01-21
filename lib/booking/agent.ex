defmodule FlightBooking.Booking.Agent do
  alias FlightBooking.Booking.Booking

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)

  def get(booking_id) do
    Agent.get(__MODULE__, fn state -> Map.get(state, booking_id) end)
  end

  def findInBetween(initial_date, final_date) do
    Agent.get(__MODULE__, fn state ->
      Map.filter(state, fn {_id, booking} ->
        Date.from_iso8601!(booking.complete_date) > Date.from_iso8601!(initial_date) and
          Date.from_iso8601!(booking.complete_date) < Date.from_iso8601!(final_date)
      end)
    end)
    |> Map.values()
  end
end
