defmodule DrivexWeb.UserController do
  use DrivexWeb, :controller

  alias Drivex.Accounts

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user})
    end
  end

  def show(conn, %{"id" => user_id}) do
    user = Accounts.get_user!(user_id)

    conn
    |> put_status(:ok)
    |> render("show.json", %{user: user})
  end
end
