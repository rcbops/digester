defmodule Digester.HostTest do
  use Digester.ModelCase

  alias Digester.Host

  @attributes %{}

  test "setting a UUID" do
    host = Host.create!(@attributes)
    refute host.uuid == ""
  end

end
