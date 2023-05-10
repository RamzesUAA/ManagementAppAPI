defmodule ManagementServer.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def up do
    create table(:permissions, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:permission_name, :string)
      add(:organization_id, references(:organizations, on_delete: :nothing, type: :integer))
      add(:role_id, references(:roles, on_delete: :nothing, type: :binary_id))

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:permissions, [:organization_id, :role_id]))
  end

  def down do
    drop(table(:permissions))
  end
end
