defmodule FlightBooking.Booking.Builder do
  alias FlightBooking.Booking.Booking
  alias FlightBooking.User.Agent, as: UserAgent

  def build(complete_date, origin, destination, user_id) when is_bitstring(complete_date) do
    with {:ok, complete_date} <- validate_date(complete_date),
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

  defp validate_date(date) do
    if String.contains?(date, "/") do
      {:ok, date}
    else
      {:error, "Formato de data inválido"}
    end
  end
end
