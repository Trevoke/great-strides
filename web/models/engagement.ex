defmodule GreatStrides.Engagement do
  use GreatStrides.Web, :model

  schema "engagements" do
    field :name, :string
    field :location, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    has_many :users, GreatStrides.User
    has_many :diaries, GreatStrides.Diary
    belongs_to :organization, GreatStrides.Organization

    timestamps
  end

  @required_fields ~w(name organization_id)
  @optional_fields ~w(start_date end_date location)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
  end
end
