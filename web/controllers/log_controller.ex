require IEx;

defmodule Digester.LogController do
  use Digester.Web, :controller
  alias Digester.Repo

  def index(conn, _params) do
    logs = Repo.all(from l in Digester.Logs.Cron, limit: 10)
    render conn, "index.json", logs: logs
  end

  def create(conn, params) do
    { :ok, log } = Map.fetch(params, "log")
    host_uuid = conn.assigns[:host_uuid]

    # TODO: Need to specialize this for Audispd logs.
    log = Digester.Logs.Cron.parse!(host_uuid, log)
    render conn, "show.json", log: log
  end
end
