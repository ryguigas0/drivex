defmodule DrivexWeb.DriveController do
  use DrivexWeb, :controller

  def index(conn, _params) do
    user_id = conn.assigns.user_id

    conn
    |> put_status(:ok)
    |> render("prot.json", %{user_id: user_id})
  end
end
