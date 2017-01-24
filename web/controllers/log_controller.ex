require IEx;

defmodule Digester.LogController do
  use Digester.Web, :controller
  alias Digester.Repo
  alias Digester.Logs.Judge

  def index(conn, _params) do
    logs = Repo.all(from l in Digester.Logs.Cron, limit: 10)
    render conn, "index.json", logs: logs
  end

  def create(conn, params) do
    case Map.fetch(params, "log") do
      { :ok, log } ->
        host_uuid = conn.assigns[:host_uuid]
        type      = Judge.type_of(log)
        log       = apply(type, :parse!, [host_uuid, log])
        render conn, "show.json", log: log
      { :error } ->
        put_status(conn, :not_found)
    end
  end
end
