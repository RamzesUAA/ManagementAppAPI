defmodule ManagementServer.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()

    {:ok, event} =
      attrs
      |> Enum.into(%{
        allDay: true,
        end: ~U[2023-04-30 13:54:00Z],
        start: ~U[2023-04-30 13:54:00Z],
        title: "some title",
        organization_id: organization.id
      })
      |> ManagementServer.Events.create_event()

    event
  end
end
