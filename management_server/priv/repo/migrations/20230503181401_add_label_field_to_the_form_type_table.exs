defmodule ManagementServer.Repo.Migrations.AddLabelFieldToTheFormTypeTable do
  use Ecto.Migration

  def up do
    alter table(:form_types) do
      add(:label, :string)
    end
  end

  def down do
    alter table(:form_types) do
      remove(:label)
    end
  end
end
