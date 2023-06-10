defmodule ManagementServerWeb.UserView do
  use ManagementServerWeb, :view
  alias ManagementServerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user-list.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      full_name: user.full_name,
      gender: user.gender,
      biography: user.biography
    }
  end

  def render("user-list.json", %{user: user}) do
    %{
      id: user.id,
      full_name: user.full_name,
      gender: user.gender,
      biography: user.biography,
      email: user.email,
      organization_id: user.organization_id,
      organization_name: user.organization_name
    }
  end
end
