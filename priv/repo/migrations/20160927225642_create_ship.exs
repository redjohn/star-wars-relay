defmodule StarWars.Repo.Migrations.CreateShip do
  use Ecto.Migration

  def change do
    create table(:ships) do
      add :name, :string
      add :faction_id, :integer

      timestamps()
    end

  end
end
