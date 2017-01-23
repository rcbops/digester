require IEx;

defmodule Digester.Logs.Cron do
  use Digester.Web, :model

  @doc """
  These module attributes show position of data in a syslog
  """
  @month    0
  @day      1
  @time     2
  @ip       3
  @process  4
  @user     5

  schema "cron_logs" do
    field :content, :string
    field :datetime, :string
    field :ip_address, :string
    field :user, :string
    field :rax_account_id, :string
    field :host_uuid, :string

    embeds_one :process_info, ProcessInfo do
      field :name
      field :process_id
    end

    belongs_to :host, Digester.Host

    timestamps()
  end

  @doc """
  Parse and insert a Syslog entry
  """
  def parse!(syslog) do
    chunks = String.split(syslog)
    params = %{
      content: syslog,
      datetime: parse_datetime(chunks),
      ip_address: parse_ip_address(chunks),
      user: parse_user_name(chunks),
      type: "cron",
      rax_account_id: "1",
      host_uuid: "1"
    }

    changeset = Digester.Logs.Cron.changeset(%Digester.Logs.Cron{}, params)
    |> Ecto.Changeset.put_embed(:process_info, parse_process(chunks))

    case Digester.Repo.insert(changeset) do
      { :ok, log } -> log
      { :error, changeset } -> changeset
    end
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :host_uuid, :rax_account_id, :content, :datetime, :ip_address, :user])
    |> validate_required([:host_uuid, :rax_account_id, :content])
  end

  defp parse_datetime(chunks) do
    month = Enum.at(chunks, @month)
    day   = Enum.at(chunks, @day)
    time  = Enum.at(chunks, @time)
    "#{month} #{day} #{time}"
  end

  defp parse_ip_address(chunks) do
    Enum.at(chunks, @ip)
      |> String.replace("ip-", "")
      |> String.replace("-", ".")
  end

  defp parse_process(chunks) do
    raw_process = Enum.at(chunks, @process)
    [_, name, id] = Regex.run(~r/(\w+)\[(\d+)\]/, raw_process)
    %{ name: name, process_id: id }
  end

  defp parse_user_name(chunks) do
    raw_name = Enum.at(chunks, @user)
    [_, name] = Regex.run(~r/(\w+)/, raw_name)
    name
  end

end
