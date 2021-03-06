defmodule GreatStrides.User do
  use GreatStrides.Web, :model

  schema "users" do
    field :username, :string
    belongs_to :engagement, GreatStrides.Engagement
    belongs_to :organization, GreatStrides.Organization
    timestamps
  end

  @required_fields ~w(username)
  @optional_fields ~w(engagement_id organization_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
  end
end
