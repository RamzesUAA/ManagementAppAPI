defmodule ManagementServerWeb.FormTypeView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.FormTypeView

  def render("index.json", %{form_types: form_types}) do
    %{data: render_many(form_types, FormTypeView, "form_type.json")}
  end

  def render("show.json", %{form_type: form_type}) do
    %{data: render_one(form_type, FormTypeView, "form_type.json")}
  end

  def render("form_type.json", %{form_type: form_type}) do
    %{
      id: form_type.id,
      label: form_type.label,
      name: form_type.name,
      fields: form_type.fields
    }
  end
end
