defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Accounts
  alias Tasktracker.Schedule.Assignment
  alias Tasktracker.Schedule.Timeblock

  def show(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    render(conn, "show.html", assignment: assignment)
  end

  def new(conn, %{"task_id" => task_id}) do
    changeset = Schedule.change_assignment(%Assignment{})
    user_id = get_session(conn, :user_id)
    task = Schedule.get_task! task_id
    if user_id && user_id == task.owner_id do
      user = Accounts.get_user_in_details(user_id)
      users = user.underlings
      render(conn, "new.html", task_id: task.id, users: users, changeset: changeset)
    else
      redirect(conn, to: page_path(conn, :index))
    end
  end

  def new_timeblock(conn, %{"assignment_id" => assignment_id}) do
    changeset = Schedule.change_timeblock(%Timeblock{})

    render(conn, "new_timeblock.html", assignment_id: assignment_id, changeset: changeset)
  end

  def edit(conn, %{"id" => id, "task_id" => task_id}) do
    assignment = Schedule.get_assignment!(id)
    changeset = Schedule.change_assignment(assignment)
    render(conn, "edit.html", assignment: assignment, task_id: task_id, changeset: changeset)
  end

  def edit_timeblock(conn, %{"id" => id, "assignment_id" => assignment_id}) do
    timeblock = Schedule.get_timeblock!(id)
    changeset = Schedule.change_timeblock(timeblock)
    render(conn, "edit_timeblock.html", timeblock: timeblock, assignment_id: assignment_id, changeset: changeset)
  end

  def create(conn, %{"assignment" => assignment}) do
    case Schedule.create_assignment(assignment) do
      {:ok, assignment} ->
        conn
        |> put_flash(:info, "Assignment created successfully.")
        |> redirect(to: task_path(conn, :show, assignment.task_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create_timeblock(conn, %{"timeblock" => timeblock}) do
    case timeblock |> Schedule.create_timeblock do
      {:ok, timeblock} ->
        conn
        |> put_flash(:info, "Timeblock created successfully.")
        |> redirect(to: assignment_path(conn, :show, timeblock.assignment_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_timeblock.html", changeset: changeset)
    end
  end

  def convert_to_timeblock(b) do
    a = for {k, v} <- b, into: %{}, do: {k, String.to_integer(v)}
    {:ok, start} = NaiveDateTime.new(a["from_year"], a["from_month"], a["from_day"], a["from_hour"], a["from_minute"], a["from_second"])
    {:ok, stop} = NaiveDateTime.new(a["to_year"], a["to_month"], a["to_day"], a["to_hour"], a["to_minute"], a["to_second"])
    %{assignment_id: a["assignment_id"], start: start, end: stop}
  end

  def convert_to_flat(a) do
    %{
      from_year: a.start.year,
      from_month: a.start.month,
      from_day: a.start.day,
      from_hour: a.start.hour,
      from_minute: a.start.minute,
      from_second: a.start.second,
      to_year: a.end.year,
      to_month: a.end.month,
      to_day: a.end.day,
      to_hour: a.end.hour,
      to_minute: a.end.minute,
      to_second: a.end.second,
      assignment_id: a.assignment_id,
      id: a.id
    }
  end

  def update(conn, %{"assignment" => assignment_params}) do
    assignment = Schedule.get_assignment!(assignment_params["id"])
    case Schedule.update_assignment(assignment, assignment_params) do
      {:ok, assignment} ->
        conn
        |> put_flash(:info, "Assignment updated successfully.")
        |> redirect(to: task_path(conn, :show, assignment.task_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assignment, changeset: changeset)
    end
  end

  def update_timeblock(conn, %{"timeblock" => timeblock_params}) do
    timeblock = Schedule.get_timeblock!(timeblock_params["id"])
    case Schedule.update_timeblock(timeblock, timeblock_params) do
      {:ok, timeblock} ->
        conn
        |> put_flash(:info, "Timeblock updated successfully.")
        |> redirect(to: assignment_path(conn, :show, timeblock.assignment_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_timeblock.html", timeblock, changeset: changeset)
    end
  end

  def delete_timeblock(conn, %{"id" => id}) do
    timeblock = Schedule.get_timeblock!(id)
    {:ok, _assignment} = Schedule.delete_timeblock(timeblock)

    conn
    |> put_flash(:info, "Timeblock deleted successfully.")
    |> redirect(to: assignment_path(conn, :show, timeblock.assignment_id))
  end

  def delete(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    {:ok, _assignment} = Schedule.delete_assignment(assignment)

    conn
    |> put_flash(:info, "Assignment deleted successfully.")
    |> redirect(to: task_path(conn, :show, assignment.task_id))
  end
end
