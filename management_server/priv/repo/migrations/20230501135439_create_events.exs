defmodule ManagementServer.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def up do
    create table(:events, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:title, :string)
      add(:start, :utc_datetime)
      add(:end, :utc_datetime)
      add(:allDay, :boolean, default: false, null: false)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      add(:user_id, references(:users, on_delete: :nothing, type: :binary_id))

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:events, [:organization_id]))
    create(index(:events, [:user_id]))
  end

  def down do
    drop(table(:events))
  end
end
