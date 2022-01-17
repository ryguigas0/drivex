defmodule DrivexWeb.TokenView do
  use DrivexWeb, :view

  def render("token.json", %{token: token}), do: %{token: token}
end
