defmodule TeetarWeb.PostView do
  use TeetarWeb, :view
  alias TeetarWeb.{PostView, UserView}

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "user_posts.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      body: post.body,
      inserted_at: post.inserted_at,
      user: render_one(post.user, UserView, "user.json")
    }
  end

  def render("user_post.json", %{posts: posts}) do
      %{data: render_many(posts, PostView, "user_posts.json")}
  end

  def render("user_posts.json", %{post: post}) do
    %{id: post.id,
      content: post.body,
      inserted_at: post.inserted_at
    }
  end
end
