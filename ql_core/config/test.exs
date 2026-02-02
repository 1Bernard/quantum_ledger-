import Config

# Configure the EventStore for the test environment
# We use a separate database to ensure tests are isolated
config :ql_core, QLCore.EventStore,
  eventstore: [
    database: "quantum_ledger_test",
    username: "postgres",
    password: "postgres_password",
    hostname: "localhost",
    pool_size: 5,
    # In tests, we often want to track events strictly
    column_data_type: :jsonb
  ]

# Configure the Read Model Repo for tests
config :ql_core, QLCore.Repo,
  database: "quantum_ledger_test",
  username: "postgres",
  password: "postgres_password",
  hostname: "localhost",
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# Print only warnings and errors during test
config :logger, level: :warning
