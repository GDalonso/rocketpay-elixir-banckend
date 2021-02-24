defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(conn, %{"filename" => arquivo}) do
    arquivo
    |> Numbers.acc_file_values()
    |> handle_response(conn)
  end
  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "HUE HUE HUE SUM = #{result}"})

  end
  defp handle_response({:error, error_context}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(error_context)

  end
end
