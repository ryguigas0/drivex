defmodule DrivexWeb.DriveView do
  use DrivexWeb, :view

  def render("prot.json", %{user_id: user_id}),
    do: %{
      msg: "THIS IS PROTECTED USER #{user_id}"
    }

  def render("upload.json", %{upload: upload}),
    do: upload
end
