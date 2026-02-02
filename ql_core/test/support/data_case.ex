defmodule QLCore.DataCase do
  @moduledoc """
  This module defines the setup for database-heavy tests.
  It uses the Ecto Sandbox to wrap every test in a transaction.
  """
  use ExUnit.CaseTemplate

  using do
    quote do
      alias QLCore.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import QLCore.DataCase
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(QLCore.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end
end
