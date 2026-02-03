defmodule QLCore.Identity.Aggregates.Tenant do
  @moduledoc """
  The Tenant aggregate root. It manages the lifecycle and business rules for a tenant.
  """
  alias QLCore.Identity.Commands.RegisterTenant
  alias QLCore.Identity.Events.TenantCreated

  defstruct [:id, :name, :slug, :admin_email]

  # --- Command Handlers (Execute) ---

  @doc "Validates registration intent and produces the TenantCreated event."
  def execute(%__MODULE__{id: nil}, %RegisterTenant{} = cmd) do
    # Simple slug generation: downcase and replace non-alphanumeric with hyphens
    slug =
      cmd.name
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9]+/, "-")
      |> String.trim("-")

    %TenantCreated{
      tenant_id: cmd.tenant_id,
      name: cmd.name,
      slug: slug,
      admin_email: cmd.admin_email,
      created_at: DateTime.utc_now()
    }
  end

  # --- State Evolvers (Apply) ---

  @doc "Updates the aggregate state based on the TenantCreated event."
  def apply(%__MODULE__{} = state, %TenantCreated{} = event) do
    %__MODULE__{
      state
      | id: event.tenant_id,
        name: event.name,
        slug: event.slug,
        admin_email: event.admin_email
    }
  end
end
