# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :star_wars,
  ecto_repos: [StarWars.Repo]

# Configures the endpoint
config :star_wars, StarWars.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "c35L1Kl66OMrFi0SuUN84yH7Daru8H6oVWdQD7+dFYNdFeZeukSIkrD2bwUanjBq",
  render_errors: [view: StarWars.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StarWars.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"