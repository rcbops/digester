require IEx;

defmodule Digester.LogController do
  use Digester.Web, :controller
  alias Digester.Log
  alias Digester.Repo

  def index(conn, _params) do
    logs = Repo.all(Log)
    render conn, "index.json", logs: logs
  end

  def create(conn, params) do
    { :ok, raw_log } = Map.fetch(params, "log")
    changeset = Log.changeset(%Log{}, %{ rax_host_id: "1", rax_account_id: "1", content: raw_log })

    case Repo.insert(changeset) do
      {:ok, log} ->
        render conn, "show.json", log: log
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
