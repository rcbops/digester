require IEx

defmodule Digester.HostTest do
  use Digester.ModelCase

  alias Digester.Host
  alias Digester.Repo

  @attributes %{}

  test "setting a UUID" do
    host = Host.create!(@attributes)
    refute host.uuid == ""
  end

  test "associations" do
    uuid = Host.create!(@attributes).uuid
    host = Repo.get_by(Host, uuid: uuid)
    |> Repo.preload(:cron_logs)
    |> Repo.preload(:audispd_logs)

    assert host.cron_logs == []
    assert host.audispd_logs == []
  end

end
