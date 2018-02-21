defmodule TeetarWeb.NetizenControllerTest do
  use TeetarWeb.ConnCase

  alias Teetar.Follower
  alias Teetar.Follower.Netizen

  @create_attrs %{following_id: 42}
  @update_attrs %{following_id: 43}
  @invalid_attrs %{following_id: nil}

  def fixture(:netizen) do
    {:ok, netizen} = Follower.create_netizen(@create_attrs)
    netizen
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all netizens", %{conn: conn} do
      conn = get conn, netizen_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create netizen" do
    test "renders netizen when data is valid", %{conn: conn} do
      conn = post conn, netizen_path(conn, :create), netizen: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, netizen_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "following_id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, netizen_path(conn, :create), netizen: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update netizen" do
    setup [:create_netizen]

    test "renders netizen when data is valid", %{conn: conn, netizen: %Netizen{id: id} = netizen} do
      conn = put conn, netizen_path(conn, :update, netizen), netizen: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, netizen_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "following_id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, netizen: netizen} do
      conn = put conn, netizen_path(conn, :update, netizen), netizen: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete netizen" do
    setup [:create_netizen]

    test "deletes chosen netizen", %{conn: conn, netizen: netizen} do
      conn = delete conn, netizen_path(conn, :delete, netizen)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, netizen_path(conn, :show, netizen)
      end
    end
  end

  defp create_netizen(_) do
    netizen = fixture(:netizen)
    {:ok, netizen: netizen}
  end
end
