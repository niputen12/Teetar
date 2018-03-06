defmodule TeetarWeb.UserController do
  use TeetarWeb, :controller

  alias Teetar.Accounts
  alias Teetar.Accounts.User
  alias TeetarWeb.Services.Authenticator
  alias TeetarWeb.Services.Mailer.Email
  alias TeetarWeb.Services.Mailer.Mailer
  alias Teetar.Code_generator

  action_fallback TeetarWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do

      random_code_generator = :crypto.strong_rand_bytes(8) |> Base.url_encode64() |> binary_part(0, 8)
      random_code = user_params |> Map.put("username", random_code_generator)
      Code_generator.create_code(user.username, random_code["username"])

      Email.welcome_text_email(user.email, user.username)
      |> Mailer.deliver_now

      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user_by_username(id)
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

  def verify(conn, %{"id" => id}) do
    user = Accounts.get_user_by_username(id)

    with {:ok, verified} <- Accounts.update_user(user, %{is_verified: true}) do
        redirect conn, external: "https://bulsuview.herokuapp.com"
      end
  end

  def auth(conn, %{"username" => username, "password" => password}) do
    is_verified = Accounts.check_if_new_user(username)

    case is_verified.is_verified == true do
      true ->
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
      _ ->
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
        # removed email verification for the mean time
        # Email.welcome_text_email(is_verified.email, is_verified.username)
        # |> Mailer.deliver_now

        # conn
        # |> put_status(:ok)
        # |> put_view(TeetarWeb.CustomErrorView)
        # |> render("errors.json", %{
        #    errors: [
        #      %{
        #        title: "unauthorized",
        #        detail: "Account not verified"
        #      }
        #    ]
        #  })
    end
  end
end
