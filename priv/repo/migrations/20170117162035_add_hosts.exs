defmodule Digester.Repo.Migrations.AddHosts do
  use Ecto.Migration

  def change do
    create table(:hosts) do
      add :brand, :string
      add :model, :string
      add :serial, :string
      add :bios, :string
      add :firmware, :string
      add :cpus, :string
      add :disks, :string
      add :nics, :string
      add :raid, :string
      add :ram, :string
      add :os, :string
      add :openstack, :string
      add :software, :string
      add :region, :string
      add :rack_id, :string
      
      timestamps()
    end
  end
end
