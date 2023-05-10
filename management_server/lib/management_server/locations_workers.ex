defmodule ManagementServer.LocationsWorkers do
  @moduledoc """
  The Workers context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias ManagementServer.Repo

  alias ManagementServer.LocationsWorkers.LocationWorker

  def create_location_worker(worker_id, locations_params \\ %{}) do
    maps =
      Enum.map(locations_params, fn attr ->
        %{location_id: attr, worker_id: worker_id}
      end)

    {count, _} = Repo.insert_all(LocationWorker, maps)

    {:ok, %{count: count}}
  end
end
