defmodule ManagementServer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:full_name, :string)
      add(:gender, :string)
      add(:biography, :text)
      add(:account_id, references(:accounts, on_delete: :delete_all, type: :binary_id))

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(index(:users, [:account_id, :full_name]))
  end

  def down do
    drop(table(:users))
  end
end
