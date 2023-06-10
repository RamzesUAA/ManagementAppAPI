defmodule ManagementServer.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ManagementServer.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        ammount: "120.5",
        description: "some description",
        name: "some name",
        priority: 42,
        status: "some status"
      })
      |> ManagementServer.Payments.create_payment()

    payment
  end
end
