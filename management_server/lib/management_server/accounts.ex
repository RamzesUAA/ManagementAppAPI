defmodule ManagementServer.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ManagementServer.Repo

  alias ManagementServer.{
    Accounts.Account,
    Roles.Role,
    UsersRoles.UserRole,
    Permissions.Permission
  }

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  def get_full_account!(id) do
    account =
      Account
      |> where(id: ^id)
      |> Repo.one()
      |> Repo.preload([:user])

    roles =
      UserRole
      |> join(:inner, [ur], r in assoc(ur, :role))
      |> join(:inner, [ur, r], p in Permission, on: r.id == p.role_id)
      |> where([ur, r, p], ur.user_id == ^account.user.id)
      |> select([ur, r, p], %{
        id: r.id,
        name: r.name,
        permission_id: p.id,
        permission_name: p.permission_name
      })
      |> Repo.all()

    permissions =
      roles
      |> Enum.group_by(&{&1.id, &1.name}, fn %{permission_id: pid, permission_name: pname} ->
        %{permission_id: pid, permission_name: pname}
      end)
      |> Enum.map(fn {{role_id, role_name}, permissions} ->
        %{role_id: role_id, role_name: role_name, permissions: permissions}
      end)

    Map.put(account, :permissions, permissions)
  rescue
    e ->
      e
  end

  @doc """
  Gets single account.any()

  Returns 'nil' if the  Account does not exist.

  ## Example

    iex> get_account_by_email(test@email.com)
    %Account{}

    iex> get_account_by_email(no_account@email.com)
    nil
  """
  def get_account_by_email(email) do
    Account
    |> where(email: ^email)
    |> Repo.one()
  end

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end
end
