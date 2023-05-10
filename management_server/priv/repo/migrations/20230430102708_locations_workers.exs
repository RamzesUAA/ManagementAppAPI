defmodule ManagementServer.Repo.Migrations.LocationsWorkers do
  use Ecto.Migration

  def up do
    create table(:locations_workers, primary_key: false) do
      add(:id, :binary_id, primary_key: true)

      add(
        :location_id,
        references(:locations, type: :binary_id, on_delete: :nothing),
        null: false
      )

      add(
        :worker_id,
        references(:workers, type: :binary_id, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end
  end

  def down do
    drop(table(:locations_workers))
  end
end
