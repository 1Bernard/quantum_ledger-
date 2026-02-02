defmodule QLCore.App do
  @moduledoc """
  The main Commanded Application.
  This module acts as the router, directing commands to the appropriate
  aggregates and managing the event store connection.
  """
  use Commanded.Application,
    otp_app: :ql_core,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: QLCore.EventStore
    ]

  router do
    # Logic for Identity Domain: Tenant Onboarding
    identify QLCore.Identity.Aggregates.Tenant, by: :tenant_id
    dispatch [QLCore.Identity.Commands.RegisterTenant], to: QLCore.Identity.Aggregates.Tenant
  end
end
