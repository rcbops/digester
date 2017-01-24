defmodule Digester.Host do
  use Digester.Web, :model

  @valid_attributes [:uuid]
  @required_attributes [:uuid]

  schema "hosts" do
    field :brand, :string
    field :model, :string
    field :serial, :string
    field :bios, :string
    field :firmware, :string
    field :region, :string
    field :rack_id, :string
    field :uuid, :string

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

    has_many :cron_logs, Digester.Logs.Cron
    has_many :audispd_logs, Digester.Logs.Audispd

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_attributes)
    |> validate_required(@valid_attributes)
  end

  def create!(_params) do
    params = %{
      uuid: UUID.uuid1()
    }

    changeset = Digester.Host.changeset(%Digester.Host{}, params)
    # |> Ecto.Changeset.put_embed(:process_info, parse_process(chunks))

    case Digester.Repo.insert(changeset) do
      { :ok, log } -> log
      { :error, changeset } -> changeset
    end
  end
end
