defmodule ManagementServer.Permissions.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "permissions" do
    field(:permission_name, :string)
    field(:organization_id, :binary_id)
    field(:role_id, :binary_id)

    timestamps()
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:permission_name])
    |> validate_required([:permission_name])
  end
end
