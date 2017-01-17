require IEx;

defmodule Digester.Log do
  use Digester.Web, :model
  use Timex

  @doc """
  These module attributes show position of data in a syslog
  """
  @month    0
  @day      1
  @time     2
  @ip       3
  @process  4
  @os       5
  @cmd      6

  schema "logs" do
    field :rax_host_id, :string
    field :rax_account_id, :string
    field :content, :string
    belongs_to :host, Digest.Host

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

  @doc """
  Parse the timestamp into a Timex object
  """
  def parse_datetime(syslog) do
    chunks = String.split(syslog)
    month  = Enum.at(chunks, @month)
    day    = Enum.at(chunks, @day)
    time   = Enum.at(chunks, @time)

    Timex.parse!("#{month} #{day} #{time}", "%b %e %H:%M:%S", :strftime)
  end

  @doc """
  Parse the IP address
  """
  def parse_ip_address(syslog) do
    chunks = String.split(syslog)
    Enum.at(chunks, @ip)
      |> String.replace("ip-", "")
      |> String.replace("-", ".")
  end

  @doc """
  Parse the process name and ID
  """
  def parse_process(syslog) do
    chunks = String.split(syslog)
    raw_process = Enum.at(chunks, @process)
    [_raw, name, id] = Regex.run(~r/(\w+)\[(\d+)\]/, raw_process)
    %{ name: name, id: id }
  end

  @doc """
  Parse the OS name
  """
  def parse_os_name(syslog) do
    chunks = String.split(syslog)
    raw_name = Enum.at(chunks, @os)
    [_raw, name] = Regex.run(~r/(\w+)/, raw_name)
    name
  end

  @doc """
  Parse the command
  """
  def parse_command(syslog) do
    chunks = String.split(syslog)
    [_raw, command] = Regex.run(~r/CMD \((.*)\)/, syslog)
    command
  end

end
