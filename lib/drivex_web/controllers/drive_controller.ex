defmodule DrivexWeb.DriveController do
  use DrivexWeb, :controller

  alias Drivex.Drive

  def index(conn, _params) do
    user_id = conn.assigns.user_id

    conn
    |> put_status(:ok)
    |> render("prot.json", %{user_id: user_id})
  end

  def upload_file(conn, %{"upload" => upload}) do
    user_id = conn.assigns.user_id

    with {:ok, upload} <- Drive.create_upload(upload, user_id) do
      conn
      |> put_status(:ok)
      |> render("upload.json", %{upload: upload})
    end
  end
end
