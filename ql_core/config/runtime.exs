import Config

# config/runtime.exs is executed for all environments (dev, test, prod)
# at the moment the application starts.

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: postgres://user:password@host/database
      """

  config :ql_core, QLCore.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :ql_core, QLCore.EventStore,
    eventstore: [
      url: database_url,
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
    ]

  # Prefixing with underscore to silence the warning until ql_web
  # consumes this via environment variables.
  _secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "environment variable SECRET_KEY_BASE is missing."
end
