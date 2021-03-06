defmodule GreatStrides.Repo.Migrations.CreateEngagement do
  use Ecto.Migration

  def change do
    create table(:engagements) do
      add :name, :string
      add :location, :string
      add :start_date, :date
      add :end_date, :date

      timestamps
    end
    create unique_index(:engagements, [:name, :start_date])
  end
end
