defmodule ManagementServerWeb.FormTypeControllerTest do
  use ManagementServerWeb.ConnCase

  import ManagementServer.FormTypesFixtures

  alias ManagementServer.FormTypes.FormType

  @create_attrs %{
    fields: %{},
    name: "some name"
  }
  @update_attrs %{
    fields: %{},
    name: "some updated name"
  }
  @invalid_attrs %{fields: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all form_types", %{conn: conn} do
      conn = get(conn, Routes.form_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create form_type" do
    test "renders form_type when data is valid", %{conn: conn} do
      conn = post(conn, Routes.form_type_path(conn, :create), form_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.form_type_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "fields" => %{},
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.form_type_path(conn, :create), form_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update form_type" do
    setup [:create_form_type]

    test "renders form_type when data is valid", %{conn: conn, form_type: %FormType{id: id} = form_type} do
      conn = put(conn, Routes.form_type_path(conn, :update, form_type), form_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.form_type_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "fields" => %{},
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, form_type: form_type} do
      conn = put(conn, Routes.form_type_path(conn, :update, form_type), form_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete form_type" do
    setup [:create_form_type]

    test "deletes chosen form_type", %{conn: conn, form_type: form_type} do
      conn = delete(conn, Routes.form_type_path(conn, :delete, form_type))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.form_type_path(conn, :show, form_type))
      end
    end
  end

  defp create_form_type(_) do
    form_type = form_type_fixture()
    %{form_type: form_type}
  end
end
