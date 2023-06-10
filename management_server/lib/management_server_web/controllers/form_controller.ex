defmodule ManagementServerWeb.FormController do
  use ManagementServerWeb, :controller

  alias ManagementServer.{Forms, LocationsForms}
  alias ManagementServer.{Forms.Form, LocationsForms.LocationForm}

  action_fallback(ManagementServerWeb.FallbackController)

  def index(conn = %{assigns: %{organization_id: organization_id}}, params) do
    forms = Forms.list_forms(organization_id, params)
    render(conn, "index.json", forms: forms)
  end

  def create(conn = %{assigns: %{organization_id: organization_id}}, %{"form" => form_params}) do
    with form_params <- Map.put(form_params, "organization_id", organization_id),
         {:ok, %Form{} = form} <- Forms.create_form(form_params),
         {:ok, _count} <- LocationsForms.create_location_form(form.id, form_params) do
      conn
      |> put_status(:created)
      |> render("show.json", form: form)
    end
  end

  def show(conn, %{"id" => id}) do
    form = Forms.get_form!(id)
    render(conn, "show.json", form: form)
  end

  def update(conn, %{"id" => id, "form" => form_params}) do
    form = Forms.get_form!(id)

    with {:ok, %Form{} = form} <- Forms.update_form(form, form_params) do
      render(conn, "show.json", form: form)
    end
  end

  def delete(conn, %{"id" => id}) do
    form = Forms.get_form!(id)

    with {:ok, %Form{}} <- Forms.delete_form(form) do
      send_resp(conn, :no_content, "")
    end
  end
end
