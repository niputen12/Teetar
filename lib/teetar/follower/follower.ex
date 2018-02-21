defmodule Teetar.Follower do
  @moduledoc """
  The Follower context.
  """

  import Ecto.Query, warn: false
  alias Teetar.Repo

  alias Teetar.Follower.Netizen

  @doc """
  Returns the list of netizens.

  ## Examples

      iex> list_netizens()
      [%Netizen{}, ...]

  """
  def list_netizens do
    Repo.all(Netizen)
  end

  @doc """
  Gets a single netizen.

  Raises `Ecto.NoResultsError` if the Netizen does not exist.

  ## Examples

      iex> get_netizen!(123)
      %Netizen{}

      iex> get_netizen!(456)
      ** (Ecto.NoResultsError)

  """
  def get_netizen!(id), do: Repo.get!(Netizen, id)

  @doc """
  Creates a netizen.

  ## Examples

      iex> create_netizen(%{field: value})
      {:ok, %Netizen{}}

      iex> create_netizen(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_netizen(attrs \\ %{}, user) do
    %Netizen{user_id: user.id}
    |> Netizen.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a netizen.

  ## Examples

      iex> update_netizen(netizen, %{field: new_value})
      {:ok, %Netizen{}}

      iex> update_netizen(netizen, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_netizen(%Netizen{} = netizen, attrs) do
    netizen
    |> Netizen.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Netizen.

  ## Examples

      iex> delete_netizen(netizen)
      {:ok, %Netizen{}}

      iex> delete_netizen(netizen)
      {:error, %Ecto.Changeset{}}

  """
  def delete_netizen(%Netizen{} = netizen) do
    Repo.delete(netizen)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking netizen changes.

  ## Examples

      iex> change_netizen(netizen)
      %Ecto.Changeset{source: %Netizen{}}

  """
  def change_netizen(%Netizen{} = netizen) do
    Netizen.changeset(netizen, %{})
  end
end
