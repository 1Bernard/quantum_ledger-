defmodule QLCore.Identity.Commands.RegisterTenant do
  @moduledoc """
  Command representing the intent to register a new corporate tenant.
  """
  @enforce_keys [:tenant_id, :name, :admin_email]
  defstruct [:tenant_id, :name, :admin_email]
end
