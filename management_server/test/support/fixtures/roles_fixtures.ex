defmodule ManagementServer.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Roles` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        id: 1,
        name: "some name"
      })
      |> ManagementServer.Organizations.create_organization()

    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name",
        organization_id: organization.id
      })
      |> ManagementServer.Roles.create_role()

    role
  end
end
