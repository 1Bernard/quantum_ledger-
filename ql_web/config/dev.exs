import Config

# --- Phoenix Endpoint Configuration ---
config :ql_web, QlWebWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  http: [ip: {127, 0, 0, 1}, port: String.to_integer(System.get_env("PORT") || "4000")],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "63E9dIPRjC66C6Wgvo+M7xoxavOZmQSQqj/ZJtfjyNjcmXJ1b+EByxyFdDp3wCEu",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:ql_web, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:ql_web, ~w(--watch)]}
  ]

# --- Live Reload Configuration ---
config :ql_web, QlWebWeb.Endpoint,
  live_reload: [
    web_console_logger: true,
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/ql_web_web/(?:controllers|live|components|router)/?.*\.(ex|heex)$"
    ]
  ]

# --- Development Features & Routes ---
config :ql_web, dev_routes: true

# --- Logging & Error Handling ---
config :logger, :default_formatter, format: "[$level] $message\n"

# Set a higher stacktrace during development for easier debugging
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# --- LiveView Debugging ---
config :phoenix_live_view,
  # Include debug annotations in rendered markup for easier UI debugging
  debug_heex_annotations: true,
  debug_attributes: true,
  enable_expensive_runtime_checks: true

# --- Mailer & External Services ---
# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
