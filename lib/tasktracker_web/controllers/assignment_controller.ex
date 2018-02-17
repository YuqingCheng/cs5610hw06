defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Schedule.Assignment

  def new(conn, %{"task_id" => task_id}) do
    assignment = %Assignment{:task_id => task_id}
    changeset = Schedule.change_assignment(%Assignment{})
    render(conn, "new.html", assignment: [assignment], task_id: task_id, changeset: changeset)
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

  def delete(conn, %{"id" => id}) do
    assignment = Schedule.get_assignment!(id)
    {:ok, _assignment} = Schedule.delete_assignment(assignment)

    conn
    |> put_flash(:info, "Assignment deleted successfully.")
    |> redirect(to: task_path(conn, :show, assignment.task_id))
  end
end
