defmodule ManagementServer.LocationsForms do
  @moduledoc """
  The LocationForm context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias ManagementServer.Repo

  alias ManagementServer.LocationsForms.LocationForm

  def create_location_form(form_id, locations_params \\ %{}) do
    locations = locations_params["locations"]
    organization_id = locations_params["organization_id"]

    maps =
      Enum.map(locations, fn attr ->
        %{location_id: attr, form_id: form_id, organization_id: organization_id}
      end)

    {count, _} = Repo.insert_all(LocationForm, maps)

    {:ok, %{count: count}}
  end
end
