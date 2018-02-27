defmodule TasktrackerWeb.TimeblockController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Schedule.Timeblock

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Schedule.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"action" => action_params}) do
    flag = action_params["flag"]
    assignment_id = action_params["assignment_id"]

    if flag == "start" do
      with {:ok, timeblock} <- Schedule.start_task(assignment_id) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", timeblock_path(conn, :show, struct(Timeblock, timeblock)))
        |> render("show.json", timeblock: struct(Timeblock, timeblock))
      end
    end

    if flag == "stop" do
      with {:ok, %Timeblock{} = timeblock} <- Schedule.stop_task(assignment_id) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", timeblock_path(conn, :show, timeblock))
        |> render("show.json", timeblock: timeblock)
      end
    end

    
  end

  def show(conn, %{"id" => id}) do
    timeblock = Schedule.get_timeblock!(id)
    render(conn, "show.json", timeblock: timeblock)
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params}) do
    timeblock = Schedule.get_timeblock!(id)

    with {:ok, %Timeblock{} = timeblock} <- Schedule.update_timeblock(timeblock, timeblock_params) do
      render(conn, "show.json", timeblock: timeblock)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeblock = Schedule.get_timeblock!(id)
    with {:ok, %Timeblock{}} <- Schedule.delete_timeblock(timeblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
