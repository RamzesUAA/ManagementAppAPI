defmodule ManagementServer.PermissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Permissions` context.
  """

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{
        permission_name: "some permission_name"
      })
      |> ManagementServer.Permissions.create_permission()

    permission
  end
end
