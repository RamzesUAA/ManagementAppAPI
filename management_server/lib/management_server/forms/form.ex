defmodule ManagementServer.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "forms" do
    field(:data, :map)
    field(:name, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    field(:form_type_id, :binary_id)
    has_one(:form_type, ManagementServer.FormTypes.FormType)

    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:name, :data, :organization_id, :form_type_id])
    |> validate_required([:name, :data])
  end
end
