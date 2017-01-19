defmodule Digester.Repo.Migrations.ReworkSchema do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      remove :type
    end

    rename table(:logs), to: table(:cron_logs)
  end
end
