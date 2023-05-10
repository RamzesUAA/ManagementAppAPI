defmodule ManagementServer.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def up do
    create table(:organizations, primary_key: false) do
      add(:id, :integer, primary_key: true, null: false)
      add(:name, :string)

      timestamps(type: :timestamptz, default: fragment("NOW()"))
    end

    execute("CREATE SEQUENCE IF NOT EXISTS organization_id_seq START 1;")

    execute(
      "ALTER TABLE organizations ALTER COLUMN id SET DEFAULT nextval('organization_id_seq');"
    )
  end

  def down do
    drop(table(:organizations))
  end
end
