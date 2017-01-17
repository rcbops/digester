defmodule Digester.LogView do
  use Digester.Web, :view

  def render("index.json", %{logs: logs}) do
    render_many(logs, Digester.LogView, "log.json")
  end

  def render("show.json", %{log: log}) do
    render_one(log, Digester.LogView, "log.json")
  end

  def render("log.json", %{log: log}) do
    %{
      rax_account_id: log.rax_account_id,
      rax_host_id: log.rax_host_id,
      content: log.content
    }
  end
end
