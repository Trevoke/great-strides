defmodule GreatStrides.Organization do
  use GreatStrides.Web, :model

  schema "organizations" do
    field :domain, :string
    has_many :engagements, GreatStrides.Engagement
    has_many :users, GreatStrides.User
    timestamps
  end

  @required_fields ~w(domain)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:domain)
  end
end
