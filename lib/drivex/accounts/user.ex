defmodule Drivex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Drivex.Accounts.Credential

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :name, :profile_pic]}
  schema "users" do
    field :name, :string
    field :profile_pic, :string

    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :profile_pic])
    |> validate_required([:name])
  end
end
