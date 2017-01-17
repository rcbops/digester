# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :digester,
  ecto_repos: [Digester.Repo]

# Configures the endpoint
config :digester, Digester.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jj5UirnkFQhoQP7PwfHQt4WYmFOi8tHMxNlN1yNo+RMrFNXk8UtmidA1hgyqnF10",
  render_errors: [view: Digester.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Digester.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
