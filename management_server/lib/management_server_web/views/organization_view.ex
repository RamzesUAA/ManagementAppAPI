defmodule ManagementServerWeb.OrganizationView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.OrganizationView
  alias ManagementServerWeb.RoleView

  def render("index.json", %{organizations: organizations}) do
    %{data: render_many(organizations, OrganizationView, "organization.json")}
  end

  def render("show.json", %{organization: organization}) do
    %{data: render_one(organization, OrganizationView, "organization.json")}
  end

  def render("organization.json", %{organization: organization}) do
    %{
      id: organization.id,
      name: organization.name
    }
  end

  def render("organization_with_roles.json", %{organization: organization}) do
    %{
      id: organization.id,
      name: organization.name,
      roles: render_many(organization.roles, RoleView, "role.json")
    }
  end

  def render("orgs_with_roles.json", %{organizations: organizations}) do
    %{data: render_many(organizations, OrganizationView, "organization_with_roles.json")}
  end
end
