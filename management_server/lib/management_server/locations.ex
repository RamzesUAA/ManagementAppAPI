defmodule ManagementServer.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias ManagementServer.Repo

  alias ManagementServer.{
    Locations.Location,
    Forms.Form,
    FormTypes.FormType,
    LocationsForms.LocationForm
  }

  def list_locations(%{assigns: %{account: %{user: %{organization_id: organization_id}}}}) do
    Location
    |> where([l], l.organization_id == ^organization_id)
    |> Repo.all()
  end

  def get_location!(id) do
    result =
      Location
      |> where([l], l.id == ^id)
      |> Repo.one()

    location_forms =
      LocationForm
      |> join(:inner, [lf], f in assoc(lf, :form))
      |> join(:inner, [lf, f], ft in FormType, on: ft.id == f.form_type_id)
      |> where([lf, f], lf.location_id == ^id)
      |> select([lf, f, ft], %{
        id: f.id,
        name: f.name,
        form_type_id: ft.id,
        form_type_name: ft.name,
        form_type_label: ft.label
      })
      |> Repo.all()
      |> Enum.group_by(& &1.form_type_label)

    Map.put(result, :forms, location_forms)
  end

  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end
end
