defmodule ManagementServer.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @timestamps_opts [type: :utc_datetime_usec]

  schema "roles" do
    field(:name, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    has_many(:user_roles, ManagementServer.UsersRoles.UserRole)
    has_many(:users, through: [:user_roles, :user])

    timestamps()
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name])
  end
end
