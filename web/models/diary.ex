defmodule GreatStrides.Diary do
  use GreatStrides.Web, :model

  schema "users" do
    field :date, Ecto.Date
    field :entry, :string
    belongs_to :user, GreatStrides.User
    belongs_to :engagement, GreatStrides.Engagement
    timestamps
  end

  @required_fields ~w(date user engagement)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
