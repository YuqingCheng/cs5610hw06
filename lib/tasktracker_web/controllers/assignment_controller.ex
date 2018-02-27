defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Accounts
  alias Tasktracker.Schedule.Assignment

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

  def edit(conn, %{"id" => id, "task_id" => task_id}) do
    assignment = Schedule.get_assignment!(id)
    changeset = Schedule.change_assignment(assignment)
    render(conn, "edit.html", assignment: assignment, task_id: task_id, changeset: changeset)
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

  def delete(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    {:ok, _assignment} = Schedule.delete_assignment(assignment)

    conn
    |> put_flash(:info, "Assignment deleted successfully.")
    |> redirect(to: task_path(conn, :show, assignment.task_id))
  end
end
