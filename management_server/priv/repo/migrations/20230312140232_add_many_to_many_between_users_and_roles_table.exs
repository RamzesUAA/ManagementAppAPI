defmodule ManagementServer.Repo.Migrations.AddManyToManyBetweenUsersAndRolesTable do
  use Ecto.Migration

  def up do
    create table(:users_roles, primary_key: false) do
      add(:id, :binary_id, primary_key: true)

      add(
        :role_id,
        references(:roles, type: :binary_id, on_delete: :nothing),
        null: false
      )

      add(
        :user_id,
        references(:users, type: :binary_id, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end
  end

  def down do
    drop(table(:users_roles))
  end
end
