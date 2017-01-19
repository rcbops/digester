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
      content: log.content,
      datetime: log.datetime,
      ip_address: log.ip_address,
      user: log.user,
      rax_account_id: log.rax_account_id,
      rax_host_id: log.rax_host_id,
      process_info: log.process_info,
      type: log.type
    }
  end
end
