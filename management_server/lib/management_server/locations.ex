defmodule ManagementServer.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias ManagementServer.Repo

  alias ManagementServer.Locations.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations(%{assigns: %{account: %{user: %{organization_id: organization_id}}}}) do
    IO.inspect("##############")
    IO.inspect(organization_id)
    IO.inspect("##############")
    IO.inspect("##############")

    Location
    |> where([l], l.organization_id == ^organization_id)
    |> Repo.all()

    # query = build_query(params)
    # Repo.all(query)
  end

  # defp build_query(params) do
  #   query = from l in Location

  #   # Add dynamic filters based on params
  #   query =
  #     Enum.reduce(params, query, fn {key, value}, acc ->
  #       case String.trim(value) do
  #         "" -> acc # Ignore empty values
  #         _ -> add_filter(acc, key, value)
  #       end
  #     end)

  #   query
  # end

  # defp add_filter(query, key, value) do
  #   case key do
  #     "organization_id" -> where(query, ilike: ^("%#{value}%"), field(l, :organization_id))
  #     "city" -> where(query, ilike: ^("%#{value}%"), field(l, :city))
  #     # Add more filters as needed
  #     _ -> query
  #   end
  # end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end
end
