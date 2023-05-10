defmodule ManagementServer.LocationsWorkers.LocationWorker do
  use Ecto.Schema

  alias __MODULE__
  import(Ecto.Changeset)

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "locations_workers" do
    belongs_to(:location, ManagementServer.Locations.Location,
      foreign_key: :location_id,
      type: :binary_id
    )

    belongs_to(:worker, ManagementServer.Workers.Worker,
      foreign_key: :worker_id,
      type: :binary_id
    )

    timestamps()
  end

  @required_params ~w(location_id worker_id)a
  @optional_params ~w()a

  def changeset(model = %LocationWorker{}, attrs \\ %{}) do
    model
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> unique_constraint([:location_id, :worker_id])
  end
end
