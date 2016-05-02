defmodule GreatStrides.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table :users do
      add :organization_id, references(:organizations, on_delete: :nothing)
      add :engagement_id, references(:engagements, on_delete: :nothing)
      add :username, :string

      timestamps
    end
    create unique_index(:users, [:username])
  end
end
