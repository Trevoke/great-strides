defmodule GreatStrides.Repo.Migrations.EngagementBelongsToOrganization do
  use Ecto.Migration

  def change do
    alter table :organizations do
      add :engagement_id, references(:engagement, on_delete: :nothing)
    end
  end
end
