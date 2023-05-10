defmodule ManagementServer.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @timestamps_opts [type: :utc_datetime_usec]

  schema "users" do
    field(:biography, :string)
    field(:full_name, :string)
    field(:gender, :string)

    belongs_to(:account, ManagementServer.Accounts.Account,
      foreign_key: :account_id,
      type: :binary_id
    )

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    has_many(:user_roles, ManagementServer.UsersRoles.UserRole)
    has_many(:roles, through: [:user_roles, :role])

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :full_name, :gender, :biography, :organization_id])
    |> validate_required([:account_id])
  end
end
