defmodule FlightBooking.Helper.Date do
  def validate_date(date) do
    if String.contains?(date, "/") do
      {:ok, format_date(date)}
    else
      {:error, "Formato de data inválido"}
    end
  end

  def format_date(date) do
    String.split(date, "/")
    |> Enum.reverse()
    |> Enum.join("-")
  end
end
