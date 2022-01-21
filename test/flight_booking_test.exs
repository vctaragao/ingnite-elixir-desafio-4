defmodule FlightBooking.FlightBookingTest do
  use ExUnit.Case

  alias FlightBooking.Booking.Agent, as: BookingAgent
  alias FlightBooking.User.Agent, as: UserAgent

  import FlightBooking.Factory

  setup_all do
    BookingAgent.start_link(%{})
    UserAgent.start_link(%{})

    on_exit(fn ->
      BookingAgent.clear()
      UserAgent.clear()
    end)

    {:ok, %{}}
  end

  describe "create_or_update_booking/4" do
    test "Criar uma reserva com sucesso" do
      user = build(:user)

      UserAgent.save(user)

      expected_booking = build(:booking, %{complete_date: "17/01/2020", user_id: user.id})

      response =
        FlightBooking.create_or_update_booking(
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

  describe "create_or_update_user/4" do
    test "Criar um usuário com sucesso" do
      expected_user = build(:user)

      response =
        FlightBooking.create_or_update_user(
          expected_user.name,
          expected_user.email,
          expected_user.cpf
        )

      assert response == {:ok, "Usuário salvo ou atualizado"}

      user = UserAgent.get(expected_user.cpf)

      assert expected_user.name == user.name
      assert expected_user.email == user.email
      assert expected_user.cpf == user.cpf
    end
  end

  describe "generate_report/2" do
    test "Gerar um relatório com sucesso" do
      user = build(:user)

      UserAgent.save(user)

      booking = build(:booking, %{complete_date: "2022-02-10", user_id: user.id})

      BookingAgent.save(booking)

      result = FlightBooking.generate_report("01/01/2022", "31/01/2022")

      assert result == :ok
    end
  end

  defp format_to_sql(date) do
    String.split(date, "/")
    |> Enum.reverse()
    |> Enum.join("-")
  end
end
