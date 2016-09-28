defmodule StarWars.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema

  alias StarWars.Database
  require Logger

  import_types StarWars.Schema.Types

  query do

    # field :rebels, :faction do
    #   resolve fn
    #     _, _ ->
    #       Database.get_rebels()
    #   end
    # end

    # field :empire, :faction do
    #   resolve fn
    #     _, _ ->
    #       Database.get_empire()
    #   end
    # end

    field :factions, list_of(:faction) do
      arg :names, list_of(:string)
      resolve fn %{names: names}, _ ->
        Database.get_factions(names)
      end
    end

    node field do
      resolve fn
        %{type: node_type, id: id}, _ ->
          Database.get(node_type, id)
        _, _ ->
          {:ok, nil}
      end
    end

  end

  mutation do
    @desc "Add a ship to a faction"
    payload field :introduce_ship do
      input do
        field :ship_name, non_null(:string)
        field :faction_id, non_null(:id)
      end
      output do
        field :new_ship_edge, :ship_edge
        field :faction, :faction
      end
      resolve &StarWars.Resolver.Ship.add/2
    end
  end

  node interface do
    resolve_type fn
      %{ships: _}, _ ->
        :faction
      _, _ ->
        :ship
    end
  end
end
