defmodule ManagementServer.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]

  schema "payments" do
    field(:ammount, :decimal)
    field(:description, :string)
    field(:name, :string)
    field(:priority, :integer)
    field(:status, :string)

    belongs_to(:organization, ManagementServer.Organizations.Organization,
      foreign_key: :organization_id,
      type: :integer
    )

    belongs_to(:assigned_user, ManagementServer.Users.User,
      foreign_key: :assigned_user_id,
      type: :binary_id
    )

    belongs_to(:assignee_user, ManagementServer.Users.User,
      foreign_key: :assignee_user_id,
      type: :binary_id
    )

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :name,
      :description,
      :status,
      :ammount,
      :priority,
      :organization_id,
      :assigned_user_id,
      :assignee_user_id
    ])
    |> validate_required([:name, :description, :status, :ammount, :priority])
  end
end
