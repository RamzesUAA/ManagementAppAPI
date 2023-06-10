defmodule ManagementServer.LocationsForms.LocationForm do
  use Ecto.Schema

  alias __MODULE__
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "locations_forms" do
    belongs_to(:location, ManagementServer.Locations.Location)
    belongs_to(:form, ManagementServer.Forms.Form)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    timestamps()
  end

  @required_params ~w(location_id form_id organization_id)a
  @optional_params ~w()a

  def changeset(model = %LocationForm{}, attrs \\ %{}) do
    model
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> unique_constraint([:location_id, :form_id])
  end
end
