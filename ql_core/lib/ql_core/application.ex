defmodule QlCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # 1. Start the Read Model Repository (Projections)
      QLCore.Repo,

      # 2. Start the EventStore (Persistence)
      QLCore.EventStore,

      # 3. Start the Commanded Application (The Logic Engine)
      QLCore.App,

      # 4. Start Oban for background jobs (emails, webhooks)
      {Oban, Application.fetch_env!(:ql_core, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QlCore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
