defmodule Digester.Repo.Migrations.RenameLogsProcess do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      remove :process
      add :process_info, :map
    end
  end
end
