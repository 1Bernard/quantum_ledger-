import Config

# --- General Application Config ---
config :ql_core,
  ecto_repos: [QLCore.Repo],
  generators: [binary_id: true, timestamp_type: :utc_datetime],
  event_stores: [QLCore.EventStore]

# --- EventStore Infrastructure ---
# We keep the Commanded-specific settings here
config :ql_core, QLCore.EventStore,
  column_data_type: :jsonb,
  serializer: Commanded.Serialization.JsonSerializer,
  schema: "event_store",
  adapter: Commanded.EventStore.Adapters.EventStore

# --- Commanded App Configuration ---
config :ql_core, QLCore.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: QLCore.EventStore
  ],
  pubsub: :local,
  registry: :local

# --- Background Processing ---
config :ql_core, Oban,
  repo: QLCore.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10, notifications: 5, webhooks: 20]

# --- JSON Library ---
config :phoenix, :json_library, Jason

# --- Environment Specific Overrides ---
import_config "#{config_env()}.exs"
