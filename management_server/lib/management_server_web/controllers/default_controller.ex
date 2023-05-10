defmodule ManagementServerWeb.DefaultController do
  use ManagementServerWeb, :controller

  def index(conn, _params) do
    text conn, "The management API is LIVE - #{Mix.env()}"
  end

end
