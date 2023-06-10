defmodule ManagementServerWeb.Auth.SetAccount do
  import Plug.Conn
  alias ManagementServerWeb.Auth.ErrorResponse
  alias ManagementServer.Accounts

  def init(_options) do
  end

  def call(conn, options) do
    if conn.assigns[:account] do
      conn
    else
      account_id = get_session(conn, :account_id)

      if account_id == nil, do: raise(ErrorResponse.Unauthorized)

      account = Accounts.get_full_account!(account_id)

      cond do
        account_id && account ->
          conn
          |> assign(:organization_id, convert_to_int(account.user.organization_id))
          |> assign(:account, account)

        true ->
          assign(conn, :account, nil)
      end
    end
  rescue
    _ ->
      raise(ErrorResponse.Unauthorized)
  end

  defp set_organization_id(conn, organization_id) do
    Conn.assign(conn, :organization_id, convert_to_int(organization_id))
  end

  defp convert_to_int(id) when is_binary(id) do
    {id, _} = Integer.parse(id)
    id
  end

  defp convert_to_int(id), do: id
end
