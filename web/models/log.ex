require IEx;

defmodule Digester.Log do
  use Digester.Web, :model
  # use Timex

  @doc """
  These module attributes show position of data in a syslog
  """
  @month    0
  @day      1
  @time     2
  @ip       3
  @process  4
  @os       5

  schema "logs" do
    field :command, :string
    field :content, :string
    field :datetime, :string
    field :ip_address, :string
    field :os, :string
    field :process, :string
    field :rax_account_id, :string
    field :rax_host_id, :string
    belongs_to :host, Digester.Host

    timestamps()
  end

  @doc """
  Parse and insert a Syslog entry
  """
  def parse!(syslog) do
    chunks    = String.split(syslog)
    process   = parse_process(chunks) # Update to embedded schema
    changeset = Digester.Log.changeset(%Digester.Log{}, %{
      content: syslog,
      datetime: parse_datetime(chunks),
      command: parse_command(syslog),
      ip_address: parse_ip_address(chunks),
      os: parse_os_name(chunks),
      process: process.id,
      rax_account_id: "1",
      rax_host_id: "1"
    })

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
    |> cast(params, [:rax_host_id, :rax_account_id, :content, :datetime, :ip_address, :os, :process, :command])
    |> validate_required([:rax_host_id, :rax_account_id, :content])
  end

  defp parse_datetime(chunks) do
    month = Enum.at(chunks, @month)
    day   = Enum.at(chunks, @day)
    time  = Enum.at(chunks, @time)

    # Timex.parse!("#{month} #{day} #{time}", "%b %e %H:%M:%S", :strftime)
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
    %{ name: name, id: id }
  end

  defp parse_os_name(chunks) do
    raw_name = Enum.at(chunks, @os)
    [_, name] = Regex.run(~r/(\w+)/, raw_name)
    name
  end

  defp parse_command(syslog) do
    [_, command] = Regex.run(~r/CMD \((.*)\)/, syslog)
    command
  end

end
