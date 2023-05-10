defmodule ManagementServerWeb.WorkerView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.WorkerView
  alias ManagementServerWeb.LocationView

  def render("index.json", %{workers: workers}) do
    %{data: render_many(workers, WorkerView, "worker.json")}
  end

  def render("show.json", %{worker: worker}) do
    %{data: render_one(worker, WorkerView, "worker.json")}
  rescue
    exception ->
      IO.inspect("CCCCCCCcc")

      IO.inspect(exception)
  end

  def render("show_with_locations.json", %{worker: worker}) do
    %{data: render_one(worker, WorkerView, "worker_locations.json")}
  rescue
    exception ->
      IO.inspect("CCCCCCCcc")

      IO.inspect(exception)
  end

  def render("worker.json", %{worker: worker}) do
    %{
      id: worker.id,
      name: worker.name,
      email: worker.email,
      age: worker.age,
      position: worker.position,
      organization_id: worker.organization_id,
      responsibility: worker.responsibility,
      description: worker.description
    }
  end

  def render("worker_locations.json", %{worker: worker}) do
    locations = Enum.map(worker.location_workers, &serialize/1)

    %{
      id: worker.id,
      name: worker.name,
      email: worker.email,
      organization_id: worker.organization_id,
      age: worker.age,
      locations: render_many(locations, LocationView, "location.json"),
      position: worker.position,
      responsibility: worker.responsibility,
      description: worker.description
    }
  end

  defp serialize(location_worker) do
    Map.get(location_worker, :location)
  end
end
