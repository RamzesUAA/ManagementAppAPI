defmodule ManagementServerWeb.EventView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      title: event.title,
      start: event.start,
      end: event.end,
      allDay: event.allDay
    }
  end
end
