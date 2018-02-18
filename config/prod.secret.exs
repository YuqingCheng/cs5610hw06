use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :tasktracker, TasktrackerWeb.Endpoint,
  secret_key_base: "Lu/mzdJKbOQKp9WUFdL/Bq9m5S3s6HTvMOAqWfQOdymXc61rroE6Lrws3ucYoEX1"

# Configure your database
config :tasktracker, Tasktracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tasktracker_dev",
  pool_size: 15
