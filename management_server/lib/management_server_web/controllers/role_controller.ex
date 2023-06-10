defmodule ManagementServerWeb.RoleController do
  use ManagementServerWeb, :controller

  alias ManagementServer.{Roles, Permissions}
  alias ManagementServer.{Roles.Role, Permissions.Permission}

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn, _params) do
    roles = Roles.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params, "permissions" => permission_params}) do
    with {:ok, %Role{} = role} <- Roles.create_role(role_params),
         {:ok, permissions} <-
           Permissions.create_permission(permission_params, role) do
      conn
      |> put_status(:created)
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Roles.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Roles.get_role!(id)

    with {:ok, %Role{} = role} <- Roles.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Roles.get_role!(id)

    with {:ok, %Role{}} <- Roles.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
