defmodule StarWars.Resolver.Ship do
  alias StarWars.Database
  require Logger

  def add(args, _info) do
    Logger.info("StarWars.Resolver.Ship.add/2: args = #{inspect(args)}")
    fId = args[:faction_id]
    ship = args[:ship_name]
    Logger.info("Looking up faction #{fId}")
    with {:ok, faction} <- Database.get(:faction, fId),
         Logger.info("Found faction #{inspect(faction)}"),
         {:ok, new_ship} <- Database.add_ship(faction, ship),
         Logger.info("Added ship #{inspect(new_ship)}"),
         do: {:ok, %{ship: new_ship, faction: faction}}
  end
end
