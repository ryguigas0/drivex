defmodule DrivexWeb.UserView do
  use DrivexWeb, :view

  def render("show.json", %{user: user}), do: user
end
