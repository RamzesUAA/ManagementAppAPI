defmodule ManagementServer.FormTypes do
  @moduledoc """
  The FormTypes context.
  """

  import Ecto.Query, warn: false
  alias ManagementServer.Repo

  alias ManagementServer.FormTypes.FormType

  @doc """
  Returns the list of form_types.

  ## Examples

      iex> list_form_types()
      [%FormType{}, ...]

  """
  def list_form_types(organization_id) do
    FormType
    |> where([l], l.organization_id == ^organization_id)
    |> Repo.all()
  end

  @doc """
  Gets a single form_type.

  Raises `Ecto.NoResultsError` if the Form type does not exist.

  ## Examples

      iex> get_form_type!(123)
      %FormType{}

      iex> get_form_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_form_type!(id), do: Repo.get!(FormType, id)

  @doc """
  Creates a form_type.

  ## Examples

      iex> create_form_type(%{field: value})
      {:ok, %FormType{}}

      iex> create_form_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_form_type(attrs \\ %{}) do
    %FormType{}
    |> FormType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a form_type.

  ## Examples

      iex> update_form_type(form_type, %{field: new_value})
      {:ok, %FormType{}}

      iex> update_form_type(form_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_form_type(%FormType{} = form_type, attrs) do
    form_type
    |> FormType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a form_type.

  ## Examples

      iex> delete_form_type(form_type)
      {:ok, %FormType{}}

      iex> delete_form_type(form_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_form_type(%FormType{} = form_type) do
    Repo.delete(form_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking form_type changes.

  ## Examples

      iex> change_form_type(form_type)
      %Ecto.Changeset{data: %FormType{}}

  """
  def change_form_type(%FormType{} = form_type, attrs \\ %{}) do
    FormType.changeset(form_type, attrs)
  end
end
