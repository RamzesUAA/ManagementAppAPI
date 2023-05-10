defmodule ManagementServer.WorkersTest do
  use ManagementServer.DataCase

  alias ManagementServer.Workers

  describe "workers" do
    alias ManagementServer.Workers.Worker

    import ManagementServer.WorkersFixtures

    @invalid_attrs %{age: nil, description: nil, email: nil, name: nil, position: nil, responsibility: nil}

    test "list_workers/0 returns all workers" do
      worker = worker_fixture()
      assert Workers.list_workers() == [worker]
    end

    test "get_worker!/1 returns the worker with given id" do
      worker = worker_fixture()
      assert Workers.get_worker!(worker.id) == worker
    end

    test "create_worker/1 with valid data creates a worker" do
      valid_attrs = %{age: 42, description: "some description", email: "some email", name: "some name", position: "some position", responsibility: "some responsibility"}

      assert {:ok, %Worker{} = worker} = Workers.create_worker(valid_attrs)
      assert worker.age == 42
      assert worker.description == "some description"
      assert worker.email == "some email"
      assert worker.name == "some name"
      assert worker.position == "some position"
      assert worker.responsibility == "some responsibility"
    end

    test "create_worker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workers.create_worker(@invalid_attrs)
    end

    test "update_worker/2 with valid data updates the worker" do
      worker = worker_fixture()
      update_attrs = %{age: 43, description: "some updated description", email: "some updated email", name: "some updated name", position: "some updated position", responsibility: "some updated responsibility"}

      assert {:ok, %Worker{} = worker} = Workers.update_worker(worker, update_attrs)
      assert worker.age == 43
      assert worker.description == "some updated description"
      assert worker.email == "some updated email"
      assert worker.name == "some updated name"
      assert worker.position == "some updated position"
      assert worker.responsibility == "some updated responsibility"
    end

    test "update_worker/2 with invalid data returns error changeset" do
      worker = worker_fixture()
      assert {:error, %Ecto.Changeset{}} = Workers.update_worker(worker, @invalid_attrs)
      assert worker == Workers.get_worker!(worker.id)
    end

    test "delete_worker/1 deletes the worker" do
      worker = worker_fixture()
      assert {:ok, %Worker{}} = Workers.delete_worker(worker)
      assert_raise Ecto.NoResultsError, fn -> Workers.get_worker!(worker.id) end
    end

    test "change_worker/1 returns a worker changeset" do
      worker = worker_fixture()
      assert %Ecto.Changeset{} = Workers.change_worker(worker)
    end
  end
end
