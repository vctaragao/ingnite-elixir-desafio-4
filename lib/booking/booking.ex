defmodule FlightBooking.Booking.Booking do
  alias FlightBooking.Booking.Agent, as: AgentBooking

  @keys [:id, :complete_date, :origin, :destination, :user_id]

  @enforce_keys @keys

  defstruct @enforce_keys

  def save_or_update(%__MODULE__{} = booking) do
    AgentBooking.save(booking)
    {:ok, %{message: "Reserva salva ou atualizada", booking_id: booking.id}}
  end
end
