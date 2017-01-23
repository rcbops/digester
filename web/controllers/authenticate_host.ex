require IEx

defmodule Digester.Plugs.AuthenticateHost do
  import Plug.Conn

  def authenticate_host(conn, _) do
    hash = conn.req_headers
    |> List.keyfind("x-rax-host-id", 0)
    |> Tuple.to_list
    |> List.last

    IEx.pry
    conn
  end

end
