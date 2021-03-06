require Poison
require IEx

defmodule Digester.Logs.LogControllerTest do
  use Digester.ConnCase

  @cron """
  Jan 17 11:30:01 ip-10-151-87-56 CRON[11934]: (ubuntu) CMD (/bin/bash -l -c 'cd /opt/web_apps/ccw/releases/20131216024215 && script/rails runner -e production '\\''TodoItem.close_forgotten_items'\\'' >> /var/log/cron 2>&1')\n"
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

    assert conn.status == 200

    count = Digester.Repo.aggregate(Digester.Logs.Cron, :count, :id)
    assert count == 1

    count = Digester.Repo.aggregate(Digester.Logs.Audispd, :count, :id)
    assert count == 0
  end

  test "POST /api/logs (without x-rax-host-id)", %{conn: conn} do
    conn = put_req_header(conn, "content-type", "application/json")
    json = Poison.encode!(%{log: @cron})
    conn = post conn, "/api/logs", json
    assert conn.status == 404
  end

end
