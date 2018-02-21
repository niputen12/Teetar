defmodule Teetar.Repo.Migrations.CreateNetizens do
  use Ecto.Migration

  def change do
    create table(:netizens) do
      add :following_id, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:netizens, [:user_id])
  end
end
