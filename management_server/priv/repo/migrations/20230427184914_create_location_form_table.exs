defmodule ManagementServer.Repo.Migrations.CreateLocationFormTable do
  use Ecto.Migration

  def up do
    create table(:locations_forms, primary_key: false) do
      add(:id, :binary_id, primary_key: true)

      add(
        :form_id,
        references(:forms, type: :binary_id, on_delete: :nothing),
        null: false
      )

      add(
        :location_id,
        references(:locations, type: :binary_id, on_delete: :nothing),
        null: false
      )

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end
  end

  def down do
    drop(table(:locations_forms))
  end
end
