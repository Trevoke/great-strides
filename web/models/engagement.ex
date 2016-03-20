defmodule GreatStrides.Engagement do
  use GreatStrides.Web, :model

  schema "engagements" do
    field :name, :string
    field :location, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date

    timestamps
  end

  @required_fields ~w(name location)
  @optional_fields ~w(start_date end_date)

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
