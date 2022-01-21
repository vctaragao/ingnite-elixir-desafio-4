defmodule FlightBooking.Booking.Report.BuilderTest do
  use ExUnit.Case

  import FlightBooking.Factory

  alias FlightBooking.Booking.Agent, as: BookingAgent
  alias FlightBooking.User.Agent, as: UserAgent

  alias FlightBooking.Booking.Report.Builder

  setup_all do
    {:ok, user_id} = generate_user()

    BookingAgent.start_link(%{})

    {:ok, booking: build(:booking, %{complete_date: "20/01/2020", user_id: user_id})}
  end

  defp generate_user do
    UserAgent.start_link(%{})

    user = build(:user)

    UserAgent.save(user)

    {:ok, user.id}
  end

  describe "build/2" do
    test "With reservation in between valid dates return reservations in a list" do
      result = Builder.build("01/01/2022", "31/01/2022")

      assert result == :ok
    end
  end
end
