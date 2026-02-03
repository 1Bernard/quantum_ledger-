defmodule QLCore.Application do
  @moduledoc """
  The Main Application Supervisor.
  """
  use Application

  @impl true
  def start(_type, _args) do
    # Define children to be supervised
    children = [
      # 1. Start the Read Model Repository (SQL)
      QLCore.Repo,

      # 2. Start the Commanded Application (The Logic Engine)
      QLCore.App,

      # 3. Start the Projectors (Listen for events and update SQL)
      {QLCore.Identity.Projectors.TenantProjector, []},

      # 4. Start Oban for background processing
      {Oban, Application.fetch_env!(:ql_core, Oban)}
    ]

    # Fixed: Using :one_for_one strategy to resolve the deprecation warning
    opts = [strategy: :one_for_one, name: QLCore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
