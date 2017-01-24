defmodule Digester.Repo.Migrations.RemoveRaxAccountIDFromCronLogs do
  use Ecto.Migration

  def change do
    alter table(:cron_logs) do
      remove :rax_account_id
    end
  end
end
