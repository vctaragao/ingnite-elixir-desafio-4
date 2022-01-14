defmodule FlightBooking.Booking.Builder do
  alias FlightBooking.Booking.Booking
  alias FlightBooking.User.Agent, as: UserAgent

  def build(complete_date, origin, destination, user_id) when is_bitstring(complete_date) do
    with true <- String.contains?(complete_date, "/"),
         {:ok, user_id} <- UserAgent.check_user(user_id) do
      %Booking{
        id: UUID.uuid4(),
        complete_date: format_date(complete_date),
        origin: origin,
        destination: destination,
        user_id: user_id
      }
      |> Booking.save_or_update()
    end
  end

  defp format_date(date) do
    String.split(date, "/")
    |> Enum.reverse()
    |> Enum.join("-")
  end
end
