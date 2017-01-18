defmodule Digester.Repo.Migrations.UpdateLogProcess do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      remove :process
      add :process, :map
    end
  end
end
