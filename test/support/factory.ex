defmodule FlightBooking.Factory do
  use ExMachina

  alias FlightBooking.User.User
  alias FlightBooking.Booking.Booking

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Nome",
      email: "email@teste.com",
      cpf: "12345678910"
    }
  end

  def booking_factory do
    %Booking{
      id: UUID.uuid4(),
      complete_date: "2022-01-17",
      origin: "Rio de janeiro",
      destination: "Itajubá",
      user_id: UUID.uuid4()
    }
  end
end
