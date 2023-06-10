defmodule ManagementServer.FormsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Forms` context.
  """

  @doc """
  Generate a form.
  """
  def form_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()

    {:ok, form} =
      attrs
      |> Enum.into(%{
        data: %{},
        name: "some name",
        organization_id: organization.id
      })
      |> ManagementServer.Forms.create_form()

    form
  end
end
