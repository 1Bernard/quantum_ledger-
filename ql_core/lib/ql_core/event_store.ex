defmodule QLCore.EventStore do
  @moduledoc """
  The EventStore module for QuantumLedger.
  This module acts as the physical storage engine for all domain events.
  """
  use EventStore, otp_app: :ql_core
end
