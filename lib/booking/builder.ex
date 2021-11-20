defmodule FlightBooking.Booking.Builder do
  alias FlightBooking.Booking.Booking

  def build(complete_date, local_origin, local_destination, user_id) do
    %Booking{
      id: UUID.uuid4(),
      complete_date: complete_date,
      local_origin: local_origin,
      local_destination: local_destination,
      user_id: user_id
    }
  end
end
