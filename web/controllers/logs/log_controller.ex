defmodule Digester.Logs.LogController do
  use Digester.Web, :controller

  alias Digester.Logs.Cron
  alias Digester.Logs.Audispd

  def create(conn, params) do
    case Map.fetch(params, "log") do
      { :ok, log } ->
        host_uuid = conn.assigns[:host_uuid]
        type      = type_of(log)

        # Parse and store the log
        apply(type, :parse!, [host_uuid, log])
        put_status(conn, :ok)
      { :error } ->
        put_status(conn, :not_found)
    end
  end

  defp type_of(log) do
    cond do
      Regex.match?(Cron.matching_regex, log) -> Cron
      Regex.match?(Audispd.matching_regex, log) -> Audispd
    end
  end
end
