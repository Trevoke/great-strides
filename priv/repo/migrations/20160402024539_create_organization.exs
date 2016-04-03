defmodule GreatStrides.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :domain, :string

      timestamps
    end

    create unique_index(:organizations, [:domain])
  end
end
