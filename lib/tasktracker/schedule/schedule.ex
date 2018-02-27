defmodule Tasktracker.Schedule do
  @moduledoc """
  The Schedule context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Schedule.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  def list_tasks_by_owner(id) do
    query = from a in Task,
        where: a.owner_id == ^id
    Repo.all(query)
        |> Enum.map(fn task -> Repo.preload(task, :timeblocks) end)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasktracker.Schedule.Assignment

  @doc """
  Returns the list of assignments.

  ## Examples

      iex> list_assignments()
      [%Assignment{}, ...]

  """
  def list_assignments do
    Repo.all(Assignment)
  end

  @doc """
  Gets a single assignment.

  Raises `Ecto.NoResultsError` if the Assignment does not exist.

  ## Examples

      iex> get_assignment!(123)
      %Assignment{}

      iex> get_assignment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assignment!(id) do
    Repo.get!(Assignment, id)
        |> Repo.preload(:timeblocks)
  end

  def get_assignment_by_task_and_user(task_id, user_id) do
    query = from a in Assignment,
            where: a.task_id == ^task_id and a.user_id == ^user_id
    Repo.all(query) 
        |> List.first 
        |> Repo.preload(:user)
        |> Repo.preload(:timeblocks)
  end

  def list_assignments_by_task(task_id) do
    query = from a in Assignment,
            where: a.task_id == ^task_id
    Repo.all(query)
       |> Enum.map(fn assignment -> Repo.preload(assignment, :user) end)
       |> Enum.map(fn assignment -> Repo.preload(assignment, :timeblocks) end)
  end

  @doc """
  Creates a assignment.

  ## Examples

      iex> create_assignment(%{field: value})
      {:ok, %Assignment{}}

      iex> create_assignment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assignment(attrs \\ %{}) do
    %Assignment{}
    |> Assignment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assignment.

  ## Examples

      iex> update_assignment(assignment, %{field: new_value})
      {:ok, %Assignment{}}

      iex> update_assignment(assignment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assignment(%Assignment{} = assignment, attrs) do
    assignment
    |> Assignment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Assignment.

  ## Examples

      iex> delete_assignment(assignment)
      {:ok, %Assignment{}}

      iex> delete_assignment(assignment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assignment(%Assignment{} = assignment) do
    Repo.delete(assignment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assignment changes.

  ## Examples

      iex> change_assignment(assignment)
      %Ecto.Changeset{source: %Assignment{}}

  """
  def change_assignment(%Assignment{} = assignment) do
    Assignment.changeset(assignment, %{})
  end

  alias Tasktracker.Schedule.Timeblock

  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%Timeblock{}, ...]

  """
  def list_timeblocks do
    Repo.all(Timeblock)
  end

  @doc """
  Gets a single timeblock.

  Raises `Ecto.NoResultsError` if the Timeblock does not exist.

  ## Examples

      iex> get_timeblock!(123)
      %Timeblock{}

      iex> get_timeblock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timeblock!(id), do: Repo.get!(Timeblock, id)

  @doc """
  Creates a timeblock.

  ## Examples

      iex> create_timeblock(%{field: value})
      {:ok, %Timeblock{}}

      iex> create_timeblock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timeblock(attrs \\ %{}) do
    %Timeblock{}
    |> Timeblock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timeblock.

  ## Examples

      iex> update_timeblock(timeblock, %{field: new_value})
      {:ok, %Timeblock{}}

      iex> update_timeblock(timeblock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timeblock(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> Timeblock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timeblock.

  ## Examples

      iex> delete_timeblock(timeblock)
      {:ok, %Timeblock{}}

      iex> delete_timeblock(timeblock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timeblock(%Timeblock{} = timeblock) do
    Repo.delete(timeblock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timeblock changes.

  ## Examples

      iex> change_timeblock(timeblock)
      %Ecto.Changeset{source: %Timeblock{}}

  """
  def change_timeblock(%Timeblock{} = timeblock) do
    Timeblock.changeset(timeblock, %{})
  end

  use Agent

  def start_task(assignment_id) do
      {_, info} = Agent.start(fn -> curr_time end, name: :"#{assignment_id}")
      timeblock = %{id: -1, start: Agent.get(:"#{assignment_id}", &(&1)), end: curr_time}
      {:ok, timeblock}
  end

  def stop_task(assignment_id) do
      start = Agent.get(:"#{assignment_id}", &(&1))
      Agent.stop(:"#{assignment_id}", :normal, :infinity)
      stop = curr_time
      timeblock = %{assignment_id: assignment_id, start: start, end: stop}
      create_timeblock(timeblock)
  end

  def curr_time do
      NaiveDateTime.utc_now |> NaiveDateTime.add(-18000, :second)
  end
end
