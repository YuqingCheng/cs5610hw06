# Tasktracker

## Features of App
 * The app is designed for the scenario where multiple users collaborately manage task by assigning task to users and tracking time for each assignment
 * Users register and log in by email
 * Every user can create, edit task info, and mark complete a task
 * Every user can assign a task to multiple users (including self), and add time spent for a specific assignment
 * Every user can unassign users from a task
 * Navigation in webpage could cover all features for app purpose (task management)
 * For test purpose, routes for editing users and deleting users are not deactivated, everyone could edit user information by going to particular links, but there's no such button in app navigation. These features should be excluded for admins only in future updates.
 
## Many to Many relation between users and tasks through assignments
[User] <-> [Assignment] <-> [Task]
  id   <--   user_id
             task_id    -->  id
 
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
