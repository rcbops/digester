defmodule Digester.Repo.Migrations.RenameOSToUser do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      remove :os
      add :user, :string
    end
  end
end
