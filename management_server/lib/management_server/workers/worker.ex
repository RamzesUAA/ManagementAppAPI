defmodule ManagementServer.Workers.Worker do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "workers" do
    field(:age, :integer)
    field(:description, :string)
    field(:email, :string)
    field(:name, :string)
    field(:position, :string)
    field(:responsibility, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    has_many(:location_workers, ManagementServer.LocationsWorkers.LocationWorker)
    has_many(:locations, through: [:location_workers, :location])

    timestamps()
  end

  @doc false
  def changeset(worker, attrs) do
    worker
    |> cast(attrs, [
      :name,
      :email,
      :age,
      :position,
      :responsibility,
      :description,
      :organization_id
    ])
    |> validate_required([:name, :email, :age, :position, :responsibility, :description])
    |> unique_constraint(:email)
    |> foreign_key_constraint(:location_workers, name: "locations_workers_worker_id_fkey")
  end
end
