defmodule Digester.Host do
  use Digester.Web, :model

  schema "hosts" do
    field :brand, :string
    field :model, :string
    field :serial, :string
    field :bios, :string
    field :firmware, :string
    field :cpus, :string
    field :disks, :string
    field :nics, :string
    field :raid, :string
    field :ram, :string
    field :os, :string
    field :openstack, :string
    field :software, :string
    field :region, :string
    field :rack_id, :string
    has_many :logs, Digester.Log

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rax_host_id, :rax_account_id, :content])
    |> validate_required([:rax_host_id, :rax_account_id, :content])
  end
end
