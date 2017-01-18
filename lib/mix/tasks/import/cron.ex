defmodule Mix.Tasks.Import.Cron do
  use Mix.Task

  @shortdoc "Import CRON logs"

  def run(_) do
    Mix.Task.run "app.start", []

    path = "/Users/mdarby/Desktop/log-storage/729732-comp-s3700-028/CRON.log"
    File.stream!(path) |> Stream.chunk(50) |> Enum.each(fn chunk ->
      Enum.each(chunk, fn(line) ->
        Digester.Log.parse!(line)
      end)
    end)

    count = Digester.Repo.aggregate(Digester.Log, :count, :id)
    Mix.shell.info "CRON logs: #{count}"
  end
end
