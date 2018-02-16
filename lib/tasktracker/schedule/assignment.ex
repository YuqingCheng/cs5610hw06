defmodule Tasktracker.Schedule.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Assignment


  schema "assignments" do
    field :time, :integer
    belongs_to :user_id, Tasktracker.Accounts.User
    belongs_to :task_id, Tasktracker.Schedule.Task

    timestamps()
  end

  @doc false
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [:time])
    |> validate_required([:time])
  end
end
