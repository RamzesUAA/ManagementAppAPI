defmodule ManagementServer.FormTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.FormTypes` context.
  """

  @doc """
  Generate a form_type.
  """
  def form_type_fixture(attrs \\ %{}) do
    {:ok, form_type} =
      attrs
      |> Enum.into(%{
        fields: %{},
        name: "some name"
      })
      |> ManagementServer.FormTypes.create_form_type()

    form_type
  end
end
