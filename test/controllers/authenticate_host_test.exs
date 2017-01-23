require IEx
require Poison

defmodule Digester.Plugs.AuthenticateHostTest do
  use Digester.ConnCase

  test "GET /", %{conn: conn} do
    conn = put_req_header(conn, "x-rax-host-id", "valuable")
    conn = get conn, "/"
    assert conn.req_headers == [{"x-rax-host-id", "valuable"}]
  end

  test "POST /api/hosts", %{conn: conn} do
    conn     = put_req_header(conn, "content-type", "application/json")
    json     = Poison.encode!(%{host: ""})
    conn     = post conn, "/api/hosts", json
    response = Poison.decode!(conn.resp_body)
    refute response["uuid"] == nil
  end
end
