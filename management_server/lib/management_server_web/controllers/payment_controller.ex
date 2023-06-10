defmodule ManagementServerWeb.PaymentController do
  use ManagementServerWeb, :controller

  alias ManagementServer.Payments
  alias ManagementServer.Payments.Payment

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn = %{assigns: %{organization_id: organization_id}}, _params) do
    payments = Payments.list_payments(organization_id)
    render(conn, "index.json", payments: payments)
  end

  def create(
        conn = %{assigns: %{organization_id: organization_id, account: %{user: %{id: user_id}}}},
        %{
          "payment" => payment_params
        }
      ) do
    payment_params =
      payment_params
      |> Map.put("organization_id", organization_id)
      |> Map.put("assignee_user_id", user_id)
      |> Map.put("status", "created")

    with {:ok, %Payment{} = payment} <- Payments.create_payment(payment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)
    render(conn, "show.json", payment: payment)
  end

  def update(conn, %{"id" => id, "payment" => payment_params}) do
    payment = Payments.get_payment!(id)

    with {:ok, %Payment{} = payment} <- Payments.update_payment(payment, payment_params) do
      render(conn, "show.json", payment: payment)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)

    with {:ok, %Payment{}} <- Payments.delete_payment(payment) do
      send_resp(conn, :no_content, "")
    end
  end
end
