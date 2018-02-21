defmodule Teetar.Follower.Netizen do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teetar.Follower.Netizen
  alias Teetar.Accounts.User

  schema "netizens" do
    field :following_id, :integer
    #field :user_id, :id
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Netizen{} = netizen, attrs) do
    netizen
    |> cast(attrs, [:following_id])
    |> validate_required([:following_id])
  end
end
