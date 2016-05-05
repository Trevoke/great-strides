defmodule GreatStrides.Diary do
  use GreatStrides.Web, :model

  schema "diaries" do
    field :entry, :string
    belongs_to :user, GreatStrides.User
    belongs_to :engagement, GreatStrides.Engagement
    timestamps
  end

  @required_fields ~w(entry user_id engagement_id)
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
