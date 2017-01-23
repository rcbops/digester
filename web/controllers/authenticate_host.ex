require IEx

defmodule Digester.Plugs.AuthenticateHost do
  import Plug.Conn

  def authenticate_host(conn, _) do
    unless setting_up_host?(conn) do
      hash = conn.req_headers
      |> List.keyfind("x-rax-host-id", 0)
      |> Tuple.to_list
      |> List.last
    end

    conn
  end

  defp setting_up_host?(conn) do
    conn.method == "POST" && conn.request_path == "/api/hosts"
  end

end
