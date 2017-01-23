defmodule Digester.Repo.Migrations.AddUUIDToHost do
  use Ecto.Migration

  def change do
    alter table(:hosts) do
      add :uuid, :string
      add :rax_account_id, :string
    end

    rename table(:cron_logs), :rax_host_id, to: :host_uuid

    alter table(:audispd_logs) do
      add :host_uuid, :string
    end

    create index(:hosts, [:uuid])
    create index(:hosts, [:rax_account_id])
    create index(:hosts, [:uuid, :rax_account_id])
    create index(:cron_logs, [:host_uuid])
    create index(:audispd_logs, [:host_uuid])
  end
end
