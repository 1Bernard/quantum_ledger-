defmodule QLCore.App do
  @moduledoc """
  The main Commanded Application.
  This module acts as the logic engine, delegating routing to QLCore.Router.
  """
  use Commanded.Application,
    otp_app: :ql_core,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: QLCore.EventStore
    ]

  # Delegate routing to the dedicated Router module
  router(QLCore.Router)
end
