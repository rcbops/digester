require IEx

defmodule Digester.Plugs.AuthenticateHostTest do
  use Digester.ConnCase

  test "GET /", %{conn: conn} do
    conn = put_req_header(conn, "x-rax-host-id", "valuable")
    conn = get conn, "/"
    assert conn.req_headers == [{"x-rax-host-id", "valuable"}]
  end

  test "GET /api/logs", %{conn: conn} do
    conn = put_req_header(conn, "x-rax-host-id", "valuable")
    conn = get conn, "/api/logs"
    assert json_response(conn, 200)
  end
end
