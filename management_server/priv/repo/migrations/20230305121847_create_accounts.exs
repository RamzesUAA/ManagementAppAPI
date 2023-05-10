defmodule ManagementServer.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def up do
    create table(:accounts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:email, :string)
      add(:hash_password, :string)

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    create(unique_index(:accounts, [:email]))
  end

  def down do
    drop(table(:accounts))
  end
end
