defmodule ManagementServer.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def up do
    create table(:forms, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:data, :map)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      add(:form_type_id, references(:form_types, on_delete: :nothing, type: :binary_id))

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:forms, [:organization_id]))
    create(index(:forms, [:form_type_id]))
  end

  def down do
    drop(table(:forms))
  end
end
