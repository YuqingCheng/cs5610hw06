defmodule Tasktracker.Schedule.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Assignment


  schema "assignments" do
    field :time, :integer
    belongs_to :user, Tasktracker.Accounts.User
    belongs_to :task, Tasktracker.Schedule.Task

    timestamps()
  end

  @doc false
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [:time, :user_id, :task_id])
    |> validate_required([:time, :user_id, :task_id])
  end
end
