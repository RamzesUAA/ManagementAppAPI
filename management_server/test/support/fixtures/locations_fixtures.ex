defmodule ManagementServer.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()

    {:ok, location} =
      attrs
      |> Enum.into(%{
        address: "some address",
        location: %{},
        name: "some name",
        organization_id: organization.id
      })
      |> ManagementServer.Locations.create_location()

    location
  end
end
