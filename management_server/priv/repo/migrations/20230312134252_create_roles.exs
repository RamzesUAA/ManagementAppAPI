defmodule ManagementServer.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def up do
    create table(:roles, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:roles, [:organization_id]))
  end

  def down do
    drop(table(:roles))
  end
end
