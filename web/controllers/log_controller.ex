require IEx;

defmodule Digester.LogController do
  use Digester.Web, :controller
  alias Digester.Log
  alias Digester.Repo

  def index(conn, _params) do
    logs = Repo.all(from l in Log, limit: 10)
    render conn, "index.json", logs: logs
  end

  def create(conn, params) do
    { :ok, syslog } = Map.fetch(params, "log")
    log = Digester.Log.parse!(syslog)
    render conn, "show.json", log: log
  end
end
