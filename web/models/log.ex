defmodule Digester.Log do
  use Digester.Web, :model

  schema "logs" do
    field :rax_host_id, :string
    field :rax_account_id, :string
    field :content, :string
    belongs_to :host, Digest.Host

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rax_host_id, :rax_account_id, :content])
    |> validate_required([:rax_host_id, :rax_account_id, :content])
  end
end
