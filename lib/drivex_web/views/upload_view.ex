defmodule DrivexWeb.UploadView do
  use DrivexWeb, :view

  def render("delete.json", %{upload: upload}),
    do: %{
      msg: "UPLOAD #{upload.id} DELETED"
    }

  def render("upload.json", %{upload: upload}),
    do: upload

  def render("many_upload.json", %{uploads: uploads}),
    do: Enum.map(uploads, fn upload -> render("upload.json", %{upload: upload}) end)
end
