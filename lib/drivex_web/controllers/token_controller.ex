defmodule DrivexWeb.TokenController do
  use DrivexWeb, :controller

  alias DrivexWeb.Token

  def create(conn, %{"email" => email, "password" => password}) do
    token = Token.create_token(email, password)

    conn
    |> put_status(:ok)
    |> render("token.json", %{token: token})
  end
end
