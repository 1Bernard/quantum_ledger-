import Config

# Configure the EventStore for the test environment
# We use a separate database to ensure tests are isolated.
# Note: Connection keys are FLATTENED so the mix tasks can find them.
config :ql_core, QLCore.EventStore,
  column_data_type: "jsonb",
  serializer: Commanded.Serialization.JsonSerializer,
  schema: "event_store",
  database: System.get_env("DB_NAME") || "quantum_ledger_test",
  username: System.get_env("DB_USER") || "postgres",
  password: System.get_env("DB_PASSWORD") || "owusuboa",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool_size: 5,
  show_sensitive_data_on_connection_error: true

# Configure the Read Model Repo for tests
config :ql_core, QLCore.Repo,
  database: System.get_env("DB_NAME") || "quantum_ledger_test",
  username: System.get_env("DB_USER") || "postgres",
  password: System.get_env("DB_PASSWORD") || "owusuboa",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# Print only warnings and errors during test
config :logger, level: :warning
