defmodule Digester.PageController do
  use Digester.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end