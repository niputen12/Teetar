defmodule Teetar.Code_generatorTest do
  use Teetar.DataCase

  alias Teetar.Code_generator

  describe "codes" do
    alias Teetar.Code_generator.Code

    @valid_attrs %{random_code: "some random_code", username: "some username"}
    @update_attrs %{random_code: "some updated random_code", username: "some updated username"}
    @invalid_attrs %{random_code: nil, username: nil}

    def code_fixture(attrs \\ %{}) do
      {:ok, code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Code_generator.create_code()

      code
    end

    test "list_codes/0 returns all codes" do
      code = code_fixture()
      assert Code_generator.list_codes() == [code]
    end

    test "get_code!/1 returns the code with given id" do
      code = code_fixture()
      assert Code_generator.get_code!(code.id) == code
    end

    test "create_code/1 with valid data creates a code" do
      assert {:ok, %Code{} = code} = Code_generator.create_code(@valid_attrs)
      assert code.random_code == "some random_code"
      assert code.username == "some username"
    end

    test "create_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Code_generator.create_code(@invalid_attrs)
    end

    test "update_code/2 with valid data updates the code" do
      code = code_fixture()
      assert {:ok, code} = Code_generator.update_code(code, @update_attrs)
      assert %Code{} = code
      assert code.random_code == "some updated random_code"
      assert code.username == "some updated username"
    end

    test "update_code/2 with invalid data returns error changeset" do
      code = code_fixture()
      assert {:error, %Ecto.Changeset{}} = Code_generator.update_code(code, @invalid_attrs)
      assert code == Code_generator.get_code!(code.id)
    end

    test "delete_code/1 deletes the code" do
      code = code_fixture()
      assert {:ok, %Code{}} = Code_generator.delete_code(code)
      assert_raise Ecto.NoResultsError, fn -> Code_generator.get_code!(code.id) end
    end

    test "change_code/1 returns a code changeset" do
      code = code_fixture()
      assert %Ecto.Changeset{} = Code_generator.change_code(code)
    end
  end
end
