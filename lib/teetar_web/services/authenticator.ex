defmodule TeetarWeb.Services.Authenticator do
  import Joken
  import Comeonin.Bcrypt
  alias Teetar.Accounts

  def check(username,password) do
    case Accounts.get_user_by_username(username) do
      nil ->
        {:error, "No user"}
      user ->
        if checkpw(password, user.encrypted_password) do
          token = generate_token(user)
          following_count = Accounts.get_following_count(user.id)
          follower_count = Accounts.get_followers(user.id)
        #  {:ok, %{token: token, user: user}}
        {:ok, %{token: token, user: user, total_following: following_count, total_followers: follower_count}}
        else
          {:error, "invalid user"}
        end

    end
  end

  defp generate_token(user) do
    my_token =
      %{user_id: user.id}
      |> token()
      |> with_signer(hs256(Application.get_env(:teetar, TeetarWeb.Endpoint)[:secret_key_base]))
      |> with_iat(current_time())
      |> sign()
      |> get_compact()
  end
end
