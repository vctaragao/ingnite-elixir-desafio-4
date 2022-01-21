defmodule FlightBooking.Booking.Report.Report do
  @keys [:id, :user_id, :from, :to, :scheduled_date]

  @enforce_keys @keys

  defstruct @keys
end
