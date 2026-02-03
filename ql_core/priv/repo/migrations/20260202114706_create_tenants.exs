defmodule QLCore.Repo.Migrations.CreateTenants do
  use Ecto.Migration

  def change do
    create table(:tenants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :admin_email, :string, null: false
      add :slug, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tenants, [:admin_email])
  end
end
