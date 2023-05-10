defmodule ManagementServer.OrganizationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Organizations` context.
  """

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        id: 42,
        name: "some name"
      })
      |> ManagementServer.Organizations.create_organization()

    organization
  end
end
