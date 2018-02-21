defmodule TeetarWeb.UserController do
  use TeetarWeb, :controller

  alias Teetar.Accounts
  alias Teetar.Accounts.User
  alias TeetarWeb.Services.Authenticator

  action_fallback TeetarWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def auth(conn, %{"username" => username, "password" => password}) do
    case Authenticator.check(username, password) do
      {:ok, user_with_token} ->
        render(conn, "show_with_token.json", user_with_token)
      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(TeetarWeb.CustomErrorView)
        |> render("errors.json", %{
             errors: [
               %{
                 title: "unauthorized",
                 detail: reason
               }
             ]
           })
        |> halt()
    end
  end
end
