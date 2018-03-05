defmodule Teetar.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_verified, :boolean
    end
  end
end
