defmodule Teetar.Repo.Migrations.CreateCodes do
  use Ecto.Migration

  def change do
    create table(:codes) do
      add :username, :string
      add :random_code, :string

      timestamps()
    end

  end
end
