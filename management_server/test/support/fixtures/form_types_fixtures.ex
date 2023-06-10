defmodule ManagementServer.FormTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.FormTypes` context.
  """

  @doc """
  Generate a form_type.
  """
  def form_type_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()

    {:ok, form_type} =
      attrs
      |> Enum.into(%{
        fields: %{},
        name: "some name",
        organization_id: organization.id
      })
      |> ManagementServer.FormTypes.create_form_type()

    form_type
  end
end
