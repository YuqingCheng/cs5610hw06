defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :get_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasktrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # get "/user/:id", UserController, :id
    resources "/users", UserController
    resources "/tasks", TaskController

    get "/assignments", AssignmentController, :index
    get "/assignments/:id", AssignmentController, :show
    get "/assignments/:task_id/new", AssignmentController, :new
    get "/assignments/:id/edit", AssignmentController, :edit
    post "/assignments", AssignmentController, :create
    put "/assignments", AssignmentController, :update
    delete "/assignments/:id", AssignmentController, :delete

    get "/assignments/timeblock/:id", AssignmentController, :delete_timeblock
    get "/assignments/:assignment_id/new_timeblock", AssignmentController, :new_timeblock
    get "/assignments/:id/edit_timeblock", AssignmentController, :edit_timeblock
    post "/assignments/timeblock", AssignmentController, :create_timeblock
    put "/assignments/timeblock", AssignmentController, :update_timeblock
    delete "/assignments/timeblock/:id", AssignmentController, :delete_timeblock
    

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  scope "/api/v1", TasktrackerWeb do
    pipe_through :api
    resources "/timeblock", TimeblockController, except: [:new, :edit]
  end

  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = Tasktracker.Accounts.get_user!(user_id || -1)
    assign(conn, :current_user, user)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TasktrackerWeb do
  #   pipe_through :api
  # end
end
