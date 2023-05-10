defmodule ManagementServer.Repo.Migrations.AddOrganizationIdToAccountTabel do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :delete_all),
        null: false
      )
    end
  end

  def down do
    alter table(:users) do
      remove(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :delete_all),
        null: false
      )
    end
  end
end
