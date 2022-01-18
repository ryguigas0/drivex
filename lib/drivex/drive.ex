defmodule Drivex.Drive do
  @moduledoc """
  The Drive context.
  """

  import Ecto.Query, warn: false
  alias Drivex.Repo

  alias Drivex.{Drive.Upload, Infra.UploadHandler}

  @doc """
  Returns the list of uploads.

  ## Examples

      iex> list_uploads()
      [%Upload{}, ...]

  """
  def list_uploads(user_id) do
    query = from u in Upload, where: u.user_id == ^user_id

    Repo.all(query)
  end

  @doc """
  Gets a single upload.

  Raises `Ecto.NoResultsError` if the Upload does not exist.

  ## Examples

      iex> get_upload!(123)
      %Upload{}

      iex> get_upload!(456)
      ** (Ecto.NoResultsError)

  """
  def get_upload!(id), do: Repo.get!(Upload, id)

  def get_upload_path(id) do
    path = get_upload!(id) |> Map.get(:path, nil)

    case path do
      nil ->
        {:error, :not_found}

      path ->
        download_path = UploadHandler.get_upload_store() <> path
        {:ok, download_path}
    end
  end

  @doc """
  Creates a upload.

  ## Examples

      iex> create_upload(%{field: value})
      {:ok, %Upload{}}

      iex> create_upload(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_upload(%Plug.Upload{} = upload, user_id) do
    name = upload.filename
    rand_name = gen_rand_name(name)

    with :ok <- UploadHandler.save(upload.path, rand_name) do
      attrs = %{
        name: name,
        extension: name |> String.split(".", trim: true) |> List.last(),
        path: rand_name,
        user_id: user_id
      }

      %Upload{}
      |> Upload.changeset(attrs)
      |> Repo.insert()
    else
      :error -> {:error, :upload_error}
    end
  end

  @doc """
  Updates a upload.

  ## Examples

      iex> update_upload(upload, %{field: new_value})
      {:ok, %Upload{}}

      iex> update_upload(upload, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_upload(%Upload{} = upload, attrs) do
    upload
    |> Upload.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a upload.

  ## Examples

      iex> delete_upload(upload)
      {:ok, %Upload{}}

      iex> delete_upload(upload)
      {:error, %Ecto.Changeset{}}

  """
  def delete_upload(upload_id) do
    upload = get_upload!(upload_id)
    :ok = UploadHandler.remove(upload.path)
    Repo.delete(upload)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking upload changes.

  ## Examples

      iex> change_upload(upload)
      %Ecto.Changeset{data: %Upload{}}

  """
  def change_upload(%Upload{} = upload, attrs \\ %{}) do
    Upload.changeset(upload, attrs)
  end

  @valid_digits ~w/0 1 2 3 4 5 6 7 8 9/

  defp gen_rand_name(name) do
    rand_nums =
      Time.utc_now()
      |> Time.to_string()
      |> String.split("", trim: true)
      |> Enum.filter(fn n -> Enum.member?(@valid_digits, n) end)
      |> Enum.join()

    rand_nums <> name
  end
end
