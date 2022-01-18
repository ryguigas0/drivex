defmodule DrivexWeb.UploadController do
  use DrivexWeb, :controller

  alias Drivex.Drive

  def index(conn, _params) do
    user_id = conn.assigns.user_id

    uploads = Drive.list_uploads(user_id)

    conn
    |> put_status(:ok)
    |> render("many_upload.json", %{uploads: uploads})
  end

  def create(conn, %{"upload" => upload}) do
    user_id = conn.assigns.user_id

    with {:ok, upload} <- Drive.create_upload(upload, user_id) do
      conn
      |> put_status(:ok)
      |> render("upload.json", %{upload: upload})
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, upload} <- Drive.delete_upload(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", %{upload: upload})
    end
  end

  def download(conn, %{"id" => id}) do
    with {:ok, download_path} <- Drive.get_upload_path(id) do
      conn
      |> send_download({:file, download_path}, disposition: :attachment)
      |> put_status(:ok)
    end
  end
end
