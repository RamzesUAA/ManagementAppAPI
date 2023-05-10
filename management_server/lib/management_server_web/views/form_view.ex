defmodule ManagementServerWeb.FormView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.FormView

  def render("index.json", %{forms: forms}) do
    %{data: render_many(forms, FormView, "form.json")}
  end

  def render("show.json", %{form: form}) do
    %{data: render_one(form, FormView, "form.json")}
  end

  def render("form.json", %{form: form}) do
    %{
      id: form.id,
      name: form.name,
      form_type_id: form.form_type_id,
      data: form.data
    }
  end
end
