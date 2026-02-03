defmodule QLCore.Identity.Events.TenantCreated do
  @moduledoc """
  Domain event emitted when a tenant registration is successfully processed.
  Deriving Jason.Encoder is necessary for persistence in the EventStore as JSONB.
  """
  @derive [Jason.Encoder]
  defstruct [:tenant_id, :name, :admin_email, :slug, :created_at]
end
