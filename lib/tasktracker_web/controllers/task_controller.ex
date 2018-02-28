defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Schedule.Task
  alias Tasktracker.Schedule.Assignment

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      tasks = Schedule.list_tasks_by_owner(user_id)
      render(conn, "index.html", tasks: tasks)
    else
      redirect(conn, to: page_path(conn, :index))
    end
    
  end

  def new(conn, _params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      changeset = Schedule.change_task(%Task{})
      render(conn, "new.html", changeset: changeset)
    else
      redirect(conn, to: page_path(conn, :index))
    end
  end

  def create(conn, %{"task" => task_params}) do
    case Schedule.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Schedule.get_task!(id)
    user_id = get_session(conn, :user_id)
    if user_id do
      if user_id == task.owner_id do
        assignments = Schedule.list_assignments_by_task(id)
        render(conn, "show.html", task: task, assignments: assignments, owned: true)  
      end   
      assignment = Schedule.get_assignment_by_task_and_user(task.id, user_id)
      if assignment do
        render(conn, "show.html", task: task, assignments: [assignment], owned: false)
      end
    end
    redirect(conn, to: page_path(conn, :index))
    
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_session(conn, :user_id)
    task = Schedule.get_task!(id)
    if user_id == task.owner_id do
      changeset = Schedule.change_task(task)
      render(conn, "edit.html", task: task, changeset: changeset)
    else
      redirect(conn, to: page_path(conn, :index))
    end 
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Schedule.get_task!(id)

    case Schedule.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Schedule.get_task!(id)
    {:ok, _task} = Schedule.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
