defmodule Teetar.FollowerTest do
  use Teetar.DataCase

  alias Teetar.Follower

  describe "peoples" do
    alias Teetar.Follower.People

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def people_fixture(attrs \\ %{}) do
      {:ok, people} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Follower.create_people()

      people
    end

    test "list_peoples/0 returns all peoples" do
      people = people_fixture()
      assert Follower.list_peoples() == [people]
    end

    test "get_people!/1 returns the people with given id" do
      people = people_fixture()
      assert Follower.get_people!(people.id) == people
    end

    test "create_people/1 with valid data creates a people" do
      assert {:ok, %People{} = people} = Follower.create_people(@valid_attrs)
    end

    test "create_people/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Follower.create_people(@invalid_attrs)
    end

    test "update_people/2 with valid data updates the people" do
      people = people_fixture()
      assert {:ok, people} = Follower.update_people(people, @update_attrs)
      assert %People{} = people
    end

    test "update_people/2 with invalid data returns error changeset" do
      people = people_fixture()
      assert {:error, %Ecto.Changeset{}} = Follower.update_people(people, @invalid_attrs)
      assert people == Follower.get_people!(people.id)
    end

    test "delete_people/1 deletes the people" do
      people = people_fixture()
      assert {:ok, %People{}} = Follower.delete_people(people)
      assert_raise Ecto.NoResultsError, fn -> Follower.get_people!(people.id) end
    end

    test "change_people/1 returns a people changeset" do
      people = people_fixture()
      assert %Ecto.Changeset{} = Follower.change_people(people)
    end
  end

  describe "peoples" do
    alias Teetar.Follower.People

    @valid_attrs %{following_id: 42}
    @update_attrs %{following_id: 43}
    @invalid_attrs %{following_id: nil}

    def people_fixture(attrs \\ %{}) do
      {:ok, people} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Follower.create_people()

      people
    end

    test "list_peoples/0 returns all peoples" do
      people = people_fixture()
      assert Follower.list_peoples() == [people]
    end

    test "get_people!/1 returns the people with given id" do
      people = people_fixture()
      assert Follower.get_people!(people.id) == people
    end

    test "create_people/1 with valid data creates a people" do
      assert {:ok, %People{} = people} = Follower.create_people(@valid_attrs)
      assert people.following_id == 42
    end

    test "create_people/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Follower.create_people(@invalid_attrs)
    end

    test "update_people/2 with valid data updates the people" do
      people = people_fixture()
      assert {:ok, people} = Follower.update_people(people, @update_attrs)
      assert %People{} = people
      assert people.following_id == 43
    end

    test "update_people/2 with invalid data returns error changeset" do
      people = people_fixture()
      assert {:error, %Ecto.Changeset{}} = Follower.update_people(people, @invalid_attrs)
      assert people == Follower.get_people!(people.id)
    end

    test "delete_people/1 deletes the people" do
      people = people_fixture()
      assert {:ok, %People{}} = Follower.delete_people(people)
      assert_raise Ecto.NoResultsError, fn -> Follower.get_people!(people.id) end
    end

    test "change_people/1 returns a people changeset" do
      people = people_fixture()
      assert %Ecto.Changeset{} = Follower.change_people(people)
    end
  end

  describe "netizens" do
    alias Teetar.Follower.Netizen

    @valid_attrs %{following_id: 42}
    @update_attrs %{following_id: 43}
    @invalid_attrs %{following_id: nil}

    def netizen_fixture(attrs \\ %{}) do
      {:ok, netizen} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Follower.create_netizen()

      netizen
    end

    test "list_netizens/0 returns all netizens" do
      netizen = netizen_fixture()
      assert Follower.list_netizens() == [netizen]
    end

    test "get_netizen!/1 returns the netizen with given id" do
      netizen = netizen_fixture()
      assert Follower.get_netizen!(netizen.id) == netizen
    end

    test "create_netizen/1 with valid data creates a netizen" do
      assert {:ok, %Netizen{} = netizen} = Follower.create_netizen(@valid_attrs)
      assert netizen.following_id == 42
    end

    test "create_netizen/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Follower.create_netizen(@invalid_attrs)
    end

    test "update_netizen/2 with valid data updates the netizen" do
      netizen = netizen_fixture()
      assert {:ok, netizen} = Follower.update_netizen(netizen, @update_attrs)
      assert %Netizen{} = netizen
      assert netizen.following_id == 43
    end

    test "update_netizen/2 with invalid data returns error changeset" do
      netizen = netizen_fixture()
      assert {:error, %Ecto.Changeset{}} = Follower.update_netizen(netizen, @invalid_attrs)
      assert netizen == Follower.get_netizen!(netizen.id)
    end

    test "delete_netizen/1 deletes the netizen" do
      netizen = netizen_fixture()
      assert {:ok, %Netizen{}} = Follower.delete_netizen(netizen)
      assert_raise Ecto.NoResultsError, fn -> Follower.get_netizen!(netizen.id) end
    end

    test "change_netizen/1 returns a netizen changeset" do
      netizen = netizen_fixture()
      assert %Ecto.Changeset{} = Follower.change_netizen(netizen)
    end
  end
end
