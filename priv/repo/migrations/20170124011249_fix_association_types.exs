defmodule Digester.Repo.Migrations.FixAssociationTypes do
  use Ecto.Migration

  def change do
    alter table(:cron_logs) do
      remove :host_id
      add :host_id, :integer
    end

    alter table(:audispd_logs) do
      remove :host_id
      add :host_id, :integer
    end

    create index(:cron_logs, [:host_id])
    create index(:audispd_logs, [:host_id])
  end
end
