defmodule Tasktracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime, null: false
      add :assignment_id, references(:assignments, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:timeblocks, [:assignment_id])
  end
end
