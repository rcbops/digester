defmodule Digester.Repo.Migrations.AddTypeToLogs do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :type, :string
    end

    create index(:logs, [:type, :rax_host_id])
    create index(:logs, [:type, :rax_account_id])
  end
end
