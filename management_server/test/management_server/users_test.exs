defmodule ManagementServer.UsersTest do
  use ManagementServer.DataCase

  alias ManagementServer.{Users, Accounts, Organizations}

  describe "users" do
    alias ManagementServer.{Users.User, Accounts.Account, Organizations.Organization}

    import ManagementServer.UsersFixtures

    @invalid_attrs %{biography: nil, full_name: nil, gender: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      user_name = Map.get(user, :full_name)
      assert Enum.any?(Users.list_users(), fn u -> Map.get(u, :full_name) == user_name end)
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      {:ok, %Account{} = account} =
        Accounts.create_account(%{
          email: "test@example.com",
          hash_password: "some hash_password"
        })

      {:ok, %Organization{} = organization} =
        Organizations.create_organization(%{name: "some name"})

      valid_attrs = %{
        biography: "some biography",
        full_name: "some full_name",
        gender: "some gender",
        organization_id: organization.id
      }

      assert {:ok, %User{} = user} = Users.create_user(account, valid_attrs)
      assert user.biography == "some biography"
      assert user.full_name == "some full_name"
      assert user.gender == "some gender"
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        biography: "some updated biography",
        full_name: "some updated full_name",
        gender: "some updated gender"
      }

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.biography == "some updated biography"
      assert user.full_name == "some updated full_name"
      assert user.gender == "some updated gender"
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
