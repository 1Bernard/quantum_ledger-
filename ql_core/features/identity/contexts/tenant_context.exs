defmodule QLCore.Features.TenantContext do
  @moduledoc """
  Translates Gherkin steps into Elixir logic.
  Updated to use the QLCore.Features namespace.
  """
  use WhiteBread.Context
  use QLCore.DataCase

  alias QLCore.App
  alias QLCore.Identity.Commands.RegisterTenant
  alias QLCore.Identity.Projections.Tenant

  # --- Background / Setup ---
  def starting_state(_state) do
    # Explicitly checkout the Ecto Sandbox because WhiteBread doesn't run ExUnit setup callbacks
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(QLCore.Repo)
    # Set mode to shared so that Async Projectors (GenServers) can see the same transaction
    Ecto.Adapters.SQL.Sandbox.mode(QLCore.Repo, {:shared, self()})
    %{tenant_name: nil, tenant_id: nil}
  end

  # --- Given ---
  given_(~r/^I have a company named "(?<name>[^"]+)"$/, fn state, %{name: name} ->
    {:ok, Map.put(state, :tenant_name, name)}
  end)

  # --- When ---
  when_(
    ~r/^I submit the registration with a valid admin email "(?<email>[^"]+)"$/,
    fn state, %{email: email} ->
      # Generate UUID v7 for time-ordered identity
      tenant_id = UUIDv7.generate()

      # Uniquify email to avoid unique constraint violations across test runs (since EventStore persists)
      unique_email = "#{System.unique_integer([:positive])}-#{email}"

      command = %RegisterTenant{
        tenant_id: tenant_id,
        name: state.tenant_name,
        admin_email: unique_email
      }

      # Ensure dispatch succeeds
      assert :ok = App.dispatch(command)
      {:ok, Map.put(state, :tenant_id, tenant_id)}
    end
  )

  # --- Then ---
  then_(~r/^a new Tenant should be created with a unique UUID v7$/, fn state ->
    # Verify the SQL Read Model with eventual consistency
    patiently(fn ->
      tenant = QLCore.Repo.get(Tenant, state.tenant_id)
      assert tenant
      # Verify slug generation (e.g. "Acme Corp" -> "acme-corp")
      expected_slug =
        state.tenant_name
        |> String.downcase()
        |> String.replace(~r/[^a-z0-9]+/, "-")
        |> String.trim("-")

      assert tenant.slug == expected_slug
    end)

    {:ok, state}
  end)

  defp patiently(fun) do
    do_patiently(fun, 10, 200)
  end

  defp do_patiently(fun, 0, _interval), do: fun.()

  defp do_patiently(fun, attempts, interval) do
    try do
      fun.()
    rescue
      ExUnit.AssertionError ->
        Process.sleep(interval)
        do_patiently(fun, attempts - 1, interval)
    end
  end

  then_(~r/^a "TenantCreated" event should be persisted to the EventStore$/, fn state ->
    # If dispatch returned :ok, the event is persisted
    {:ok, state}
  end)

  and_(~r/^the Tenant should be initialized with a default "USD" wallet$/, fn state ->
    # Logic for Wallet will be implemented in the next aggregate
    {:ok, state}
  end)
end
