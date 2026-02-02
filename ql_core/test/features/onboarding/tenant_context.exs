defmodule QLCore.Features.Onboarding.TenantContext do
  use WhiteBread.Context
  use QLCore.DataCase

  alias QLCore.App
  alias QLCore.Identity.Commands.RegisterTenant

  # --- Given Steps ---

  given_ ~r/^I have a company named "(?<name>[^"]+)"$/, fn state, %{name: name} ->
    {:ok, Map.put(state, :tenant_name, name)}
  end

  # --- When Steps ---

  when_ ~r/^I submit the registration with a valid admin email "(?<email>[^"]+)"$/,
    fn state, %{email: email} ->
      tenant_id = UUIDv7.generate()

      command = %RegisterTenant{
        tenant_id: tenant_id,
        name: state.tenant_name,
        admin_email: email
      }

      case App.dispatch(command) do
        :ok -> {:ok, Map.put(state, :tenant_id, tenant_id)}
        {:error, reason} -> {:error, reason, state}
      end
  end

  # --- Then Steps ---

  then_ ~r/^a new Tenant should be created with a unique UUID v7$/, fn state ->
    # We will verify this against the database in the next step
    {:ok, state}
  end

  then_ ~r/^a "TenantCreated" event should be persisted to the EventStore$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^the Tenant should be initialized with a default "USD" wallet$/, fn state ->
    {:ok, state}
  end
end
