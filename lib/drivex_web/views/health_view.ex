defmodule DrivexWeb.HealthView do
  use DrivexWeb, :view

  def render("health.json", %{}),
    do: %{
      health: "ok"
    }
end
