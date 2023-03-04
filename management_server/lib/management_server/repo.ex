defmodule ManagementServer.Repo do
  use Ecto.Repo,
    otp_app: :management_server,
    adapter: Ecto.Adapters.Postgres
end
