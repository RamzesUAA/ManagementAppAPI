defmodule ManagementServer.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
  end

  def up do
    create table(:locations, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:location, :map)
      add(:address, :string)
      add(:type, :string)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:locations, [:organization_id]))
  end

  def down do
    drop(table(:locations))
  end
end
