defmodule ManagementServerWeb.Router do
  use ManagementServerWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{error: message}) |> halt()
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    # plug(CORSPlug, origins: ["*"], allow_headers: ["*"])
  end

  pipeline :auth do
    plug(ManagementServerWeb.Auth.Pipeline)
    plug(ManagementServerWeb.Auth.SetAccount)
  end

  scope "/api/swagger" do
    forward("/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :management_server,
      swagger_file: "swagger.json"
    )
  end

  scope "/api", ManagementServerWeb do
    pipe_through(:api)
    get("/", DefaultController, :index)
    post("/accounts/create", AccountController, :create)
    post("/accounts/sign_in", AccountController, :sign_in)
    post("/roles/create", RoleController, :create)
    post("/organizations/create", OrganizationController, :create)
  end

  scope "/api", ManagementServerWeb do
    pipe_through([:api, :auth])
    get("/accounts", AccountController, :index)
    get("/accounts/current", AccountController, :current_account)
    get("/accounts/sign_out", AccountController, :sign_out)
    get("/accounts/refresh_session", AccountController, :refresh_session)
    post("/accounts/update", AccountController, :update)

    get("/users", UserController, :index)
    put("/users/update", UserController, :update)
    post("/users/create", UserController, :create)

    get("/roles", RoleController, :index)

    get("/organizations", OrganizationController, :index)
    get("/organizations_roles", OrganizationController, :organizations_with_roles)

    get("/locations", LocationController, :index)
    get("/locations/:id", LocationController, :show)
    post("/locations", LocationController, :create)
    delete("/locations/:id", LocationController, :delete)
    put("/locations/:id", LocationController, :update)

    get("/forms", FormController, :index)
    get("/forms/:id", FormController, :show)
    post("/forms", FormController, :create)
    delete("/forms/:id", FormController, :delete)
    put("/forms/:id", FormController, :update)

    get("/workers", WorkerController, :index)
    get("/workers/:id", WorkerController, :show)
    post("/workers", WorkerController, :create)
    delete("/workers/:id", WorkerController, :delete)
    put("/workers/:id", WorkerController, :update)

    get("/events", EventController, :index)
    get("/events/:id", EventController, :show)
    post("/events", EventController, :create)
    delete("/events/:id", EventController, :delete)
    put("/events/:id", EventController, :update)

    get("/form_types", FormTypeController, :index)
    get("/form_types/:id", FormTypeController, :show)
    post("/form_types", FormTypeController, :create)
    delete("/form_types/:id", FormTypeController, :delete)
    put("/form_types/:id", FormTypeController, :update)

    get("/payments", PaymentController, :index)
    get("/payments/:id", PaymentController, :show)
    post("/payments", PaymentController, :create)
    delete("/payments/:id", PaymentController, :delete)
    put("/payments/:id", PaymentController, :update)
  end
end
