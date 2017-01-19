require IEx;

defmodule Digester.Logs.Audispd do
  use Digester.Web, :model

  @valid_attributes [:datetime, :node, :type, :msg, :pid, :uid, :auid, :ses,
    :acct, :exe, :hostname, :addr, :terminal, :res, :content]
  @required_attributes [:datetime, :node, :type, :msg, :pid, :uid, :auid, :ses,
    :acct, :exe, :hostname, :addr, :terminal, :res, :content]

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

    belongs_to :host, Digester.Host
  end

  @doc """
  Parse and insert a Audispd entry
  """
  def parse!(log) do
    params = %{
      content: log,
      datetime: parse_datetime(log)
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
    |> validate_required([])
  end

  defp parse_datetime(log) do
    [dt, _] = Regex.run(~r/(\w{3}\s\d{2}\s\d{2}:\d{2}:\d{2})/, log)
    dt
  end

end
