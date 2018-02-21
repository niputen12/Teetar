defmodule TeetarWeb.Services.Plugs.AuthenticatorPlug do
  alias TeetarWeb.Utils.ErrorUtils
  alias Teetar.Accounts
  import Plug.Conn
  import Joken

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        token
        |> get_token_claims()
        |> assign_claims(conn)
      _invalid ->
        conn
        |> ErrorUtils.throw(:unauthorized, reason: "Bearer token is missing")
    end
  end

  defp get_token_claims(jwt) do
    jwt
    |> token()
    |> with_signer(hs256(Application.get_env(:teetar, TeetarWeb.Endpoint)[:secret_key_base]))
    |> verify()
    |> get_claims()
  end

  defp assign_claims(claims, conn) do
    user = Accounts.get_user!(claims["user_id"])

    assign(conn, :user, user)
  end
end
