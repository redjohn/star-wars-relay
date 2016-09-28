# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StarWars.Repo.insert!(%StarWars.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
empire = StarWars.Repo.insert!(%StarWars.Faction{name: "Galactic Empire"})
rebels = StarWars.Repo.insert!(%StarWars.Faction{name: "Alliance to Restore the Republic"})

StarWars.Repo.insert!(%StarWars.Ship{name: "X-Wing", faction: rebels})
StarWars.Repo.insert!(%StarWars.Ship{name: "Y-Wing", faction: rebels})
StarWars.Repo.insert!(%StarWars.Ship{name: "A-Wing", faction: rebels})
StarWars.Repo.insert!(%StarWars.Ship{name: "Millenium Falcon", faction: rebels})
StarWars.Repo.insert!(%StarWars.Ship{name: "Home One", faction: rebels})

StarWars.Repo.insert!(%StarWars.Ship{name: "TIE Fighter", faction: empire})
StarWars.Repo.insert!(%StarWars.Ship{name: "TIE Interceptor", faction: empire})
StarWars.Repo.insert!(%StarWars.Ship{name: "Executor", faction: empire})
