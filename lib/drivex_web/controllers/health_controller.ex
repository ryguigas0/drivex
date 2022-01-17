defmodule DrivexWeb.HealthController do
  use DrivexWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("health.json")
  end
end
