defmodule Digester.Repo.Migrations.AddFieldsToLog do
  use Ecto.Migration

  def change do
    alter table(:logs) do
      add :datetime, :string
      add :ip_address, :string
      add :process, :string
      add :os, :string
    end
  end
end
