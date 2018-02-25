defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :admin, :boolean
    belongs_to :manager, Tasktracker.Accounts.User
    many_to_many :tasks, Tasktracker.Schedule.Task, join_through: Tasktracker.Schedule.Assignment
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id])
    |> validate_required([:email, :name, :manager_id])
  end
end
