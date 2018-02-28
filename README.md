# Tasktracker

## Features & Design choices of App
 * Users register and log in by email
 * Only admin can assign manager to users, please log in as admin by 'admin@admin.com', and go to 'tasks2.yuqingc.com/users' to see all the users, manager can be assigned by editting user's profile.
 * Every user can create, thus owns a task, but can only assign it to his/her underlings. A task can only be owned by one user, thus ownership relation between user and task is one-to-many. User can see his/her owned tasks by clicking 'owned tasks' in navbar.
 * A task can be assigned to multiple users, thus assignment relationship between user and task is many-to-many. User can see his/her tasks to do in his/her profile page.
 * User can track time spent on a task in the form of timeblocks/intervals by either clicking start/stop or filling form manually, each assignment has its own tracked time.  
 * User is responsible for the correctness of timeblocks. Start/Stop button always show current time, while filling forms gives users great freedom in tracking time spent, and it doesn't guarantee the correctness of time interval.
 * Only manager/owner of a task can edit task detail and mark it as complete.
 * Manager can see the time spent of all underlings's tasks, but cannot edit/delete time spent. Only user corresponding to an assignment can edit/delete time spent.
 * User cannot see his/her partner's time spent on the same task
 
 
## Many to Many relation between users and tasks through assignments
*       [User] <-> [Assignment] <-> [Task]
*         id   <--   user_id
*                    task_id    -->  id
 
## Deployment
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
