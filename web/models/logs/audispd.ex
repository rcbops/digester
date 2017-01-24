require IEx;

defmodule Digester.Logs.Audispd do
  use Digester.Web, :model

  @valid_attributes [:datetime, :node, :type, :msg, :pid, :uid, :auid, :ses,
    :acct, :exe, :hostname, :addr, :terminal, :res, :content, :acct, :host_id]
  @required_attributes [:datetime, :host_id]

  schema "audispd_logs" do
    field :datetime, :string
    field :node, :string
    field :type, :string
    field :msg, :string
    field :pid, :string
    field :uid, :string
    field :auid, :string
    field :ses, :string
    field :acct, :string
    field :exe, :string
    field :hostname, :string
    field :addr, :string
    field :terminal, :string
    field :res, :string
    field :content, :string

    belongs_to :host, Digester.Host, foreign_key: :host_id
  end

  @doc """
  Parse and insert a Audispd entry
  """
  def parse!(host_id, log) do
    params = %{
      acct: parse_attribute("acct", log),
      addr: parse_attribute("addr", log),
      auid: parse_attribute("auid", log),
      content: log,
      datetime: parse_datetime(log),
      exe: parse_attribute("exe", log),
      host_id: host_id,
      hostname: parse_attribute("hostname", log),
      msg: parse_attribute("msg", log),
      node: parse_attribute("node", log),
      pid: parse_attribute("pid", log),
      res: parse_attribute("res", log),
      ses: parse_attribute("ses", log),
      terminal: parse_attribute("terminal", log),
      type: parse_attribute("type", log),
      uid: parse_attribute("uid", log)
    }

    changeset = Digester.Logs.Audispd.changeset(%Digester.Logs.Audispd{}, params)

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
    |> cast(params, @valid_attributes)
    |> validate_required(@required_attributes)
  end

  defp parse_attribute(name, log) do
    { :ok, regex } = Regex.compile("#{name}=([^ ]*)")
    [_, a] = Regex.run(regex, log)
    String.trim(a)
  end

  defp parse_datetime(log) do
    [dt, _] = Regex.run(~r/(\w{3}\s\d{2}\s\d{2}:\d{2}:\d{2})/, log)
    dt
  end

end
