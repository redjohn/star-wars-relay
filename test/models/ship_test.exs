defmodule StarWars.ShipTest do
  use StarWars.ModelCase

  alias StarWars.Ship

  @valid_attrs %{faction_id: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ship.changeset(%Ship{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ship.changeset(%Ship{}, @invalid_attrs)
    refute changeset.valid?
  end
end
