defmodule Drivex.Drive.Folder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Drivex.{Accounts.User, Drive.Upload}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "folders" do
    field :name, :string
    field :child_files, :id

    belongs_to :user, User

    many_to_many :folders, Folder, join_through: "movies_actors"

    has_many :child_uploads, Upload

    timestamps()
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
