defmodule ManagementServerWeb.PermissionView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.PermissionView

  def render("index.json", %{permissions: permissions}) do
    %{data: render_many(permissions, PermissionView, "permission.json")}
  end

  def render("show.json", %{permission: permission}) do
    %{data: render_one(permission, PermissionView, "permission.json")}
  end

  def render("permission.json", %{permission: permission}) do
    %{
      id: permission.id,
      permission_name: permission.permission_name
    }
  end
end
