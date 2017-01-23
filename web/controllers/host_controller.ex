defmodule Digester.HostController do
  use Digester.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    { :ok, info } = Map.fetch(params, "host")
    host = Digester.Host.create!(info)
    render conn, "show.json", host: host
  end
end
