defmodule Digester.Logs.AudispdController do
  use Digester.Web, :controller
  alias Digester.Repo
  alias Digester.Host

  def index(conn, _params) do
    host = Repo.one(Host, uuid: conn.params["host_id"])
    logs = Ecto.assoc(host, :audispd_logs) |> Repo.all
    render conn, "index.json", logs: logs
  end
end
