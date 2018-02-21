defmodule Teetar.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Teetar.Blog.Post
  alias Teetar.Accounts.User

  schema "posts" do
    field :body, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
