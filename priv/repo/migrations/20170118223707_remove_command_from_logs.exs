defmodule Digester.Repo.Migrations.RemoveCommandFromLogs do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      remove :command
    end
  end
end
