defmodule ManagementServer.FormTypesTest do
  use ManagementServer.DataCase

  alias ManagementServer.FormTypes

  describe "form_types" do
    alias ManagementServer.FormTypes.FormType

    import ManagementServer.FormTypesFixtures

    @invalid_attrs %{fields: nil, name: nil}

    test "list_form_types/0 returns all form_types" do
      form_type = form_type_fixture()
      assert FormTypes.list_form_types() == [form_type]
    end

    test "get_form_type!/1 returns the form_type with given id" do
      form_type = form_type_fixture()
      assert FormTypes.get_form_type!(form_type.id) == form_type
    end

    test "create_form_type/1 with valid data creates a form_type" do
      valid_attrs = %{fields: %{}, name: "some name"}

      assert {:ok, %FormType{} = form_type} = FormTypes.create_form_type(valid_attrs)
      assert form_type.fields == %{}
      assert form_type.name == "some name"
    end

    test "create_form_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FormTypes.create_form_type(@invalid_attrs)
    end

    test "update_form_type/2 with valid data updates the form_type" do
      form_type = form_type_fixture()
      update_attrs = %{fields: %{}, name: "some updated name"}

      assert {:ok, %FormType{} = form_type} = FormTypes.update_form_type(form_type, update_attrs)
      assert form_type.fields == %{}
      assert form_type.name == "some updated name"
    end

    test "update_form_type/2 with invalid data returns error changeset" do
      form_type = form_type_fixture()
      assert {:error, %Ecto.Changeset{}} = FormTypes.update_form_type(form_type, @invalid_attrs)
      assert form_type == FormTypes.get_form_type!(form_type.id)
    end

    test "delete_form_type/1 deletes the form_type" do
      form_type = form_type_fixture()
      assert {:ok, %FormType{}} = FormTypes.delete_form_type(form_type)
      assert_raise Ecto.NoResultsError, fn -> FormTypes.get_form_type!(form_type.id) end
    end

    test "change_form_type/1 returns a form_type changeset" do
      form_type = form_type_fixture()
      assert %Ecto.Changeset{} = FormTypes.change_form_type(form_type)
    end
  end
end
