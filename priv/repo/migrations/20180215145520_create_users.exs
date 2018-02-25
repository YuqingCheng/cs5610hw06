defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :manager_id, references(:users, on_delete: :nilify_all), null: true
      add :admin, :boolean, default: false, null: false

      timestamps()
    end

  end
end
