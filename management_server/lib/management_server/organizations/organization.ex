defmodule ManagementServer.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  schema "organizations" do
    field(:name, :string)

    has_many(:roles, ManagementServer.Roles.Role)

    timestamps()
  end

  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
