defmodule FlightBooking.Booking.Booking do
  @keys [:id, :complete_date, :local_origin, :local_destination, :user_id]

  @enforce_keys @keys

  defstruct @enforce_keys
end
