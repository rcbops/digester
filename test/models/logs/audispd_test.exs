defmodule Digester.Logs.AudispdTest do
  use Digester.ModelCase

  alias Digester.Logs.Audispd

  @log """
  Jan 15 10:47:01 727405-object-disk-033 audispd: node=727405-object-disk-033 type=USER_START msg=audit(1484477221.034:938164/: pid=5400 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_open acct="root" exe="/usr/sbin/cron" hostname=? addr=? terminal=cron res=success'
  """

  test "the date" do
    log = Audispd.parse!(@log)
    assert log.datetime == "Jan 15 10:47:01"
  end

  test "the actual content" do
    log = Audispd.parse!(@log)
    assert log.content == "Jan 15 10:47:01 727405-object-disk-033 audispd: node=727405-object-disk-033 type=USER_START msg=audit(1484477221.034:938164/: pid=5400 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_open acct=\"root\" exe=\"/usr/sbin/cron\" hostname=? addr=? terminal=cron res=success'\n"
  end

  test "the node" do
    log = Audispd.parse!(@log)
    assert log.node == "727405-object-disk-033"
  end

  test "the type" do
    log = Audispd.parse!(@log)
    assert log.type == "USER_START"
  end

  test "the msg" do
    log = Audispd.parse!(@log)
    assert log.msg == "audit(1484477221.034:938164/:"
  end

  test "the pid" do
    log = Audispd.parse!(@log)
    assert log.pid == "5400"
  end

  test "the uid" do
    log = Audispd.parse!(@log)
    assert log.uid == "0"
  end

end
