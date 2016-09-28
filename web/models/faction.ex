defmodule StarWars.Faction do
  use StarWars.Web, :model

  schema "factions" do
    field :name, :string
    has_many :ships, StarWars.Ship

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
