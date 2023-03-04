defmodule ManagementServerWeb.Router do
  use ManagementServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ManagementServerWeb do
    pipe_through :api
  end
end
