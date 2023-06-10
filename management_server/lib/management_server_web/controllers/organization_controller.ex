defmodule ManagementServerWeb.OrganizationController do
  use ManagementServerWeb, :controller

  alias ManagementServer.Organizations
  alias ManagementServer.Organizations.Organization

  alias ManagementServerWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias ManagementServer.{Accounts, Accounts.Account, Users, Users.User}

  import ManagementServerWeb.Auth.AuthorizedPlug
  import Plug.Conn.Status, only: [code: 1]

  plug(:is_authorized when action in [:update, :delete])

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn, _params) do
    organizations = Organizations.list_organizations()
    render(conn, "index.json", organizations: organizations)
  end

  def organizations_with_roles(conn, _params) do
    organizations = Organizations.list_organizations_with_roles()
    render(conn, "orgs_with_roles.json", organizations: organizations)
  end

  def create(conn, %{"organization" => organization_params}) do
    with {:ok, %Organization{} = organization} <-
           Organizations.create_organization(organization_params) do
      conn
      |> put_status(:created)
      |> render("show.json", organization: organization)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Organizations.get_organization!(id)
    render(conn, "show.json", organization: organization)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Organizations.get_organization!(id)

    with {:ok, %Organization{} = organization} <-
           Organizations.update_organization(organization, organization_params) do
      render(conn, "show.json", organization: organization)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Organizations.get_organization!(id)

    with {:ok, %Organization{}} <- Organizations.delete_organization(organization) do
      send_resp(conn, :no_content, "")
    end
  end
end
