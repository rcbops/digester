defmodule Digester.Logs.CronView do
  use Digester.Web, :view

  def render("index.json", %{logs: logs}) do
    render_many(logs, Digester.Logs.CronView, "log.json")
  end

  def render("show.json", %{log: log}) do
    render_one(log, Digester.Logs.CronView, "log.json")
  end

  def render("log.json", %{log: log}) do
    %{
      content: log.content,
      datetime: log.datetime,
      ip_address: log.ip_address,
      user: log.user,
      host_uuid: log.host_uuid,
      process_info: log.process_info
    }
  end
end
