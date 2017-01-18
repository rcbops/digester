defmodule Digester.Host do
  use Digester.Web, :model

  schema "hosts" do
    field :brand, :string
    field :model, :string
    field :serial, :string
    field :bios, :string
    field :firmware, :string
    field :region, :string
    field :rack_id, :string

    embeds_many :cpus, CPU do
      field :model
      field :speed
    end

    embeds_many :disks, Disk do
      field :name
      field :model
      field :vendor
      field :device
      field :drivers
      field :size
      field :form_factor
      field :speed
      field :serial_number
    end

    embeds_many :nics, NIC do
      field :model
      field :firmware
    end

    embeds_many :raids, RAID do
      field :layout
      field :firmware
    end

    embeds_many :rams, RAM do
      field :form_factor
      field :size
      field :bank
      field :type
      field :speed
      field :manufacturer
      field :serial_number
    end

    embeds_one :operating_system, OS do
      field :distribution
      field :version
      field :kernel
      field :packages
    end

    embeds_one :openstack, OpenStack do
      field :version
      field :projects
    end

    embeds_many :applications, Application do
      field :name
      field :version
    end

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
