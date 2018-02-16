defmodule Tasktracker.ScheduleTest do
  use Tasktracker.DataCase

  alias Tasktracker.Schedule

  describe "tasks" do
    alias Tasktracker.Schedule.Task

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Schedule.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Schedule.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Schedule.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Schedule.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_task(task, @invalid_attrs)
      assert task == Schedule.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Schedule.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Schedule.change_task(task)
    end
  end

  describe "assignments" do
    alias Tasktracker.Schedule.Assignment

    @valid_attrs %{time: 42}
    @update_attrs %{time: 43}
    @invalid_attrs %{time: nil}

    def assignment_fixture(attrs \\ %{}) do
      {:ok, assignment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_assignment()

      assignment
    end

    test "list_assignments/0 returns all assignments" do
      assignment = assignment_fixture()
      assert Schedule.list_assignments() == [assignment]
    end

    test "get_assignment!/1 returns the assignment with given id" do
      assignment = assignment_fixture()
      assert Schedule.get_assignment!(assignment.id) == assignment
    end

    test "create_assignment/1 with valid data creates a assignment" do
      assert {:ok, %Assignment{} = assignment} = Schedule.create_assignment(@valid_attrs)
      assert assignment.time == 42
    end

    test "create_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_assignment(@invalid_attrs)
    end

    test "update_assignment/2 with valid data updates the assignment" do
      assignment = assignment_fixture()
      assert {:ok, assignment} = Schedule.update_assignment(assignment, @update_attrs)
      assert %Assignment{} = assignment
      assert assignment.time == 43
    end

    test "update_assignment/2 with invalid data returns error changeset" do
      assignment = assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_assignment(assignment, @invalid_attrs)
      assert assignment == Schedule.get_assignment!(assignment.id)
    end

    test "delete_assignment/1 deletes the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{}} = Schedule.delete_assignment(assignment)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_assignment!(assignment.id) end
    end

    test "change_assignment/1 returns a assignment changeset" do
      assignment = assignment_fixture()
      assert %Ecto.Changeset{} = Schedule.change_assignment(assignment)
    end
  end
end
