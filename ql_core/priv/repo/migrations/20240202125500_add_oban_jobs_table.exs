defmodule QLCore.Repo.Migrations.AddObanJobsTable do
  use Ecto.Migration

  def up do
    # This creates the oban_jobs and oban_peers tables
    Oban.Migration.up(version: 11)
  end

  def down do
    Oban.Migration.down()
  end
end
