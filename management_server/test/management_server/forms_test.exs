defmodule ManagementServer.FormsTest do
  use ManagementServer.DataCase

  alias ManagementServer.Forms

  describe "forms" do
    alias ManagementServer.Forms.Form

    import ManagementServer.FormsFixtures

    @invalid_attrs %{data: nil, name: nil}

    test "get_form!/1 returns the form with given id" do
      form = form_fixture()
      assert Forms.get_form!(form.id) == form
    end

    test "create_form/1 with valid data creates a form" do
      {:ok, organization} =
        %{}
        |> Enum.into(%{
          id: 1,
          name: "some name"
        })
        |> ManagementServer.Organizations.create_organization()

      valid_attrs = %{data: %{}, name: "some name", organization_id: organization.id}

      assert {:ok, %Form{} = form} = Forms.create_form(valid_attrs)
      assert form.data == %{}
      assert form.name == "some name"
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      update_attrs = %{data: %{}, name: "some updated name"}

      assert {:ok, %Form{} = form} = Forms.update_form(form, update_attrs)
      assert form.data == %{}
      assert form.name == "some updated name"
    end

    test "update_form/2 with invalid data returns error changeset" do
      form = form_fixture()
      assert {:error, %Ecto.Changeset{}} = Forms.update_form(form, @invalid_attrs)
      assert form == Forms.get_form!(form.id)
    end

    test "delete_form/1 deletes the form" do
      form = form_fixture()
      assert {:ok, %Form{}} = Forms.delete_form(form)
      assert_raise Ecto.NoResultsError, fn -> Forms.get_form!(form.id) end
    end

    test "change_form/1 returns a form changeset" do
      form = form_fixture()
      assert %Ecto.Changeset{} = Forms.change_form(form)
    end
  end
end
