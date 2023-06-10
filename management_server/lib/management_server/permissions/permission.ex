defmodule ManagementServer.Permissions.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "permissions" do
    field(:permission_name, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    belongs_to(:role, ManagementServer.Roles.Role,
      foreign_key: :role_id,
      type: :binary_id
    )

    timestamps()
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:permission_name, :organization_id, :role_id])
    |> validate_required([:permission_name])
  end
end
