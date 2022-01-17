defmodule Drivex.DriveFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Drivex.Drive` context.
  """

  @doc """
  Generate a unique upload path.
  """
  def unique_upload_path, do: "some path#{System.unique_integer([:positive])}"

  @doc """
  Generate a upload.
  """
  def upload_fixture(attrs \\ %{}) do
    {:ok, upload} =
      attrs
      |> Enum.into(%{
        extension: "some extension",
        name: "some name",
        path: unique_upload_path()
      })
      |> Drivex.Drive.create_upload()

    upload
  end
end
