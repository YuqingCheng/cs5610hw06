defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :owner_id, references(:users, on_delete: :delete_all), null: false 

      timestamps()
    end

  end
end
