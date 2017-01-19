require IEx;

defmodule Digester.LogController do
  use Digester.Web, :controller
  alias Digester.Repo

  def index(conn, _params) do
    logs = Repo.all(from l in Digester.Logs.Cron, limit: 10)
    render conn, "index.json", logs: logs
  end

  def create(conn, params) do
    { :ok, syslog } = Map.fetch(params, "log")
    log = Digester.Logs.Cron.parse!(syslog)
    render conn, "show.json", log: log
  end
end
