defmodule FlightBooking.Booking.BuilderTest do
  use ExUnit.Case

  alias FlightBooking.Booking.Builder
  alias FlightBooking.Booking.Agent, as: BookingAgent

  alias FlightBooking.User.Agent, as: UserAgent

  import FlightBooking.Factory

  setup_all do
    {:ok, user_id} = generate_user()

    BookingAgent.start_link(%{})

    on_exit(fn ->
      BookingAgent.clear()
      UserAgent.clear()
    end)

    {:ok, booking: build(:booking, %{complete_date: "17/01/2020", user_id: user_id})}
  end

  defp generate_user do
    UserAgent.start_link(%{})

    user = build(:user)

    UserAgent.save(user)

    {:ok, user.id}
  end

  describe "build/4" do
    test "Criar uma reserva com sucesso", setup do
      expected_booking = setup[:booking]

      response =
        Builder.build(
          expected_booking.complete_date,
          expected_booking.origin,
          expected_booking.destination,
          expected_booking.user_id
        )

      expected_booking = %{
        expected_booking
        | complete_date: format_to_sql(expected_booking.complete_date)
      }

      assert {:ok, %{message: "Reserva salva ou atualizada", booking_id: booking_id}} = response

      booking = BookingAgent.get(booking_id)

      assert expected_booking.complete_date == booking.complete_date
      assert expected_booking.origin == booking.origin
      assert expected_booking.destination == booking.destination
      assert expected_booking.user_id == booking.user_id
    end
  end

  defp format_to_sql(date) do
    String.split(date, "/")
    |> Enum.reverse()
    |> Enum.join("-")
  end
end
