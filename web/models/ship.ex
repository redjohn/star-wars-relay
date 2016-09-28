defmodule StarWars.Ship do
  use StarWars.Web, :model
  require Logger

  schema "ships" do
    field :name, :string
    belongs_to :faction, StarWars.Faction

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    Logger.info("Ship changeset params: #{inspect(params)}")
    struct
    |> cast(params, [:name, :faction_id])
    |> validate_required([:name, :faction_id])
  end
end
