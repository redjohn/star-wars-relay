defmodule StarWars.Database do
  alias Absinthe.Flag
  alias StarWars.{Faction, Repo, Ship}
  import Ecto.Query
  require Logger

  @xwing %{
    id: "1",
    name: "X-Wing"
  }

  @ywing %{
    id: "2",
    name: "Y-Wing",
  }

  @awing %{
    id: "3",
    name: "A-Wing",
  }

  # Yeah, technically it's Corellian. But it flew in the service of the rebels,
  # so for the purposes of this demo it"s a rebel ship.
  @falcon %{
    id: "4",
    name: "Millenium Falcon"
  }

  @home_one %{
    id: "5",
    name: "Home One"
  }

  @tie_fighter %{
    id: "6",
    name: "TIE Fighter"
  }

  @tie_interceptor %{
    id: "7",
    name: "TIE Interceptor"
  }

  @executor %{
    id: "8",
    name: "Executor"
}

  @rebels %{
    id: "1",
    faction_id: "1",
    name: "Alliance to Restore the Republic",
    ships: ["1", "2", "3", "4", "5"]
  }

  @empire %{
    id: "2",
    faction_id: "2",
    name: "Galactic Empire",
    ships: ["6", "7", "8"]
  }

  @data %{
    faction: %{
      "1" => @rebels,
      "2" => @empire
    },
    ship: %{
      "1" => @xwing,
      "2" => @ywing,
      "3" => @awing,
      "4" => @falcon,
      "5" => @home_one,
      "6" => @tie_fighter,
      "7" => @tie_interceptor,
      "8" => @executor
    }
  }

  def data, do: @data

  def get(:faction, id), do: {:ok, get_faction(id)}

  def get(:ship, id), do: {:ok, Repo.get!(Ship, id)}

  def get_faction(id) do
    Repo.one!(from f in Faction, where: f.id == ^id, preload: [:ships])
  end

  def get_factions(names) do
    factions = names |> Enum.map(fn
      "rebels" -> get_faction(2)
      "empire" -> get_faction(1)
      _name -> nil
    end)
    Logger.info("Got Factions for #{inspect(names)}: #{inspect(factions)}")
    {:ok, factions}
  end

  def add_ship(faction, ship_name) do
    query = from s in Ship, select: count(s.id), where: fragment("name ILIKE ?", ^ship_name)
    ship_exists = Repo.one!(query) > 0
    if ship_exists do
      Logger.info("Ship #{ship_name} already exists")
      {:ok, nil}
    else
      new_ship = Repo.insert!(Ship.changeset(%Ship{}, %{name: ship_name, faction_id: faction.id}))
      Logger.info("Added new ship #{inspect(new_ship)}")
      {:ok, new_ship}
    end
  end
end
