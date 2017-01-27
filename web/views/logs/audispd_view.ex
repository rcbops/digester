defmodule Digester.Logs.AudispdView do
  use Digester.Web, :view

  def render("index.json", %{logs: logs}) do
    render_many(logs, Digester.Logs.AudispdView, "log.json")
  end

  def render("show.json", %{log: log}) do
    render_one(log, Digester.Logs.AudispdView, "log.json")
  end

  def render("log.json", %{log: log}) do
    %{
      acct: log.acct,
      addr: log.addr,
      auid: log.auid,
      content: log.content,
      datetime: log.datetime,
      exe: log.exe,
      hostname: log.hostname,
      msg: log.msg,
      node: log.node,
      pid: log.pid,
      res: log.res,
      ses: log.ses,
      terminal: log.terminal,
      type: log.type,
      uid: log.uid
    }
  end
end
