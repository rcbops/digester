defmodule Digester.LogTest do
  use Digester.ModelCase

  alias Digester.Log

  @syslog "Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"

  test "parses the date" do
    log = Log.parse!(@syslog)
    assert log.datetime == "Jan 17 11:30:01"
  end

  test "parse IP address" do
    log = Log.parse!(@syslog)
    assert log.ip_address == "10.151.87.56"
  end

  test "parse the process name and ID" do
    log = Log.parse!(@syslog)
    # assert log.process == %{ name: "CRON", id: "11934" }
    assert log.process == "11934"
  end

  test "parse the OS name" do
    log = Log.parse!(@syslog)
    assert log.os == "ubuntu"
  end

  # test "parse the command" do
  #   log = Log.parse!(@syslog)
  #   assert log.command == "/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1'"
  # end

end
