defmodule Drivex.Infra.UploadHandler do
  @upload_store "./assets/"

  def save(file_location, new_name) do
    File.copy(file_location, @upload_store <> new_name)
    |> case do
      {:ok, _} -> :ok
      {:error, _} -> :error
    end
  end

  def remove(name) do
    File.rm(@upload_store <> name)
    |> case do
      :ok -> :ok
      {:error, _} -> :error
    end
  end

  def get_upload_store, do: @upload_store
end
