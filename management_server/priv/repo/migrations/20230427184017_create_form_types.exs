defmodule ManagementServer.Repo.Migrations.CreateFormTypes do
  use Ecto.Migration

  def up do
    create table(:form_types, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:fields, :map)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:form_types, [:organization_id]))
  end

  def down do
    drop(table(:form_types))
  end
end
