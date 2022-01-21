defmodule FlightBooking.Booking.Report.Builder do
  import FlightBooking.Helper.Date

  alias FlightBooking.Booking.Booking
  alias FlightBooking.Booking.Agent, as: BookingAgent

  @file_path "relatorios/relatorio.csv"

  def build(inital_date, final_date) do
    with {:ok, initial_date} <- validate_date(inital_date),
         {:ok, final_date} <- validate_date(final_date) do
      BookingAgent.findInBetween(initial_date, final_date)
      |> generate_report()
    end
  end

  defp generate_report(bookings) do
    {:ok, file} = File.open(@file_path, [:append, :utf8])

    bookings
    |> Enum.each(fn booking -> format_line(booking) |> insert_line(file) end)

    File.close(file)
  end

  defp format_line(%Booking{} = booking) do
    "#{booking.user_id},#{booking.origin},#{booking.destination},#{booking.complete_date}\n"
  end

  defp insert_line(line, file) do
    IO.write(file, line)
  end
end
