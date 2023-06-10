defmodule ManagementServer.UsersRoles do
  @moduledoc """
  The User Roles context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias ManagementServer.Repo

  alias ManagementServer.UsersRoles.UserRole

  def create_user_role(user_id, role_id) do
    %UserRole{}
    |> UserRole.changeset(%{user_id: user_id, role_id: role_id})
    |> Repo.insert()
  rescue
    e -> IO.inspect(e)
  end
end
