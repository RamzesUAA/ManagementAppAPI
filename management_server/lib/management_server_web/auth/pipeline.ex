defmodule ManagementServerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :management_server,
    module: ManagementServerWeb.Auth.Guardian,
    error_handler: ManagementServerWeb.Auth.GuardianErrorHandler

  plug(Guardian.Plug.VerifySession)
  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
