defmodule ManagementServer.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "locations" do
    field(:address, :string)
    field(:location, :map)
    field(:name, :string)
    field(:type, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    has_many(:location_form, ManagementServer.LocationsForms.LocationForm)
    has_many(:forms, through: [:location_form, :form])

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:id, :name, :location, :address, :type, :organization_id])
    |> validate_required([:name, :location, :address])
  end
end
