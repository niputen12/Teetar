defmodule Teetar.Code_generator.Code do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teetar.Code_generator.Code


  schema "codes" do
    field :random_code, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%Code{} = code, attrs) do
    code
    |> cast(attrs, [:username, :random_code])
    |> validate_required([:username, :random_code])
  end
end
