defmodule TeetarWeb.NetizenController do
  use TeetarWeb, :controller

  alias Teetar.Follower
  alias Teetar.Follower.Netizen
  plug TeetarWeb.Services.Plugs.AuthenticatorPlug

  action_fallback TeetarWeb.FallbackController

  def index(conn, _params) do
    netizens = Follower.list_netizens()
    render(conn, "index.json", netizens: netizens)
  end

  def create(conn, %{"netizen" => netizen_params}) do
    with {:ok, %Netizen{} = netizen} <- Follower.create_netizen(netizen_params, conn.assigns.user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", netizen_path(conn, :show, netizen))
      |> render("show.json", netizen: netizen)
    end
  end

  def show(conn, %{"id" => id}) do
    netizen = Follower.get_netizen!(id)
    render(conn, "show.json", netizen: netizen)
  end

  def update(conn, %{"id" => id, "netizen" => netizen_params}) do
    netizen = Follower.get_netizen!(id)

    with {:ok, %Netizen{} = netizen} <- Follower.update_netizen(netizen, netizen_params) do
      render(conn, "show.json", netizen: netizen)
    end
  end

  def delete(conn, %{"id" => id}) do
    netizen = Follower.get_netizen!(id)
    with {:ok, %Netizen{}} <- Follower.delete_netizen(netizen) do
      send_resp(conn, :no_content, "")
    end
  end
end
