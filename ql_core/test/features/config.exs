defmodule QLCore.Features.Config do
  use WhiteBread.SuiteConfiguration

  suite name: "Tenant Onboarding",
        context: QLCore.Features.Onboarding.TenantContext,
        feature_paths: ["features/onboarding/"]
end
