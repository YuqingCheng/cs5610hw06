defmodule Tasktracker.Schedule.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Task


  schema "tasks" do
    field :description, :string
    field :title, :string
    many_to_many :users, Tasktracker.Accounts.User, join_through: Tasktracker.Schedule.Assignment

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
