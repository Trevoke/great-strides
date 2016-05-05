defmodule GreatStrides.Repo.Migrations.CreateDiaries do
  use Ecto.Migration

  def change do
    create table(:diaries) do
      add :entry, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :engagement_id, references(:engagements, on_delete: :nothing)
      timestamps
    end
  end
end
