defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Schedule.Assignment

  def index(conn, _params) do
    assignments = Schedule.list_assignments()
    render(conn, "index.html", assignments: assignments)
  end

  def new(conn, _params) do
    changeset = Schedule.change_assignment(%Assignment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"assignment" => assignment_params}) do
    case Schedule.create_assignment(assignment_params) do
      {:ok, assignment} ->
        conn
        |> put_flash(:info, "Assignment created successfully.")
        |> redirect(to: assignment_path(conn, :show, assignment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    render(conn, "show.html", assignment: assignment)
  end

  def edit(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    changeset = Schedule.change_assignment(assignment)
    render(conn, "edit.html", assignment: assignment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "assignment" => assignment_params}) do
    assignment = Schedule.get_assignment!(id)

    case Schedule.update_assignment(assignment, assignment_params) do
      {:ok, assignment} ->
        conn
        |> put_flash(:info, "Assignment updated successfully.")
        |> redirect(to: assignment_path(conn, :show, assignment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assignment: assignment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    {:ok, _assignment} = Schedule.delete_assignment(assignment)

    conn
    |> put_flash(:info, "Assignment deleted successfully.")
    |> redirect(to: assignment_path(conn, :index))
  end
end
