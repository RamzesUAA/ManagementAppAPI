defmodule ManagementServer.FormTypes.FormType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]

  schema "form_types" do
    field(:fields, :map)
    field(:name, :string)
    field(:label, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    timestamps()
  end

  @doc false
  def changeset(form_type, attrs) do
    form_type
    |> cast(attrs, [:name, :fields, :label, :organization_id])
    |> validate_required([:name, :fields])
  end
end
