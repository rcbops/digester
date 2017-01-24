require IEx

defmodule Digester.Logs.Judge do

  alias Digester.Logs.Cron
  alias Digester.Logs.Audispd

  def type_of(log) do
    cond do
      Regex.match?(Cron.matching_regex, log) -> Cron
      Regex.match?(Audispd.matching_regex, log) -> Audispd
    end
  end

end
