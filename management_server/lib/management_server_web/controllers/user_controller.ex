defmodule ManagementServerWeb.UserController do
  use ManagementServerWeb, :controller

  alias ManagementServer.Users
  alias ManagementServer.Users.User

  import ManagementServerWeb.Auth.AuthorizedPlug

  plug(:is_authorized when action in [:update, :delete])

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.update_user(conn.assigns.account.user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
