defmodule StarWars.Repo.Migrations.CreateFaction do
  use Ecto.Migration

  def change do
    create table(:factions) do
      add :name, :string

      timestamps()
    end

  end
end
