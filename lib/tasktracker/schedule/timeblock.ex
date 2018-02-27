defmodule Tasktracker.Schedule.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Timeblock


  schema "timeblocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :assignment, Tasktracker.Accounts.Assignment

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end, :assignment_id])
    |> validate_required([:start, :end, :assignment_id])
  end
end
