defmodule Digester.Repo.Migrations.AddCommandToLogs do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :command, :text
    end
  end
end
