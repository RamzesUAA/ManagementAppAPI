defmodule ManagementServerWeb.AccountController do
  use ManagementServerWeb, :controller
  use PhoenixSwagger

  alias ManagementServerWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias ManagementServer.{Accounts, Accounts.Account, Users, Users.User}

  import ManagementServerWeb.Auth.AuthorizedPlug
  import Plug.Conn.Status, only: [code: 1]

  plug(:is_authorized when action in [:update, :delete])

  action_fallback(ManagementServerWeb.FallbackController)

  def swagger_definitions do
    %{
      Account:
        swagger_schema do
          title("Account request body")
          description("The body of a request used to create or update a Account")

          properties do
            data(
              Schema.new do
                properties do
                  attributes(
                    :object,
                    "The intended attributes of the Account"
                  )
                end
              end
            )
          end
        end
    }
  end

  swagger_path :create do
    post("api/accounts")

    tag("Create account")
    summary("Create account")
    description("Create account")
    produces("application/json")
    operation_id("create_account")

    parameters do
      data(
        :body,
        Schema.ref(:Account),
        "Account payload in JSON-API format; This data is used to create the Account"
      )
    end

    response(200, "OK", Schema.ref(:Account))
    response(500, "Server Error")
  end

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["hash_password"])
    end
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    authorize_account(conn, email, hash_password)
  end

  defp authorize_account(conn, email, hash_password) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render("account_token.json", %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def refresh_session(conn, %{}) do
    token = Guardian.Plug.current_token(conn)
    {:ok, account, new_token} = Guardian.authenticate(token)

    conn
    |> Plug.Conn.put_session(:account_id, account.id)
    |> put_status(:ok)
    |> render("account_token.json", %{account: account, token: new_token})
  end

  def sign_out(conn, %{}) do
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("account_token.json", %{account: account, token: nil})
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_full_account!(id)
    render(conn, "full_account.json", account: account)
  end

  def current_account(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render("full_account.json", %{account: conn.assigns.account})
  end

  def update(conn, %{"current_hash" => current_hash, "account" => account_params}) do
    case Guardian.validate_password(current_hash, conn.assigns.account.hash_password) do
      true ->
        {:ok, account} = Accounts.update_account(conn.assigns.account, account_params)
        render(conn, "show.json", account: account)

      false ->
        raise ErrorResponse.Unauthorized, message: "Password incorrect."
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
