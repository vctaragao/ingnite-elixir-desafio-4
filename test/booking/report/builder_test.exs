defmodule FlightBooking.Booking.Report.BuilderTest do
  use ExUnit.Case

  import FlightBooking.Factory

  alias FlightBooking.Booking.Agent, as: BookingAgent
  alias FlightBooking.User.Agent, as: UserAgent

  alias FlightBooking.Booking.Report.Builder

  setup_all do
    {:ok, user_id} = generate_user()

    BookingAgent.start_link(%{})

    booking = build(:booking, %{complete_date: "2020-01-20", user_id: user_id})

    BookingAgent.save(booking)

    {:ok, %{}}
  end

  defp generate_user do
    UserAgent.start_link(%{})

    user = build(:user)

    UserAgent.save(user)

    {:ok, user.id}
  end

  describe "build/2" do
    # Melhorias
    # - Tornar teste Idempotente
    # - Fazer assert com dados gerados no arquivo
    # - Criar mais testes para validar que reservas fora do intervalo não são incluidas no relatório
    # - Criar teste para validar se reservas que casem na data inicial ou final, são incluidas
    # - Testar geração do relatório com multiplas reservas sendo encontradas (mais de uma linha)

    test "Com reservas salvas no entre as datas passadas retornar reserva como uma linha no relatório" do
      result = Builder.build("01/01/2022", "31/01/2022")

      assert result == :ok
    end
  end
end
