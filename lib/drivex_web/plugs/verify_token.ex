defmodule DrivexWeb.Plugs.VerifyToken do
  import Plug.Conn

  alias Phoenix.Controller
  alias DrivexWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{user_id: user_id}} <- Token.verify_token(token) do
      assign(conn, :user_id, user_id)
    else
      {:error, _} -> handle_error(conn)
    end
  end

  defp handle_error(conn) do
    conn
    |> put_status(:unauthorized)
    |> Controller.put_view(DrivexWeb.ErrorView)
    |> Controller.render("unauthorized.json")
    |> halt()
  end
end
