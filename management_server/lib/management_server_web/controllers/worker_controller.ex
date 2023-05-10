defmodule ManagementServerWeb.WorkerController do
  use ManagementServerWeb, :controller

  alias ManagementServer.{Workers, LocationsWorkers}
  alias ManagementServer.{Workers.Worker, LocationsWorkers.LocationWorker}

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn, _params) do
    workers = Workers.list_workers()
    render(conn, "index.json", workers: workers)
  end

  def create(conn = %{assigns: %{organization_id: organization_id}}, %{
        "worker" => worker_params,
        "locations" => locations_params
      }) do
    worker_params = Map.put(worker_params, "organization_id", organization_id)

    with {:ok, %Worker{} = worker} <- Workers.create_worker(worker_params),
         {:ok, _count} <-
           LocationsWorkers.create_location_worker(worker.id, locations_params) do
      conn
      |> put_status(:created)
      |> render("show.json", worker: worker)
    end
  end

  def show(conn, %{"id" => id}) do
    worker = Workers.get_worker!(id)
    render(conn, "show_with_locations.json", worker: worker)
  end

  def update(conn, %{"id" => id, "worker" => worker_params}) do
    worker = Workers.get_worker!(id)

    with {:ok, %Worker{} = worker} <- Workers.update_worker(worker, worker_params) do
      render(conn, "show.json", worker: worker)
    end
  end

  def delete(conn, %{"id" => id}) do
    worker = Workers.get_worker!(id)

    with {:ok, %Worker{}} <- Workers.delete_worker(worker) do
      send_resp(conn, :no_content, "")
    end
  end
end
