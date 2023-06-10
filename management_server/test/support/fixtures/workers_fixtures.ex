defmodule ManagementServer.WorkersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Workers` context.
  """

  @doc """
  Generate a worker.
  """
  def worker_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()

    {:ok, worker} =
      attrs
      |> Enum.into(%{
        age: 42,
        description: "some description",
        email: "some email",
        name: "some name",
        position: "some position",
        responsibility: "some responsibility",
        organization_id: organization.id
      })
      |> ManagementServer.Workers.create_worker()

    worker
  end
end
