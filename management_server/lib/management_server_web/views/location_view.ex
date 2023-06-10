defmodule ManagementServerWeb.LocationView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.LocationView
  alias ManagementServerWeb.FormView

  def render("index.json", %{locations: locations}) do
    %{data: render_many(locations, LocationView, "location.json")}
  end

  def render("show.json", %{location: location}) do
    %{data: render_one(location, LocationView, "location.json")}
  end

  def render("show_with_forms.json", %{location: location}) do
    %{data: render_one(location, LocationView, "location_forms.json")}
  end

  def render("location.json", %{location: location}) do
    %{
      id: location.id,
      organization_id: location.organization_id,
      name: location.name,
      location: location.location,
      type: location.type,
      updated_at: location.updated_at,
      address: location.address
    }
  end

  def render("location_forms.json", %{location: location}) do
    %{
      id: location.id,
      organization_id: location.organization_id,
      name: location.name,
      location: location.location,
      type: location.type,
      updated_at: location.updated_at,
      forms: location.forms,
      address: location.address
    }
  end

  defp serialize(location_form) do
    Map.get(location_form, :form)
  end
end
