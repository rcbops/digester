require IEx

defmodule Digester.Plugs.AuthenticateHost do
  import Plug.Conn

  alias Digester.Repo
  alias Digester.Host

  def init(options) do
    options
  end

  def call(conn, _) do
    if setting_up_host?(conn) do
      conn
    else
      host_header = conn.req_headers |> List.keyfind("x-rax-host-id", 0)

      case host_header do
        nil -> error_out!(conn)
        _ -> assign_host!(conn, host_header)
      end
    end
  end

  defp setting_up_host?(conn) do
    conn.method == "POST" && conn.request_path == "/api/hosts"
  end

  defp assign_host!(conn, host_header) do
    uuid = host_header |> Tuple.to_list |> List.last
    host = Repo.get_by(Host, uuid: uuid)

    case host do
      nil -> conn |> error_out!
      _ ->
        conn
        |> assign(:host_uuid, host.uuid)
        |> assign(:current_host, host)
    end
  end

  defp error_out!(conn) do
    conn
    |> put_status(:not_found)
    |> Phoenix.Controller.put_view(Digester.ErrorView)
    |> halt
  end

end
