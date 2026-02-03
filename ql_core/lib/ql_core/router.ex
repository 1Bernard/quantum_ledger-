defmodule QLCore.Router do
  @moduledoc """
  Centralizes all command routing for the QuantumLedger system.
  Follows the LedgerFlow pattern for explicit aliases and identity mapping.
  """
  use Commanded.Commands.Router

  # --- Identity Domain ---
  alias QLCore.Identity.Commands.RegisterTenant
  alias QLCore.Identity.Aggregates.Tenant

  # Accounts/Tenants Dispatch
  dispatch [RegisterTenant],
    to: Tenant,
    identity: :tenant_id

  # --- Future Domains (Wallets, Transfers) will be added below ---
end
