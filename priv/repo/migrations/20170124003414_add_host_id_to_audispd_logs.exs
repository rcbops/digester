defmodule Digester.Repo.Migrations.AddHostIDToAudispdLogs do
  use Ecto.Migration

  def change do
    alter table(:audispd_logs) do
      add :host_id, :string
    end

    create index(:audispd_logs, [:host_id])
  end
end
