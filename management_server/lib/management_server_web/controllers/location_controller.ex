defmodule ManagementServerWeb.LocationController do
  use ManagementServerWeb, :controller

  alias ManagementServer.Locations
  alias ManagementServer.Locations.Location

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn, _params) do
    locations = Locations.list_locations(conn)
    render(conn, "index.json", locations: locations)
  end

  def create(conn = %{assigns: %{organization_id: organization_id}}, %{
        "location" => location_params
      }) do
    location_params = Map.put(location_params, "organization_id", organization_id)

    with {:ok, %Location{} = location} <- Locations.create_location(location_params) do
      conn
      |> put_status(:created)
      |> render("show.json", location: location)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Locations.get_location!(id)
    render(conn, "show_with_forms.json", location: location)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Locations.get_location!(id)

    with {:ok, %Location{} = location} <- Locations.update_location(location, location_params) do
      render(conn, "show.json", location: location)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Locations.get_location!(id)

    with {:ok, %Location{}} <- Locations.delete_location(location) do
      send_resp(conn, :no_content, "")
    end
  end
end
