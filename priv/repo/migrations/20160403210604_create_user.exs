defmodule GreatStrides.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_table :users do
      add :organization_id, references(:organization, on_delete: :nothing)
      add :engagement_id, references(:engagement, on_delete: :nothing)
      add :username, :string

      timestamps
    end
  end
end
