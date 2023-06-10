defmodule ManagementServer.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    organization = ManagementServer.OrganizationsFixtures.organization_fixture()
    account = ManagementServer.AccountsFixtures.account_fixture()

    attrs =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        full_name: "some full_name",
        gender: "some gender",
        organization_id: organization.id
      })

    {:ok, user} = ManagementServer.Users.create_user(account, attrs)

    user
  end
end
