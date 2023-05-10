defmodule ManagementServerWeb.FormTypeController do
  use ManagementServerWeb, :controller

  alias ManagementServer.FormTypes
  alias ManagementServer.FormTypes.FormType

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn = %{assigns: %{organization_id: organization_id}}, _params) do
    form_types = FormTypes.list_form_types(organization_id)
    render(conn, "index.json", form_types: form_types)
  end

  def create(conn = %{assigns: %{organization_id: organization_id}}, %{
        "form_type" => form_type_params
      }) do
    form_type_params = Map.put(form_type_params, "organization_id", organization_id)

    with {:ok, %FormType{} = form_type} <- FormTypes.create_form_type(form_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.form_type_path(conn, :show, form_type))
      |> render("show.json", form_type: form_type)
    end
  end

  def show(conn, %{"id" => id}) do
    form_type = FormTypes.get_form_type!(id)
    render(conn, "show.json", form_type: form_type)
  end

  def update(conn, %{"id" => id, "form_type" => form_type_params}) do
    form_type = FormTypes.get_form_type!(id)

    with {:ok, %FormType{} = form_type} <- FormTypes.update_form_type(form_type, form_type_params) do
      render(conn, "show.json", form_type: form_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    form_type = FormTypes.get_form_type!(id)

    with {:ok, %FormType{}} <- FormTypes.delete_form_type(form_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
