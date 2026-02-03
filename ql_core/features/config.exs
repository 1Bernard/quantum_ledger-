# This line is mandatory to fix the "cannot use ExUnit.Case" error.
# autorun: false prevents ExUnit from trying to run its own tests after White-Bread finishes.
ExUnit.start(autorun: false)
# Explicitly load contexts since they are now in nested domain folders
Code.require_file("identity/contexts/tenant_context.exs", __DIR__)

defmodule QLCore.Features.Config do
  @moduledoc """
  Suite configuration for White-Bread.
  Maps the 'Tenant Onboarding' suite to the TenantContext logic.
  """
  use WhiteBread.SuiteConfiguration

  suite(
    name: "Identity",
    context: QLCore.Features.TenantContext,
    feature_paths: ["features/identity/"]
  )
end
