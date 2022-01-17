defmodule Drivex.Drive.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  alias Drivex.Accounts.User

  @fields [:name, :extension, :path, :user_id]

  @derive {Jason.Encoder, only: [:id] ++ @fields}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "uploads" do
    field :extension, :string
    field :name, :string
    field :path, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:path)
  end
end
