defmodule StarWars.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation
  use Timex

  alias Absinthe.Relay.Connection
  alias StarWars.{Database,Repo}

  @moduledoc """
  Graphql Types
  """

  scalar :time, description: "ISOz time" do
    parse fn(timestamp) ->
      {:ok, datetime} = Timex.parse(timestamp, "{s-epoch}")
      datetime
    end
    serialize fn(datetime) ->
      {:ok, timestamp} = Timex.format(datetime, "{s-epoch}")
      String.to_integer(timestamp)
    end
  end

  @desc "A ship in the Star Wars saga"
  node object :ship do

    @desc "The name of the ship."
    field :name, :string

  end

  @desc "A faction in the Star Wars saga"
  node object :faction do

    @desc "The name of the faction"
    field :name, :string

    @desc "The id of the faction"
    field :faction_id, :integer do
      resolve fn _args, %{source: faction} ->
        {:ok, faction.id}
      end
    end

    @desc "The ships used by the faction."
    connection field :ships, node_type: :ship do
      resolve fn resolve_args, %{source: faction} ->
        connection = Connection.from_list(
          Repo.all(Ecto.assoc(faction, :ships)),
          resolve_args
        )
        {:ok, connection}
      end
    end
  end

  # Default
  connection node_type: :ship

end
