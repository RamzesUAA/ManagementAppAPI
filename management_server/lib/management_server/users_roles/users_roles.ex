defmodule ManagementServer.UsersRoles.UserRole do
  use Ecto.Schema

  alias __MODULE__
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @timestamps_opts [type: :utc_datetime_usec]

  schema "users_roles" do
    belongs_to(:user, ManagementServer.Users.User)
    belongs_to(:role, ManagementServer.Roles.Role)

    timestamps()
  end

  @required_params ~w(user_id role_id)a
  @optional_params ~w()a

  def changeset(model = %UserRole{}, attrs \\ %{}) do
    model
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> unique_constraint([:user_id, :role_id])
  end
end
