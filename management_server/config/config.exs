# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :management_server,
  ecto_repos: [ManagementServer.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :management_server, ManagementServerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ManagementServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ManagementServer.PubSub,
  live_view: [signing_salt: "7OobucUm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guarnian
config :management_server, ManagementServerWeb.Auth.Guardian,
  issuer: "management_server",
  secret_key: "NVJODEewQv/7wHAvoeoULFATjtEa15D3hv91cTlh4MxGslQt5Pznbp/0camTe3Ew"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: ManagementServer.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

config :management_server, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ManagementServerWeb.Router,
      endpoint: ManagementServerWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
