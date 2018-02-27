defmodule Tasktracker.Schedule.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Assignment


  schema "assignments" do
    field :time, :integer
    belongs_to :user, Tasktracker.Accounts.User
    belongs_to :task, Tasktracker.Schedule.Task
    has_many :timeblocks, Tasktracker.Schedule.Timeblock, foreign_key: :assignment_id

    timestamps()
  end

  @doc false
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
  end
end
