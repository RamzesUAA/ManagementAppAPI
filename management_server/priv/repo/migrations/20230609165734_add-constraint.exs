defmodule :"Elixir.ManagementServer.Repo.Migrations.Add-constraint" do
  use Ecto.Migration

  def up do
    drop_if_exists(constraint("locations_workers", "locations_workers_worker_id_fkey"))
    drop_if_exists(constraint("locations_workers", "locations_workers_location_id_fkey"))

    alter table(:locations_workers) do
      modify(:worker_id, references(:workers, type: :binary_id, on_delete: :delete_all))
      modify(:location_id, references(:locations, type: :binary_id, on_delete: :delete_all))
    end

    drop_if_exists(constraint("locations_forms", "locations_forms_form_id_fkey"))
    drop_if_exists(constraint("locations_forms", "locations_forms_location_id_fkey"))
    drop_if_exists(constraint("locations_forms", "locations_forms_organization_id_fkey"))

    alter table(:locations_forms) do
      modify(:form_id, references(:forms, type: :binary_id, on_delete: :delete_all))
      modify(:location_id, references(:locations, type: :binary_id, on_delete: :delete_all))

      modify(
        :organization_id,
        references(:organizations, type: :integer, on_delete: :delete_all)
      )
    end
  end

  def down do
    drop_if_exists(constraint("locations_workers", "locations_workers_worker_id_fkey"))
    drop_if_exists(constraint("locations_workers", "locations_workers_location_id_fkey"))

    alter table(:locations_workers) do
      modify(:worker_id, references(:workers, type: :binary_id))
      modify(:location_id, references(:locations, type: :binary_id))
    end

    drop_if_exists(constraint("locations_forms", "locations_forms_form_id_fkey"))
    drop_if_exists(constraint("locations_forms", "locations_forms_location_id_fkey"))
    drop_if_exists(constraint("locations_forms", "locations_forms_organization_id_fkey"))

    alter table(:locations_forms) do
      modify(:form_id, references(:forms, type: :binary_id))
      modify(:location_id, references(:locations, type: :binary_id))
      modify(:organization_id, references(:organizations, type: :integer))
    end
  end
end
