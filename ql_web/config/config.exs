import Config

# --- General Application Config ---
config :ql_web,
  generators: [timestamp_type: :utc_datetime]

# --- Phoenix Endpoint Configuration ---
# Note: Ensure the module name matches your actual generated app name (e.g., QlWebWeb)
config :ql_web, QlWebWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: QlWebWeb.ErrorHTML, json: QlWebWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: QlWeb.PubSub,
  live_view: [signing_salt: "jUgY9qkn"]

# --- Mailer Configuration ---
config :ql_web, QlWeb.Mailer, adapter: Swoosh.Adapters.Local

# --- Assets: Esbuild ---
config :esbuild,
  version: "0.25.4",
  ql_web: [
    args: ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# --- Assets: Tailwind ---
config :tailwind,
  version: "4.1.7",
  ql_web: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

# --- Logging ---
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# --- Global Parsers ---
config :phoenix, :json_library, Jason

# --- Environment Overrides ---
# THIS MUST REMAIN AT THE VERY BOTTOM AND ONLY APPEAR ONCE.
import_config "#{config_env()}.exs"
