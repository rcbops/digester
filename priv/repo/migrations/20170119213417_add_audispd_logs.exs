defmodule Digester.Repo.Migrations.AddAudispdLogs do
  use Ecto.Migration

  def change do
    create table(:audispd_logs) do
      add :datetime, :string
      add :node, :string
      add :type, :string
      add :msg, :string
      add :pid, :string
      add :uid, :string
      add :auid, :string
      add :ses, :string
      add :acct, :string
      add :exe, :string
      add :hostname, :string
      add :addr, :string
      add :terminal, :string
      add :res, :string
      add :content, :text
      timestamps()
    end
  end
end
