defmodule Drivex.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :extension, :string
      add :path, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:uploads, [:path, :user_id])
  end
end
