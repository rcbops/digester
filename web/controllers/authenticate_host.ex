require IEx

defmodule Digester.Plugs.AuthenticateHost do
  import Plug.Conn

  alias Digester.Repo
  alias Digester.Host

  def authenticate_host(conn, _) do
    if setting_up_host?(conn) do
      conn
    else
      host_uuid = conn.req_headers
      |> List.keyfind("x-rax-host-id", 0)
      |> Tuple.to_list
      |> List.last

      host = Repo.get_by(Host, uuid: host_uuid)

      conn
      |> assign(:host_uuid, host_uuid)
      |> assign(:current_host, host)
    end
  end

  defp setting_up_host?(conn) do
    conn.method == "POST" && conn.request_path == "/api/hosts"
  end

end
