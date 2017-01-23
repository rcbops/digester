defmodule Digester.Logs.CronTest do
  use Digester.ModelCase

  alias Digester.Logs.Cron

  @log "Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"

  test "parsing" do
    log = Cron.parse!("sample", @log)
    assert log.ip_address == "10.151.87.56"
    assert log.process_info.name == "CRON"
    assert log.process_info.process_id == "11934"
    assert log.user == "ubuntu"
    assert log.host_uuid == "sample"
    assert log.content == "Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"
  end

end
