require Poison

defmodule Digester.LogControllerTest do
  use Digester.ConnCase

  @cron """
  Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"
  """

  @audispd """
  Jan 15 10:47:01 727405-object-disk-033 audispd: node=727405-object-disk-033 type=USER_START msg=audit(1484477221.034:938164/: pid=5400 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_open acct="root" exe="/usr/sbin/cron" hostname=? addr=? terminal=cron res=success'
  """

  test "GET /", %{conn: conn} do
    conn = put_req_header(conn, "x-rax-host-id", "valuable")
    conn = get conn, "/"
    assert conn.req_headers == [{"x-rax-host-id", "valuable"}]
  end

  test "POST /api/hosts (does not require host_uuid)", %{conn: conn} do
    conn     = put_req_header(conn, "content-type", "application/json")
    json     = Poison.encode!(%{host: ""})
    conn     = post conn, "/api/hosts", json
    response = Poison.decode!(conn.resp_body)
    refute response["uuid"] == nil
  end

  test "POST /api/logs (requires host_uuid)", %{conn: conn} do
    host_uuid = Digester.Host.create!({}).uuid
    conn      = put_req_header(conn, "content-type", "application/json")
    conn      = put_req_header(conn, "x-rax-host-id", host_uuid)
    json      = Poison.encode!(%{log: @cron})
    conn      = post conn, "/api/logs", json
    response  = Poison.decode!(conn.resp_body)
    count     = Digester.Repo.aggregate(Digester.Logs.Cron, :count, :id)

    assert response["host_uuid"] == host_uuid
    assert count == 1
  end

end
