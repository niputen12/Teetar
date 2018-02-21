defmodule Teetar.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teetar.Accounts.User
  alias Teetar.Blog.Post
  import Comeonin.Bcrypt
  alias Teetar.Follower.Netizen

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :encrypted_password, :string
    field :username, :string
    field :password, :string, virtual: true
    has_many :posts, Post
    has_many :followers, Netizen

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :username, :password])
    |> validate_required([:firstname, :lastname, :email, :username, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> encrypted_password()
  end

  defp encrypted_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password, hash_key: :encrypted_password))
  end
  defp encrypted_password(changeset), do: changeset
end
