defmodule Digester.Logs.CronTest do
  use Digester.ModelCase

  alias Digester.Logs.Cron

  @syslog "Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"

  test "the date" do
    log = Cron.parse!(@syslog)
    assert log.datetime == "Jan 17 11:30:01"
  end

  test "IP address" do
    log = Cron.parse!(@syslog)
    assert log.ip_address == "10.151.87.56"
  end

  test "the process name and ID" do
    log = Cron.parse!(@syslog)
    assert log.process_info.name == "CRON"
    assert log.process_info.process_id == "11934"
  end

  test "the user name" do
    log = Cron.parse!(@syslog)
    assert log.user == "ubuntu"
  end

  test "the actual content" do
    log = Cron.parse!(@syslog)
    assert log.content == "Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"
  end

end
