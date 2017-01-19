defmodule Digester.LogResolver do
  def all(_args, _info) do
    {:ok, Digester.Repo.all(Digester.Log)}
  end
end
