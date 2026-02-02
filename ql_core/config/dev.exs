import Config

# Pulling credentials from environment variables with safe defaults
db_user = System.get_env("DB_USER") || "postgres"
db_password = System.get_env("DB_PASSWORD") || "owusuboa"
db_host = System.get_env("DB_HOST") || "localhost"
db_name = System.get_env("DB_NAME") || "quantum_ledger_dev"

# EventStore Dev Settings - FLATTENED (Fixes KeyError :database)
config :ql_core, QLCore.EventStore,
  database: db_name,
  username: db_user,
  password: db_password,
  hostname: db_host,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Read Model Repo Dev Settings
config :ql_core, QLCore.Repo,
  database: db_name,
  username: db_user,
  password: db_password,
  hostname: db_host,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Minimal logging for development
config :logger, :console, format: "[$level] $message\n"
