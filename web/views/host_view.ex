defmodule Digester.HostView do
  use Digester.Web, :view

  def render("index.json", %{hosts: hosts}) do
    render_many(hosts, Digester.HostView, "host.json")
  end

  def render("show.json", %{host: host}) do
    render_one(host, Digester.HostView, "host.json")
  end

  def render("host.json", %{host: host}) do
    %{
      brand: host.brand,
      model: host.model,
      serial: host.serial,
      bios: host.bios,
      firmware: host.firmware,
      region: host.region,
      rack_id: host.rack_id,
      uuid: host.uuid
    }
  end
end
