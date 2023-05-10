defmodule ManagementServerWeb.EventController do
  use ManagementServerWeb, :controller

  alias ManagementServer.Events
  alias ManagementServer.Events.Event

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.json", events: events)
  end

  def create(
        conn = %{assigns: %{organization_id: organization_id, account: %{user: %{id: user_id}}}},
        %{
          "event" => event_params
        }
      ) do
    event_params =
      event_params
      |> Map.put("organization_id", organization_id)
      |> Map.put("user_id", user_id)

    with {:ok, %Event{} = event} <- Events.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Events.get_event!(id)

    with {:ok, %Event{} = event} <- Events.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Events.get_event!(id)

    with {:ok, %Event{}} <- Events.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
