# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :teetar,
  ecto_repos: [Teetar.Repo]

# Configures the endpoint
config :teetar, TeetarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MVHeQ7gEEDHtlUaSgt6Wc9u4vAnL1/jtAaYzUtKoW2acmdlS30u5c9chNgFFels/",
  render_errors: [view: TeetarWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Teetar.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :teetar, TeetarWeb.Services.Mailer.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.sendgrid.net",
  port: 587,
  username: "apikey",
  password: "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",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
