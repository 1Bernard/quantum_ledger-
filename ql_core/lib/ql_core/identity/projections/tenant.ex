defmodule QLCore.Identity.Projections.Tenant do
  @moduledoc """
  Ecto schema for the 'tenants' read model table.
  This is the structure used for querying data in the SQL database.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "tenants" do
    field :name, :string
    field :admin_email, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(tenant, attrs) do
    tenant
    |> cast(attrs, [:id, :name, :admin_email, :slug])
    |> validate_required([:id, :name, :admin_email])
    |> unique_constraint(:admin_email)
  end
end
