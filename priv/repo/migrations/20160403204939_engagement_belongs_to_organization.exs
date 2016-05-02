defmodule GreatStrides.Repo.Migrations.EngagementBelongsToOrganization do
  use Ecto.Migration

  def change do
    alter table :engagements do
      add :organization_id, references(:organizations, on_delete: :nothing)
    end
  end
end
