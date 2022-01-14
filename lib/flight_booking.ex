defmodule FlightBooking do
  alias FlightBooking.Booking.Builder, as: BookingBuilder
  alias FlightBooking.User.Builder, as: UserBuilder

  defdelegate create_or_update_booking(complete_date, local_origin, local_destination, user_id),
    to: BookingBuilder,
    as: :build

  defdelegate create_or_update_user(name, email, cpf), to: UserBuilder, as: :build
end
