defmodule Digester.Repo.Migrations.AddLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :host_id, :string
      add :rax_host_id, :string
      add :rax_account_id, :string
      add :content, :text

      timestamps()
    end
  end
end
