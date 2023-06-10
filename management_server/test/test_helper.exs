Application.ensure_all_started(:mox)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ManagementServer.Repo, :manual)
Mox.defmock(ManagementServer.MockRepo, for: Ecto.Repo)

# <- Add this
# Application.put_env(:bound, :weather, WeatherBehaviourMock) # <- Add this

defmodule ManagementServer.MockRepo do
  defmacro __using__(_) do
    quote do
      def get(_, _), do: :ok
      def all(_), do: :ok
      # add the rest of the Repo functions you want to mock here...
    end
  end
end
