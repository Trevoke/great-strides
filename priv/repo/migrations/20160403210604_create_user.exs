defmodule GreatStrides.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_table :users do
      add :organization_id, references(:organizations, on_delete: :nothing)
      add :engagement_id, references(:engagements, on_delete: :nothing)
      add :username, :string

      timestamps
    end
  end
end
