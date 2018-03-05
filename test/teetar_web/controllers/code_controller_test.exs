defmodule TeetarWeb.CodeControllerTest do
  use TeetarWeb.ConnCase

  alias Teetar.Code_generator
  alias Teetar.Code_generator.Code

  @create_attrs %{random_code: "some random_code", username: "some username"}
  @update_attrs %{random_code: "some updated random_code", username: "some updated username"}
  @invalid_attrs %{random_code: nil, username: nil}

  def fixture(:code) do
    {:ok, code} = Code_generator.create_code(@create_attrs)
    code
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all codes", %{conn: conn} do
      conn = get conn, code_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create code" do
    test "renders code when data is valid", %{conn: conn} do
      conn = post conn, code_path(conn, :create), code: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, code_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "random_code" => "some random_code",
        "username" => "some username"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, code_path(conn, :create), code: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update code" do
    setup [:create_code]

    test "renders code when data is valid", %{conn: conn, code: %Code{id: id} = code} do
      conn = put conn, code_path(conn, :update, code), code: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, code_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "random_code" => "some updated random_code",
        "username" => "some updated username"}
    end

    test "renders errors when data is invalid", %{conn: conn, code: code} do
      conn = put conn, code_path(conn, :update, code), code: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete code" do
    setup [:create_code]

    test "deletes chosen code", %{conn: conn, code: code} do
      conn = delete conn, code_path(conn, :delete, code)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, code_path(conn, :show, code)
      end
    end
  end

  defp create_code(_) do
    code = fixture(:code)
    {:ok, code: code}
  end
end
