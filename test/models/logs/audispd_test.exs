require IEx

defmodule Digester.Logs.AudispdTest do
  use Digester.ModelCase

  alias Digester.Logs.Audispd
  alias Digester.Host

  @log """
  Jan 15 10:47:01 727405-object-disk-033 audispd: node=727405-object-disk-033 type=USER_START msg=audit(1484477221.034:938164/: pid=5400 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_open acct="root" exe="/usr/sbin/cron" hostname=? addr=? terminal=cron res=success'
  """

  test "parsing" do
    host = Host.create!(%{})
    log = Audispd.parse!(host.uuid, @log)
    assert log.acct == "\"root\""
    assert log.addr == "?"
    assert log.content == @log
    assert log.datetime == "Jan 15 10:47:01"
    assert log.exe == "\"/usr/sbin/cron\""
    assert log.hostname == "?"
    assert log.msg == "audit(1484477221.034:938164/:"
    assert log.node == "727405-object-disk-033"
    assert log.pid == "5400"
    assert log.res == "success'"
    assert log.ses == "4294967295"
    assert log.terminal == "cron"
    assert log.type == "USER_START"
    assert log.uid == "0"
    assert log.host_id == "sample"
  end

end
