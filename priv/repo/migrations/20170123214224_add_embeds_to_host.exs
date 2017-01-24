defmodule Digester.Repo.Migrations.AddEmbedsToHost do
  use Ecto.Migration

  def change do
    alter table(:hosts) do
      add :raids, :text
      add :rams, :text
      add :operating_system, :text
      add :applications, :text
    end
  end
end
