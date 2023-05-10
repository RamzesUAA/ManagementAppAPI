defmodule ManagementServer.Repo.Migrations.CreateWorkers do
  use Ecto.Migration

  def up do
    create table(:workers, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:email, :string)
      add(:age, :integer)
      add(:position, :string)
      add(:responsibility, :string)
      add(:description, :string)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end
  end

  def down do
    drop(table(:workers))
  end
end
