defmodule ManagementServerWeb.PaymentView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.PaymentView

  def render("index.json", %{payments: payments}) do
    %{data: render_many(payments, PaymentView, "payment_with_users.json")}
  end

  def render("show.json", %{payment: payment}) do
    %{data: render_one(payment, PaymentView, "payment.json")}
  end

  def render("payment.json", %{payment: payment}) do
    %{
      id: payment.id,
      name: payment.name,
      description: payment.description,
      status: payment.status,
      ammount: payment.ammount,
      priority: payment.priority
    }
  end

  def render("payment_with_users.json", %{payment: payment}) do
    %{
      id: payment.id,
      name: payment.name,
      description: payment.description,
      status: payment.status,
      ammount: payment.ammount,
      priority: payment.priority,
      assignee_user_id: payment.assignee_user.id,
      assignee_user_name: payment.assignee_user.full_name,
      assigned_user_id: payment.assigned_user.id,
      assigned_user_name: payment.assigned_user.full_name
    }
  end
end
