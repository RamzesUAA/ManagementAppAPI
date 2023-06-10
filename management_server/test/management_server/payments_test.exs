defmodule ManagementServer.PaymentsTest do
  use ManagementServer.DataCase

  alias ManagementServer.Payments

  describe "payments" do
    alias ManagementServer.Payments.Payment

    import ManagementServer.PaymentsFixtures

    @invalid_attrs %{ammount: nil, description: nil, name: nil, priority: nil, status: nil}

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Payments.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Payments.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{ammount: "120.5", description: "some description", name: "some name", priority: 42, status: "some status"}

      assert {:ok, %Payment{} = payment} = Payments.create_payment(valid_attrs)
      assert payment.ammount == Decimal.new("120.5")
      assert payment.description == "some description"
      assert payment.name == "some name"
      assert payment.priority == 42
      assert payment.status == "some status"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payments.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      update_attrs = %{ammount: "456.7", description: "some updated description", name: "some updated name", priority: 43, status: "some updated status"}

      assert {:ok, %Payment{} = payment} = Payments.update_payment(payment, update_attrs)
      assert payment.ammount == Decimal.new("456.7")
      assert payment.description == "some updated description"
      assert payment.name == "some updated name"
      assert payment.priority == 43
      assert payment.status == "some updated status"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.update_payment(payment, @invalid_attrs)
      assert payment == Payments.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Payments.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Payments.change_payment(payment)
    end
  end
end
