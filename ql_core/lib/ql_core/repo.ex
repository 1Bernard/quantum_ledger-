defmodule QLCore.Repo do
  @moduledoc """
  The Ecto Repository for the Read Model (Projections).
  This handles standard SQL queries for the UI and Dashboards.
  """
  use Ecto.Repo,
    otp_app: :ql_core,
    adapter: Ecto.Adapters.Postgres
end
