defmodule QLCore.Identity.Projectors.TenantProjector do
  @moduledoc """
  The Projector listens for TenantCreated events and persists them to the 'tenants' table.
  """
  use Commanded.Projections.Ecto,
    application: QLCore.App,
    repo: QLCore.Repo,
    name: "Identity.TenantProjector",
    consistency: :strong

  alias QLCore.Identity.Events.TenantCreated
  alias QLCore.Identity.Projections.Tenant

  project(%TenantCreated{} = event, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :tenant, %Tenant{
      id: event.tenant_id,
      name: event.name,
      slug: event.slug,
      admin_email: event.admin_email
    })
  end)
end
