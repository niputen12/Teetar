defmodule TeetarWeb.PostController do
  use TeetarWeb, :controller

  alias Teetar.Blog
  alias Teetar.Blog.Post
  plug TeetarWeb.Services.Plugs.AuthenticatorPlug

  action_fallback TeetarWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts(conn.assigns.user)
    render(conn, "index.json", posts: posts)
  end

  def home(conn, _) do
    redirect conn, to: "public/index.html"
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Blog.create_post(post_params, conn.assigns.user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def newsfeed(conn, _params) do
    posts = Blog.list_all_posts()
    render(conn, "index.json", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id, conn.assigns.user)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    with {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
