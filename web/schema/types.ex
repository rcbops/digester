defmodule Digester.Schema.Types do
  use Absinthe.Schema.Notation

  object :log do
    field :content, :string
    field :datetime, :string
    field :ip_address, :string
    field :user, :string
    field :host_uuid, :string
  end
end
