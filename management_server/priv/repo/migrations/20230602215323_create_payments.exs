defmodule ManagementServer.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def up do
    create table(:payments, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:description, :string)
      add(:status, :string)
      add(:ammount, :decimal)
      add(:priority, :integer)

      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :nothing),
        null: false
      )

      add(:assigned_user_id, references(:users, on_delete: :nothing, type: :binary_id))
      add(:assignee_user_id, references(:users, on_delete: :nothing, type: :binary_id))

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:payments, [:organization_id]))
    create(index(:payments, [:assigned_user_id]))
    create(index(:payments, [:assignee_user_id]))
  end

  def down do
    drop(table(:payments))
  end
end
