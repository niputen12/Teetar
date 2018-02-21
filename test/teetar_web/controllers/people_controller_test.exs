defmodule TeetarWeb.PeopleControllerTest do
  use TeetarWeb.ConnCase

  alias Teetar.Follower

  @create_attrs %{following_id: 42}
  @update_attrs %{following_id: 43}
  @invalid_attrs %{following_id: nil}

  def fixture(:people) do
    {:ok, people} = Follower.create_people(@create_attrs)
    people
  end

  describe "index" do
    test "lists all peoples", %{conn: conn} do
      conn = get conn, people_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Peoples"
    end
  end

  describe "new people" do
    test "renders form", %{conn: conn} do
      conn = get conn, people_path(conn, :new)
      assert html_response(conn, 200) =~ "New People"
    end
  end

  describe "create people" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, people_path(conn, :create), people: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == people_path(conn, :show, id)

      conn = get conn, people_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show People"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, people_path(conn, :create), people: @invalid_attrs
      assert html_response(conn, 200) =~ "New People"
    end
  end

  describe "edit people" do
    setup [:create_people]

    test "renders form for editing chosen people", %{conn: conn, people: people} do
      conn = get conn, people_path(conn, :edit, people)
      assert html_response(conn, 200) =~ "Edit People"
    end
  end

  describe "update people" do
    setup [:create_people]

    test "redirects when data is valid", %{conn: conn, people: people} do
      conn = put conn, people_path(conn, :update, people), people: @update_attrs
      assert redirected_to(conn) == people_path(conn, :show, people)

      conn = get conn, people_path(conn, :show, people)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, people: people} do
      conn = put conn, people_path(conn, :update, people), people: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit People"
    end
  end

  describe "delete people" do
    setup [:create_people]

    test "deletes chosen people", %{conn: conn, people: people} do
      conn = delete conn, people_path(conn, :delete, people)
      assert redirected_to(conn) == people_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, people_path(conn, :show, people)
      end
    end
  end

  defp create_people(_) do
    people = fixture(:people)
    {:ok, people: people}
  end
end
