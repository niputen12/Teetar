defmodule TeetarWeb.UserView do
  use TeetarWeb, :view
  alias TeetarWeb.{UserView, PostView, NetizenView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("show_with_token.json", user_with_token) do
    %{data: render_one(user_with_token, UserView, "user_with_token.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      username: user.username}
  end

  def render("user_with_token.json", %{user: %{user: user, token: token, total_following: following_count, total_followers: follower_count}}) do
     %{id: user.id,
       username: user.username,
       posts: render_many(user.posts, PostView, "user_posts.json"),
       followers: render_many(user.followers, NetizenView, "followings.json"),
       following: following_count,
       followers: follower_count,
       meta: %{
         token: token
      }
     }
   end
end
