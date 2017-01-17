defmodule Digester.LogTest do
  use Digester.ModelCase

  alias Digester.Log

  @syslog "Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"

  test "parses the date" do
    datetime = Log.parse_datetime(@syslog)
    actual = Timex.format(datetime, "%b %e %H:%M:%S", :strftime)
    assert actual == {:ok, "Jan 17 11:30:01"}
  end

  test "parse IP address" do
    assert Log.parse_ip_address(@syslog) == "10.151.87.56"
  end

  test "parse the process name and ID" do
    assert Log.parse_process(@syslog) == %{ name: "CRON", id: "11934" }
  end

  test "parse the OS name" do
    assert Log.parse_os_name(@syslog) == "ubuntu"
  end

  test "parse the command" do
    assert Log.parse_command(@syslog) == "/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1'"
  end
end
