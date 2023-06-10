defmodule ManagementServer.AccountsTest do
  use ManagementServer.DataCase

  alias ManagementServer.Accounts

  describe "accounts" do
    alias ManagementServer.Accounts.Account

    import ManagementServer.AccountsFixtures

    @invalid_attrs %{email: "invalid", hash_password: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{email: "test@example.com", hash_password: "some hash_password"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.email == "test@example.com"

      # Using verify_pass to verify the hashed password
      assert Bcrypt.verify_pass("some hash_password", account.hash_password)
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{email: "updated@example.com", hash_password: "some updated hash_password"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.email == "updated@example.com"

      # Using verify_pass to verify the hashed password
      assert Bcrypt.verify_pass("some updated hash_password", account.hash_password)
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
