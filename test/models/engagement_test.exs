defmodule GreatStrides.EngagementTest do
  use GreatStrides.ModelCase

  alias GreatStrides.Engagement

  @valid_attrs %{end_date: "2010-04-17", location: "some content", name: "some content", start_date: "2010-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Engagement.changeset(%Engagement{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Engagement.changeset(%Engagement{}, @invalid_attrs)
    refute changeset.valid?
  end
end
