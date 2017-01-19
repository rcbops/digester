defmodule Digester.Schema do
  use Absinthe.Schema
  import_types Digester.Schema.Types

  query do
    field :logs, list_of(:log) do
      resolve &Digester.LogResolver.all/2
    end
  end

end
