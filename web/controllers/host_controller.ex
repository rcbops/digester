defmodule Digester.HostController do
  use Digester.Web, :controller

  alias Digester.Host

  def index(conn, _params) do
    hosts = Repo.all(from h in Host, limit: 10)
    render conn, "index.json", hosts: hosts
  end

  def create(conn, params) do
    { :ok, info } = Map.fetch(params, "host")
    host = Host.create!(info)
    render conn, "show.json", host: host
  end
end
