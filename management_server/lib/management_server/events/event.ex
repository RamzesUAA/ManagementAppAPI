defmodule ManagementServer.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]

  schema "events" do
    field(:allDay, :boolean, default: false)
    field(:end, :utc_datetime)
    field(:start, :utc_datetime)
    field(:title, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    belongs_to(:user, ManagementServer.Users.User,
      foreign_key: :user_id,
      type: :binary_id
    )

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :start, :end, :allDay, :organization_id, :user_id])
    |> validate_required([:title, :start, :end, :allDay])
  end
end
