defmodule ManagementServer.PermissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Permissions` context.
  """

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()

    {:ok, permission} =
      attrs
      |> Enum.into(%{
        permission_name: "some permission_name",
        organization_id: organization.id
      })
      |> ManagementServer.Permissions.create_permission()

    permission
  end
end
